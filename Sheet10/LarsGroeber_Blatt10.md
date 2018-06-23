# Aufgabenblatt 10 - Lars Groeber

## Aufgabe 1

### a)

Stellt eine Relation zwischen einem Bild und einer Person dar. Ein Bild hat eine ID und eine Angabe über Lizenz und Preis. Eine Person hat eine ID und eine Angabe über den Vor- und Nachnamen. Ein Bild kann beliebig viele Personen zeigen, eine Person kann von beliebig vielen Bildern gezeigt werden.

Bild (<u>ID</u>, Lizenz, Preis)

Person (<u>ID</u>, VName, NName)

Bild_zeigt (<u>ID_Bild</u>, <u>ID_Person</u>)

### b)

Stellt eine Relation zwischen einem Bild und einer Person dar. Ein Bild hat eine ID und eine Angabe über Lizenz und Preis. Eine Person hat eine ID und eine Angabe über den Vor- und Nachnamen. Ein Bild wurde genau einmal erstellt von beliebig vielen Personen, dabei wird auch der Aufnahmezeitpunkt angegeben.

Bild (<u>ID</u>, Lizenz, Preis, Erstellt von, Aufnahmezeitpunkt)

Person (<u>ID</u>, VName, NName)

### c)

Stellt eine Relation zwischen einem Bild und einem System dar. Ein Bild hat eine ID und eine Angabe über Lizenz und Preis. Ein System hat eine ID und einen Ort. Ein Bild kann in keinem oder genau einem System gespeichert sein, während ein System beliebig viele Bilder speichern kann.

Bild (<u>ID</u>, Lizenz, Preis)

Systeme (<u>ID</u>, Ort)

gespeichert_in(<u>Bild_ID</u>, <u>System_ID</u>)

### d)

Stellt eine relation zwischen einem System und einem BackupStorage dar. Ein BackupStorage ist dabei ein System mit der zusätzlichen Angabe über die Kapazität. Ein System hat eine ID und einen Ort. Ein System muss in genau zwei BackupStorages "gebackupt" sein, in einem BackupStorage können beliebig viele Systeme gebackupt werden.

Systeme (<u>ID</u>, Ort, Backup1, Backup2)

BackupStorage(<u>ID</u>, Ort, Kapazität)

## Aufgabe 3

### i)

A { a1, a2, a3 }

B { b1, b2 }

C { c1, c2 }

r { <a1, b1, c1>, <a2, b2, c2>, <a3, b1, c1>, <a1, b2, c2> }

### ii)

Funktioniert nicht, da wir (siehe i)) genau vier Verknüpfungen (wegen der (2,2) bei C) brauchen, mit einem A aber nur maximal 2 erstellen können.
