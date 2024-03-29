DROP TABLE anggota
DROP TABLE pustakawan
DROP TABLE pengarang
DROP TABLE kategori
DROP TABLE buku
DROP TABLE pengarang_buku
DROP TABLE catatan_peminjaman
DROP TABLE denda
DROP TABLE pembayaran_denda
DROP TABLE shift
DROP TABLE pemberian_shift

-- Tabel Anggota
CREATE TABLE anggota (
    id NUMBER(8,0) CONSTRAINT anggota_id_pk PRIMARY KEY,
    nama VARCHAR2(30) CONSTRAINT anggota_nama_nn NOT NULL,
    alamat VARCHAR2(60) CONSTRAINT anggota_alamat_nn NOT NULL,
    no_telp VARCHAR2(15) CONSTRAINT anggota_no_telp_nn NOT NULL,
    email VARCHAR2(40),
    password VARCHAR2(255),
    CONSTRAINT anggota_no_telp_uk UNIQUE (no_telp),
    CONSTRAINT anggota_email_uk UNIQUE (email)
);

 
-- Tabel Pustakawan
CREATE TABLE pustakawan (
    id NUMBER(8,0) CONSTRAINT pustakawan_id_pk PRIMARY KEY,
    nama VARCHAR2(30) CONSTRAINT pustakawan_nama_nn NOT NULL,
    alamat VARCHAR2(60) CONSTRAINT pustakawan_alamat_nn NOT NULL,
    no_telp VARCHAR2(15) CONSTRAINT pustakawan_no_telp_nn NOT NULL,
    CONSTRAINT pustakawan_no_telp_uk UNIQUE (no_telp)
)
 
-- Tabel Pengarang
CREATE TABLE pengarang (
    id NUMBER(8,0) CONSTRAINT pengarang_id_pk PRIMARY KEY,
    nama_depan VARCHAR2(20),
    nama_belakang VARCHAR2(20) CONSTRAINT pengarang_namab_nn NOT NULL,
)
 
 
-- Tabel Kategori
CREATE TABLE kategori (
    id NUMBER(3,0) CONSTRAINT kat_id_pk PRIMARY KEY,
    nama VARCHAR2(20) CONSTRAINT kat_nama_nn NOT NULL
)
 
 
-- Tabel Buku
CREATE TABLE buku (
    id NUMBER(8,0) CONSTRAINT buku_id_pk PRIMARY KEY,
    judul VARCHAR2(50) CONSTRAINT buku_judul_nn NOT NULL,
    tahun NUMBER(4),
    isbn VARCHAR2(17),
    id_kategori NUMBER(3,0),
    ketersediaan NUMBER(1,0) CONSTRAINT buku_keter_nn NOT NULL,
    CONSTRAINT buku_kat_id_fk FOREIGN KEY (id_kategori) REFERENCES kategori(id) ON DELETE SET NULL,
    CONSTRAINT check_ketersediaan CHECK (ketersediaan IN (1, 0))
)
 
 
-- Tabel Pengarang Buku
CREATE TABLE pengarang_buku (
    id_buku NUMBER(8,0) CONSTRAINT peng_buku_id_buku_fk REFERENCES buku(id) ON DELETE CASCADE,
    id_pengarang NUMBER(8,0) CONSTRAINT peng_buku_id_pengarang_fk REFERENCES pengarang(id) ON DELETE CASCADE,
    CONSTRAINT peng_buku_pk PRIMARY KEY (id_buku, id_pengarang)
)
 
 
-- Tabel Catatan Peminjaman
CREATE TABLE catatan_peminjaman (
    id_buku NUMBER(8,0) CONSTRAINT cat_pem_id_buku_fk REFERENCES buku(id) ON DELETE CASCADE,
    tanggal_peminjaman DATE CONSTRAINT cat_pem_tgl_pem_nn NOT NULL,
    tanggal_pengembalian DATE,
    id_anggota NUMBER(8,0) CONSTRAINT cat_pem_id_anggota_fk REFERENCES anggota(id) ON DELETE CASCADE,
    id_pustakawan NUMBER(8,0) CONSTRAINT cat_pem_id_pustakawan_fk REFERENCES pustakawan(id) ON DELETE SET NULL,
    CONSTRAINT cat_pem_id_tgl_pk PRIMARY KEY (id_buku, tanggal_peminjaman),
    CONSTRAINT check_tgl_cat_pem CHECK (tanggal_peminjaman <= tanggal_pengembalian)
)
 
