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


module Web.Tentang.LaporanTahunan (
  pgTentangLaporanTahunan
) where

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import Static

import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar

pgTentangLaporanTahunan :: forall t m. MonadWidget t m
          => m ()
pgTentangLaporanTahunan =
  elClass "section" "hero is-medium animated is-light is-bold slideInRight slower" $
    divClass "hero-body" $
      divClass "container" $ do
        divClass "columns is-centered" $ do
          divClass "column is-half" $
            elAttr "a" (Map.fromList [("href","/#"),("class","content")]) $ do
              elAttr "h3" (Map.singleton "class" "title is-3") $ text "Halaman ini sedang dalam perbaikan, silahkan kembali lagi nanti"
              return ()
          return ()
        return ()
