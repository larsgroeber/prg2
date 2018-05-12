-- ============================================================================
-- Grundlagen der Programmierung 2 
-- Aufgabenblatt 5
-- ============================================================================

    module Blatt5_LarsGroeber where
    import Data.Char
    import Data.List
    
    -- =============================================================================
    -- =
    -- = Aufgabe 1
    -- =
    
    data BBaum a = BBlatt a | BKnoten a (BBaum a) (BBaum a)
      deriving(Eq,Show)
    
    data NBaum a = NBlatt a | NKnoten a [NBaum a]
      deriving(Eq,Show)

    --
    -- b)
    --
    musik = NKnoten "Musik"
        [
            NKnoten "Techno"
            [
                NBlatt "Re-Flex - Ubap",
                NBlatt "Dominion - Salted Popcord",
                NBlatt "XS Project - The Real Bass"
            ],
            NKnoten "Rock"
            [
                NBlatt "CSS - I Fly",
                NBlatt "The Offspring - Pretty Fly",
                NBlatt "Die Ärzte - Deine Schuld"
            ],
            NKnoten "Klassik"
            [
                NBlatt "Beethoven - Mondschein Senate",
                NBlatt "Mozart - Zauberflöte",
                NBlatt "Tchaikovsky - Schwanensee"
            ]
        ]
    
    -- 
    -- c)
    --
    getValueB :: BBaum Int -> Int
    getValueB (BBlatt a) = a
    getValueB (BKnoten a _ _) = a

    allaggr :: BBaum Int -> Bool
    allaggr (BBlatt _) = True
    allaggr (BKnoten sum b1 b2) = (sum == getValueB b1 + getValueB b2) && allaggr b1 && allaggr b2
    
    --
    -- d)
    --
    toNTree :: BBaum a -> NBaum a
    toNTree (BBlatt a) = NBlatt a
    toNTree (BKnoten a b1 b2) = NKnoten a [toNTree b1, toNTree b2]

    listToNTree :: [NBaum (BBaum a)] -> [NBaum (NBaum a)]
    listToNTree [] = []
    listToNTree (NKnoten a list : xs) = NKnoten (toNTree a) (listToNTree list) : listToNTree xs
    listToNTree (NBlatt a : xs) = NBlatt (toNTree a) : listToNTree xs

    btreestontrees :: NBaum (BBaum a) -> NBaum (NBaum a)
    btreestontrees (NKnoten bbaum list) = NKnoten (toNTree bbaum) (listToNTree list)
    
    -- =
    -- =
    -- =============================================================================
    
    -- =============================================================================
    -- =
    -- = Aufgabe 2
    -- =
    
    type Note = (Int, Int, Int, Int)
    -- (Oktave,Tonh"o"he in der Oktave,L"ange,Lautst"arke)
    type Noten = [(Int,Int,Int,Int)]
    -- Baum-Datenstruktur f"ur Melodien und Basslines.
    data Baum = Blatt Noten | Knoten Noten [Baum]
      deriving(Eq,Show)
    -- Datenstruktur f"ur die gesamten Entw"urfe.
    data Entwuerfe = Entwuerfe Baum Baum Int
      deriving(Eq,Show)
    
    -- Beispiel.
    m1 = [(6,3,2,100),(-1,-1,2,100),(5,3,2,100),(-1,-1,1,100),(5,3,2,100),(-1,-1,1,100),(5,3,2,100),(5,6,8,100),(5,9,4,100),(5,10,4,100),(6,1,2,100),(5,6,2,100),(-1,-1,1,100),(5,6,2,100),(-1,-1,1,100),(5,6,2,100),(5,6,2,100),(5,8,2,100),(5,5,2,100),(5,6,2,100),(5,5,1,100),(-1,-1,1,100),(5,6,1,100),(5,4,3,100),(5,3,2,100),(5,5,1,100),(5,7,1,100),(5,8,1,100),(5,10,1,100),(5,11,1,100),(5,12,1,100)]
    m2 = [(5,3,2,100),(4,10,2,100),(-1,-1,1,100),(4,10,2,100),(-1,-1,1,100),(4,10,2,100),(-1,-1,1,100),(4,10,1,100),(4,12,1,100),(4,10,1,100),(4,10,1,100),(4,10,1,100),(5,5,1,100),(5,1,1,100),(5,3,1,100),(5,1,1,100),(5,3,1,100),(4,10,1,100),(5,1,1,100),(4,10,1,100),(5,1,1,100),(4,8,1,100),(4,10,1,100),(4,8,1,100),(5,1,1,100),(4,10,1,100),(5,1,1,100),(4,10,1,100),(5,3,2,100),(-1,-1,2,100),(5,3,2,100),(5,3,2,100),(5,3,2,100),(5,10,1,100),(5,3,1,100),(4,10,2,100),(4,10,2,100),(5,6,2,100),(-1,-1,2,100),(5,1,2,100),(5,1,2,100),(6,3,2,100),(4,10,2,100),(4,10,2,100),(4,10,2,100),(5,3,1,100),(4,10,1,100),(5,1,1,100),(4,10,1,100),(5,3,1,100),(4,10,1,100),(5,1,1,100),(4,12,1,100),(5,3,1,100),(5,1,1,100),(5,2,1,100),(4,10,1,100),(5,3,1,100),(4,10,1,100),(5,1,1,100),(5,2,1,100),(5,3,2,100),(4,10,1,100),(5,1,1,100),(4,10,2,100),(5,1,2,100),(4,10,2,100),(4,11,2,100),(5,1,2,100),(4,11,2,100),(5,3,2,100),(-1,-1,2,100),(5,1,2,100),(5,1,2,100),(4,11,2,100),(5,3,2,100),(5,3,2,100),(5,3,2,100),(5,1,1,100),(-1,-1,1,100),(5,1,1,100),(-1,-1,1,100),(5,1,1,100),(5,6,1,100),(5,4,1,100),(5,3,1,100),(5,1,1,100),(4,11,1,100),(5,3,2,100),(5,1,2,100),(4,10,2,100)]
    m3 = [(5,3,1,100),(5,5,1,100),(5,6,2,100),(5,3,1,100),(5,5,1,100),(5,6,2,100),(5,3,2,100),(5,3,2,100),(5,3,1,100),(5,5,1,100),(5,3,1,100),(5,5,1,100)]
    
    b1 = [(4,3,2,100),(3,3,2,100),(4,3,2,100),(3,3,2,100),(4,3,2,100),(3,3,1,100),(4,3,2,100),(3,3,1,100),(4,3,2,100),(4,6,2,100),(3,6,2,100),(4,6,2,100),(3,6,2,100),(4,9,2,100),(3,9,2,100),(4,10,2,100),(3,10,2,100),(4,1,2,100),(3,6,2,100),(-1,-1,1,100),(3,6,2,100),(-1,-1,1,100),(3,6,2,100),(2,6,2,100),(3,8,2,100),(3,6,2,100),(2,6,2,100),(2,8,2,100),(2,11,1,100),(3,4,3,100),(3,3,2,100),(3,1,2,100),(3,4,2,100),(3,6,2,100)]
    b2 = [(3,3,2,100),(2,10,2,100),(-1,-1,1,100),(2,10,2,100),(-1,-1,1,100),(2,10,2,100),(-1,-1,1,100),(2,10,1,100),(2,10,4,100),(3,5,2,100),(3,3,2,100),(3,1,2,100),(3,5,2,100),(3,3,2,100),(3,1,2,100),(3,5,2,100),(3,3,2,100),(3,3,2,100),(2,6,2,100),(3,3,2,100),(3,3,2,100),(3,3,2,100),(2,6,2,100),(2,10,2,100),(2,10,2,100),(3,6,2,100),(2,6,2,100),(3,1,2,100),(3,1,2,100),(3,3,2,100),(2,10,2,100),(2,10,2,100),(2,10,2,100),(3,3,2,100),(2,10,2,100),(3,3,2,100),(2,10,2,100),(3,3,2,100),(2,10,2,100),(3,3,2,100),(3,1,2,100),(3,3,2,100),(3,1,2,100),(2,10,2,100),(3,1,2,100),(2,10,2,100),(2,11,2,100),(3,1,2,100),(2,11,2,100),(3,3,2,100),(-1,-1,2,100),(3,1,2,100),(3,1,2,100),(2,11,2,100),(3,3,2,100),(3,3,2,100),(3,3,2,100),(3,1,5,100),(3,6,1,100),(3,4,1,100),(3,3,1,100),(3,1,1,100),(2,11,1,100),(3,3,2,100),(3,1,2,100),(2,10,2,100)]
    b3 = [(3,6,2,100),(3,3,2,100),(3,6,2,100),(3,3,2,100),(3,6,4,100),(3,6,1,100),(3,5,1,100),(3,6,1,100),(3,5,1,100)]
    
    mbaum = 
      Knoten m1 
        [Knoten m2
          [Knoten m1
             [Knoten m3
               [Blatt m2]
              ,
              Knoten m2
               [Blatt m3]
             ]
           ,
           Knoten m3
             [Knoten m2
               [Blatt m1,
                Blatt m3]
             ]
          ]
         ,
         Knoten m2
           [Blatt m1
            ,
            Knoten m1
              [Blatt m2,
               Blatt m3,
               Blatt m1
              ]
           ]
        ]
    
    bbaum = 
      Knoten b1 
        [Knoten b2
          [Knoten b1
             [Knoten b3
               [Blatt b2]
              ,
              Knoten b2
               [Blatt b3]
             ]
           ,
           Knoten b3
             [Knoten b2
               [Blatt b1,
                Blatt b3]
             ]
          ]
         ,
         Knoten b2
           [Blatt b1
            ,
            Knoten b1
              [Blatt b2,
               Blatt b3,
               Blatt b1
              ]
          ]
        ]
    
    entwuerfe = Entwuerfe mbaum bbaum 152
    
    --
    -- a)
    --
    anzahlNotenMB :: Entwuerfe -> Int
    anzahlNotenMB (Entwuerfe m _ _) = anzahlNotenMBIt m

    anzahlNotenMBIt :: Baum -> Int
    anzahlNotenMBIt (Blatt a) = length a
    anzahlNotenMBIt (Knoten a list) = length a + anzahlNotenMBList list

    anzahlNotenMBList :: [Baum] -> Int
    anzahlNotenMBList list = sum $ map anzahlNotenMBIt list
    
    --
    -- b)
    --
    transposeNote :: Int -> Note -> Note
    transposeNote value (a,b,c,d) = (a + ((tb - 1) `div` 12), (12 + tb - 1) `mod` 12 + 1, c, d) 
      where tb = b + value
    
    transposeNoten :: Int -> Noten -> Noten
    transposeNoten value = map (transposeNote value)

    transponiere :: Entwuerfe -> Int -> Entwuerfe
    transponiere (Entwuerfe m b t) value = Entwuerfe (transponiereIt value m) (transponiereIt value b) t

    transponiereIt :: Int -> Baum -> Baum
    transponiereIt value (Blatt a) = Blatt (transposeNoten value a)
    transponiereIt value (Knoten a list) = Knoten (transposeNoten value a) (map (transponiereIt value) list)
    
    -- =
    -- =
    -- =============================================================================