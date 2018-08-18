{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DataKinds #-}

module Util.Collection (
    mkApp
  ) where

import Reflex.Dom
import Static

import Data.Foldable (traverse_)
import Data.Semigroup ((<>))

import Data.Text (Text)

import Data.Map (Map)
import qualified Data.Map as Map

collectionCssFiles :: [Text]
collectionCssFiles = [
    static @"css/bulma.min.css"
  , static @"css/all.min.css"
  , static @"css/baabuljannah.min.css"
  , static @"css/animate.min.css"
  , static @"css/style.min.css"
  ]

collectionJsFiles :: [Text]
collectionJsFiles = []

headerHTML :: [Text] -> StaticWidget x ()
headerHTML cssFiles = do
  el "title" $ text "Masjid Baabul Jannah"
  elAttr "meta" ("charset" =: "utf-8") blank
  elAttr "meta" ("name" =: "viewport" <>
                 "content" =: "width=device-width, initial-scale=1, shrink-to-fit=no") blank
  let
    stylesheet src =
      elAttr "link" (Map.fromList [("rel", "stylesheet"), ("href", src)]) blank
  traverse_ stylesheet $ collectionCssFiles ++ cssFiles

footerHTML :: [Text] -> Widget x ()
footerHTML jsFiles =
  let
    script src =
      elAttr "script" ("src" =: src) blank
  in
    traverse_ script $ collectionJsFiles ++ jsFiles

mkApp :: [Text] -> [Text] -> Widget x () -> (StaticWidget x (), Widget x ())
mkApp cssFiles jsFiles widget = (headerHTML cssFiles, widget >> footerHTML jsFiles)
