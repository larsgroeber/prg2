import Test.Hspec
import Sheet3

main :: IO ()
main = hspec $ do
    describe "f1" $ do
        it "works" $ do
            f1 "138aza" `shouldBe` 14
            f1 "" `shouldBe` 0
            f1 "aaaa" `shouldBe` 4
            f1 "zzzz1" `shouldBe` 1

    describe "f2" $ do
        it "works" $ do
            f2 ["Test!", "Test"] `shouldBe` ["TEST!", "Test"]
            f2 ["!", "Test"] `shouldBe` ["!", "Test"]
            f2 ["Test", "Test"] `shouldBe` ["Test", "Test"]
            f2 ["Test", ""] `shouldBe` ["Test", ""]
            f2 ["Test test test !", "test"] `shouldBe` ["TEST TEST TEST !", "test"]


    describe "f3" $ do
        it "works" $ do
            f3 [[1,2], [4..8], [5..10]] `shouldBe` [8, 7, 6, 10, 9, 8]
            f3 [[], [4..8], [5..10]] `shouldBe` [8, 7, 6, 10, 9, 8]
            f3 [[1,2], [1..4], [6..8], [8..12]] `shouldBe` [4, 3, 2, 12, 11, 10]

    describe "g1" $ do
        it "works" $ do
            g1 [1, 2, 3, 4] `shouldBe` [2, 1, 4, 3]
            g1 [1, 2, 3] `shouldBe` [2, 1, 3]
            g1 [] `shouldBe` []
            g1 [1] `shouldBe` [1]

    describe "g2" $ do
        it "works" $ do
            g2 [[[1,2], [3]], [[4, 3]]] `shouldBe` 8
            g2 [[[1,2], [4,5], [7,8,9]], [[13, 15], [19]]] `shouldBe` 44
            g2 [[[2,2], [3,5], [10,8,9]], [[13, 15], [19]]] `shouldBe` 47

    describe "g3" $ do
        it "works" $ do
            g3 ['a', 'b', 'c'] `shouldBe` "abbccc"
            g3 [] `shouldBe` ""
            g3 ['a'] `shouldBe` "a"
            g3 ['a', 'b', 'c', 'd'] `shouldBe` "abbcccdddd"

    describe "dart" $ do
        it "throwIllegal" $ do
            throwIllegal [1,1] `shouldBe` False 
            throwIllegal [1,20] `shouldBe` False 
            throwIllegal [1,21] `shouldBe` True
            throwIllegal [-1,20] `shouldBe` True
            throwIllegal [1,25] `shouldBe` False
            throwIllegal [3,25] `shouldBe` True

        it "roundIllegal" $ do
            roundIllegal [1, 1] [[1,1], [2, 2]] `shouldBe` False
            roundIllegal [1, 1] [[1,1], [2, 21]] `shouldBe` True
            roundIllegal [0, 1] [[1,1], [2, 21]] `shouldBe` True

        it "pointsAfterThrow" $ do
            pointsAfterThrow 10 [1,1] `shouldBe` 9
            pointsAfterThrow 10 [2, 20]  `shouldBe` 10
            pointsAfterThrow 10 [1, 10]  `shouldBe` 0

        it "pointsAfterRound" $ do
            pointsAfterRound [[1,1]] 10 `shouldBe` 9
            pointsAfterRound [[2,1], [2, 2]] 10 `shouldBe` 4
            pointsAfterRound [[3,1], [1, 10]] 10 `shouldBe` 7

        it "oneRound" $ do
            oneRound [10, 10] 0 [[1,1]] `shouldBe` [9, 10]
            oneRound [10, 10] 1 [[2, 3], [1, 1]] `shouldBe` [10, 3]
            oneRound [10, 10] 1 [[2, 3], [1, 10]] `shouldBe` [10, 4]
            oneRound [10, 10] 1 [[2, 3], [1, 4]] `shouldBe` [10, 0]

        it "nextRound" $ do
            nextRound [1, 10] 0 [[[1,1]]] `shouldBe` 1
            nextRound [1, 10] 1 [[[1,1]], [[1,1]]] `shouldBe` 1
            nextRound [1, 1] 1 [[[1,1]]] `shouldBe` 2
            nextRound [1, 10] 1 [[[1,1]]] `shouldBe` 0

        it "legSieger" $ do
            legSieger leg1 `shouldBe` 1
            legSieger leg2 `shouldBe` 2
            legSieger leg3 `shouldBe` 1
            legSieger [[[1,1], [1,2], [1,3]]] `shouldBe` 0

        it "highout" $ do
            highOut  [leg3,leg2,leg3,leg4,leg3] `shouldBe` 167
            highOut  [leg3,leg3,leg3] `shouldBe` 120
            highOut  [leg4,leg3] `shouldBe` 0
            highOut  [leg4] `shouldBe` 0