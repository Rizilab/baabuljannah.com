{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DataKinds #-}


module Web.Tentang.DKM (
  pgTentangDKM
) where

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import Static

import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar

pgTentangDKM :: forall t m. MonadWidget t m
          => m ()
pgTentangDKM =
  elClass "section" "section box animated flipInX fast" $ do
    divClass "container" $ do
      elAttr "div" (Map.fromList [("class","title is-4")
                                 ,("style","text-align:center;")]) $
        el "p" $ text "Susunan Pengurus Dewan Kemakmuran Masjid (DKM) Baabul Jannah"
      divClass "tile is-ancestor" $ do
        ketuaDKM
        wakilKetuaDKM
        return ()
      return ()
    return ()

ketuaDKM :: forall t m. MonadWidget t m
         => m ()
ketuaDKM =
  divClass "tile tile-dkm is-parent is-6 animated fadeInRight delay-1s" $
    divClass "message is-primary" $ do
      divClass "message-header" $ el "p" $ text "Ketua"
      divClass "message-body" $
        divClass "card" $ do
          divClass "card-image card-image-dkm" $
            elClass "figure" "image" $
              elAttr "img" (Map.fromList [("src","https://bulma.io/images/placeholders/128x128.png")
                                         ,("class","is-rounded")]) $ pure ()
          divClass "card-content card-content-dkm" $ do
            elClass "p" "title is-4" $ text "Sofyan"
            elClass "p" "subtitle is-7" $ text "RT...."
            return ()
          return ()
      return ()

wakilKetuaDKM :: forall t m. MonadWidget t m
              => m ()
wakilKetuaDKM =
  divClass "tile tile-dkm is-parent is-6 animated fadeInLeft delay-1s" $
    divClass "message is-primary" $ do
      divClass "message-header" $ el "p" $ text "Wakil Ketua"
      divClass "message-body" $
        divClass "card" $ do
          divClass "card-image card-image-dkm" $
            elClass "figure" "image" $
              elAttr "img" (Map.fromList [("src","https://bulma.io/images/placeholders/128x128.png")
                                         ,("class","is-rounded")]) $ pure ()
          divClass "card-content card-content-dkm" $ do
            elClass "p" "title is-4" $ text "H. Sukro M."
            elClass "p" "subtitle is-7" $ text "RT.012"
            return ()
          return ()
      return ()
