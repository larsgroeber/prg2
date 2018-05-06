import Test.Hspec
import Blatt4

main :: IO ()
main = hspec $ do
    describe "b2" $ do
        it "works" $ do
            gesamtGewicht (tragetasche) `shouldBe` 45
            gesamtGewicht (Tragetasche []) `shouldBe` 0
            gesamtGewicht (Tragetasche [Lieferung (Objekt True 100 (0,0,0)) 100 ""]) `shouldBe` 100

    describe "b3" $ do
        it "works" $ do
            aendereZerbrechlich (Tragetasche [Lieferung (Objekt False 100 (30, 30, 30)) 100 ""]) (30,30,30)
                `shouldBe` (Tragetasche [Lieferung (Objekt True 100 (30, 30, 30)) 100 ""])
            aendereZerbrechlich (Tragetasche [Lieferung (Objekt False 100 (30, 30, 30)) 100 "", Lieferung (Objekt True 100 (30, 20, 30)) 100 ""]) (30,30,30)
                `shouldBe` (Tragetasche [Lieferung (Objekt True 100 (30, 30, 30)) 100 "",  Lieferung (Objekt True 100 (30, 20, 30)) 100 ""])

    describe "aufgabeA" $ do
        it "works" $ do
            take 8 aufgabeA `shouldBe` [185,445,705,965,1225,1485,1745,2005]

    describe "aufgabeB" $ do
        it "works" $ do
            aufgabeB [(1,2), (3,4)] `shouldBe` [1,2,3,4] 
            aufgabeB [] `shouldBe` [] 
            aufgabeB [(1,2)] `shouldBe` [1,2] 

    describe "aufgabeC" $ do
        it "works" $ do
            take 12 aufgabeC `shouldBe` [(0,True,'a'),(0,True,'b'),(0,True,'c'),(0,True,'d'),(3,True,'a'),(3,True,'b'),(3,True,'c'),(3,True,'d'),(20,True,'a'),(20,True,'b'),(20,True,'c'),(20,True,'d')] 
            
    describe "aufgabeD" $ do
        it "works" $ do
            take 9 aufgabeD `shouldBe` [(1,1,2),(1,3,4),(2,2,4),(2,4,6),(3,1,4),(3,3,6),(4,2,6),(4,4,8),(1,1,0)]