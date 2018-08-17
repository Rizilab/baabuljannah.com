{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
module Frontend where

import qualified Data.Text as T
import Reflex.Dom.Core

import Util.Collection
import UI

--frontend :: MonadWidget t m => (m (), m ())
--frontend = mkApp [] [] mkUi

headElement :: MonadWidget t m => m ()
headElement = headerHTML []

bodyElement :: MonadWidget t m => m ()
bodyElement = do
  mkUi
  footerHTML []
  return ()
