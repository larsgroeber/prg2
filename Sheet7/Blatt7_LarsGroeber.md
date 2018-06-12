# Aufgabenblatt 7 - Lars Gröber

## 1)

### a)

| Befehl    | Stack    |
| --------- | -------- |
| PushK 11  | 11       |
| PushK 13  | 11,13    |
| Push 1    | 11,13,11 |
| Sub       | 11,2     |
| Push 0    | 11,2,2   |
| Mark 1    | 11,2,2   |
| Branchz 2 | 11,2     |
| Slide 1 1 | 2        |
| PushK 2   | 2,2      |
| PushK 4   | 2,2,4    |
| Mult      | 2,8      |
| PushK 8   | 2,8,8    |
| Sub       | 2,0      |
| Jump 1    | 2,0      |
| Branchz 2 | 2        |
| Mark 2    | 2        |

### b)

Siehe Blatt7_LarsGroeber.hs

## 2)

### a)

```
pushK 1
pushK 1
slide 2 2
```

### b)

```
pushK 1
-
branchz Second
pop
pop
jump False

Second.
pushK 1
-
branchz Third
pop
jump False

Third.
branchz True
False.
pushK 0
jump End

True.
pushK 1

End.
```

### c)

```
START.
# 2
pop
-
push 0
pushK -1

# 8
pop
pop
pop
pushK 1
push 0
pushK -1

# 3
pop
pop
-
pushK 1
pushK 0
pushK -1

# 8 
pop
slide 1 2
pop
pushK 1
pushK 1
pushK 1
pushK -1

# 4
+
pushK -1

# 8
-
pushK -1

# 5
+
*
*
push 0
pushK 1
pushK -1

# 8
pop
pop
pop
pop
pushK 1
push 0
push 0
pushK -1

# 6
+
*
push 1
pushK -1

# 8
+
pop
pop
pushK 1
pushK 1
pushK -1

# 7 
+
*
*
pushK 1
push 0
pushK -1

# 8
pop
pop
pop
pop
pushK 1
push 0
push 0
pushK -1

jump START
```