DROP DATABASE IF EXISTS Lars_Groeber;
CREATE DATABASE Lars_Groeber COLLATE "utf8_general_ci";
USE Lars_Groeber;

# a)
# column names are too long...
CREATE TABLE gesundheit
(
  Codes INT NOT NULL PRIMARY KEY,
  Stadtteil VARCHAR(255) NOT NULL,
  a INT NOT NULL,
  b INT NOT NULL,
  c INT NOT NULL,
  d INT NOT NULL,
  e INT NOT NULL,
  f INT NOT NULL
);

# b)
SET GLOBAL local_infile = 'ON';
LOAD DATA LOCAL INFILE '/Users/lars/Downloads/gesundheit_einfach.csv' INTO TABLE Lars_Groeber.gesundheit
  CHARACTER
  SET 'latin2'
  FIELDS TERMINATED BY ';'
  ENCLOSED BY '' LINES TERMINATED BY '\n' IGNORE 1 LINES;

# c)
CREATE VIEW revier_telefonliste
AS
  SELECT
    name,
    telefon
  FROM polizeirevier;

CREATE VIEW strassen_polizei
AS
  SELECT
    p.nr   AS polizei_nr,
    p.name AS polizei_name,
    p.telefon,
    p.flaeche,
    p.einwohner,
    p.pendler,
    s.nr   AS strasse_nr,
    s.name AS strasse_name,
    s.auftrennungstyp,
    s.von,
    s.bis,
    s.stadtteil,
    s.postleitzahl
  FROM polizeirevier p
    JOIN strassenverzeichnis s ON s.polizeirevier = p.nr;

CREATE VIEW strassen_aerzte
AS
  SELECT
    s.nr   AS strasse_nr,
    s.name AS strasse_name,
    s.auftrennungstyp,
    s.von,
    s.bis,
    s.postleitzahl,
    g.*
  FROM strassenverzeichnis s
    JOIN gesundheit g on g.Stadtteil = s.stadtteil;


# d)
SELECT DISTINCT telefon
  from strassen_polizei
  where strasse_name = "Berger StraÃŸe";

SELECT strasse_name, Stadtteil, max(f)
  from strassen_aerzte
  group by Stadtteil, strasse_name
  having max(f) = (SELECT max(f)
    from strassen_aerzte);