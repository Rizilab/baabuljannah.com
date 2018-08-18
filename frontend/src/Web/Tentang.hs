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


module Web.Tentang (
    pgTentang
  , pgTentangVisiMisi
  , pgTentangSejarah
  , pgTentangLaporanTahunan
  , pgTentangDKM
  , pgTentangGaleri
) where

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import Static

import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar
import Web.Tentang.VisiMisi (pgTentangVisiMisi)
import Web.Tentang.Sejarah (pgTentangSejarah)
import Web.Tentang.LaporanTahunan (pgTentangLaporanTahunan)
import Web.Tentang.DKM (pgTentangDKM)
import Web.Tentang.Galeri (pgTentangGaleri)

pgTentang :: forall t m. MonadWidget t m
          => m ()
pgTentang =
  elClass "div" "tile animated slideInRight slower" $ do
    el "p" $ text "Ini untuk halaman tentang"
    return ()
