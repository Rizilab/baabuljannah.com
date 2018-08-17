{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE LambdaCase #-}


module Util.Button where

import Reflex
import Reflex.Class
import Reflex.Dom.Builder.Class
import Reflex.Dom.Class
import Reflex.Dom
import Reflex.Dom.Widget.Basic hiding (linkClass, tabDisplay)
import Reflex.Dom.Builder.Immediate

import Data.Maybe
import Data.Text                      as T
import Data.Map (Map)
import qualified Data.Map             as Map

headerBarLink :: forall k t m. (Ord k, MonadWidget t m ) => T.Text -> k -> Dynamic t Bool -> m (Event t k)
headerBarLink x k isSelected = do
      let attrs = fmap (\b -> if b then Map.singleton "class" "is-active" else Map.empty) isSelected
      elDynAttr "li" attrs $ do
        a <- link x
        return $ fmap (const k) (_link_clicked a)

