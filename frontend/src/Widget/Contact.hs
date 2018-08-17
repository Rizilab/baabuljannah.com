{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Widget.Contact
    (
      contactUI
    ) where

import Reflex.Dom

contactUI :: MonadWidget t m => m ()
contactUI = elClass "div" "contact" $ do
  el "h1" $ text "This is for contact"
  return ()
