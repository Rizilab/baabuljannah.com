{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE TupleSections #-}
module Main where

import qualified Data.Text            as T
import qualified Data.Map             as Map
import           Data.Maybe
import           Reflex
import           Reflex.Dom
import           Reflex.Dom.Contrib.Router as Router
import           Data.Either
import           Data.Monoid
import           Data.List
import qualified URI.ByteString        as U
import Control.Monad (join)

import           Types
import           Widget


main :: IO ()
main = mainWidgetWithHead headElement bodyElement

headElement :: MonadWidget t m => m ()
headElement = do
  el "title" $ text "Rizilab - Home"
  styleSheet "index.css"
  where
    styleSheet link = elAttr "link" (Map.fromList [
          ("rel", "stylesheet")
        , ("type", "text/css")
        , ("href", link)
      ]) $ return ()

bodyElement :: (MonadWidget t m) => m ()
bodyElement = do
  elAttr' "div" ("class" =: "container") $ do
    rec
      let
        bxLabel = join (fst <$> boxLabel)
        regisAct = switchDyn $ (((fromMaybe ([] <$ never)) . snd) <$> boxLabel)
        response = (toUserCred <$> (leftmost [validation,logoutAction,regisAct]))
      (credBox,validation)   <- credentialBox bxLabel
      (logOBox,logoutAction) <- logoutBox bxLabel
      boxLabel <- widgetHold (navHeaderWithLanding credBox) $ ffor response (navWithRoute validation credBox logOBox)
    return ()
  return ()

navHeaderWithLanding :: (MonadWidget t m)
                     => Event t (Maybe LoginBox)
                     -> m ((Dynamic t (Maybe NavBox)), (Maybe (Event t [(Either String UserCredentialResponse)])))
navHeaderWithLanding cb = do
  navHeader <- navHeaderLoggedOut cb
  landingPage <- landingPage
  return (navHeader,Nothing)

navWithRoute :: (MonadWidget t m)
             => Event t [(Either String UserCredentialResponse)]
             -> Event t (Maybe LoginBox)
             -> Event t (Maybe LoginBox)
             -> UserCredentialResponse
             -> m ((Dynamic t  (Maybe NavBox)), (Maybe (Event t [(Either String UserCredentialResponse)])))
navWithRoute evRoute cB lB usrC =
  case usrC of
    (InvalidAction _ _) -> navHeaderWithLanding cB
    (LoginCredential suc msg jwt usrN role) -> do
      navHeader <- navHeaderLoggedIn lB
      navRoute <- Router.route (createRoute <$> evRoute)
      return (navHeader,Nothing)
    (RegisterCredential suc msg usrN usrE) -> do
      rec
        navHeader <- navHeaderRegister rB
        (rB, regisAction) <- registerBox msg navHeader
      return (navHeader,(Just regisAction))

createRoute :: [(Either String UserCredentialResponse)]
            -> T.Text
createRoute evlist =
  case uncons (rights evlist) of
    Nothing     -> "/"
    Just ((InvalidAction _ _), _) -> "/"
    Just ((LoginCredential _ _ _ _ role), _) -> "/dashboard/" <> role <> "/"
    Just ((RegisterCredential _ m _ _), _) -> "/registration/"
