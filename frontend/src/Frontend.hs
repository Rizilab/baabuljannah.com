{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
module Frontend where

import qualified Data.Text as T
import Reflex.Dom.Core

import Common.Api
import Static
import Util.Collection
import UI

frontend :: (StaticWidget x (), Widget x ())
frontend = mkApp [] [] mkUi
