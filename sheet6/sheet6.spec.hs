import Test.Hspec
import Blatt6_LarsGroeber

main :: IO ()
main = hspec $ do
    describe "parseAttacken" $ do
        it "works" $ do
            parseAttacken "Schelle" `shouldBe` [("", "Schelle")]
            parseAttacken "Schelle;Schelle;Dampfhammer" `shouldBe` [(";Schelle;Dampfhammer","Schelle"),(";Dampfhammer","Schelle;Schelle"),
              ("","Schelle;Schelle;Dampfhammer"),(";Dampfhammer","Schelle;Schelle"),
              ("","Schelle;Schelle;Dampfhammer"),("","Schelle;Schelle;Dampfhammer"),
              ("","Schelle;Schelle;Dampfhammer")]

    describe "parseAttackenC" $ do
      it "works" $ do
        parseAttackenC "Schelle;Dampfhammer;Drehung 45;Dampfhammer" `shouldBe` [(";Dampfhammer;Drehung 45;Dampfhammer",(0,1,0,0)),
          (";Drehung 45;Dampfhammer",(1,1,0,0)),
          (";Drehung 45;Dampfhammer",(1,1,0,0)),
          ("",(2,1,0,0)),
          ("",(2,1,0,0))]
            

    -- describe "vergleiche" $ do
    --   it "works" $ do
    --       allaggr testBaum `shouldBe` True