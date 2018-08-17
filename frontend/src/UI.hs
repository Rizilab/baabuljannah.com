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


module UI (
  mkUi
) where

import Control.Monad (void)

import Reflex.Dom.Core
import Language.Javascript.JSaddle (liftJSM)
import Data.Map (Map)
import qualified Data.Map as Map

import Reflex.Dom.Routing.Writer
import Static

import Types.RouteWidget
import UI.Base
import Util.Bulma.Components.Navbar
import Web

mkUi :: forall t m. MonadWidget t m
     => m ()
mkUi = elClass "section" "section" $ runAppT $ do
  mkNavbar
  mkWeb
  mkFooter
  return ()

{-  divClass "row" . divClass "container-fluid d-flex flex-row" $ do
    divClass "container-fluid p-2" $
      mkBody (tellRedirectLocally [Widget ""])-}

