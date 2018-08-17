{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE LambdaCase #-}

-- {-# LANGUAGE ExplicitForAll #-}

module Widget.Navigation
    (
      --navHeader
      credentialBox
    , logoutBox
    , registerBox
    , navHeaderLoggedIn
    , navHeaderLoggedOut
    , navHeaderRegister
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
import UIUtils

type ListCredTabsM t m a =
  EventWriterT t
    [ (Either String UserCredentialResponse) ] m a

imgsrcLO :: T.Text
imgsrcLO = "/img/navbar_loggedout_logo.png"

imgsrcLI :: T.Text
imgsrcLI = "/img/navbar_loggedin_logo.png"

leftImgLO :: Map.Map T.Text T.Text
leftImgLO = ("src" =: imgsrcLO) <>
            ("class" =: "Nav Nav__Logo")
leftImgLI :: Map.Map T.Text T.Text
leftImgLI = ("src" =: imgsrcLI) <>
            ("class" =: "Nav Nav__Logo")

idAttrs :: Show a => a -> Map.Map T.Text T.Text
idAttrs x = ("id" =: T.pack (show x))

blogLink :: Map.Map T.Text T.Text
blogLink = ("target" =: "_blank") <> ("href" =: "")

showAttrs :: (Reflex t ) => Bool -> Dynamic t T.Text
showAttrs b =
  case b of
    True -> constDyn "LoginAndRegister__Tab_click"
    _    -> constDyn "LoginAndRegister__Tab_notClick"


overlayBox :: Reflex t
           => Dynamic t (Maybe NavBox)
           -> Dynamic t (Map.Map T.Text T.Text)
overlayBox e =
  (\x -> ("class" =: ("Nav Nav__BoxDisplay" <> (unbox x) ))) <$> e
  where
    unbox (Just _)  = " Nav__BoxDisplay_click"
    unbox Nothing   = " Nav__BoxDisplay_notClick"

toNavBox :: UserCredentialResponse -> Maybe NavBox
toNavBox (InvalidAction _ _) = Just Login
toNavBox (LoginCredential _ _ _ _ _) = Nothing
toNavBox (RegisterCredential _ _ _ _) = Nothing

navBoxContainerCredential :: Reflex t
                => Dynamic t (Maybe NavBox)
                -> Dynamic t (Map.Map T.Text T.Text)
navBoxContainerCredential e =
  (\x -> ("class" =: ("NavBox NavBox__Container" <> (unbox x) ))) <$> e
  where
    unbox (Just Login)  = " NavBox__Container__Credential_on"
    unbox (Just About)  = " NavBox__Container__Credential_on"
    unbox (Just Logout) = " "
    unbox Nothing       = " "

navBoxContainerLogout :: Reflex t
                => Dynamic t (Maybe NavBox)
                -> Dynamic t (Map.Map T.Text T.Text)
navBoxContainerLogout e =
  (\x -> ("class" =: ("NavBox NavBox__Container" <> (unbox x) ))) <$> e
  where
    unbox (Just Logout) = " NavBox__Container__LogoutBox_on"
    unbox _             = " "

navBoxContainerRegister :: Reflex t
                => Dynamic t (Maybe NavBox)
                -> Dynamic t (Map.Map T.Text T.Text)
navBoxContainerRegister e =
  (\x -> ("class" =: ("NavBox NavBox__Container" <> (unbox x) ))) <$> e
  where
    unbox _ = " NavBox__Container__RegisterBox_on"
   -- unbox _             = " "

isLoggedOut :: UserCredentialResponse
            -> (Map.Map T.Text T.Text)
isLoggedOut usrC =
  ("class" =: "Nav") <> (check' usrC)
  where
    check' (InvalidAction _ _) = "style" =: "display:block"
    check' _ = "style" =: "display:none"

isLoggedIn :: UserCredentialResponse
           -> (Map.Map T.Text T.Text)
isLoggedIn usrC =
  ("class" =: "Nav") <> (check' usrC)
  where
    check' (LoginCredential _ _ _ _ _) = "style" =: "display:block"
    check' _ = "style" =: "display:none"

{-navHeader :: (MonadWidget t m)
          => Dynamic t UserCredentialResponse
          -> m (Event t [(Either String UserCredentialResponse)])
navHeader userCredDyn = do
  loggedOut <- elDynAttr "div" (isLoggedOut <$> userCredDyn) $ do
    navHeadLO <- navHeaderLoggedOut
    return navHeadLO
  loggedIn <- elDynAttr "div" (isLoggedIn <$> userCredDyn) $ do
    navHeadLI <- navHeaderLoggedIn
    return navHeadLI
  return $ leftmost [loggedOut, loggedIn]-}

credentialBox :: (MonadWidget t m)
              => Dynamic t (Maybe NavBox)
              -> m ((Event t (Maybe LoginBox)) , (Event t [(Either String UserCredentialResponse)]))
credentialBox boxLabel = do
  rec
    overlayLabel <- holdDyn Nothing $ leftmost [usrC, (updated boxLabel)]
    let
      boxClass = overlayBox overlayLabel
      navBoxClass = navBoxContainerCredential overlayLabel
      usrC = (toNavBox . toUserCred) <$> evAll
      dynSelect = Just <$> (Enable <$ (domEvent Click ev1))
    (ev1,_) <- elDynAttr' "div" boxClass $ (return ())
    (ev2,evAll) <- elDynAttr' "div" navBoxClass $ do
        loginProp <- loginProperties boxLabel
        aboutProp <- aboutProperties boxLabel
        return loginProp
  return (dynSelect,evAll)

logoutBox :: (MonadWidget t m)
          => Dynamic t (Maybe NavBox)
          -> m ((Event t (Maybe LoginBox)), (Event t [(Either String UserCredentialResponse)]))
logoutBox boxLabel = do
  rec
    overlayLabel <- holdDyn Nothing $ leftmost [usrC, (updated boxLabel)]
    let
      navBoxClass = navBoxContainerLogout overlayLabel
      usrC = (toNavBox . toUserCred) <$> evAll
      dynSelect = Just <$> (Enable <$ (domEvent Click ev2))
    (ev2,evAll) <- elDynAttr' "div" navBoxClass $ do
        logoutProp <- logoutProperties boxLabel
        return logoutProp
  return (dynSelect,evAll)

registerBox :: (MonadWidget t m)
          => ResponseMessage
          -> Dynamic t (Maybe NavBox)
          -> m ((Event t (Maybe LoginBox)), (Event t [(Either String UserCredentialResponse)]))
registerBox msg boxLabel = do
  rec
    overlayLabel <- holdDyn Nothing $ leftmost [usrC, (updated boxLabel)]
    let
      navBoxClass = navBoxContainerRegister overlayLabel
      usrC = (toNavBox . toUserCred) <$> evAll
      dynSelect = Just <$> (Enable <$ (domEvent Click ev2))
    (ev2,evAll) <- elDynAttr' "div" navBoxClass $ do
        logoutProp <- elDynAttr "div" (showRegis boxLabel) $ do
          el "h1" $ text msg
          yesButton <- toCustomClick "div" "Ok" Yes "Button_yes" Nothing
          return $ yesButton
        return $ ffor logoutProp $ (\case
          (Just _) -> [Right (InvalidAction False "out")]
          Nothing  -> [Left "nothing"])
  return (dynSelect,evAll)

navHeaderLoggedOut :: (MonadWidget t m)
                   => Event t (Maybe LoginBox)
                   -> m (Dynamic t (Maybe NavBox))
navHeaderLoggedOut credBox = do
  elAttr "img" leftImgLO $ text ""
  boxLabel <- do
    let
      updateBoxD = Nothing <$ credBox
    login <- toCustomClick "div" "Masuk" Login "Nav Nav__Login" Nothing
    elAttr "hr" ("class" =: "Nav Nav__VerticalLine") $ text ""
    about <- toCustomClick "div" "Tentang Kami" About "Nav Nav__About" Nothing
    dynSelect <- holdDyn Nothing $ leftmost [login, about, updateBoxD]
    return dynSelect
 -- elAttr "hr" ("class" =: "Nav Nav__HorizontalLine") $ text ""
  return boxLabel

navHeaderLoggedIn :: (MonadWidget t m)
                  => Event t (Maybe LoginBox)
                  -> m (Dynamic t (Maybe NavBox))
navHeaderLoggedIn credBox = do
  elAttr "img" leftImgLI $ text ""
  let
    updateBoxD = Nothing <$ credBox
  boxLabel <- do
    keluar <- toCustomClick "div" "Keluar" Logout "Nav Nav__Logout" Nothing
    dynSelect <- holdDyn Nothing $ leftmost [keluar]
    return dynSelect
  return boxLabel

navHeaderRegister :: (MonadWidget t m)
                  => Event t (Maybe LoginBox)
                  -> m (Dynamic t (Maybe NavBox))
navHeaderRegister credBox = do
  elAttr "img" leftImgLI $ text ""
  {-let
    updateBoxD = Nothing <$ credBox
    boxLabel <- do
    register <- toCustomClick "div" Register "Nav Nav__Register" Nothing
    dynSelect <- holdDyn Nothing $ register
    return dynSelect-}
  return $ constDyn (Just Register)


showAbout :: Reflex t
          => Dynamic t (Maybe NavBox)
          -> Dynamic t (Map.Map T.Text T.Text)
showAbout e =
  (\x -> ("class" =: ("NavBox NavBox_animate NavBox__AboutBox" <> (unbox x)))) <$> e
  where
    unbox (Just About)  = " NavBox__AboutBox_on"
    unbox _             = " "

aboutProperties :: (Reflex t, MonadWidget t m)
                => Dynamic t (Maybe NavBox)
                -> m ()
aboutProperties dynAttrs = do
  result <- elDynAttr "div" (showAbout dynAttrs) $ do
    el "p" $ text "PT. Qoeduu Berkah Bersama"
    return ()
  return ()

showLogin :: Reflex t
          => Dynamic t (Maybe NavBox)
          -> Dynamic t (Map.Map T.Text T.Text)
showLogin e =
  (\x -> ("class" =: ("NavBox NavBox_animate NavBox__LoginBox" <> (unbox x)))) <$> e
  where
    unbox (Just Login)  = " NavBox__LoginBox_on"
    unbox _             = " "

showLogout :: Reflex t
          => Dynamic t (Maybe NavBox)
          -> Dynamic t (Map.Map T.Text T.Text)
showLogout e =
  (\x -> ("class" =: ("NavBox NavBox_animate NavBox__LogoutBox" <> (unbox x)))) <$> e
  where
    unbox (Just Logout)  = " NavBox__LogoutBox_on"
    unbox _              = " "

showRegis :: Reflex t
          => Dynamic t (Maybe NavBox)
          -> Dynamic t (Map.Map T.Text T.Text)
showRegis e =
  (\x -> ("class" =: ("NavBox NavBox_animate NavBox__RegisterBox" <> (unbox x)))) <$> e
  where
    unbox (Just Register)  = " NavBox__RegisterBox_on"
    unbox _              = " NavBox__RegisterBox_on"

-- runEventWriterT :: (Reflex t, Monad m, Semigroup w)
                -- => EventWriterT t w m a
--                 -> m (a, Event t w)
loginProperties :: (Reflex t, MonadWidget t m)
                => Dynamic t (Maybe NavBox)
                -> m (Event t [(Either String UserCredentialResponse)])
loginProperties dynAttrs = do
  (_, evAll) <- runEventWriterT $
    elDynAttr "div" (showLogin dynAttrs) $
      tabDisplay "NavBox__Header" "NavBox__List_on" $
        Map.fromList
          [ (1, ("Masuk", masukProperties))
          , (2, ("Daftar", daftarProperties))
          ]
  return $ evAll

logoutProperties :: (Reflex t, MonadWidget t m)
                 => Dynamic t (Maybe NavBox)
                 -> m (Event t [(Either String UserCredentialResponse)])
logoutProperties dynAttrs = do
  evAll <- elDynAttr "div" (showLogout dynAttrs) $ do
    el "h1" $ text "Anda telah berhasil logout"
    yesButton <- toCustomClick "div" "Ok" Yes "Button_yes" Nothing
    return $ yesButton
  return $ ffor evAll $ (\case
    (Just _) -> [Right (InvalidAction False "out")]
    Nothing    -> [Left "nothing"])

registerProperties :: (Reflex t, MonadWidget t m)
                 => ResponseMessage
                 -> Dynamic t (Maybe NavBox)
                 -> m (Event t [(Either String UserCredentialResponse)])
registerProperties msg dynAttrs = do
  evAll <- elDynAttr "div" (showRegis dynAttrs) $ do
    el "h1" $ text msg
    yesButton <- toCustomClick "div" "Ok" Yes "Button_yes" Nothing
    return $ yesButton
  return $ ffor evAll $ (\case
    (Just _) -> [Right (InvalidAction False "out")]
    Nothing    -> [Left "nothing"])

inputBar :: (MonadWidget t m) => m ()
inputBar =
  elAttr "span" ("class" =: "bar") $ text ""

masukProperties :: (MonadWidget t m)
                => ListCredTabsM t m ()
masukProperties = do
  usrInput <- elAttr "div" ("class" =: "NavBox__Group") $ do
    usrI <- textInput $ def & textInputConfig_inputType .~ "username"
                            & attributes .~ constDyn (("class" =: "NavBox__LandingInput") <>
                                                      ("required" =: "") <>
                                                      ("placeholder" =: " "))
    inputBar
    elAttr "label" ("class" =: "NavBox__LandingInput_title") $ text "Username"
    return usrI

  usrPassword <- elAttr "div" ("class" =: "NavBox__Group") $ do
    usrP <- textInput $ def & textInputConfig_inputType .~ "password"
                            & attributes .~ constDyn (("class" =: "NavBox__LandingInput") <>
                                                      ("required" =: "") <>
                                                      ("placeholder" =: " "))
    inputBar
    elAttr "label" ("class" =: "NavBox__LandingInput_title") $ text "Password"
    return usrP

  blankbr
  evClick <- toCustomClick "button" "Masuk" Masuk "NavBox__Group NavBox__Group__Button" Nothing
  rec
    let
      usr =  value usrInput
      pass = value usrPassword
      cred = tagPromptlyDyn (liftA2 (,) usr pass) evClick
      (eErr, eResp) = fanEither evRsp
    evRsp <- performRequestAsyncWithError ((credApi . toQLogin) <$> cred)
  tellEvent (((\e -> [Left e]) . show) <$> eErr)
  tellEvent (((\e -> [Right e]) . toUCResponse) <$> eResp)
  return ()

toUCResponse :: XhrResponse -> UserCredentialResponse
toUCResponse xhr =
  case decodeXhrResponse xhr of
    (Just response) -> response
    Nothing         -> Types.defaultUCResponse

daftarProperties :: (Reflex t, MonadWidget t m)
                 =>
                 ListCredTabsM t m ()
daftarProperties = do
  usrInput <- elAttr "div" ("class" =: "NavBox__Group") $ do
    usrI <- textInput $ def & textInputConfig_inputType .~ "username"
                            & attributes .~ constDyn (("class" =: "NavBox__LandingInput") <>
                                                      ("required" =: "") <>
                                                      ("placeholder" =: " "))
    inputBar
    elAttr "label" ("class" =: "NavBox__LandingInput_title") $ text "Username"
    elDynAttr "p" ((PU.checkInput . snd) <$> (chkUsr usrI)) $ dynText (snd <$> (chkUsr usrI))
    return usrI

  hpInput <- elAttr "div" ("class" =: "NavBox__Group") $ do
    hpI <- textInput $ def & textInputConfig_inputType .~ "handphone"
                           & attributes .~ constDyn (("class" =: "NavBox__LandingInput") <>
                                                      ("required" =: "") <>
                                                      ("placeholder" =: " "))
    inputBar
    elAttr "label" ("class" =: "NavBox__LandingInput_title") $ text "Handphone"
    elDynAttr "p" ((PU.checkInput . snd) <$> (chkHp hpI)) $ dynText (snd <$> (chkHp hpI))
    return hpI

  usrEmail <- elAttr "div" ("class" =: "NavBox__Group") $ do
    usrE <- textInput $ def & textInputConfig_inputType .~ "email"
                            & attributes .~ constDyn (("class" =: "NavBox__LandingInput") <>
                                                      ("required" =: "") <>
                                                      ("placeholder" =: " "))
    inputBar
    elAttr "label" ("class" =: "NavBox__LandingInput_title") $ text "Email"
    elDynAttr "p" ((PU.checkInput . snd) <$> (chkEm usrE)) $ dynText (snd <$> (chkEm usrE))
    return usrE

  usrPassword <- elAttr "div" ("class" =: "NavBox__Group") $ do
    usrP <- textInput $ def & textInputConfig_inputType .~ "password"
                            & attributes .~ constDyn (("class" =: "NavBox__LandingInput") <>
                                                      ("required" =: "") <>
                                                      ("placeholder" =: " "))
    inputBar
    elAttr "label" ("class" =: "NavBox__LandingInput_title") $ text "Password"
    elDynAttr "p" ((PU.checkInput . snd) <$> (chkPass usrP)) $ dynText (snd <$> (chkPass usrP))
    return usrP

  blankbr
  evClick <- toCustomClick "button" "Daftarkan" Daftar "NavBox__Group NavBox__Group__Button" Nothing
  rec
    let
      usr =  value usrInput
      hp = value hpInput
      email = value usrEmail
      pass = value usrPassword
      theBool = checkFirst <$> usr <*> hp <*> email <*> pass
      theEvent = (\x -> if x == True then evClick else Nothing <$ never) <$> theBool
      cred = tagPromptlyDyn (Types.QRegistration <$> usr <*> hp <*> email <*> pass) (switchDyn theEvent)
      (eErr, eResp) = fanEither evRsp
    evRsp <- performRequestAsyncWithError (credApi <$> cred)
  tellEvent (((\e -> [Left e]) . show) <$> eErr)
  tellEvent (((\e -> [Right e]) . toUCResponse) <$> eResp)
  return ()
  where
    chkUsr  uI = PU.checkUserName <$> (value uI)
    chkHp   hI = PU.checkPhone <$> (value hI)
    chkEm   uE = PU.checkEmail <$> (value uE)
    chkPass uP = PU.checkPassword <$> (value uP)

checkFirst :: T.Text -> T.Text -> T.Text -> T.Text -> Bool
checkFirst usr hp em ps =
  (fst (PU.checkUserName usr)) &&
  (fst (PU.checkPhone hp)) &&
  (fst (PU.checkEmail em)) &&
  (fst (PU.checkPassword ps))

credApi :: Types.UserCredentialPost -> XhrRequest T.Text
credApi usrC =
  case usrC of
    (QRegistration _ _ _ _) ->  XhrRequest "POST" ("/auth/register")
    (QLogin _ _) -> XhrRequest "POST" ("/auth/login")
    $ def & xhrRequestConfig_headers .~ ("Content-Type" =: "application/json")
          & xhrRequestConfig_sendData .~ body
          & xhrRequestConfig_responseHeaders .~ AllHeaders
  where
    body = LT.toStrict $ B.toLazyText $ encodeToTextBuilder $ toJSON usrC

toQLogin :: (T.Text, T.Text) -> Types.UserCredentialPost
toQLogin (usr, pass) = Types.QLogin usr pass


