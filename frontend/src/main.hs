{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE FlexibleContexts #-}

module Main where

import qualified Data.Text            as T
import qualified Data.Map             as Map
import           Data.Maybe
import           Reflex
import           Reflex.Dom
import           Reflex.Dom.Contrib.Router as Router
import           Reflex.Dom.Routing.Writer as RWT
import           Reflex.Dom.Routing.Nested as RNT
import           Reflex.Dom.Storage.Class
import           Reflex.Dom.Storage.Base
import           Data.Either
import           Data.Monoid
import           Data.List
import qualified URI.ByteString        as U
import Control.Monad (join, void)
import GHCJS.DOM.Window (getLocalStorage)
import GHCJS.DOM.Storage (setItem, getItem)
import GHCJS.DOM                       as DOM
import Control.Monad.IO.Class
import Control.Monad.Trans.Class
import Data.JSString (unpack)

import Web.Navigation
import UI.Base
import Web


main :: IO ()
main = mainWidgetWithHead headElement bodyElement

headElement :: MonadWidget t m => m ()
headElement = do
  el "title" $ text "Masjid BaabulJannah"
  bulma "static/css/baabuljannah.min.css"
  allmin "static/css/all.min.css"
  animate "static/css/animate.min.css"
  where
    bulma link = elAttr "link" (Map.fromList [
          ("rel", "stylesheet")
        , ("type", "text/css")
        , ("href", link)
      ]) $ return ()
    allmin link = elAttr "link" (Map.fromList [
          ("rel", "stylesheet")
        , ("type", "text/css")
        , ("href", link)
      ]) $ return ()
    animate link = elAttr "link" (Map.fromList [
          ("rel", "stylesheet")
        , ("type", "text/css")
        , ("href", link)
      ]) $ return ()

bodyElement :: (MonadWidget t m) => m ()
bodyElement =
  elClass "section" "section" $ runAppT $ do
    mkNavbar
    mkWeb
    return ()
