{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE RecordWildCards #-}

module Util.Bulma.Components.Navbar where

import Reflex
import Reflex.Class
import Reflex.Dom.Builder.Class
import Reflex.Dom.Class
import Reflex.Dom

import Data.Map (Map)
import qualified Data.Map as Map
import Data.Text as T

navbarBurger :: forall t m. MonadWidget t m
          => T.Text
          -> T.Text
          -> m (Dynamic t Bool)
navbarBurger elm dataTarget = do
  rec
    let
      dynAttrs = fmap (\s -> if s then Map.fromList [("class","navbar-burger is-active"), ("data-target",dataTarget)]
                                else Map.fromList [("class","navbar-burger"), ("data-target",dataTarget)]) click
    (ev1,_) <- elDynAttr' elm dynAttrs $
      elAttr "span" (Map.singleton "class" "icon ") $
        elAttr "i" (Map.singleton "class" "fas fa-bars") $ return ()
    click   <- toggle False (domEvent Click ev1)
  return click

navbarMenu :: forall t m. MonadWidget t m
          => T.Text
          -> Dynamic t Bool
          -> m ()
navbarMenu elm click =
  let
    dynAttrs = fmap (\s -> if s then Map.fromList [("id","navMenuLanding"), ("class","navbar-menu is-active")]
                                else Map.fromList [("id","navMenuLanding"), ("class","navbar-menu")]) click
  in
    elDynAttr elm dynAttrs $ do
      navbarMenuStart "div"
      navbarMenuEnd "div"
      return ()

navbarMenuStart :: forall t m. MonadWidget t m
          => T.Text
          -> m ()
navbarMenuStart elm =
  elAttr elm (Map.singleton "class" "navbar-start") $ do
    elAttr "a" (Map.fromList [("class", "navbar-item"), ("href", "/#")]) $
        text "Beranda"
    elAttr "div" (Map.fromList [("class", "navbar-item has-dropdown is-hoverable")]) $ do
      elAttr "a" (Map.fromList [("class", "navbar-link"), ("href", "/#Tentang")]) $
        text "Tentang"
      elAttr "div" (Map.singleton "class" "navbar-dropdown") $ do
        elAttr "a" (Map.fromList [("class", "navbar-item"), ("href", "/#Tentang/VisiMisi")]) $
          text "Visi dan Misi"
        elAttr "a" (Map.fromList [("class", "navbar-item"), ("href", "/#Tentang/Sejarah")]) $
          text "Sejarah"
        elAttr "a" (Map.fromList [("class", "navbar-item"), ("href", "/#Tentang/LaporanTahunan")]) $
          text "Laporan Tahunan"
        elAttr "a" (Map.fromList [("class", "navbar-item"), ("href", "/#Tentang/DKM")]) $
          text "Dewan Kemakmuran Masjid"
        elAttr "a" (Map.fromList [("class", "navbar-item"), ("href", "/#Tentang/Galeri")]) $
          text "Galeri"
        return ()
      return ()
    elAttr "a" (Map.fromList [("class", "navbar-item"), ("href", "/#Berita")]) $
        text "Berita"
    return ()

navbarMenuEnd :: forall t m. MonadWidget t m
          => T.Text
          -> m ()
navbarMenuEnd elm =
  elAttr elm (Map.singleton "class" "navbar-end") $
    return ()
