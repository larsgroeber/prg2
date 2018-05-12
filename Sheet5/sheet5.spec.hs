import Test.Hspec
import Blatt5_LarsGroeber

testBaum = BKnoten 5 (BBlatt 2) (BBlatt 3)
testBaum2 = BKnoten 4 (BBlatt 2) (BBlatt 3)
testBaum3 = BKnoten 4 (BKnoten 3 (BBlatt 2) (BBlatt 1)) (BBlatt 1)
testBaum4 = BKnoten 5 (BKnoten 3 (BBlatt 2) (BBlatt 1)) (BBlatt 1)

testBaum2_1 = NKnoten (BKnoten 1 (BBlatt 1) (BBlatt 1)) []
testBaum2_1_sol = NKnoten (NKnoten 1 [NBlatt 1, NBlatt 1]) []

testBaum2_2 = NKnoten (BKnoten 1 (BBlatt 1) (BBlatt 1)) [testBaum2_1, testBaum2_1]
testBaum2_2_sol = NKnoten (NKnoten 1 [NBlatt 1, NBlatt 1]) [testBaum2_1_sol, testBaum2_1_sol]

note = (1,2,3,4)
mBaum1 = Knoten [note, note, note] []
mBaum2 = Knoten [note, note, note] [Knoten [note, note] [Blatt [note], Blatt [note]]]
noteT = (1,4,3,4)
mBaum1T = Knoten [noteT, noteT, noteT] []
mBaum2T = Knoten [noteT, noteT, noteT] [Knoten [noteT, noteT] [Blatt [noteT], Blatt [noteT]]]


main :: IO ()
main = hspec $ do
    describe "allaggr" $ do
        it "works" $ do
            allaggr testBaum `shouldBe` True
            allaggr testBaum2 `shouldBe` False
            allaggr testBaum3 `shouldBe` True
            allaggr testBaum4 `shouldBe` False

    describe "btreestontrees" $ do
        it "works" $ do
            btreestontrees testBaum2_1 `shouldBe` testBaum2_1_sol
            btreestontrees testBaum2_2 `shouldBe` testBaum2_2_sol

    describe "anzahlNotenMB" $ do
        it "works" $ do
            anzahlNotenMB (Entwuerfe mBaum1 mBaum1 1) `shouldBe` 3
            anzahlNotenMB (Entwuerfe mBaum2 mBaum1 1) `shouldBe` 7

    describe "transposeNote" $ do
        it "works" $ do
            transposeNote 3 (1,1,1,1) `shouldBe` (1,4,1,1)
            transposeNote 3 (1,9,1,1) `shouldBe` (1,12,1,1)
            transposeNote 3 (1,10,1,1) `shouldBe` (2,1,1,1)
            transposeNote (-3) (1,10,1,1) `shouldBe` (1,7,1,1)
            transposeNote (-3) (1,3,1,1) `shouldBe` (0,12,1,1)

    describe "transponiere" $ do
        it "works" $ do
            transponiere (Entwuerfe mBaum1 mBaum1 1) 2 `shouldBe` (Entwuerfe mBaum1T mBaum1T 1)
            transponiere (Entwuerfe mBaum2 mBaum1 1) 2 `shouldBe` (Entwuerfe mBaum2T mBaum1T 1)