{-# LANGUAGE GADTs #-}
{-@ LIQUID "--reflection" @-}
-- | Test that the refinement types produced for GADTs are
-- compatible with the Haskell types.
module T2349 where

data Expr t where
  I :: Int -> Expr Int

  NIL :: Expr [t]
  CONS :: Int -> Expr t -> Expr [t] -> Expr [t]

{-@
data Expr t where
  I :: Int -> Expr Int
  NIL :: Expr {v:[t] | len v = 0}
  CONS :: i:Nat -> head:Expr t -> tail:Expr {v:[t] | len v = i} ->
          Expr {v:[t] | len v = i+1}
@-}


{-@
good :: Expr {v:[Int] | len v = 1}
@-}
good :: Expr [Int]
good = CONS 0 (I 2) NIL
