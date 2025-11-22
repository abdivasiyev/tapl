module Chapter3 where

data Term
  = TTrue
  | TFalse
  | TZero
  | IsZero Term
  | Succ Term
  | Pred Term
  | IfThenElse Term Term Term
  deriving (Eq, Show)

terms :: Int -> [Term]
terms 0 = []
terms 1 = [TTrue, TFalse, TZero]
terms n =
  terms (n - 1)
    <> map IsZero (terms (n - 1))
    <> map Succ (terms (n - 1))
    <> map Pred (terms (n - 1))
    <> [ IfThenElse t1 t2 t3
       | i <- [1 .. n - 2]
       , j <- [1 .. n - 1 - i]
       , let k = n - 1 - i - j
       , k > 0
       , t1 <- terms i
       , t2 <- terms j
       , t3 <- terms k
       ]

ex3_2_3 :: Int
ex3_2_3 = length . terms $ 3

-- >>> ex3_2_3
-- 48
