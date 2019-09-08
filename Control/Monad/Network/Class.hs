{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleInstances #-}

module Control.Monad.Network.Class
       ( Connection(..)
       ) where

import qualified Data.ByteString.Char8 as S
import           Control.Monad.Trans.Class   (MonadTrans, lift)

class Connection c where
  send :: S.ByteString -> c ()
  recv :: Int -> c S.ByteString
  reconnect :: c ()

instance {-# OVERLAPPABLE #-}
    ( MonadTrans t
    , Connection m
    , Monad m
    ) => Connection (t m)
  where
      send = lift . send
      recv = lift . recv
      reconnect = lift reconnect
