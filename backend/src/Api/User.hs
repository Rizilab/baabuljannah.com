{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module Api.User where

-- Standard Library
import Data.Aeson (FromJSON, ToJSON)
import Data.Text
import GHC.Generics

-- Third Party Library
import Servant.API
import Servant.Auth

-- Local Library
import AuthAPI.Types

type UnprotectedUserAPI =
       PostUserRegistration
  :<|> PostUserLogin

type ProtectedUserAPI =
       PatchUserAccount
  :<|> GetUserDetails

type PostUserRegistration =
  "register" :> ReqBody '[JSON] UserRegister :> Post '[JSON] ResponseUserRegistration

type PostUserLogin =
  "login" :> ReqBody '[JSON] UserLogin :> Post '[JSON] ResponseLogin

type PatchUserAccount =
  "edit" :> ReqBody '[JSON] UserLogin :> Patch '[JSON] ResponsePatch

type GetUserDetails =
  "user" :> ReqBody '[JSON] UserProfile :> Get '[JSON] ResponseUserDetail