-- Tabel Denda
CREATE TABLE denda (
    id NUMBER(8,0) CONSTRAINT denda_id_pk PRIMARY KEY,
    id_anggota NUMBER(8,0) CONSTRAINT denda_id_anggota_fk REFERENCES anggota(id) ON DELETE CASCADE,
    tanggal_denda DATE,
    nominal NUMBER(8,0),
    CONSTRAINT check_nom_denda CHECK (nominal > 0)
)
 
-- Tabel Pembayaran Denda
CREATE TABLE pembayaran_denda (
    id NUMBER(8,0) CONSTRAINT pem_den_id_pk PRIMARY KEY,
    id_anggota NUMBER(8,0) CONSTRAINT pem_denda_id_anggota_fk REFERENCES anggota(id) ON DELETE CASCADE,
    tanggal_pembayaran DATE,
    nominal_pembayaran NUMBER(8,0)
    CONSTRAINT check_nom_pem CHECK (nominal_pembayaran > 0)
)
 
-- Tabel Shift
CREATE TABLE shift (
    kode NUMBER(2,0) CONSTRAINT shift_kode_pk PRIMARY KEY,
    deskripsi VARCHAR2(50)
)
 
-- Tabel Pemberian Shift
CREATE TABLE pemberian_shift (
    kode_shift NUMBER(2,0) CONSTRAINT pem_shift_kode_fk REFERENCES shift(kode) ON DELETE CASCADE,
    id_pustakawan NUMBER(8,0) CONSTRAINT pem_shift_id_pustakawan REFERENCES pustakawan(id) ON DELETE CASCADE,
    tanggal_pemberian DATE NOT NULL,
    CONSTRAINT pem_shift_pk PRIMARY KEY (kode_shift, id_pustakawan)
)
 
-- Index

CREATE INDEX buku_judul_idx
ON buku (judul);
CREATE INDEX pengarang_idx
ON pengarang (first_name, last_name);
CREATE INDEX shift_idx
ON pemberian_shift (kode_shift);
 
-- Sequence
CREATE SEQUENCE id_anggota_sequence
INCREMENT BY 1
START WITH 10
MAXVALUE 99999999
NOCYCLE
 
CREATE SEQUENCE id_denda_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 99999999
NOCYCLE
 
CREATE SEQUENCE id_pembayaran_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 99999999
NOCYCLE

--contoh insert into pake sequence (setelah pakai synnonym)
 
 
 
-- Synonym
 
CREATE SYNONYM idseq FOR id_anggota_sequence;
CREATE SYNONYM cat_pem FOR catatan_peminjaman;
 
 
-- Isi data
 
--contoh insert into pake sequence (setelah pakai synnonym)

--id 10

INSERT INTO anggota (id, nama, alamat, no_telp, email, password) 
VALUES (idseq.NEXTVAL, 'Muhammad Agung Zuhdi', 'Desa Bekasi, Kecamatan Cikarang, Kabupaten Bekasi', '0324234423', 'magungzuh@gmail.com', '713C6827F92CC74' );
INTO anggota (id, nama, alamat, no_telp, email, password) 
VALUES (idseq.NEXTVAL, 'Dewi Anbara Primayu', 'Condet, Kecamatan Kec. Kramat Jati, Jakarta Timur', '08121323205', 'ayu.anbara@gmail.com', '713C6827F92CC74' )
INTO anggota (id, nama, alamat, no_telp, email, password) 
VALUES (idseq.NEXTVAL, 'Winda Oktaviona', 'Dramaga, Kabupaten Bogor, Jawa Barat', '081272323096', 'winda.oktav@gmail.com', '713C6827F92ddewe4' )
INTO anggota (id, nama, alamat, no_telp, email, password) 
VALUES (idseq.NEXTVAL, 'Indah Permatasari', 'Dramaga, Kabupaten Bogor, Jawa Barat', '081211322545', '', '' )
INTO anggota (id, nama, alamat, no_telp, email, password) 
VALUES (idseq.NEXTVAL, 'Setiabudi', 'Dramaga, Kabupaten Bogor, Jawa Barat', '081211376546', '', '' )
INTO anggota (id, nama, alamat, no_telp, email, password) 
VALUES (idseq.NEXTVAL, 'Lusi Susanti', 'Dramaga, Kabupaten Bogor, Jawa Barat', '081211393463', '', '' )

