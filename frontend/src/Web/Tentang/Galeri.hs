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

module Web.Tentang.Galeri (
  pgTentangGaleri
) where

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import Static

import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar

pgTentangGaleri :: forall t m. MonadWidget t m
          => m ()
pgTentangGaleri =
  elClass "div" "tile animated bounceInUp slower" $ do
    return ()
