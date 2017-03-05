data Level = Level
  { rooms :: [Room]
  , ego   :: Ego
  }

-- | Events that can occur
data Reaction = Reaction
  { trigger   :: Event -> Bool
  , condition :: Condition
  , effect    :: [Event]
  }

data Condition
  = Always
  | And Condition Condition
  | Or  Condition Condition
  | ItemInRoom ..?
  | ItemStateIs String
  | GlobalVar ..?
  ..?

-- | A command the player can enter
data Command
  = Look Object
  | Use  Object
  | UseWith Object Object
  ..?

-- | A place where the player can go
newtype RoomId = RoomId Integer
data Room = Room
  { roomId            :: RoomId
  , roomDescription   :: Description
  , soundRedirections :: [SoundRedirection]
  }

findItemsInRoom :: Level -> Room -> [Item]


-- | A place where an item or a static object can be
data Position = Position
  { x          :: Double
  , y          :: Double
  , z          :: Double
  }

data Location = Location
  { position :: Position
  , roomId   :: RoomId
  }

-- | Collects all the sound in a room and brings it into the
data SoundRedirection = SoundRedirection
  { dampening          :: Double
  , redirectedLocation :: Location -- Target RoomId and Position from target
  }

data Description = Description
  { title :: String
  , body  :: String
  }

data Connection :: Connection
  { targetRoomId :: RoomId
  }


data ItemStatus = Taken | Located Location

data Item = Item
  { itemObject :: Object
  , status     :: ItemStatus
  }

data Fixture = Fixture
  { fixtureObject   :: Object
  , fixtureLocation :: Location
  , isConnection    :: Maybe Connection
  }


data Object = Object
  { objectDescription :: Description
  , isVisible         :: Bool
  , sounds            :: Sounds
  }

data Sounds = Sounds
  { eventSounds :: Event -> Maybe Sound
  , constSound  :: Maybe Sound
  }

data Sound = Sound
  { defaultSample      :: Sample
  , alternativeSamples :: [Sample]
  , order              :: Order
  }
data Order = Random | InOrder

data Sample = Sample ..?

data Ego = Ego
  { egoLocation :: Location
  }