INSERT INTO anggota (id, nama, alamat, no_telp, email, password) 
VALUES (idseq.NEXTVAL, '', 'Depok', '0852123432320', 'magungzuh@gmail.com', '713C6827F92CC74' );
-- Insert pustakawan
INSERT ALL
INTO pustakawan (id, nama, alamat, no_telp)
VALUES (54160033, 'Budi Cahyono', 'Dramaga, Kabupaten Bogor, Jawa Barat', 081211376545)
INTO pustakawan (id, nama, alamat, no_telp)
VALUES (54160098, 'Susi Susanti', 'Dramaga, Kabupaten Bogor, Jawa Barat', 081211393463)
INTO pustakawan (id, nama, alamat, no_telp)
VALUES (54150052, 'Joni Andreas', 'Dramaga, Kabupaten Bogor, Jawa Barat', 081543453244)
SELECT * FROM dual;
 
-- Insert pengarang
INSERT ALL
INTO pengarang (id, nama_depan, nama_belakang)
VALUES (1, 'Tere', 'Liye')
INTO pengarang (id, nama_depan, nama_belakang)
VALUES (2, 'Hajime', 'Isyama')
INTO pengarang (id, nama_depan, nama_belakang)
VALUES (3, 'Katie', 'Daynes')
INTO pengarang (id, nama_depan, nama_belakang)
VALUES (4, 'Kyowon', 'Co')
INTO pengarang (id, nama_depan, nama_belakang)
VALUES (5, 'Kim', 'Cecil')
INTO pengarang (id, nama_depan, nama_belakang)
VALUES (6, 'Steve', 'Parker')
INTO pengarang (id, nama_depan, nama_belakang)
VALUES (7, 'Ian C', 'Stewart')
INTO pengarang (id, nama_depan, nama_belakang)
VALUES (8, 'Justin P', 'Lomont')
INTO pengarang (id, nama_depan, nama_belakang)
VALUES (9, 'Salman', 'Alfarizi')
SELECT * FROM dual;  

-- Insert Kategori
INSERT ALL
INTO kategori (id, nama)
VALUES (101, 'Novel')
INTO kategori (id, nama)
VALUES (102, 'Komik')
INTO kategori (id, nama)
VALUES (103, 'Cerita Gambar')
INTO kategori (id, nama)
VALUES (201, 'Ensiklopedi')
INTO kategori (id, nama)
VALUES (202, 'Biografi')
SELECT * FROM dual;  
-- Insert Buku

