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


module Web.Landing (
  pgLanding
) where

import Reflex
import Reflex.Dom.Core
import Reflex.Class

import Data.Map (Map)
import qualified Data.Map as Map
import Data.Text
import Data.Maybe         as Maybe
import Prelude hiding (mapM, mapM_, sequence, sequence_)
import Control.Applicative
import Control.Monad.Fix
import Control.Monad.Trans.Class
import Control.Lens.Indexed


import Static

import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar

pgLanding :: forall t m. MonadWidget t m
          => m ()
pgLanding =
  elClass "div" "animated bounceInUp slower" $ do
    heroLanding
    elAttr "hr" (Map.singleton "class" "navbar-divider landing-divider") $ pure ()
    tileAddress
    tileMappingBackground


heroLanding :: forall t m. (Reflex t, MonadWidget t m)
            => m ()
heroLanding = do
  let
    tabItems = Map.fromList [(1, ("Info Kajian", heroBannerKajian)), (2, ("Event Masjid", heroBannerEvent))]
    t0 = Maybe.listToMaybe $ Map.keys tabItems
  divClass "tile box is-ancestor" $ do
    elClass "div" "tile is-8 hero is-light is-bold is-large" $ do
      rec
        heroLandingBody tabItems currentTab
        currentTab <-
          divClass "hero-foot" $
            elClass "nav" "tabs is-boxed is-fullwidth" $
              divClass "container" $
                el "ul" $ do
                  tabClicksList <- Map.elems <$> imapM (\k (s, _) -> headerBarLink s k $ demuxed currentTab (Just k)) tabItems
                  let eTabClicks = leftmost tabClicksList
                  fmap demux $ holdDyn t0 $ fmap Just eTabClicks
      return ()
    tileRight

heroLandingHead :: forall t m. (Reflex t, MonadWidget t m)
                => m ()
heroLandingHead = pure ()

heroLandingBody :: forall m k t. (Ord k, Reflex t, MonadWidget t m)
                => Map.Map k (Text, m ())
                -> Demux t (Maybe k)
                -> m ()
heroLandingBody tabItems currentTab =
  divClass "tile is-parent hero-body" $
    iforM_ tabItems $ \k (_, w) -> do
      let isSelected = demuxed currentTab $ Just k
          attrs = ffor isSelected $ \s -> if s then Map.singleton "class" "tile is-child content has-text-centered"
                                               else Map.fromList [ ("class","tile is-child content has-text-centered")
                                                                 , ("style","display:none;")]
      elDynAttr "div" attrs w
      return ()

heroLandingFoot :: forall t m k. (Ord k, Reflex t, MonadWidget t m)
                => Map.Map k (Text, m ())
                -> m ()
heroLandingFoot tabItems =
  divClass "tile is-parent hero-foot" $
    elClass "nav" "tabs is-boxed is-fullwidth" $ pure ()

heroBannerKajian :: forall t m. (Reflex t, MonadWidget t m)
                 => m ()
heroBannerKajian = do
    el "h1" $ text "Pengumuman Kajian Masjid"

heroBannerEvent  :: forall t m. (Reflex t, MonadWidget t m)
                 => m ()
heroBannerEvent = do
    el "h1" $ text "Pengumuman Event Masjid"

tileRight :: forall t m. (Reflex t, MonadWidget t m)
          => m ()
tileRight =
  elAttr "div" (Map.singleton "class" "tile landing-right") $ do
    elAttr "div" (Map.singleton "class" "tile is-parent is-5 is-vertical") $ do
      elAttr "iframe" (Map.fromList [("class","landing-clock"), ("src","https://jam.jadwalsholat.org/digitalclock/")]) $ return ()
      elAttr "iframe" (Map.fromList [("class","landing-adzan"), ("src","https://www.jadwalsholat.org/adzan/ajax.row.php?id=67")]) $ return ()
      elClass "div" "tile is-child" $ do
        elAttr "p" (Map.singleton "class" "title is-4") $ text "Berita Terbaru"
        elAttr "hr" (Map.singleton "class" "navbar-divider landing-divider") $ pure ()
        elAttr "ul" (Map.singleton "class" "content landing-recent") $ do
          el "li" $ elAttr "a" (Map.fromList [("class","landing-news"),("href","#/Media/Berita")]) $ text "Kajian Syuruq"
          el "li" $ elAttr "a" (Map.fromList [("class","landing-news"),("href","#/Media/Berita")]) $ text "Kajian Ummahat"
          el "li" $ elAttr "a" (Map.fromList [("class","landing-news"),("href","#/Media/Berita")]) $ text "Waktu Sholat Iedul Adha"
          return ()
        return ()
      return ()
    nextEvent
    return ()

nextEvent :: forall t m. (Reflex t, MonadWidget t m)
          => m ()
