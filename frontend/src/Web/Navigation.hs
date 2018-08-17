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


module Web.Navigation (
  mkNavbar
) where

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map

import UI.Base
import Util.Bulma.Components.Navbar

mkNavbar :: forall t m. WebUiM t m
         => m ()
mkNavbar = do
  elClass "nav" "navbar animated bounceInDown slower" $ do
    burgerClick <-
      divClass "navbar-brand" $ do
        elAttr "a" (Map.fromList [("class", "navbar-item"), ("href", "/")]) $
          elClass "figure" "image is-128x128" $
            elAttr "img" (Map.singleton "src" ("static/images/baabul_logo_new.jpg")) $ return ()
        navbarBurger "a" "navMenuLanding"
    navbarMenu "div" burgerClick
  return ()
