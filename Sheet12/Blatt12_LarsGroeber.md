# Blatt 12 - Lars Groeber 5692604 - Gruppe 7

## Aufgabe 1

### a)

Schlüssel: {ABE}
Nicht-Primen Attribute: {C, D}
Nicht in 2.NF, da C von A funktional abhängt.

### b)

Schlüssel: {CB}
Nicht-Primen Attribute: {A, D, E}
Nicht in 2.NF, da A und D von C abhängen.

### c)

Schlüssel: {D, AB, CE}
Nicht-Primen Attribute: {}
In 2.NF, da es keine Nicht-Primen Attribute gibt.

### d)

Schlüssel: {AB, AD, AE}
Nicht-Primen Attribute: {C}
In 2.NF, da C nur von AB funktional abhängt.

### e)

Schlüssel: {AD, AE}
Nicht-Primen Attribute: {B, C}
In 2.NF, da BC nur direkt von AD abhängen.

### f)

Nicht rechts: {B, D}
BD = {B, D, A, C, E}
Schlüssel: {BD}
Nicht-Prime Attribute: {A, C, E}
Nicht in 2.NF, da A und C von D funktional abhängen.

### g)

Nicht rechts: {}
B = {B, A, C, D, E}
D = {D, B, A, C, E}
AD und AB können keine Schlüssel sein.
Schlüssel: {B, D}
Nicht-Prime Attribute: {A, C, E}
In 2.NF, da A, C nur direkt funktional von B abhängen.

## Aufgabe 2

```mysql
DROP DATABASE IF EXISTS prg2_blatt12_2_2018;
CREATE DATABASE prg2_blatt12_2_2018;
Use prg2_blatt12_2_2018;
CREATE USER lars IDENTIFIED BY 'prg2_2018';
CREATE ROLE role_prg2;
GRANT ALL PRIVILEGES on prg2_blatt12_2_2018 to role_prg2;
GRANT role_prg2 to lars;

DROP TABLE IF EXISTS person;
CREATE Table person (
  ID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(255) NOT NULL ,
  Vorname VARCHAR(255) NOT NULL ,
  Status VARCHAR(255) NOT NULL DEFAULT 'private'
);

INSERT INTO person (Name, Vorname, Status) VALUES (
    "Lars",
  "Gröber",
  "private"
), (
    "Tim",
  "Horton",
  "public"
), (
    "Mc",
  "Donalds",
  "private"
);

CREATE view person_view as SELECT * FROM person WHERE Status = "private";

SELECT PASSWORD('prg2_2018');
SELECT authentication_string from mysql.user WHERE user = 'lars';

FLUSH TABLES WITH READ LOCK;
SET GLOBAL read_only = 1;
# Beides lockt Tabellen, so dass nur noch von ihnen gelesen werden kann.
# Dies gilt auch für die root-User.
```

## Aufgabe 3

skip-show-database: Nur Nutzer mit der "Show Databases" Berechtigung können alle Datenbanken anzeigen.

bind-address = 127.0.0.1: Setzt den Netzwerk Socket, an dem der Mysql Server hören soll auf localhost (127.0.0.1).

secure-file-priv=0: Setzt das Verzeichnis aus dem Dateien eingelesen dürfen (über den Load Data Befehl zum Beispiel). Da es auf "0" gesetzt ist, ist das Laden oder Schreiben von Dateien nicht erlaubt.

## Aufgabe 4

```mysql
# a)
SELECT
  postleitzahl        AS PLZ,
  COUNT(postleitzahl) AS Anzahl
FROM strassenverzeichnis
GROUP BY postleitzahl
HAVING COUNT(postleitzahl) > 25
ORDER BY Anzahl DESC;

# b)
# Schlüsselkandidaten: (nr, auftrennungstyp, von), (nr, auftrennungstyp, bis)
# Nr notwendig zur "groben" Aufteilung, auftrennungstyp und von/bis werden bei gleicher Nr benötigt.
SELECT COUNT(*)
FROM strassen_polizei;
SELECT COUNT(*)
FROM (SELECT nr
      FROM Lars_Groeber.strassen_polizei
      GROUP BY nr, auftrennungstyp, von) a;
SELECT COUNT(*)
FROM (SELECT nr
      FROM Lars_Groeber.strassen_polizei
      GROUP BY nr, auftrennungstyp, bis) a;

# c)
SELECT name_p AS Polizeirevier
FROM strassen_polizei
GROUP BY name_p, postleitzahl
HAVING COUNT(name_p) = (SELECT max(Anzahl)
                        FROM (SELECT count(name_p) AS Anzahl
                              FROM (SELECT
                                      name_p,
                                      postleitzahl
                                    FROM strassen_polizei
                                    GROUP BY name_p, postleitzahl) a
                              GROUP BY a.name_p) b);
```
