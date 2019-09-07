{-# LANGUAGE NoImplicitPrelude #-}
module Lib where

import BasePrelude
import System.Process (callCommand)


manualMergeMain :: IO ()
manualMergeMain = do
  putStrLn "starting ManualMerge v1.0"
  args <- getArgs
  when (length args < 1) $ die "you must provide an arguement"
  let
    maybeArg = listToMaybe args :: Maybe String
    firstArg = fromMaybe "" $ listToMaybe args
  filesToDiff <- lines <$> readFile firstArg
  result <- gitCycle filesToDiff
  return ()



gitCycle :: [FilePath] -> IO ()
gitCycle paths = mapM_ gitCheck $ reverse paths
data GitResponse = Yes | No
  deriving (Eq, Ord, Show, Read)

parseResponse :: String -> GitResponse
parseResponse []      = Yes
parseResponse ('y':_) = Yes
parseResponse ('Y':_) = Yes
parseResponse _       = No

gitCheck :: FilePath -> IO ()
gitCheck fp = do
  callCommand $ "git --no-pager diff " ++ fp
  print "Would you like to check out the original file? (Y/N)"
  response <- parseResponse<$> getLine
  mergeOrWrite response fp
  return ()

mergeOrWrite :: GitResponse -> FilePath -> IO ()
mergeOrWrite r fp 
  = case r of
      Yes -> callCommand $ "git checkout " ++ fp
      No -> appendFile "manualmerge_output.txt" $ 
              '\n' : fp

