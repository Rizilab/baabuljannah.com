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


module Web.Media (
    pgMedia
  , pgMediaBerita
  , pgMediaPublikasi
  , pgMediaSiaranPers
) where


import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import Static

import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar

import Web.Media.Berita
import Web.Media.Publikasi
import Web.Media.SiaranPers

pgMedia :: forall t m. MonadWidget t m
          => m ()
pgMedia =
  elClass "div" "tile animated bounceInUp slower" $ do
    return ()
