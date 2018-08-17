{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Types where

import Data.Aeson
import Data.Aeson.Text
import Data.Aeson.Types
import qualified Data.Text     as T
import qualified Data.Maybe    as Maybe
import qualified Data.Map      as Map
import Data.Foldable (asum)
import Data.Monoid ((<>))
import Data.Either
import Control.Applicative
import Reflex.Dom
import GHC.Generics

type FirstName = T.Text
type LastName = T.Text
type Email = T.Text
type Phone = T.Text
type Address = T.Text
type UserName = T.Text
type UserID = T.Text
type Password = T.Text
type Role = T.Text
type JWTToken = T.Text
type ResponseMessage = T.Text
type ResponseStatus  = Bool

type QAppMonad t m = MonadWidget t m

data NavBox = Login | About | Logout | Register deriving (Show, Eq, Ord)
data LoginBox = Masuk | Daftar| Enable | Disable deriving (Show, Eq, Ord)
data YesNo = Yes | No deriving (Show, Eq, Ord)

data PersonName =
  PersonName { uFirstName :: FirstName
             , uLastName  :: LastName
             } deriving (Show, Eq)

instance FromJSON PersonName where
  parseJSON (Object v) = do
    uFirstName <- v .: "first"
    uLastName <- v .: "last"
    return PersonName{..}

  parseJSON invalid    = typeMismatch "PersonName" invalid

instance ToJSON PersonName where
  -- this generate Value
  toJSON (PersonName uFirstName uLastName) =
    object ["first" .= uFirstName, "last" .= uLastName]

  -- this generate bytestring builder
  toEncoding (PersonName uFirstName uLastName) =
    pairs ("first" .= uFirstName <> "last" .= uLastName)

data User =
  User { uId :: UserID
       , uName :: PersonName
       , uUserName :: UserName
       } deriving (Show)

instance FromJSON User where
  parseJSON (Object v) = do
    uId <- v .: "id"
    uName <- v .: "name"
    uUserName <- v .: "username"
    return User{..}

  parseJSON invalid    = typeMismatch "User" invalid
instance ToJSON User where
  -- this generate Value
  toJSON (User id uName uUserName) =
    object ["id" .= id, "name" .= uName, "username" .= uUserName]

  -- this generate bytestring builder
  toEncoding (User id uName uUserName) =
    pairs ("id" .= id <> "name" .= uName <> "username" .= uUserName)

data UserCredentialPost =
    QRegistration
      { ucUser     :: UserName
      , ucPhone    :: Phone
      , ucEmail    :: Email
      , ucPassword :: Password
      }
  | QLogin
      { ucUser     :: UserName
      , ucPassword :: Password
  } deriving (Show)

instance ToJSON UserCredentialPost where
  -- this generate Value
  toJSON (QRegistration ucU ucP ucE ucPs) =
    object ["username"  .= ucU
           , "phone"    .= ucP
           , "email"    .= ucE
           , "password" .= ucPs
           ]
  toJSON (QLogin ucU ucPs) =
    object [ "username" .= ucU
           , "password" .= ucPs
           ]

  -- this generate bytestring builder
  toEncoding (QRegistration ucU ucP ucE ucPs) =
    pairs ( "username" .= ucU <>
            "phone"    .= ucP <>
            "email"    .= ucE <>
            "password" .= ucPs
          )
  toEncoding (QLogin ucU ucPs) =
    pairs ( "username" .= ucU <>
            "password" .= ucPs
          )

data UserCredentialResponse =
    InvalidAction
      { success :: ResponseStatus
      , message :: ResponseMessage
      }
  | LoginCredential
      { success:: ResponseStatus
      , message :: ResponseMessage
      , token :: JWTToken
      , user :: User
      , role :: Role
      }
  | RegisterCredential
      { success :: ResponseStatus
      , message :: ResponseMessage
      , userName :: UserName
      , email :: Email
      }

instance FromJSON UserCredentialResponse where
  parseJSON = withObject "login or register or invalid" $ \o ->
    asum [ LoginCredential <$> o .: "success"
                           <*> o .: "message"
                           <*> o .: "token"
                           <*> o .: "user"
                           <*> o .: "role"
         , RegisterCredential <$> o .: "success"
                              <*> o .: "message"
                              <*> o .: "username"
                              <*> o .: "email"
         , InvalidAction      <$> o .: "success" <*> o .: "message"
         ]

defaultUCResponse :: UserCredentialResponse
defaultUCResponse = InvalidAction False "Cannot Parse JSON"

toUserCred :: [(Either String UserCredentialResponse)]
           -> UserCredentialResponse
toUserCred []    = InvalidAction False "Response JSON belum berhasil di konversi"
toUserCred (x:_) =
  case x of
    (Left e)     -> InvalidAction False (T.pack e)
    (Right usrC) -> usrC

