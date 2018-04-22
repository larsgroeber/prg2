h x = if x < 10 then 0 else 2 * x + h (x - 1)

hIter r x = if x < 10 then r else hIter (r + 2 * x) (x - 1)

h' = hIter 0

f a b c = if c >= 21
    then (if c < 27 then a*c else f a (f a a (c+100)) (c+9))
    else f a (f a a (c+100)) (c+9)


f' a b c = if c >= 21 && c < 27
    then a*c
    else f a (f a a (c+100)) (c+9)