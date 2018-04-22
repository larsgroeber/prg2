import Test.Hspec
import Blatt1 (note, istZugDiagonal, bedrohtRichtung, feldA, feldB, bishopInDirection, bedroht, zeigeFeld, istZugGueltig, zieheWennGueltig, geloest)


main :: IO ()
main = hspec $ do
    describe "istZugDiagonal" $ do
        it "returns true" $ do
            istZugDiagonal 1 1 2 2 `shouldBe` True
            istZugDiagonal 1 2 3 4 `shouldBe` True
            istZugDiagonal 5 1 8 4 `shouldBe` True
            istZugDiagonal 5 3 3 1 `shouldBe` True
            istZugDiagonal 3 3 5 1 `shouldBe` True
            istZugDiagonal 4 3 5 2 `shouldBe` True

        it "returns False" $ do
            istZugDiagonal 1 1 2 3 `shouldBe` False
            istZugDiagonal 1 2 2 4 `shouldBe` False
            istZugDiagonal 5 1 7 4 `shouldBe` False

    describe "bishopInDirection" $ do
        it "works" $ do
            bishopInDirection 3 1 (1, 1) feldA `shouldBe` 'w'
            bishopInDirection 3 3 (1, -1) feldA `shouldBe` 'w'
            bishopInDirection 3 1 (-1, 1) feldA `shouldBe` 's'
            bishopInDirection 3 1 (1, -1) feldA `shouldBe` ' '

    describe "bedrohtRichtung" $ do
        it "returns True" $ do
            bedrohtRichtung 3 1 's' 1 feldA `shouldBe` True
            bedrohtRichtung 3 3 's' 2 feldA `shouldBe` True
            bedrohtRichtung 3 1 'w' 0 feldA `shouldBe` True
            bedrohtRichtung 2 4 'w' 3 feldA `shouldBe` True
            bedrohtRichtung 4 1 'w' 0 feldA `shouldBe` True

        it "returns False" $ do
            bedrohtRichtung 3 1 'w' 1 feldA `shouldBe` False
            bedrohtRichtung 3 3 'w' 2 feldA `shouldBe` False
            bedrohtRichtung 3 1 's' 0 feldA `shouldBe` False
            bedrohtRichtung 2 4 's' 3 feldA `shouldBe` False
            bedrohtRichtung 4 1 's' 0 feldA `shouldBe` False

    describe "bedroht" $ do
        it "returns True" $ do
            bedroht 3 1 's' feldA `shouldBe` True
            bedroht 3 3 's' feldA `shouldBe` True
            bedroht 3 1 'w' feldA `shouldBe` True
            bedroht 2 4 'w' feldA `shouldBe` True
            bedroht 4 1 'w' feldA `shouldBe` True

        it "returns False" $ do
            bedroht 2 2 's' feldA `shouldBe` False
            bedroht 2 3 's' feldA `shouldBe` False
            bedroht 4 2 'w' feldA `shouldBe` False
            bedroht 4 3 'w' feldA `shouldBe` False

    describe "istZugGueltig" $ do
        it "returns True" $ do
            istZugGueltig 1 1 2 2 feldA `shouldBe` True
            istZugGueltig 5 3 4 2 feldA `shouldBe` True
            istZugGueltig 4 3 5 2 feldB `shouldBe` True

        it "returns False" $ do
            istZugGueltig 1 1 3 3 feldA `shouldBe` False
            istZugGueltig 5 3 2 3 feldA `shouldBe` False
            istZugGueltig 4 3 5 2 feldA `shouldBe` False
    
    describe "zieheWennGueltig" $ do
        it "works" $ do
            (zieheWennGueltig 1 1 2 2 feldA) 1 1 `shouldBe` ' '
            (zieheWennGueltig 1 1 2 2 feldA) 2 2 `shouldBe` 's'
            (zieheWennGueltig 5 3 4 2 feldA) 4 2 `shouldBe` 'w'
            (zieheWennGueltig 5 3 4 2 feldA) 5 3 `shouldBe` ' '

    describe "geloest" $ do
        it "works" $ do
            geloest (zieheWennGueltig 4 3 5 2 feldB) `shouldBe` True
        