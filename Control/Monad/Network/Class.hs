{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}

module Control.Monad.Network.Class
       ( MonadConnection(..)
       , RunMonadConnection(..)
       ) where

import qualified Data.ByteString.Char8 as S

class Monad c => MonadConnection c where
  send :: S.ByteString -> c ()
  recv :: Int -> c S.ByteString
  reconnect :: c ()

class MonadConnection c => RunMonadConnection c s m | c -> s, c -> m where
  runConnection :: s -> c a -> m a
