{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DataKinds #-}


module Web.Tentang.Sejarah (
  pgTentangSejarah
) where

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import Static

import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar

pgTentangSejarah :: forall t m. MonadWidget t m
          => m ()
pgTentangSejarah =
  elClass "section" "section box animated zoomIn fast" $ do
    divClass "container" $
      divClass "tile is-ancestor" $ do
        divClass "tile is-parent is-8" $
          divClass "content" $ do
            elClass "h1" "title is-1" $ text "Sejarah Masjid Baabul Jannah"
            elClass "h3" "subtitle" $ text "Sejarah singkat masjid baabul jannah"
            el "p" $ text "Masjid Baabul Jannah didirikan pada tahun 1997 ......"
        divClass "tile is-parent is-4" $
          elClass "figure" "image is-3By4" $
            elAttr "img" (Map.fromList [("src","https://bulma.io/images/placeholders/480x640.png")]) $ pure ()
        return ()
    return ()
