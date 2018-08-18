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


module Web.Footer (
  mkFooter
) where

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import Static

import UI.Base
import Util.Bulma.Components.Navbar

mkFooter :: forall t m. MonadWidget t m
          => m ()
mkFooter =
  elClass "footer" "footer box animated slower" $ do
    divClass "container" $
      divClass "footer-links" $
        divClass "columns" $ do
          divClass "column is-3" $ do
            el "p" $ elAttr "a" (Map.fromList [("href","#"),("class","title is-4")]) $ text "Beranda"
            el "p" $ elAttr "a" (Map.fromList [("href","#Aktivitas"),("class","title is-4")]) $ text "Aktivitas"
            el "p" $ elAttr "a" (Map.fromList [("href","#Media"),("class","title is-4")]) $ text "Media"
            el "p" $ elAttr "a" (Map.fromList [("href","#Media/Berita"),("class","subtitle is-5")]) $ text "Berita"
            el "p" $ elAttr "a" (Map.fromList [("href","#Media/Publikasi"),("class","subtitle is-5")]) $ text "Publikasi"
            el "p" $ elAttr "a" (Map.fromList [("href","#Media/SiaranPers"),("class","subtitle is-5")]) $ text "Siaran Pers"
            return ()
          divClass "column is-3" $ do
            el "p" $ elAttr "a" (Map.fromList [("href","#Tentang"),("class","title is-4")]) $ text "Tentang"
            el "p" $ elAttr "a" (Map.fromList [("href","#Tentang/VisiMisi"),("class","subtitle is-5")]) $ text "Visi dan Misi"
            el "p" $ elAttr "a" (Map.fromList [("href","#Tentang/Sejarah"),("class","subtitle is-5")]) $ text "Sejarah"
            el "p" $ elAttr "a" (Map.fromList [("href","#Tentang/LaporanTahunan"),("class","subtitle is-5")]) $ text "Laporan Tahunan"
            el "p" $ elAttr "a" (Map.fromList [("href","#Tentang/DKM"),("class","subtitle is-5")]) $ text "Dewan Kemakmuran Masjid"
            el "p" $ elAttr "a" (Map.fromList [("href","#Tentang/Galeri"),("class","subtitle is-5")]) $ text "Galeri"
            return ()
          divClass "column is-6" $ pure ()
          return ()
    elAttr "p" (Map.singleton "class" "copyright")$ text "© 2018 RiziLab All Rights Reserved"
