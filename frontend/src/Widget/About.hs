{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Widget.About
    (
        aboutUI
    ) where

import Reflex.Dom

aboutUI :: MonadWidget t m => m ()
aboutUI = elClass "div" "about" $ do
  el "h1" $ text "This is for about"
  return ()