nextEvent =
  elAttr "div" (Map.singleton "class" "tile is-parent is-5 is-vertical") $
    elAttr "div" (Map.singleton "class" "tile is-child") $ do
      elAttr "p" (Map.singleton "class" "title is-4") $ text "Event Berikutnya"
      elAttr "hr" (Map.singleton "class" "navbar-divider landing-divider") $ pure ()
      divClass "card box" $ do
        elAttr "a" (Map.fromList [("class","card-header"),("href","#/Aktivitas")]) $
          elAttr "div" (Map.fromList [("class","card-image")
                                     ,("style","background-image: url(https://d1csp7g2pnyvdv.cloudfront.net/uploads/story_world/cover/6/large_5b45e687-80f9-41a3-b57e-35d55147742a.jpg);")
                                     ]
                       ) $ pure ()
        divClass "card-body" $ do
          elAttr "a" (Map.singleton "href" "#/Aktivitas") $
            divClass "card-title" $ do
              elAttr "p" (Map.singleton "class" "title is-6") $ text "Kajian Syuruq:"
              elAttr "p" (Map.singleton "class" "subtitle") $ text "Menggapai Ridho Ilahi"
          divClass "card-description" $
            el "p" $ text "Ridho ilahi adalah salah satu pencapaian yang sangat diinginkan oleh umat Islam."
          return ()

        divClass "card-footer" $
          elAttr "a" (Map.fromList [("class","button is-link is-outlined")
                                   ,("href","#Aktivitas")
                                   ]) $ text "Baca Selengkapnya"
        return ()
      ----------------------
      divClass "card box" $ do
        elAttr "a" (Map.fromList [("class","card-header"),("href","#/Aktivitas")]) $
          elAttr "div" (Map.fromList [("class","card-image")
                                      ,("style","background-image: url(https://d1csp7g2pnyvdv.cloudfront.net/uploads/story_world/cover/6/large_5b45e687-80f9-41a3-b57e-35d55147742a.jpg);")
                                     ]
                       ) $ pure ()
        divClass "card-body" $ do
          elAttr "a" (Map.singleton "href" "#/Aktivitas") $
            divClass "card-title" $ do
              elAttr "p" (Map.singleton "class" "title is-6") $ text "Kajian Parenting:"
              elAttr "p" (Map.singleton "class" "subtitle") $ text "Al-qur'an Untuk Anak"
          divClass "card-description" $
            el "p" $ text "Anak adalah titipan Allah yang harus selalu dijaga"
          return ()

        divClass "card-footer" $
          elAttr "a" (Map.fromList [("class","button is-link is-outlined")
                                   ,("href","#Aktivitas")
                                   ]) $ text "Baca Selengkapnya"
        return ()
      return ()


tileAddress :: forall t m. (Reflex t, MonadWidget t m)
            => m ()
tileAddress =
  elClass "div" "tile is-ancestor" $
    divClass "tile hero is-primary is-bold is-medium" $
      divClass "tile is-parent hero-body" $
        divClass "tile is-child content has-text-centered" $ do
          elAttr "p"  (Map.singleton "class" "title is-3") $
            text "Masjid Baabul Jannah"
          elAttr "p" (Map.singleton "class" "subtitle") $
            text "Jl. Duta Plaza No.1, Tugu, Cimanggis, Tugu, Depok, Kota Depok, Jawa Barat 16451"
          return ()

tileMappingBackground :: forall t m. (Reflex t, MonadWidget t m)
                      => m ()
tileMappingBackground =
  divClass "tile is-ancestor" $ do
    elAttr "iframe" (Map.fromList [("class","tile is-parent landing-map"),("src","https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d495.64834408143736!2d106.85016445596409!3d-6.369873101677465!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x28c5d9bfea657f99!2sMasjid+Baabul+Jannah!5e0!3m2!1sid!2sid!4v1534577978377"),("width","600"),("height","450"),("frameborder","0"),("style","border:0"),("allowfullscreen","")]) $ return ()
    divClass "tile is-parent box" $
      divClass "content" $ do
        elAttr "p" (Map.singleton "class" "title is-2") $ text "Tentang Masjid"
        elAttr "p" (Map.singleton "class" "subtitle") $ text "Gambaran Umum Masjid Baabul Jannah"
        el "p" $ text "Masjid Baabul Jannah merupakan masjid perumahan yang didirkan sejak tahun 1988 silam. Masjid ini dibangun atas inisiatif para warga muslim sekitar dan berkembang hingga seperti sekarang. Untuk mengetahui sejarah lengkap masjid ini, dapat dilihat melalui halaman Sejarah pada menu navigasi"
        el "p" $ text "Lokasi yang strategis menjadikan Masjid Baabul Jannah baik sebagai tempat singgah para warga yang sedang safar, maupun warga tetap disekitar masjid. Apabila hendak mengunjungi masjid Baabul Jannah, silahkan ikuti peta yang ada pada halaman ini."
        return ()
    return ()
