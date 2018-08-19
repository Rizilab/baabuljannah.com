{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DataKinds #-}


module Web.Tentang (
    pgTentang
) where

import Control.Monad (void)

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Data.Text

import Reflex.Dom.Routing.Writer
import Reflex.Dom.Routing.Nested
import Static

import Types.RouteWidget
import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar
import Web.Tentang.VisiMisi (pgTentangVisiMisi)
import Web.Tentang.Sejarah (pgTentangSejarah)
import Web.Tentang.LaporanTahunan (pgTentangLaporanTahunan)
import Web.Tentang.DKM (pgTentangDKM)
import Web.Tentang.Galeri (pgTentangGaleri)

pgTentang :: forall t m. WebUiM t m
          => m ()
pgTentang =
  void $ withRoute $ \route -> case fromMaybe (Widget "") route of
     Widget "VisiMisi" -> pgTentangVisiMisi
     Widget "Sejarah"  -> pgTentangSejarah
     Widget "LaporanTahunan" -> pgTentangLaporanTahunan
     Widget "DKM" -> pgTentangDKM
     Widget "Galeri" -> pgTentangGaleri
     Widget "" -> pgLandingTentang
     Widget _  -> tellRedirectLocally [Widget ""]

pgLandingTentang :: forall t m. MonadWidget t m
          => m ()
pgLandingTentang =
  elClass "section" "hero is-medium animated is-warning is-bold slideInRight slower" $
    divClass "hero-body" $
      divClass "container" $ do
        divClass "columns" $ do
          divClass "column is-4" $
            elAttr "a" (Map.fromList [("href","/#Tentang/VisiMisi"),("class","content")]) $ do
              elAttr "h3" (Map.singleton "class" "title is-3") $ text "Visi dan Misi"
              elAttr "p" (Map.singleton "class" "subtitle") $ text "Visi dan Misi kepengurusan Masjid Baabul Jannah"
              return ()
          divClass "column is-4" $
            elAttr "a" (Map.fromList [("href","/#Tentang/Sejarah"),("class","content")]) $ do
              elAttr "h3" (Map.singleton "class" "title is-3") $ text "Sejarah"
              elAttr "p" (Map.singleton "class" "subtitle") $ text "Sejarah pendirian Masjid Baabul Jannah"
              return ()
          divClass "column is-4" $
            elAttr "a" (Map.fromList [("href","/#Tentang/Galeri"),("class","content")]) $ do
              elAttr "h3" (Map.singleton "class" "title is-3") $ text "Galeri"
              elAttr "p" (Map.singleton "class" "subtitle") $ text "Kumpulan dokumentasi kegiatan Masjid Baabul Jannah"
              return ()
          return ()
        divClass "columns" $ do
          divClass "column is-6" $
            elAttr "a" (Map.fromList [("href","/#Tentang/LaporanTahunan"),("class","content")]) $ do
              elAttr "h3" (Map.singleton "class" "title is-3") $ text "Laporan Tahunan"
              elAttr "p" (Map.singleton "class" "subtitle") $ text "Laporan tahunan keuangan Masjid Baabul Jannah"
              return ()
          divClass "column is-6" $
            elAttr "a" (Map.fromList [("href","/#Tentang/DKM"),("class","content")]) $ do
              elAttr "h3" (Map.singleton "class" "title is-3") $ text "Dewan Kemakmuran Masjid"
              elAttr "p" (Map.singleton "class" "subtitle") $ text "Susunan profil kepengurusan Masjid Baabul Jannah"
              return ()
          return ()
        return ()
