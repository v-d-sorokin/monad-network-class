{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}

module Control.Monad.Ether.Network.Class
       ( MonadConnection(..)
       ) where

import qualified Data.ByteString.Char8 as S
import Control.Monad.Trans.Class

class Monad c => MonadConnection tag c where
  send :: proxy tag -> S.ByteString -> c ()
  recv :: proxy tag -> Int -> c S.ByteString
  reconnect :: proxy tag -> c ()

instance {-# OVERLAPPABLE #-}
         (MonadTrans t, Monad (t m), MonadConnection tag m) => MonadConnection tag (t m) where
  send tag b = lift $ send tag b
  recv tag len = lift $ recv tag len
  reconnect tag = lift $ reconnect tag
