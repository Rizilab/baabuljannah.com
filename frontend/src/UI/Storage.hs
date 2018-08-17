{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module UI.Storage (
    CredentialTag (..)
  ) where

import Data.Dependent.Map (Some(..))
import Data.Dependent.Sum (ShowTag(..))
import Data.GADT.Show
import Data.GADT.Compare
import Data.Functor.Identity (Identity(..))

import Data.Aeson
import Data.GADT.Aeson

-- STORAGE --

data CredentialTag a where
  Tag1 :: CredentialTag Int

instance GEq CredentialTag where
  geq Tag1 Tag1 = Just Refl

instance GCompare CredentialTag where
  gcompare Tag1 Tag1    = GEQ

instance GKey CredentialTag where
  toKey (This Tag1) = "tag1"

  fromKey t =
    case t of
      "tag1" -> Just (This Tag1)
      _ -> Nothing

  keys _ = [This Tag1]

instance ToJSONTag CredentialTag Identity where
  toJSONTagged Tag1 = toJSON

instance FromJSONTag CredentialTag Identity where
  parseJSONTagged Tag1 = parseJSON
