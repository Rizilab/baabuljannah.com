{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import qualified Data.Text            as T
import qualified Data.Map             as Map
import           Data.Monoid
import Options.Generic
import Api as Api

data ServerArgs =
    Init -- <?> "Initialize server configuration (first time only)"
  | Start -- <?> "Start Webservice"
  | Migrate -- <?> "Setting up database/Migrate existing database"
  deriving (Show, Generic)

instance ParseRecord ServerArgs

getArgs :: IO ServerArgs
getArgs = getRecord "SmartSettlers Backend Webservice"

main :: IO ()
main = do
  x <- getArgs
  case x of
    Init -> putStrLn "This is init"
    Start -> putStrLn "This is Webservice"
    Migrate -> putStrLn "This is for DB Migrate"