INSERT ALL  
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (111, 'Hujan', 2016, '978-602-032-478-4', 101, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (112, 'Hujan', 2016, '978-602-032-478-4', 101, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (113, 'Hujan', 2016, '978-602-032-478-4', 101, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (114, 'Hujan', 2016, '978-602-032-478-4', 101, 1)
SELECT * FROM dual;  

INSERT ALL 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (121, 'Rindu', 2016, '978-602-899-790-4', 101, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (122, 'Rindu', 2016, '978-602-899-790-4', 101, 1)
 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (131, 'Bintang', 2017, '978-602-035-117-9', 101, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (132, 'Bintang', 2017, '978-602-035-117-9', 101, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (133, 'Bintang', 2017, '978-602-035-117-9', 101, 1)
 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (411,'Attack on Titan vol.1' , 2021, '978-602-021-751-2', 102, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (412,'Attack on Titan vol.1' , 2021, '978-602-021-751-2', 102, 1)
SELECT * FROM dual;  
 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (421,'Attack on Titan vol.2' , 2021, '978-602-021-875-2', 102, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (422,'Attack on Titan vol.2' , 2021, '978-602-021-875-2', 102, 1)
 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (511,'Lobak Raksasa' , 2018, '978-602-455-402-6', 103, 1)
 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (631,'Peniup Seruling dari Hamelin' , 2013, '978-979-074-027-3', 103, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (632,'Peniup Seruling dari Hamelin' , 2013, '978-979-074-027-3', 103, 1)
 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (711,'Putri yang Rapi' , 2017, '978-602-455-213-8', 103, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (712,'Putri yang Rapi' , 2017, '978-602-455-213-8', 103, 1)
 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (951,'Ensiklopedia Tubuh Manusia Ed 2' , 2016, '978-602-252-595-0', 201, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (952,'Ensiklopedia Tubuh Manusia Ed 2' , 2016, '978-602-252-595-0', 201, 1)
 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (331,'Ensiklopedia Kimia Vol. 5' , 2015, '978-602-252-595-0', 201, 1)
 
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (251,'Mohammad Hatta : Biografi Singkat 1902 - 1904' , 2020, '978-623-721-963-7', 202, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (252,'Mohammad Hatta : Biografi Singkat 1902 - 1904' , 2020, '978-623-721-963-7', 202, 1)

SELECT * FROM dual;  
 
-- Insert Pengarang Buku 
INSERT ALL  
INTO pengarang_buku (id_buku, id_pengarang)                 
VALUES (111, 1)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (112, 1)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (113, 1)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (114, 1)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (121, 1)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (122, 1)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (131, 1)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (132, 1)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (133, 1)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (411, 2)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (412, 2)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (421, 2)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (422, 2)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (511, 3)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (631, 4)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (632, 4)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (711, 5)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (712, 5)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (951, 6)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (952, 6)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (331, 7)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (331, 8)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (251, 9)
 
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (252, 9)

SELECT * FROM dual;  

-- Insert Shift
INSERT ALL
INTO shift (kode, deskripsi)
VALUES (1, 'Masuk jam : 07.00, Keluar jam 11.00')
INTO shift (kode, deskripsi)
VALUES (2, 'Masuk jam : 11.00, Keluar jam 15.00')
INTO shift (kode, deskripsi)
VALUES (3, 'Masuk jam : 15.00, Keluar jam 19.00')
SELECT * FROM dual;  

-- Insert pemberian_shift
INSERT ALL
INTO pemberian_shift (kode_shift, id_pustakawan, tanggal_pemberian)
VALUES ( 1, 54160033, TO_DATE('1-Aug-2021', 'DD-Mon-YYYY'))
INTO pemberian_shift (kode_shift, id_pustakawan, tanggal_pemberian)
VALUES ( 2, 54160098, TO_DATE('1-Aug-2021', 'DD-Mon-YYYY'))
INTO pemberian_shift (kode_shift, id_pustakawan, tanggal_pemberian)
VALUES ( 3, 54150052, TO_DATE('1-Aug-2021', 'DD-Mon-YYYY'))
SELECT * FROM dual;  

 
 
-- Insert catatan_peminjaman

INSERT ALL
INTO catatan_peminjaman (id_buku, tanggal_peminjaman, tanggal_pengembalian, id_anggota, id_pustakawan)
VALUES (411, TO_DATE('03-Aug-2021', 'DD-Mon-YYYY'), TO_DATE('10-Aug-2021', 'DD-Mon-YYYY'), 12, 54160033)

INTO catatan_peminjaman (id_buku, tanggal_peminjaman, tanggal_pengembalian, id_anggota, id_pustakawan)
VALUES (111, TO_DATE('03-Aug-2021','DD-Mon-YYYY'), TO_DATE('14-Aug-2021', 'DD-Mon-YYYY'), 13, 54160033)

INTO catatan_peminjaman (id_buku, tanggal_peminjaman, tanggal_pengembalian, id_anggota, id_pustakawan)
VALUES (251, TO_DATE('12-Aug-2021','DD-Mon-YYYY'), TO_DATE('22-Aug-2021', 'DD-Mon-YYYY'), 10, 54160033)
SELECT * FROM dual;  

INTO catatan_peminjaman (id_buku, tanggal_peminjaman, tanggal_pengembalian, id_anggota, id_pustakawan)
VALUES (133, TO_DATE('14-Aug-2021','DD-Mon-YYYY'), TO_DATE('21-Aug-2021', 'DD-Mon-YYYY'), 11, 54160033)
SELECT * FROM dual;  

INTO catatan_peminjaman (id_buku, tanggal_peminjaman, tanggal_pengembalian, id_anggota, id_pustakawan)
VALUES (133, TO_DATE('1-Sep-2021','DD-Mon-YYYY'), TO_DATE('7-Sep-2021', 'DD-Mon-YYYY'), 11, 54160033)
SELECT * FROM dual;  



-- Insert denda
INSERT ALL
INTO denda (id, id_anggota, tanggal_denda, nominal)
VALUES (id_denda_seq.NEXTVAL, 13, TO_DATE('12-Aug-2021', 'DD-Mon-YYYY'), 1000)
INTO denda (id, id_anggota, tanggal_denda, nominal)
VALUES (id_denda_seq.NEXTVAL, 13, TO_DATE('13-Aug-2021', 'DD-Mon-YYYY'), 1000)
INTO denda (id, id_anggota, tanggal_denda, nominal)
VALUES (id_denda_seq.NEXTVAL, 10, TO_DATE('20-Aug-2021', 'DD-Mon-YYYY'), 1000)
INTO denda (id, id_anggota, tanggal_denda, nominal)
VALUES (id_denda_seq.NEXTVAL, 10, TO_DATE('21-Aug-2021', 'DD-Mon-YYYY'), 1000)
INTO denda (id, id_anggota, tanggal_denda, nominal)
VALUES (id_denda_seq.NEXTVAL, 10, TO_DATE('22-Aug-2021', 'DD-Mon-YYYY'), 1000)
SELECT 1 FROM dual; 

-- Insert pembayaran denda
INSERT INTO pembayaran_denda (id, id_anggota, tanggal_pembayaran, nominal_pembayaran)
VALUES (id_denda_seq.NEXTVAL, 13, TO_DATE('14-Aug-2021', 'DD-Mon-YYYY'), 2000)


-- View
 
CREATE OR REPLACE FORCE VIEW "DETAIL_BUKU" AS
    SELECT 
        DISTINCT("ID"), "ISBN", "JUDUL", "TAHUN", "KATEGORI", LISTAGG("PENGARANG", '; ') WITHIN GROUP (ORDER BY "PENGARANG")OVER (PARTITION BY "ID") as "PENGARANG"  
    FROM
        (SELECT b.id "ID", b.isbn "ISBN", b.judul "JUDUL", b.tahun "TAHUN", k.nama "KATEGORI", p.nama_depan || ' ' || p.nama_belakang "PENGARANG"
        FROM        
                buku b,
                pengarang_buku pb,
                pengarang p,
                kategori k
        WHERE 
                b.id = pb.id_buku
                AND pb.id_pengarang = p.id
                AND b.id_kategori = k.id)
    ORDER BY "ID"
    WITH READ ONLY

CREATE VIEW buku yang ditulis penulis
CREATE VIEW jadwal_pustakawan
 
CREATE VIEW riwayat_denda
 
-- Case Testing
 
-- 3 SELECT

-- SELECT cari nama pengarang
SELECT *
FROM DETAIL_BUKU
WHERE LOWER("PENGARANG") LIKE '%haj%'
 
SELECT 
    k.nama "Kategori", COUNT(k.nama) "Jumlah yang dipinjam"
FROM 
    cat_pem c,
    buku b,
    kategori k
WHERE c.id_buku = b.id AND b.id_kategori = k.id
GROUP BY k.nama
ORDER BY "Jumlah yang dipinjam" DESC

GROUP BY id_kategori;

--SELECT kategori laris

--SELECT Denda yang belum dibayar

SELECT a.id, a.nama, "Denda yang belum dibayar"
FROM anggota a,
    (SELECT d.id_anggota "id", NVL("denda",0) - NVL("pembayaran",0) "Denda yang belum dibayar"
     FROM 
        (SELECT id_anggota , SUM(nominal) "denda"
        FROM denda
        GROUP BY id_anggota) d,
        (SELECT id_anggota, SUM(nominal_pembayaran) "pembayaran"
        FROM pembayaran_denda
        GROUP BY id_anggota) p
     WHERE d.id_anggota = p.id_anggota (+)) b
WHERE a.id = b."id"

--SELECT Jumlah Buku yang sama
SELECT COUNT(isbn) 
FROM buku 
WHERE isbn = '978-602-252-595-0';

-- 3 UPDATE/DELETE

--update isbn buku
UPDATE buku
SET isbn = '978-602-252-596-0'
WHERE id = 331

--update nominal denda jadi minus
UPDATE denda
SET nominal = -9000
WHERE id = 1

--delete kategori
DELETE FROM kategori
WHERE id = 103

 
-- Berdasarkan bulan
SELECT extract(year from tanggal_peminjaman) "tahun", extract(month from tanggal_peminjaman) "bulan", k.nama, COUNT(k.nama) "Jumlah yang dipinjam"
FROM    cat_pem c,    buku b,    kategori k
WHERE c.id_buku = b.id AND b.id_kategori = k.id
GROUP BY extract(year from tanggal_peminjaman), extract(month from tanggal_peminjaman), ROLLUP(k.nama)
ORDER BY "Jumlah yang dipinjam" DESC;

-- Berdasarkan tahun
SELECT extract(year from tanggal_peminjaman) "tahun", k.nama, COUNT(k.nama) "Jumlah yang dipinjam"
FROM    cat_pem c,    buku b,    kategori k
WHERE c.id_buku = b.id AND b.id_kategori = k.id
GROUP BY extract(year from tanggal_peminjaman), ROLLUP(k.nama)
ORDER BY "Jumlah yang dipinjam" DESC;
