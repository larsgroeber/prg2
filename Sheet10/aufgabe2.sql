DROP DATABASE IF EXISTS Blatt10;
CREATE DATABASE Blatt10;

USE Blatt10;

### a)

# Person
CREATE TABLE Person (
  ID    INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
  VName VARCHAR(255) NULL,
  NName VARCHAR(255) NULL
);

# Bild
CREATE TABLE Bild (
  ID                INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Lizenz            VARCHAR(255) NULL,
  Preis             DECIMAL      NULL,
  Erstellt_von      INT          NOT NULL,
  Aufnahmezeitpunkt DATETIME     NULL,
  FOREIGN KEY fk_bild_person (Erstellt_von) REFERENCES Person (ID)
);

# zeigt Relation
CREATE TABLE Bild_zeigt (
  ID_Bild   INT NOT NULL,
  ID_Person INT NOT NULL,
  PRIMARY KEY (ID_Bild, ID_Person),
  FOREIGN KEY fk_bild_zeigt_bild (ID_Bild) REFERENCES Bild (ID),
  FOREIGN KEY fk_bild_zeigt_person (ID_Person) REFERENCES Person (ID)
);

# BackupStorage
CREATE TABLE BackupStorage (
  ID        INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Ort       VARCHAR(255) NULL,
  Kapazität DECIMAL      NOT NULL
);

# System
CREATE TABLE Systeme (
  ID      INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Ort     VARCHAR(255) NULL,
  Backup1 INT          NOT NULL,
  Backup2 INT          NOT NULL,
  FOREIGN KEY fk_system_backup1 (Backup1) REFERENCES BackupStorage (ID),
  FOREIGN KEY fk_system_backup2 (Backup2) REFERENCES BackupStorage (ID)
);

# gespeichert_in
CREATE TABLE Gespeichert_in (
  Bild_ID   INT NOT NULL,
  System_ID INT NOT NULL,
  PRIMARY KEY (Bild_ID, System_ID),
  FOREIGN KEY fk_gespeichert_in_bild (Bild_ID) REFERENCES Bild (ID),
  FOREIGN KEY fk_gespeichert_in_system (System_ID) REFERENCES Systeme (ID)
);

### b)

INSERT INTO Person (VName, NName)
VALUES ("Max", "Meier"), ("Lars", "Groeber"), ("Max", "Mustermann"), ("Alexa", "Home");
INSERT INTO Bild (Lizenz, Preis, Erstellt_von, Aufnahmezeitpunkt)
VALUES ("CC", 200, 1, NOW()), ("CC", 2000, 1, NOW()), ("CC", 500, 2, NOW()), ("CC", 200, 3, NOW())
INSERT INTO Bild_zeigt (ID_Bild, ID_Person) VALUES (1, 1), (1, 2), (2, 2), (3, 3);
INSERT INTO BackupStorage (Ort, Kapazität) VALUES ("Berlin", 50), ("Frankfurt", 20), ("München", 20), ("Köln", 100);
INSERT INTO Systeme (Ort, Backup1, Backup2)
VALUES ("Berlin", 1, 2), ("Frankfurt", 2, 1), ("München", 3, 4), ("Köln", 3, 1);
INSERT INTO Gespeichert_in (Bild_ID, System_ID) VALUES (1, 1), (1, 2), (2, 2), (3, 3);

### c)

SELECT
  P.VName AS Vorname,
  P.NName AS Nachname,
  B.ID    AS Bild_ID,
  B.Preis
FROM Bild B
  JOIN Person P ON B.Erstellt_von = P.ID
ORDER BY P.NName, P.VName, B.Preis;

### d)

SELECT
  B.ID AS Bild_ID,
  S.ID AS System_ID,
  Backup1,
  Backup2
FROM Bild B
  JOIN Gespeichert_in Gi ON B.ID = Gi.Bild_ID
  JOIN Systeme S ON Gi.System_ID = S.ID;