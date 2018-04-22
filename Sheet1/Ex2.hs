module Ex2 where

note :: Bool -> Bool -> Float -> Float -> Double
note vorgerechnet1 vorgerechnet2 bonus klausurpunkte =
    let totalPoints = klausurpunkte + bonus
        bestanden = klausurpunkte >= 40 && totalPoints >= 50
        vorgerechnet = vorgerechnet1 && vorgerechnet2
        note' | not bestanden || not vorgerechnet = 5.0
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
    in note'
