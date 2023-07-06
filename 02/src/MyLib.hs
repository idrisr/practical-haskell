module MyLib (ack) where

-- ackermann
ack :: Int -> Int -> Int
ack 0 n = n + 1
ack m 0 = ack m' 1
    where m' = m-1
ack m n = ack m' $ ack m n'
    where n' = n-1
          m' = m-1

{-
A(0,   n)   = n + 1
A(m+1, 0)   = A(m, 1)
A(m+1, n+1) = A(m, A(m+1, n))

-}
