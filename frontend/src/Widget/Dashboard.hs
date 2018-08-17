{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE LambdaCase #-}

-- {-# LANGUAGE ExplicitForAll #-}

module Widget.Dashboard
    (

    ) where


import Reflex
import Reflex.Class
import Reflex.EventWriter
import Reflex.Dom
import Reflex.Dom.Widget.Basic (tabDisplay)
import Data.Text (Text)
import Data.Text.Encoding as TE
import Data.Aeson
import Data.Aeson.Text
import Data.ByteString.Lazy
import qualified Data.Text.Lazy as LT
import qualified Data.Text.Lazy.Builder as B
import qualified Data.Text     as T
import qualified Data.Maybe    as Maybe
import qualified Data.Map      as Map
import Data.Monoid ((<>))
import Control.Applicative
import Control.Monad (join)

import Types  as Types
import ParseUtil as PU
