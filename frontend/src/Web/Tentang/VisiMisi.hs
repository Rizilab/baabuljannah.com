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


module Web.Tentang.VisiMisi (
  pgTentangVisiMisi
) where

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar

pgTentangVisiMisi :: forall t m. MonadWidget t m
          => m ()
pgTentangVisiMisi =
  elClass "div" "tile is-ancestor animated bounceInU slower" $ do
    elClass "div" "tile is-parent" $
      el "h1" $ text "Tentang Visi & Misi"
    elClass "div" "tile is-parent is-8" $
      elAttr "div" (Map.singleton "class" "tile is-child box") $ do
        elAttr "div" (Map.singleton "class" "content") $
          elAttr "iframe" (Map.fromList [("src","https://jam.jadwalsholat.org/digitalclock/")]) $ return ()
        elAttr "div" (Map.singleton "class" "content") $
          elAttr "iframe" (Map.fromList [("src","https://www.jadwalsholat.org/adzan/ajax.row.php?id=67")]) $ return ()
        return ()
    return ()
