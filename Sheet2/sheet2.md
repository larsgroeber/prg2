Blatt 2 - Lars Gröber

# Aufgabe 1

## a)

* f1 referenziert f2, f4, f1 direkt
* f2 referenziert f1, f4 direkt
* f3 referenziert f4, f5 direkt
* f4 referenziert f4 direkt
* f5 referenziert f3 direkt

## b)

* f1 referenziert f2, f4, f1
* f2 referenziert f1, f2, f4
* f3 referenziert f4, f5, f3
* f4 referenziert f4
* f5 referenziert f3, f4, f5

## c)

f1 und f5 sind direkt rekursiv.

## d)

f1, f3, f4 und f5 sind rekursiv.

## e)

(f1, f2), (f3, f5) sind verschränkt rekursiv.

# Aufgabe 2

## a)

|                                | g1   | g2   | g3   | g4   |
| -------------                  |------| -----|---   |---   |
| ist iterativ                   | ja   | nein | nein | nein |
| ist endrekursiv                | ja   | nein | nein | nein |
| ist linear rekursiv            | ja   | ja   | nein | nein |
| ist Baum-rekursiv              | ja   | ja   | nein | ja   |
| ist geschachtelt Baum-rekursiv | ja   | ja   | ja   | ja   |

## b)

```haskell
hIter r x = if x < 10 then r else hIter (r + 2 * x) (x - 1)

h' = hIter 0
```

# Aufgabe 3

## a)

`f 1 2 3 = if c >= 21
then (if c < 27 then a*c else f a (f a a (c+100)) (c+9))
else f a (f a a (c+100)) (c+9)`

-> D

`if 3 >= 21
then (if 3 < 27 then 1*3 else f 1 (f 1 1 (3+100)) (3+9))
else f 1 (f 1 1 (3+100)) (3+9)`

-> A

`if False
then (if 3 < 27 then 1*3 else f 1 (f 1 1 (3+100)) (3+9))
else f 1 (f 1 1 (3+100)) (3+9)`

-> I

`f 1 (f 1 1 (3+100)) (3+9)`

-> D

`if (3+9) >= 21
then (if (3+9) < 27 then 1*(3+9) else f 1 (f 1 1 ((3+9)+100)) ((3+9)+9))
else f 1 (f 1 1 ((3+9)+100)) ((3+9)+9)`

-> A

`if 12 >= 21
then (if (3+9) < 27 then 1*(3+9) else f 1 (f 1 1 ((3+9)+100)) ((3+9)+9))
else f 1 (f 1 1 ((3+9)+100)) ((3+9)+9)`

-> A

`if False
then (if (3+9) < 27 then 1*(3+9) else f 1 (f 1 1 ((3+9)+100)) ((3+9)+9))
else f 1 (f 1 1 ((3+9)+100)) ((3+9)+9)`

-> I

`f 1 (f 1 1 ((3+9)+100)) ((3+9)+9)`

-> D

`if ((3+9)+9) >= 21
then (if ((3+9)+9) < 27 then 1*((3+9)+9) else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9))
else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9)`

-> A

`if (12+9) >= 21
then (if ((3+9)+9) < 27 then 1*((3+9)+9) else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9))
else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9)`

-> A
 
`if 21 >= 21
then (if ((3+9)+9) < 27 then 1*((3+9)+9) else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9))
else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9)`

-> A

`if True
then (if ((3+9)+9) < 27 then 1*((3+9)+9) else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9))
else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9)`

-> I

`if ((3+9)+9) < 27 then 1*((3+9)+9) else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9)`

-> A

`if (12+9) < 27 then 1*((3+9)+9) else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9)`

-> A

`if 21 < 27 then 1*((3+9)+9) else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9)`

-> A

`if True then 1*((3+9)+9) else f 1 (f 1 1 (((3+9)+9)+100)) (((3+9)+9)+9)`

-> I

`1*((3+9)+9)`

-> A

`1*(12+9)`

-> A

`1*(21)`

-> A

`21`


## b)

`f 1 2 3 = if c >= 21
then (if c < 27 then a*c else f a (f a a (c+100)) (c+9))
else f a (f a a (c+100)) (c+9)`

-> D

