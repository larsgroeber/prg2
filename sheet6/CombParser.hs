{-
   Eine Kombinatorbibliothek mittels Parser-Kombinatorn  
   Jeder Teilparser akzeptiert einen String und gibt eine Liste aus Paaren zurueck:
              (Reststring, Parse-Ergebnis)
    Die Infix-Funktionen  <*>, <*, *>   koennen jeweils 2 Parser kombinieren
        und parsen; erst Parse 1, dann Parser 2, 
         der Unterschied liegt in der Weitergabe der Ergebnisse
    Die Infix-Funktionen  <|>, <!>   kombinieren Parser als alternative Moeglichkeiten
    der erste untersucht beide Moeglchkeiten, und  <!> nimmt maximal eine erfolgreiche.
  
 Um einen deterministischen Parser zu erhalten:  niemals <|>  sondern nur <!> verwenden.
 Dann ist aber die Fehlererkennung nicht besser. Fuer bessere Fehlererkennung: CombParserWithError11
-}

{-   im ghc 7.10:  braucht man  wg <*>: 
   import Prelude hiding ((<*>),(*>),(<*))
-}
module CombParser where

  import Prelude hiding ((<*>),(*>),(<*))
  import Data.Char
  
  
  infixr 6 <*>, <*, *>
  infixr 4 <|>, <!>
  infixl 5 <@ 
  
  
  
  type Parser a b = [a] -> [([a],b)]
  
  symbol :: Eq s => s -> Parser s s
  symbol a []                      = []
  symbol a (x:xs)  | a ==x         = [(xs,x)]
                   | otherwise     = []
  
  token :: Eq s => [s] -> Parser s [s]
  --  token :: Eq s => [s] -> Parser s [s]
  token k xs | k == (take n xs)    = [(drop n xs, k)] 
             | otherwise           = []
                                   where n = length k
  
  satisfy :: (s -> Bool) -> Parser s s
  satisfy p [] = []
  satisfy p (x:xs) = [(xs,x) | p x]
  
  epsilon :: Parser s ()
  epsilon xs = [(xs,())]
  
  succeed :: r -> Parser s r
  succeed v xs = [(xs,v)]
  
  pfail :: Parser s r
  pfail xs = []
  
  ---infixr 6 <*>, <*, *>
  --- infixr 4 <|>
  
  (<*>) :: Parser s a -> Parser s b -> Parser s (a,b)
  (p1 <*> p2) xs = [(xs2, (v1,v2)) 
                   | (xs1,v1) <- p1 xs,
                     (xs2,v2) <- p2 xs1]
  
  (<|>) :: Parser s a -> Parser s a -> Parser s a
  (p1 <|> p2) xs = p1 xs ++ p2 xs
  
  --   nimmt nur das erste Ergebnis einer Alternative:   
  (<!>) :: Parser s a -> Parser s a -> Parser s a
  (p1 <!> p2) xs = take 1 (p1 xs ++ p2 xs)
  
  sp :: Parser Char a -> Parser Char a
  sp p = p . dropWhile (== ' ')
  
  --  wsp entfernt Leerzeichen  
  wsp :: Parser Char a -> Parser Char a
  wsp p = p . filter (\x -> not (x == ' ' || x == '\n'))
  
  --  nur das erste Resultat
  just :: Parser s a -> Parser s a
  just p = filter (null . fst) . p
  
   
  -- infixl 5 <@ 
  
  (<@) :: Parser s a -> (a-> b) -> Parser s b
  
  (p <@ f) xs = [(ys, f v) | (ys,v) <- p xs]
  
  (<*) :: Parser s a -> Parser s b -> Parser s a
  p <* q = p <*> q <@ fst
  
  (*>) :: Parser s a -> Parser s b -> Parser s b
  p *> q = p <*> q <@ snd
  
  list (x,xs) = x:xs
  
  many :: Parser s a -> Parser s [a]
  many p = p <*> many p <@ list
          <|> succeed []
  
  many1 p = p <*> many p <@ list
  
  --  manyCond p cond :  cond ist ein praedikat, wird angewendet auf Anzahl $n$ der Parses, wenn eine 
  --  Liste der Ergebnisse produziert wird
  --    zB  (== 10)
  manyCond p cond inp =  let manyparser = p <*> many p <@ list  <|> succeed []    
                             res = (manyparser inp)   
                             resFiltered = filter (\(x,y) -> cond (length y)) res
                           in resFiltered 
                           
  manyEqN p n =  manyCond p (== n)   
                       
  digit :: Integral a => Parser Char a
  digit = satisfy isDigit <@ f
         where f c = toEnum (ord c - ord '0')
  
  upper = satisfy isUpper <@ id
  lower = satisfy isLower <@ id
  alphanum = satisfy isAlphaNum <@ id
  notupper = satisfy (\x -> isAlphaNum x && not(isUpper x)) <@ id
  
  natural :: Integral a => Parser Char a
  natural = many1 digit <@ foldl f 0
               where f a b = a*10 + b
  
  -- manyex many1ex  parsen maximal weit ohne backtracking
  --  Z.B.  naturalex 1234   ergibt nur 1234, nicht 1234, 123, 12, 1,[] 
  --  Ist nur erlaubt, wenn die Grammatik diese Alternativen nicht benoetigt
      
  manyex :: Parser s a -> Parser s [a]
  manyex p = p <*> many p <@ list
          <!> succeed []
  
  many1ex p = p <*> manyex p <@ list
  option p = p <@ (\x->[x])
             <!> epsilon <@ (\x-> [])
  
  
  naturalex :: Integral a => Parser Char a
  --  naturalex ::  Parser Char Integer
  naturalex = many1ex digit <@ foldl f 0
               where f a b = a*10 + b
  
  pack:: Parser s a -> Parser s b -> Parser s c -> Parser s b
  pack s1 p s2 = s1 *> p <* s2
  
  --   soll zB x+y+a+b+c  parsen als Liste x,y,a,b,c
  opSeqInf psymb parg = (parg  <*> many (psymb *> parg))  <@ list
  
  opSeqInfEx psymb parg = (parg  <*> manyex (psymb *> parg))  <@ list
  
  paarf f = \(x,y) -> f x y
  
  --   Strings parsen
  
  stringZeichen = ((satisfy (/= '\"') <@ (: [])) <|> token "\"\"" <@ (take 1))
  manyStringZeichen = many1ex stringZeichen 
  string = pack (symbol '\"') (manyStringZeichen <@ concat) (symbol '\"')
  
  ---   Identifier  parsen
  alphaSymbol = satisfy isAlpha <@ (\x -> [x])
  alphanums = manyex alphanum
  
  identifier = alphaSymbol <*> alphanums <@ (\(x,y) -> x++y)
  
   
   
   
   