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
    pgBerita
) where


import Control.Monad (void)

import Reflex.Dom.Core
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Data.Text

import Reflex.Dom.Routing.Writer
import Reflex.Dom.Routing.Nested
import Static

import Types.RouteWidget
import UI.Base
import Util.Button
import Util.Bulma.Components.Navbar

pgBerita :: forall t m. WebUiM t m
          => m ()
pgBerita =
   void $ withRoute $ \route -> case fromMaybe (Widget "") route of
     Widget "" -> pgLandingBerita
     Widget _  -> tellRedirectLocally [Widget ""]

pgLandingBerita :: forall t m. MonadWidget t m
          => m ()
pgLandingBerita =
  elClass "section" "hero is-medium animated is-light is-bold slideInRight slower" $
    divClass "hero-body" $
      divClass "container" $ do
        divClass "columns is-centered" $ do
          divClass "column is-half" $
            elAttr "a" (Map.fromList [("href","/#"),("class","content")]) $ do
              elAttr "h3" (Map.singleton "class" "title is-3") $ text "Halaman ini sedang dalam perbaikan, silahkan kembali lagi nanti"
              return ()
          return ()
        return ()
