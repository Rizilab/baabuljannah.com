{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE LambdaCase #-}

module UIUtils where

import Data.Text.Encoding
import qualified Data.ByteString.Lazy as BL
import Reflex
import Reflex.Dom
import Data.Text                      as T
import Types
import Data.Map (Map)
import Text.Email.Validate            as Email
import Data.Monoid ((<>))
import Data.Char (isSpace, isLower, isDigit, isUpper)

toCustomClick :: (Show a, MonadWidget t m)
              => T.Text
              -> T.Text
              -> a
              -> T.Text
              -> Maybe (Dynamic t T.Text)
              -> m (Event t (Maybe a))
toCustomClick elm txt label adds (Just dyn) = do
  let dynAttrs = dyn <> (constDyn adds)
  (ev1,_) <- elDynAttr' elm (("class" =:) <$> dynAttrs) $ do
    el "p" $ text txt
  return $ Just <$>  (label <$ (domEvent Click ev1))
toCustomClick elm txt label adds Nothing = do
  (ev1,_) <- elAttr' elm ("class" =: adds) $ do
    el "p" $ text txt
  return $ Just <$> (label <$ (domEvent Click ev1))

blankbr :: (MonadWidget t m) => m ()
blankbr = el "br" $ text ""
