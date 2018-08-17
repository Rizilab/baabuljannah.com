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
  elClass "div" "tile is-ancestor animated bounceInUp slower" $ do
    elClass "div" "tile is-parent" heroLanding
    elClass "div" "tile is-parent is-8" $
      elAttr "div" (Map.singleton "class" "tile is-child box") $ do
        elAttr "div" (Map.singleton "class" "content") $
          elAttr "iframe" (Map.fromList [("src","https://jam.jadwalsholat.org/digitalclock/")]) $ return ()
        elAttr "div" (Map.singleton "class" "content") $
          elAttr "iframe" (Map.fromList [("src","https://www.jadwalsholat.org/adzan/ajax.row.php?id=67")]) $ return ()
        return ()
    return ()


heroLanding :: forall t m. (Reflex t, MonadWidget t m)
            => m ()
<<<<<<< HEAD
heroLanding = do
  let
    tabItems = Map.fromList [(1, ("Info Kajian", heroBannerKajian)), (2, ("Event Masjid", heroBannerEvent))]
    t0 = Maybe.listToMaybe $ Map.keys tabItems

  elClass "div" "hero is-success is-fullheight" $ do
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

heroLandingHead :: forall t m. (Reflex t, MonadWidget t m)
                => m ()
heroLandingHead = pure ()

heroLandingBody :: forall m k t. (Ord k, Reflex t, MonadWidget t m)
                => Map.Map k (Text, m ())
                -> Demux t (Maybe k)
                -> m ()
heroLandingBody tabItems currentTab =
  divClass "hero-body" $
    divClass "container" $ do
      iforM_ tabItems $ \k (_, w) -> do
        let isSelected = demuxed currentTab $ Just k
            attrs = ffor isSelected $ \s -> if s then Map.singleton "class" "content has-text-centered"
                                                 else Map.fromList [ ("class","content has-text-centered")
                                                                   , ("style","display:none;")]
<<<<<<< HEAD
        elDynAttr "div" attrs w
      return ()

heroLandingFoot :: forall t m k. (Ord k, Reflex t, MonadWidget t m)
                => Map.Map k (Text, m ())
                -> m ()
heroLandingFoot tabItems =
  divClass "hero-foot" $
    elClass "nav" "tabs is-boxed is-fullwidth" $
      divClass "container" $ pure ()

heroBannerKajian :: forall t m. (Reflex t, MonadWidget t m)
                 => m ()
heroBannerKajian = do
    el "h1" $ text "Pengumuman Kajian Masjid"

heroBannerEvent  :: forall t m. (Reflex t, MonadWidget t m)
                 => m ()
heroBannerEvent = do
    el "h1" $ text "Pengumuman Event Masjid"
