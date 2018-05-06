# Aufgabe 3

## a)

`s1 := \y -> if (x y) then ((\w -> w) y) else ((\z -> z) z)`

### FV:

```
FV(s1) = (FV(x y) ∪ FV((\w -> w) y) ∪ FV((\z -> z) z)) \ {y}
FV(s1) = (FV(x) ∪ FV(y) ∪ FV(\w -> w) ∪ FV(y) ∪ FV(\z -> z) ∪ FV(z)) \ {y}
FV(s1) = (FV(x) ∪ FV(y) ∪ FV(w) \ {w} ∪ FV(y) ∪ FV(z) \ {z} ∪ FV(z)) \ {y}
FV(s1) = {x} ∪ {} ∪ {} ∪ {} ∪ {} ∪ {z}
FV(s1) = {x, z}
```

### GV

```
GV(s1) = GV(if (x y) then ((\w -> w) y) else ((\z -> z) z)) ∪ {y}
GV(s1) = GV(x y) ∪ GV((\w -> w) y) ∪ GV((\z -> z) z) ∪ {y}
GV(s1) = GV(x) ∪ GV(y) ∪ GV(\w -> w) ∪ GV(y) ∪ GV(\z -> z) ∪ GV(z) ∪ {y}
GV(s1) = GV(x) ∪ GV(y) ∪ GV(w) ∪ {w} ∪ GV(y) ∪ GV(z) ∪ {z} ∪ GV(z) ∪ {y}
GV(s1) = {} ∪ {} ∪ {} ∪ {w} ∪ {} ∪ {} ∪ {z} ∪ {} ∪ {y}
GV(s1) = {w,z,y}
```

## b)

`s2 := let g x = (\x -> \y -> (g y)) in let w = g u (g y), z = w in g`

### FV:

```
FV(s2) = FV(let g = \x -> (\x -> \y -> (g y)) in let w = g u (g y), z = w in g)
FV(s2) = (FV(let w = g u (g y), z = w in g) ∪ FV(\x -> (\x -> \y -> (g y)))) \ {g}
FV(s2) = ((FV(g) ∪ FV(g u (g y)) ∪ FV(w)) \ {z,w} ∪ FV(\x -> \y -> (g y)) \ {x}) \ {g}
FV(s2) = ((FV(g) ∪ FV(g) ∪ FV(u) ∪ FV(g) ∪ FV(y) ∪ FV(w)) \ {z,w} ∪ (FV(g) ∪ FV(y)) \ {y, x}) \ {g}
FV(s2) = (({g} ∪ {g} ∪ {u} ∪ {g} ∪ {y} ∪ {w}) \ {z,w} ∪ ({g} ∪ {y}) \ {y, x}) \ {g}
FV(s2) = ({g, u, y} ∪ {g}) \ {g}
FV(s2) = {u,y}
```

### GV

```
GV(s2) = GV(let g = \x -> (\x -> \y -> (g y)) in let w = g u (g y), z = w in g)
GV(s2) = {g, x, y} ∪ GV(g y) ∪ GV(let w = g u (g y), z = w in g)
GV(s2) = {g, x, y} ∪ GV(g) ∪ GV(y) ∪ {w, z} ∪ GV(g u (g y)) ∪ GV(w) ∪ GV(g)
GV(s2) = {g, x, y} ∪ {w, z}
GV(s2) = {g, x, y, w, z}
```
