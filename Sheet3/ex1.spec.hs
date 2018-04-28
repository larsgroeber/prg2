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