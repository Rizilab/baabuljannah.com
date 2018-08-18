{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DataKinds #-}


module Web (
    mkWeb
  , mkNavbar
  , mkFooter
) where

import Control.Monad (void)

import Reflex.Dom.Core
import Language.Javascript.JSaddle (liftJSM)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Data.Text

import Reflex.Dom.Routing.Writer
import Reflex.Dom.Routing.Nested
import Static

import Types.RouteWidget
import UI.Base
import Util.Bulma.Components.Navbar
import Web.Navigation (mkNavbar)
import Web.Footer (mkFooter)
import Web.Landing (pgLanding)
import Web.Tentang
import Web.Aktivitas (pgAktivitas)
import Web.Media

mkWeb :: forall t m. (WebUiM t m)
      => m ()
mkWeb =
  void $ withRoute $ \route -> case fromMaybe (Widget "") route of
    Widget "Tentang"   -> pgTentang
    Widget "Tentang/VisiMisi" -> pgTentangVisiMisi
    Widget "Tentang/Sejarah"  -> pgTentangSejarah
    Widget "Tentang/LaporanTahunan" -> pgTentangLaporanTahunan
    Widget "Tentang/DKM" -> pgTentangDKM
    Widget "Tentang/Galeri" -> pgTentangGaleri
    Widget "Aktivitas" -> pgAktivitas
    Widget "Media"     -> pgMedia
    Widget "Media/Berita" -> pgMediaBerita
    Widget "Media/Publikasi" -> pgMediaPublikasi
    Widget "Media/SiaranPers" -> pgMediaSiaranPers
    Widget ""          -> pgLanding
    Widget _           -> tellRedirectLocally [Widget ""]
