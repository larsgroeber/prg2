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
        parseAttackenC "Schelle" `shouldBe` [("",(0,1,0,0))]
        parseAttackenC "" `shouldBe` []
        parseAttackenC "Schelle;Dampfhammer" `shouldBe` [(";Dampfhammer",(0,1,0,0)),("",(1,1,0,0)),("",(1,1,0,0))]
            

    describe "vergleiche" $ do
      it "works" $ do
        vergleiche "Schelle;Schlag auf Bauch;Dampfhammer" "Schelle;Schelle;Schelle;Schlag auf Bauch" `shouldBe` ("Bud","Terence","","")
        vergleiche "Schelle" "Schelle;Schelle;Schelle;Schlag auf Bauch" `shouldBe` ("","Terence","","Terence")
        vergleiche "Dampfhammer;Dampfhammer" "Schelle;Schelle;Schelle;Schlag auf Bauch" `shouldBe` ("Bud","Terence","","Terence")