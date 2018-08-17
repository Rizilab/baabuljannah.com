{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module ParseUtil where

import Data.Text.Encoding
import qualified Data.ByteString.Lazy as BL
import Reflex
import Reflex.Dom
import Data.Text                      as T
import Types
import Data.Map (Map)
import Text.Email.Validate            as Email
import Data.Monoid ((<>))
import Data.Char (isSpace, isLower, isDigit, isUpper)

checkInput :: T.Text -> Map T.Text T.Text
checkInput txt = ("class" =: "NavBox__LandingInput NavBox__LandingInput_error") <>
  case T.null txt of
    True -> ("style" =: "display:none")
    False -> ("style" =: "display:block")

checkUserName :: T.Text -> (Bool, T.Text)
checkUserName usrName =
  case T.all isLower usrName && (not (T.all isSpace usrName)) of
    True  -> (True, "")
    False -> (False, "*Username tidak boleh ada spasi atau huruf capital")

checkPhone :: T.Text -> (Bool, T.Text)
checkPhone phone =
  case T.all isDigit phone &&  isPhone phone of
    True  -> (True, "")
    False -> (False, "*Isi nomor handphone dengan benar")

checkEmail :: T.Text -> (Bool, T.Text)
checkEmail email =
  case isEmail of
    True  -> (True, "")
    False -> (False, "*Isi e-mail dengan benar")
  where
    isEmail = (Email.isValid . encodeUtf8) email

checkPassword :: T.Text -> (Bool, T.Text)
checkPassword pass =
  case (T.any isUpper pass) && (T.any isLower pass) && (T.any isDigit pass) && (T.length pass >= 8) of
    True  -> (True, "")
    False -> (False, "*Password minimal 8 karakter, 1 huruf kapital dan 1 angka")

isPhone :: T.Text -> Bool
isPhone phn =
  case uncons phn of
    Just (chr, _) -> chr == '0'
    Nothing       -> False

