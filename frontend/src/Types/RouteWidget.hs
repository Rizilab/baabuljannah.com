{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Types.RouteWidget (
    RouteWidget(..)
  , toSegments
  , fromSegments
  , routeToText
  ) where

import Data.Semigroup ((<>))
import GHC.Generics

import Control.Lens

import Data.Text (Text)
import qualified Data.Text as Text

import Data.Aeson (ToJSON, FromJSON)

import Reflex.Dom.Routing.Nested
import URI.ByteString

data RouteWidget =
  Widget Text
  deriving (Eq, Ord, Show, Generic)

instance ToJSON RouteWidget where
instance FromJSON RouteWidget where

toSegments :: URIRef a -> [RouteWidget]
toSegments =
  fmap Widget .
  nullTextToEmptyList .
  Text.splitOn "/" .
  Text.dropAround (== '/') .
  fragAsText
 where
   nullTextToEmptyList [""] = []
   nullTextToEmptyList x = x

fromSegments :: URIRef a -> [RouteWidget] -> URIRef a
fromSegments u =
  setFrag u . routeToText

routeToText :: [RouteWidget]
            -> Text
routeToText =
  Text.intercalate "/" .
  fmap routeFragmentToText

routeFragmentToText :: RouteWidget
                    -> Text
routeFragmentToText (Widget t) =
  t
