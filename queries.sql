CREATE database komunikacja_miejska;
CREATE SCHEMA rozklad_jazdy;
SET SEARCH_PATH TO rozklad_jazdy;

CREATE TABLE rozklad_jazdy.linie(
    numer_linii INTEGER PRIMARY KEY,
    rodzaj_linii TEXT NOT NULL,
    rodzaj_transportu TEXT NOT NULL CHECK(rodzaj_transportu IN('tramwaj', 'autobus')),
    przystanek_poczatkowy TEXT NOT NULL,
    przystanek_koncowy TEXT NOT NULL
);

CREATE TABLE przystanki(
    id_przystanku SERIAL PRIMARY KEY,
    nazwa_przystanku TEXT NOT NULL,
    rodzaj_transportu TEXT NOT NULL CHECK(rodzaj_transportu IN('tramwaj', 'autobus'))
);

CREATE TABLE stacje(
    id_stacji SERIAL PRIMARY KEY,
    numer_linii INTEGER NOT NULL,
    id_przystanku INTEGER NOT NULL,
    godzina_odjazdu TIME NOT NULL
);

ALTER TABLE stacje ADD FOREIGN KEY (numer_linii) REFERENCES linie(numer_linii);
ALTER TABLE stacje ADD FOREIGN KEY (id_przystanku) REFERENCES przystanki(id_przystanku);

SELECT l.*, s.godzina_odjazdu FROM linie l
         JOIN stacje s ON l.numer_linii = s.numer_linii
         JOIN przystanki p on s.id_przystanku = p.id_przystanku
         WHERE p.nazwa_przystanku = 'Krowodrza Górka P+R 04';

SELECT s.godzina_odjazdu FROM stacje s
    JOIN przystanki p ON s.id_przystanku = p.id_przystanku
    WHERE p.nazwa_przystanku =  'Krowodrza Górka P+R 04'
    AND s.numer_linii = 137;

SELECT p.nazwa_przystanku, s.godzina_odjazdu FROM stacje s
    JOIN przystanki p ON s.id_przystanku = p.id_przystanku
    AND s.numer_linii = 137;

