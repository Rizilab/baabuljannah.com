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


module Web.Tentang.VisiMisi (
  pgTentangVisiMisi
) where

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import Static

import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar

pgTentangVisiMisi :: forall t m. MonadWidget t m
          => m ()
pgTentangVisiMisi =
  elClass "section" "hero is-warning box animated rotateIn fast" $ do
    divClass "container" $
      divClass "tile is-ancestor" $ do
        divClass "tile is-parent is-6 animated fadeInLeft delay-2s" $
          divClass "content" $ do
            elClass "h1" "title is-1" $ text "Visi"
            elClass "h3" "subtitle" $ text "Menciptakan Generasi Islam Yang Bermartabat"
            el "p" $ text "Masjid Baabul Jannah mempunyai visi yang ...."
        divClass "tile is-parent is-6 animated fadeInRight delay-2s" $
           divClass "content" $ do
            elClass "h1" "title is-1" $ text "Misi"
            elClass "h3" "subtitle" $ text "Menjalin Persatuan dan Kesatuan antar Generasi"
            el "p" $ text "Masjid Baabul Jannah memiliki misi yang sangat dijunjung tinggi..."
        return ()
    return ()
