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