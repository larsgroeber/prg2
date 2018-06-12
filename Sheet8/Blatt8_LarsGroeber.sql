# 1)
CREATE DATABASE IF NOT EXISTS Lars_Groeber;
SHOW DATABASES;

# 2)
USE Lars_Groeber;
# a)
CREATE TABLE IF NOT EXISTS Polizeireviere (
  Nr        INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name      VARCHAR(255) NULL,
  Telefon   VARCHAR(255) NULL,
  Flaeche   DECIMAL      NULL,
  Einwohner INT          NULL,
  Pendler   INT          NULL
);
CREATE TABLE IF NOT EXISTS Straßenverzeichnis (
  Straßennummer  INT                         NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Straßenname    VARCHAR(255)                NOT NULL,
  Spalte1        ENUM ('gerade', 'ungerade') NULL,
  von            INT                         NULL,
  bis            INT                         NULL,
  Polizerrevier  INT                         NOT NULL,
  Stadtteil_Name VARCHAR(255)                NOT NULL,
  Postleitzahl   INT                         NULL,
  FOREIGN KEY fk_revier(Polizerrevier) REFERENCES Polizeireviere (Nr)
);

# b) - nutze MacOS/Bash
SET GLOBAL local_infile = 'ON';
LOAD DATA LOCAL INFILE '/Users/lars/Downloads/polizeireviere.csv' INTO TABLE Lars_Groeber.Polizeireviere FIELDS TERMINATED BY '$'
ENCLOSED BY '' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/Users/lars/Downloads/strassenverzeichnis_einfach.csv' INTO TABLE Lars_Groeber.Straßenverzeichnis
CHARACTER SET 'latin2' FIELDS TERMINATED BY ';'
ENCLOSED BY '' LINES TERMINATED BY '\n' IGNORE 1 LINES;

# c)
INSERT INTO Polizeireviere VALUES (NULL, 'Lars Gröber', '5692604', 30, 20123, 40000);

# d)
# Stadtteil_Name ist nicht getrimmt
SELECT DISTINCT COUNT(Straßenname)
FROM Straßenverzeichnis
WHERE Stadtteil_Name LIKE 'Bockenheim%';

SELECT Telefon
FROM Polizeireviere
WHERE Name = 'Lars Gröber';

SELECT SUM(Einwohner)
FROM Polizeireviere;

SELECT MAX(Einwohner + Pendler)
FROM Polizeireviere;

SELECT Telefon
FROM Polizeireviere
  JOIN Straßenverzeichnis S ON Polizeireviere.Nr = S.Polizerrevier
WHERE Straßenname = 'Berger Straße';

SELECT Telefon
FROM Polizeireviere
  JOIN Straßenverzeichnis S ON Polizeireviere.Nr = S.Polizerrevier
WHERE Straßenname = 'Achenbachstraße' AND (Spalte1 = 'gerade' OR Spalte1 = '');
