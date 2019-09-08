{-# LANGUAGE MultiParamTypeClasses   #-}
{-# LANGUAGE ScopedTypeVariables     #-}
{-# LANGUAGE TypeApplications        #-}
{-# LANGUAGE FlexibleInstances       #-}
{-# LANGUAGE AllowAmbiguousTypes     #-}

module Control.Monad.Network.Class.Tagged
       ( Connection(..)
       ) where

import           Control.Monad.Trans.Class   (MonadTrans, lift)
import qualified Data.ByteString.Char8       as S
import Data.Functor.Trans.Tagged

class Connection tag c where
  send :: S.ByteString -> c ()
  recv :: Int -> c S.ByteString
  reconnect :: c ()

instance {-# OVERLAPPABLE #-}
    ( MonadTrans t
    , Connection tag m
    , Monad m
    ) => Connection tag (t m)
  where
      send = lift . send @tag
      recv = lift . recv @tag
      reconnect = lift (reconnect @tag)
