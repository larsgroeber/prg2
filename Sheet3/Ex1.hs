-- =============================================================================
-- Grundlagen der Programmierung 2 
-- Aufgabenblatt 3 - Lars Gröber
-- =============================================================================

    module Ex1 where

    import Data.Char

    -- =============================================================================
    -- =
    -- = Aufgabe 1
    -- =
    
    -- -
    -- - a)
    -- -
    
    -- helper function fo f1
    f1_help (x:xs) | isDigit x = digitToInt x + f1 xs
                   | x == 'a' =  1 + f1 xs
                   | otherwise = f1 xs

    f1 :: String -> Int
    -- Funktion, die einen String erhält und ihn nach ein paar willkürlichen 
    -- Vorgaben in eine Zahl konvertiert
    -- Beispiel: f1 "138aza" soll 14 ergeben
    f1 x | null x = 0
         | otherwise = f1_help x
    
    -- -
    -- - b)
    -- - 
    
    -- converts a string to upper case
    allToUpper = map toUpper
    -- checks if a string ends in '!'
    hasExclamationMark x | null x = False
                         | otherwise = last x == '!'
    -- converts a string to upper case if it ends in '!'
    convertToUpperIfExcalmation x | hasExclamationMark x = allToUpper x
                                  | otherwise = x
    
    f2 :: [String] -> [String]
    -- Funktion, die eine Liste an Strings erhält und alle Strings, die mit einen Ausrufezeichen enden
    -- zu Großbuchstaben konvertiert
    -- Beispiel: f2 "Test!", "Test"] soll ["TEST!", "Test"] ergeben
    f2 = map convertToUpperIfExcalmation
    
    -- -
    -- - c)
    -- -

    -- filter for lists longer than three
    filterForListsLongerThanThree = filter (\ x -> length x > 3)
    -- reverse all inner lists
    reverseAllLists = map reverse
    -- keep first three elements
    keepFirstThree = map (\x -> [head x, x!!1, x!!2])
    -- flatten inner lists to one
    flatten x = flattenIt x []
    flattenIt x s | null x = s
                  | otherwise = flattenIt (tail x) (s ++ head x)
    
    f3 :: [[Int]] -> [Int]
    -- Funktion die eine Liste an Listen von Ints erhält und auf willkürliche Weise diese zu einer
    -- Liste an Ints konvertiert.
    -- Beispiel: f3 [[1,2], [4..8], [5..10]] soll [8, 7, 6, 10, 9, 8] ergeben
    f3 x = flatten (keepFirstThree (reverseAllLists (filterForListsLongerThanThree x)))
    
    -- =
    -- =
    -- =============================================================================
    
    -- =============================================================================
    -- =
    -- = Aufgabe 2
    -- =
    
    -- -
    -- - a)
    -- - 
    
    g1 = undefined -- zu implementieren!
    
    -- -
    -- - b)
    -- -
    
    g2 = undefined -- zu implementieren!
    
    -- -
    -- - c)
    -- -
    
    g3 = undefined -- zu implementieren!
    
    -- =
    -- =
    -- =============================================================================
    
    -- =============================================================================
    -- =
    -- = Aufgabe 3
    -- =
    
    -- Beispiel-Legs.
    leg1 = [[[3,20],[3,20],[3,20]], [[3,20],[3,19],[2,25]], [[3,19],[3,19],[3,19]],
            [[3,20],[3,19],[2,25]], [[2,25],[2,25],[2,25]]]
    leg2 = [[[3,20],[3,20],[3,20]], [[3,20],[3,19],[2,25]], [[3,19],[3,19],[3,19]],
            [[3,20],[3,19],[2,25]], [[2,25],[2,25],[1,25]], [[3,20],[3,19],[2,25]]]
    leg3 = [[[3,20],[1,20],[1,20]], [[3,20],[1,20],[1,20]], [[3,20],[3,20],[3,20]],
            [[3,20],[3,20],[3,20]], [[3,20],[1,1] ,[2,20]], [[3,20],[1,1] ,[2,20]],
            [[3,20],[1,20],[2,20]]]
    leg4 = [[[3,20],[1,20],[1,20]], [[3,20],[1,20],[1,20]], [[3,20],[3,20],[3,20]],
            [[3,20],[3,20],[3,20]], [[3,20],[1,1] ,[2,20]], [[3,20],[1,1] ,[2,20]],
            [[3,20],[1,20],[1,20]], [[3,20],[1,20],[2,20]]]
    
    -- -
    -- - a)
    -- -
    
    legSieger = undefined -- zu implementieren!
    
    -- -
    -- - b)
    -- - 
    
    highOut = undefined -- zu implementieren!
    
    -- =
    -- =
    -- =============================================================================                                                                                    