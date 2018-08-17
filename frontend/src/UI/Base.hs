{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE ConstraintKinds #-}

module UI.Base (
    AppT
  , WebUiM
  , runAppT
  ) where

import Data.Coerce (coerce)
import Data.Text

import Control.Monad.Trans (MonadTrans(..), MonadIO(..))
import Control.Monad.Fix (MonadFix)
import Control.Monad.Exception (MonadException, MonadAsyncException)
import Control.Monad.Ref (MonadRef(..), MonadAtomicRef(..))
import Control.Monad.Reader (MonadReader(..), ReaderT, runReaderT)
import Control.Monad.State (MonadState(..))

import Reflex
import Reflex.Host.Class
import Reflex.Dom.Core

import Reflex.Dom.Routing.Nested
import Reflex.Dom.Routing.Writer
import Reflex.Dom.Storage.Base
import Reflex.Dom.Storage.Class

#ifndef ghcjs_HOST_OS
import GHCJS.DOM.Types (MonadJSM)
#endif

import UI.Storage
import Types.RouteWidget

type WebUiM t m = ( MonadWidget t m
                  , RouteWriter t RouteWidget m
                  , HasRoute t RouteWidget m
                  , HasStorage t CredentialTag m
                  )

newtype AppT t m a = AppT {
  unAppT :: RouteWriterT t RouteWidget (RouteT t RouteWidget (StorageT t CredentialTag m)) a
  } deriving (Functor, Applicative, Monad, MonadIO, MonadFix, MonadHold t,
              MonadException, MonadAsyncException,
              MonadSample t, PostBuild t, MonadReflexCreateTrigger t, TriggerEvent t, MonadAtomicRef)

instance MonadTrans (AppT t) where
  lift = AppT . lift . lift . lift

instance Requester t m => Requester t (AppT t m) where
  type Request (AppT t m) = Request m
  type Response (AppT t m) = Response m
  requesting = lift . requesting
  requesting_ = lift . requesting_

instance (Adjustable t m, MonadHold t m) => Adjustable t (AppT t m) where
  runWithReplace a0 a' = AppT $ runWithReplace (unAppT a0) (fmapCheap unAppT a')
  traverseDMapWithKeyWithAdjust f dm edm = AppT $ traverseDMapWithKeyWithAdjust (\k v -> unAppT $ f k v) (coerce dm) (coerceEvent edm)
  {-# INLINABLE traverseDMapWithKeyWithAdjust #-}
  traverseIntMapWithKeyWithAdjust f dm edm = AppT $ traverseIntMapWithKeyWithAdjust (\k v -> unAppT $ f k v) (coerce dm) (coerceEvent edm)
  {-# INLINABLE traverseIntMapWithKeyWithAdjust #-}
  traverseDMapWithKeyWithAdjustWithMove f dm edm = AppT $ traverseDMapWithKeyWithAdjustWithMove (\k v -> unAppT $ f k v) (coerce dm) (coerceEvent edm)
  {-# INLINABLE traverseDMapWithKeyWithAdjustWithMove #-}

instance PerformEvent t m => PerformEvent t (AppT t m) where
  type Performable (AppT t m) = Performable m
  performEvent_ = lift . performEvent_
  performEvent = lift . performEvent

instance MonadRef m => MonadRef (AppT t m) where
  type Ref (AppT t m) = Ref m
  newRef = lift . newRef
  readRef = lift . readRef
  writeRef r = lift . writeRef r

instance (MonadQuery t q m, Monad m) => MonadQuery t q (AppT t m) where
  tellQueryIncremental = lift . tellQueryIncremental
  askQueryResult = lift askQueryResult
  queryIncremental = lift . queryIncremental

instance (Monad m, NotReady t m) => NotReady t (AppT t m)

instance (DomBuilder t m, MonadHold t m, MonadFix m) => DomBuilder t (AppT t m) where
  type DomBuilderSpace (AppT t m) = DomBuilderSpace m
  textNode = lift . textNode
  element elementTag cfg (AppT child) = AppT $ element elementTag cfg child
  inputElement = lift . inputElement
  textAreaElement = lift . textAreaElement
  selectElement cfg (AppT child) = AppT $ selectElement cfg child
  placeRawElement = lift . placeRawElement
  wrapRawElement e = lift . wrapRawElement e

instance HasDocument m => HasDocument (AppT t m)

instance HasJSContext m => HasJSContext (AppT t m) where
  type JSContextPhantom (AppT t m) = JSContextPhantom m
  askJSContext = AppT askJSContext
#ifndef ghcjs_HOST_OS
instance MonadJSM m => MonadJSM (AppT t m)
#endif

instance MonadState s m => MonadState s (AppT t m) where
  get = lift get
  put = lift . put

<<<<<<< HEAD
=======
{-instance Monad m => MonadReader Text (AppT t m) where
  ask = AppT . lift . lift . lift $ ask
  -- RouteWriterT t RouteWidget (RouteT t RouteWidget (StorageT t CredentialTag (ReaderT Text m))) a
  -- t2                         ( t1                  ( t                       (m             ))) r
  local f = AppT . local f . unAppT
  reader = AppT . lift . reader
--}
>>>>>>> origin/master
instance (Reflex t, Monad m, MonadHold t m) => HasStorage t CredentialTag (AppT t m) where
  askStorage = AppT . lift . lift $ askStorage
  tellStorage = AppT . lift . lift . tellStorage

instance MonadWidget t m => HasRoute t RouteWidget (AppT t m) where
  routeContext = AppT . lift $ routeContext
  withSegments f = AppT . withSegments f . unAppT

instance MonadWidget t m => RouteWriter t RouteWidget (AppT t m) where
  tellRoute = AppT . tellRoute

runAppT :: MonadWidget t m
       => AppT t m ()
       -> m ()
runAppT =
  runStorageT LocalStorage .
    runRoute toSegments fromSegments .
    fmap snd .
    runRouteWriterT .
    unAppT