`if 3 >= 21
then (if 3 < 27 then 1*3 else f 1 (f 1 1 (3+100)) (3+9))
else f 1 (f 1 1 (3+100)) (3+9)`

-> A

`if False
then (if 3 < 27 then 1*3 else f 1 (f 1 1 (3+100)) (3+9))
else f 1 (f 1 1 (3+100)) (3+9)`

-> I

`f 1 (f 1 1 (3+100)) (3+9)`

-> A

`f 1 (f 1 1 103) (3+9)`

-> D

`f 1 (if 103 >= 21
then (if 103 < 27 then 1*103 else f 1 (f 1 1 (103+100)) (103+9))
else f 1 (f 1 1 (103+100)) (103+9)) (3+9)`

-> A

`f 1 (if True
then (if 103 < 27 then 1*103 else f 1 (f 1 1 (103+100)) (103+9))
else f 1 (f 1 1 (103+100)) (103+9)) (3+9)`

-> I

`f 1 (if 103 < 27 then 1*103 else f 1 (f 1 1 (103+100)) (103+9)) (3+9)`

-> A

`f 1 (if False then 1*103 else f 1 (f 1 1 (103+100)) (103+9)) (3+9)`

-> I

`f 1 (f 1 (f 1 1 (103+100)) (103+9)) (3+9)`

-> A

`f 1 (f 1 (f 1 1 203) (103+9)) (3+9)`

-> D

`f 1 (f 1 (if 203 >= 21
then (if 203 < 27 then 1*203 else f 1 (f 1 1 (203+100)) (203+9))
else f 1 (f 1 1 (203+100)) (203+9)) (103+9)) (3+9)`

-> A

`f 1 (f 1 (if True
then (if 203 < 27 then 1*203 else f 1 (f 1 1 (203+100)) (203+9))
else f 1 (f 1 1 (203+100)) (203+9)) (103+9)) (3+9)`

Ab hier endlose weitere Auswertung, da der innere if-Ausdruck nie zu True ausgewertet wird.

## c)

`f (1+1) 2 17 = if c >= 21
then (if c < 27 then a*c else f a (f a a (c+100)) (c+9))
else f a (f a a (c+100)) (c+9)`

-> D

`f (1+1) 2 17 = if 17 >= 21
then (if 17 < 27 then (1+1)*17 else f (1+1) (f (1+1) (1+1) (17+100)) (17+9))
else f (1+1) (f (1+1) (1+1) (17+100)) (17+9)`

-> A

`if False
then (if 17 < 27 then (1+1)*17 else f (1+1) (f (1+1) (1+1) (17+100)) (17+9))
else f (1+1) (f (1+1) (1+1) (17+100)) (17+9)`

-> I

`f (1+1) (f (1+1) (1+1) (17+100)) (17+9)`

-> D

`if (17+9) >= 21
then (if (17+9) < 27 then (1+1)*(17+9) else f (1+1) (f (1+1) (1+1) ((17+9)+100)) ((17+9)+9))
else f (1+1) (f (1+1) (1+1) ((17+9)+100)) ((17+9)+9)`

-> A (shared)

`if 26 >= 21
then (if 26 < 27 then (1+1)*26 else f (1+1) (f (1+1) (1+1) (26+100)) (26+9))
else f (1+1) (f (1+1) (1+1) (26+100)) (26+9)`

-> A

`if True
then (if 26 < 27 then (1+1)*26 else f (1+1) (f (1+1) (1+1) (26+100)) (26+9))
else f (1+1) (f (1+1) (1+1) (26+100)) (26+9)`

-> I

`if 26 < 27 then (1+1)*26 else f (1+1) (f (1+1) (1+1) (26+100)) (26+9)`

-> A

`if True then (1+1)*26 else f (1+1) (f (1+1) (1+1) (26+100)) (26+9)`

-> I

`(1+1)*26`

-> A

`2*26`

-> A

`52`


## d)

```haskell
g :: Int -> Int -> Int -> Int
-- Funktion f mit drei Argumenten und ohne doppeltes if
-- g 1 2 3 soll 21 ergeben
g a b c = if c >= 21 && c < 27
    then a*c
    else f a (f a a (c+100)) (c+9)
```