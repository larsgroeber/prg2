-- ============================================================================
-- Grundlagen der Programmierung 2 
-- Aufgabenblatt 6
-- ============================================================================

  module Blatt6_LarsGroeber where
  import Prelude hiding ((<*>),(*>),(<*))
  import Data.Char
  import Data.List
  import Data.List.Split
  import CombParser
  
  -- =============================================================================
  -- =
  -- = Aufgabe 1
  -- =
  
  --
  -- c)
  --
  tupleToList (x1,x2) = x1 ++ x2
  semi = token ";"
  gradzahl = token "45" <|> token "90" <|> token "135" <|> token "180"
  aktion = token "Schelle" <|> token "Schlag auf Schulter" <|> token "Schlag auf Bauch"
  attacke = token "Dampfhammer" <|> aktion <|>  (aktion <*> (semi <*> attacke <@ tupleToList) <@ tupleToList)
  attacken = attacke <|> (attacke <*> (semi <*> attacken <@ tupleToList) <@ tupleToList) <|> 
    ((attacke <*> (semi <*> ((token "Drehung ") <*> gradzahl <@ tupleToList) <@ tupleToList) <@ tupleToList) <*> semi <@ tupleToList) <*> attacken <@ tupleToList

  parseAttacken :: Parser Char String
  parseAttacken = attacken -- zu implementieren!
  
  --
  -- d)
  --
  
  type CTuple = (Integer, Integer, Integer, Integer)
  updateTuple :: String -> CTuple -> CTuple
  updateTuple "Dampfhammer" (d, s, sc, b) = (d+1, s, sc, b)
  updateTuple "Schelle" (d, s, sc, b) = (d, s + 1, sc, b)
  updateTuple "Schlag auf Schulter" (d, s, sc, b) = (d, s, sc + 1, b)
  updateTuple "Schlag auf Bauch" (d, s, sc, b) = (d, s, sc, b + 1)
  updateTuple _ a = a

  updateResultTuple :: String -> CTuple -> CTuple
  updateResultTuple result tuple = updateTuple (last (splitOn ";" result)) tuple

  parseAttackenC :: Parser Char (Integer,Integer,Integer,Integer)
  parseAttackenC text = snd (mapAccumL (\tuple (x,xs) -> let nT = updateResultTuple xs tuple in (nT, (x, nT))) (0,0,0,0) (attacken text)) 
  
  --
  -- e)
  --
  
  vergleiche :: String -> String ->  (String,String,String,String)
  vergleiche = undefined -- zu implementieren!
  
  -- =
  -- =
  -- =============================================================================