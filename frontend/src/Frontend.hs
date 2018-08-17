{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
module Frontend where

import qualified Data.Text as T
import Reflex.Dom.Core

import Static
import Util.Collection
import UI

frontend :: MonadWidget t m => (m (), m ())
frontend = mkApp [] [] mkUi
