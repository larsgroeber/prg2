-- ============================================================================
-- Grundlagen der Programmierung 2 
-- Aufgabenblatt 1
-- Lars Gröber
-- ============================================================================

    module Blatt1 where

    import Data.List

    -- =
    -- = Aufgabe 1
    -- =
    
    note :: Bool -> Bool -> Float -> Float -> Double
    note vorgerechnet1 vorgerechnet2 bonus klausurpunkte =
        let totalPoints = klausurpunkte + bonus
            -- Zum Bestehen können nicht mehr als 10 Bonuspunkte verwendet werden
            bestanden = klausurpunkte >= 40 && totalPoints >= 50
            -- In beiden Hälften muss vorgerechnet werden
            vorgerechnet = vorgerechnet1 && vorgerechnet2
            -- Guards zur Berechnung der Note
            mark | not bestanden || not vorgerechnet = 5.0
                    | totalPoints >= 86 = 1.0
                    | totalPoints >= 82 = 1.3
                    | totalPoints >= 78 = 1.7
                    | totalPoints >= 74 = 2.0
                    | totalPoints >= 70 = 2.3
                    | totalPoints >= 66 = 2.7
                    | totalPoints >= 62 = 3.0
                    | totalPoints >= 58 = 3.3
                    | totalPoints >= 54 = 3.7
                    | totalPoints >= 50 = 4.0
                    | otherwise = 0
        in mark
        
    -- Beispiele (alle geben True zurück):
    -- (note False True 10 400) == 5.0
    -- (note True False 10 400) == 5.0
    -- (note True True 10 90) == 1.0
    -- (note True True 4 45) == 5.0
    
    -- =
    -- = Aufgabe 2
    -- =
    -- = ---------------------------------------------------------------------------
    -- = - zeigeFeld und Beispielmatrizen.
    -- = -
    
    zeigeFeld feld = putStrLn $ unlines [[feld i (5-j) | i <- [1..5]] | j <- [1..4]]
    
    -- Start
    feldA 1 1 = 's'
    feldA 1 2 = 's'
    feldA 1 3 = 's'
    feldA 1 4 = 's'
    feldA 5 1 = 'w'
    feldA 5 2 = 'w'
    feldA 5 3 = 'w'
    feldA 5 4 = 'w'
    feldA _ _ = ' '
    
    -- Fast erreichtes Ziel.
    feldB 1 1 = 'w'
    feldB 1 2 = 'w'
    feldB 1 3 = 'w'
    feldB 1 4 = 'w'
    feldB 4 3 = 's'
    feldB 5 1 = 's'
    feldB 5 3 = 's'
    feldB 5 4 = 's'
    feldB _ _ = ' '
    
    -- = -
    -- = - Aufgabe a)
    -- = -
    
    -- Zug ist diagonal, wenn in x- und y-Richtung (betragsmäßig) gleich viele Schritte gegangen werden
    istZugDiagonal xFigur yFigur xZiel yZiel = abs (xFigur - xZiel) == abs (yFigur - yZiel)
    
    -- Beispiele:
    -- istZugDiagonal 1 1 2 2 == True
    -- istZugDiagonal 1 2 3 4 == True
    -- istZugDiagonal 5 1 8 4 == True
    -- istZugDiagonal 1 1 2 3 == False
    -- istZugDiagonal 1 2 2 4 == False
    -- istZugDiagonal 5 1 7 4 == False

    -- = -
    -- = - Aufgabe b)
    -- = -

    -- Hilfsfunktion, die den Richtungsvektor zurückgibt
    direction 0 = (-1,1)
    direction 1 = (1,1)
    direction 2 = (1,-1)
    direction 3 = (-1,-1)
                
    otherColor 'w' = 's'
    otherColor 's' = 'w'

    -- gibt True zurück, wenn Punkt außerhalb des Feldes ist
    outsideField x y = x < 0 || y < 0 || x > 5 || y > 4

    bishopInDirection :: Int -> Int -> (Int, Int) -> (Int -> Int -> Char) -> Char
    -- gibt ' ' zurück, wenn kein Läufer in der gegebenen Richtung ist, ansonsten wird die Farbe des Läufers
    -- zurückgegeben
    bishopInDirection x y dir field = result 
        where result | outsideField x y = ' '
                     | field x y /= ' ' = field x y
                     -- rekursiv einen Schritt in die gegebene Richtung gehen
                     | otherwise = bishopInDirection (x + fst dir) (y + snd dir) dir field

    -- wird bedroht, wenn ein Läufer der anderen Farbe in der gegebenen Richtung steht
    bedrohtRichtung x y c dir field = bishopInDirection x y (direction dir) field == otherColor c
    
    -- Beispiele:
    -- bedrohtRichtung 3 1 's' 1 feldA == True
    -- bedrohtRichtung 3 3 's' 2 feldA == True
    -- bedrohtRichtung 3 1 'w' 0 feldA == True
    -- bedrohtRichtung 3 1 'w' 1 feldA == False
    -- bedrohtRichtung 3 3 'w' 2 feldA == False
    -- bedrohtRichtung 3 1 's' 0 feldA == False

    -- = -
    -- = - Aufgabe c)
    -- = -
    
    -- Feld wird bedroht, wenn es aus einer der vier Richtungen bedroht wird
    bedroht x y c field = bedrohtRichtung x y c 0 field 
        || bedrohtRichtung x y c 1 field 
        || bedrohtRichtung x y c 2 field 
        || bedrohtRichtung x y c 3 field 

    -- Beispiele:
    -- bedroht 3 1 's' feldA == True
    -- bedroht 3 3 's' feldA == True
    -- bedroht 3 1 'w' feldA == True
    -- bedroht 2 2 's' feldA == False
    -- bedroht 2 3 's' feldA == False
    -- bedroht 4 2 'w' feldA == False
    
    -- = -
    -- = - Aufgabe d)
    -- = -
    
    -- Zug ist gültig, wenn auf dem Ausgangsfeld eine Figur, auf dem Zielfeld keine Figur steht
    -- der Zug diagonal ist und das Zielfeld nicht bedroht wird
    istZugGueltig xF yF xG yG field = field xF yF /= ' '
        && field xG yG == ' '
        && istZugDiagonal xF yF xG yG 
        && not (bedroht xG yG color field)
        where color = field xF yF 

    -- Beispiele:
    -- istZugGueltig 1 1 2 2 feldA == True
    -- istZugGueltig 5 3 4 2 feldA == True
    -- istZugGueltig 4 3 5 2 feldB == True
    -- istZugGueltig 1 1 3 3 feldA == False
    -- istZugGueltig 5 3 2 3 feldA == False
    -- istZugGueltig 4 3 5 2 feldA == False
    
    -- = -
    -- = - Aufgabe e)
    -- = -
    
    -- Wenn Zug gültig ist, übergebe das neue Feld, ansonsten gebe das alte zurück
    zieheWennGueltig xF yF xG yG field = if istZugGueltig xF yF xG yG field
        then newField 
        else field 
        where 
            newField x y
                | x == xF && y == yF = ' '
                | x == xG && y == yG = field xF yF 
                | otherwise = field x y
    
    -- Beispiele:
    -- (zieheWennGueltig 1 1 2 2 feldA) 1 1 == ' '
    -- (zieheWennGueltig 1 1 2 2 feldA) 2 2 == 's'
    -- (zieheWennGueltig 5 3 4 2 feldA) 4 2 == 'w'
    -- (zieheWennGueltig 5 3 4 2 feldA) 5 3 == ' '

    -- = -
    -- = - Aufgabe f)
    -- = -
    
    -- Rätsel ist gelöst, wenn alle weißen Läufer auf der linken und alle schwarzen auf der rechten
    -- Seite des Spielfeldes stehen.
    geloest field = field 1 1 == 'w'
        && field 1 2 == 'w'
        && field 1 3 == 'w'
        && field 1 4 == 'w'
        && field 5 1 == 's'
        && field 5 2 == 's'
        && field 5 3 == 's'
        && field 5 4 == 's'

    -- Beispiele:
    -- geloest (zieheWennGueltig 4 3 5 2 feldB) == True
    -- geloest (zieheWennGueltig 3 3 5 2 feldB) == False