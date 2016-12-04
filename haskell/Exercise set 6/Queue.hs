module Queue
(Queue,
emptyQ, -- :: Queue a
addQ, -- :: a -> Queue a -> Queue a
remQ -- :: Queue a -> Maybe (a,Queue a)
)
where

newtype Queue a = Q ([a],[a])

emptyQ :: Queue a
emptyQ = Q ([],[])

addQ :: a -> Queue a -> Queue a
addQ new (Q (add,re)) = Q (new:add,re)

remQ :: Queue a -> Maybe (a,Queue a)
remQ (Q ([], [])) = Nothing
remQ (Q (add, [])) = remQ (Q ([], reverse add))
remQ (Q (add, x:xs)) = Just (x, Q (add, xs))
