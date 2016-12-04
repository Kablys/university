hanoiM :: Integer -> IO ()
hanoiM n = hanoiM' n 'a' 'b' 'c' where
  hanoiM' 0 _ _ _ = return ()
  hanoiM' n a b c = do
    hanoiM' (n-1) a c b
    putStrLn $ "Move " ++ show a ++ " to " ++ show c
    hanoiM' (n-1) b a c
