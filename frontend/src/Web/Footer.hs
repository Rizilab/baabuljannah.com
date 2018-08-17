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
  elClass "" "animated bounceInDown slower" $ return ()
