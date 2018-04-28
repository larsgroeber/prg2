import Test.Hspec
import Ex1

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

    describe "g3" $ do
        it "works" $ do
            g3 ['a', 'b', 'c'] `shouldBe` "abbccc"
            g3 [] `shouldBe` ""
            g3 ['a'] `shouldBe` "a"
            g3 ['a', 'b', 'c', 'd'] `shouldBe` "abbcccdddd"