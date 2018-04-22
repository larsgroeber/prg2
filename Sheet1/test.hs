import Test.HUnit
import Ex2 (note)


test1 = TestCase (assertEqual "not vorgerechnet" 5.0 (note False True 10 400))
test2 = TestCase (assertEqual "not vorgerechnet" 5.0 (note True False 10 400))
test3 = TestCase (assertEqual "0 points" 5.0 (note True True 0 0))
test4 = TestCase (assertEqual "just not enough" 5.0 (note True True 4 45))
test5 = TestCase (assertEqual "just not enough" 5.0 (note True True 0 49))
test6 = TestCase (assertEqual "10 bonus limit" 5.0 (note True True 9 40))
test7 = TestCase (assertEqual "1.0" 1.0 (note True True 10 90))
test8 = TestCase (assertEqual "1.3" 1.3 (note True True 10 72))

tests = TestList [TestLabel "T" test1, TestLabel "T" test2, TestLabel "T" test3, TestLabel "T" test4, TestLabel "T" test5, TestLabel "T" test6, TestLabel "T" test7, TestLabel "T" test8]