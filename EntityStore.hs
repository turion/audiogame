data EntityStore a = EntityStore
  { entities   :: [(Integer, a)]
  , keyCounter :: Integer
  }
-- TODO Find more efficient data structure than a list
-- TODO Generalise keyCounter type to a typeclass


initialStore :: EntityStore a
initialStore = EntityStore [] 0

store :: a -> StateT (EntityStore a) m Integer
store a = do
  EntityStore entities keyCounter <- get
  put $ EntityStore ((keyCounter, a) : entities) $ keyCounter + 1

-- TODO Have a version in an error monad that retrieves the value and throws an error if not present
retrieve :: Integer -> StateT (EntityStore a) m (Maybe a)
retrieve n = lookup n <$> gets entities

-- | Tries to remove the key from the store and returns success or failure
-- TODO Make more efficient
-- TODO Possibly make code more beautiful with lenses
remove :: Integer -> StateT (EntityStore a) m Bool
remove n = do
  store <- get
  if n `elem` map fst (entities store)
    then do
          put $ store { entities = filter ((/= n) . fst) entities}
          return True
    else return False
