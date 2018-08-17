{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE LambdaCase #-}

-- {-# LANGUAGE ExplicitForAll #-}

module Widget.Landing
    (
      landingPage
    ) where


import Reflex
import Reflex.Class
import Reflex.EventWriter
import Reflex.Dom
import Reflex.Dom.Widget.Basic (tabDisplay)
import Data.Text (Text)
import Data.Text.Encoding as TE
import Data.Aeson
import Data.Aeson.Text
import Data.ByteString.Lazy
import qualified Data.Text.Lazy as LT
import qualified Data.Text.Lazy.Builder as B
import qualified Data.Text     as T
import qualified Data.Maybe    as Maybe
import qualified Data.Map      as Map
import Data.Monoid ((<>))
import Control.Applicative
import Control.Monad (join)

import Types  as Types
import ParseUtil as PU

imgsrcFO :: T.Text
imgsrcFO = "/img/footer_white_logo.png"

centerImgFO :: Map.Map T.Text T.Text
centerImgFO = ("src" =: imgsrcFO) <>
              ("class" =: "LandingBox LandingBox__Footer__Logo")

imgsrcBigIcon :: T.Text
imgsrcBigIcon = "/img/big_icon_landing_logo.png"

leftBigIcon :: Map.Map T.Text T.Text
leftBigIcon = ("src" =: imgsrcBigIcon) <>
              ("class" =: "LandingBox LandingBox__Main LandingBox__Main__Icon")

landingPage :: (MonadWidget t m)
            => m () -- (Event t [(Either String UserCredentialResponse)])
landingPage = do
  landingBox <- elAttr "div" ("class" =: "LandingBox") $ do
    landingBoxMain <- elAttr "div" ("class" =: "LandingBox LandingBox__Main") $ do
        elAttr "img" leftBigIcon $ text ""
        el "h1" $ text "QOEIPS hadir untuk anda"
        el "p"  $ text "QOEIPS merupakan jasa manajemen kekayaan intelektual berbasis Aplikasi Web yang dikembangkan oleh PT. Qoeduu Berkah Bersama"
        return ()
    landingBoxStatic
    landingBoxTabUI <- elAttr "div" ("class" =: "LandingBox LandingBox__TabUI") $ do
      tabDisplay "LandingBox LandingBox__TabUI LandingBox__TabUI__Header" "LandingBox LandingBox__TabUI LandingBox__TabUI_on" $
        Map.fromList
          [ (1, ("Who", tabUIWho))
          , (2, ("Why", tabUIWhy))
          , (3, ("Where", tabUIWhere))
          ]
      return ()
    landingBoxPartner
    landingBoxCopyright
  return ()

landingBoxStatic :: (MonadWidget t m)
                 => m ()
landingBoxStatic = do
  boxStatic <- elAttr "div" ("class" =: "LandingBox LandingBox__Static") $ do
    el "h1" $ text "Sistem Integrasi Hak atas Kekayaan Intelektual"
    el "hr" $ text ""
    el "p"  $ text "QOEIPS merupakan sistem integrasi hak atas kekayaan intelektual pertama yang akan membantu anda dalam mengelola kekayaan intelektual yang anda miliki"
  return ()

landingBoxPartner :: (MonadWidget t m)
                  => m ()
landingBoxPartner = do
  partner <- elAttr "div" ("class" =: "LandingBox LandingBox__Partner") $ do
    el "h1" $ text "Mitra Kami"
    return ()
  return ()

landingBoxCopyright :: (MonadWidget t m)
                    => m ()
landingBoxCopyright = do
  footer <- elAttr "div" ("class" =: "LandingBox LandingBox__Footer") $ do
    elAttr "img" centerImgFO $ text ""
    el "p" $ text "QOEIPS - 2018 All Rights Reserved."
    return ()
  return ()

tabUIWho :: (MonadWidget t m)
         => m ()
tabUIWho = do
  tabWho <- elAttr "div" ("class" =: "LandingBox LandingBox__TabUI LandingBox__TabUI__Who") $ do
    el "h1" $ text "QOEIPS, Qoeduu Intellectual Property System."
    el "p"  $ text "QOEIPS merupakan solusi utama anda dalam manajemen kekayaan intelektual anda"
    return ()
  return ()

tabUIWhy :: (MonadWidget t m)
         => m ()
tabUIWhy = do
  tabWhy <- elAttr "div" ("class" =: "LandingBox LandingBox__TabUI LandingBox__TabUI__Why") $ do
    el "h1" $ text "Mudah, Terjamin, dan Terbaik"
    el "p"  $ text "Dengan menggunakan QOEIPS, semua kekayaan intelektual anda dengan mudah dikelola, terjamin kerahasiaannya dan berada pada pelayanan terbaik"
    return ()
  return ()

tabUIWhere :: (MonadWidget t m)
           => m ()
tabUIWhere = do
  tabWhere <- elAttr "div" ("class" =: "LandingBox LandingBox__TabUI LandingBox__TabUI__Where") $ do
    el "h1" $ text "Dari Sabang Sampai Merauke"
    el "p"  $ text "QOEIPS memiliki data center yang terpusat di Indonesia untuk menjaga privasi para pengguna."
    return ()
  return ()
