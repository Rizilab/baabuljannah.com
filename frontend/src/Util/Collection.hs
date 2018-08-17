{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DataKinds #-}

module Util.Collection (
    headerHTML
  , mkApp
  , footerHTML
  ) where

import Reflex.Dom

import Data.Foldable (traverse_)
import Data.Semigroup ((<>))

import Data.Text (Text)

import Data.Map (Map)
import qualified Data.Map as Map

collectionCssFiles :: [Text]
collectionCssFiles = [
    "static/css/bulma.min.css"
  , "static/css/all.min.css"
  , "static/css/baabuljannah.min.css"
  , "static/css/animate.min.css"
  ]

collectionJsFiles :: [Text]
collectionJsFiles = []

headerHTML :: MonadWidget t m => [Text] -> m ()
headerHTML cssFiles = do
  el "title" $ text "Masjid Baabul Jannah"
  elAttr "meta" ("charset" =: "utf-8") $ return ()
  elAttr "meta" ("name" =: "viewport" <>
                 "content" =: "width=device-width, initial-scale=1, shrink-to-fit=no") $ return ()
  let
    stylesheet src =
      elAttr "link" (Map.fromList [("rel", "stylesheet"), ("href", src), ("type","text/css")]) $ return ()
  traverse_ stylesheet $ collectionCssFiles ++ cssFiles

footerHTML :: MonadWidget t m => [Text] -> m ()
footerHTML jsFiles =
  let
    script src =
      elAttr "script" ("src" =: src) blank
  in
    traverse_ script $ collectionJsFiles ++ jsFiles

mkApp :: MonadWidget t m => [Text] -> [Text] -> m () -> (m (), m ())
mkApp cssFiles jsFiles widget = (headerHTML cssFiles, widget >> footerHTML jsFiles)
