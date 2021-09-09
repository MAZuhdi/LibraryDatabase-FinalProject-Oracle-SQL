-- Tabel Anggota
CREATE TABLE anggota (
    id NUMBER(8,0) CONSTRAINT anggota_id_pk PRIMARY KEY,
    nama VARCHAR2(30) CONSTRAINT anggota_nama_nn NOT NULL,
    alamat VARCHAR2(60) CONSTRAINT anggota_alamat_nn NOT NULL,
    no_telp VARCHAR2(15) CONSTRAINT anggota_no_telp_nn NOT NULL,
    nip VARCHAR2(8),
    CONSTRAINT anggota_no_telp_uk UNIQUE (no_telp)
);
 
-- Tabel Pustakawan
CREATE TABLE pustakawan (
    id NUMBER(8,0) CONSTRAINT pustakawan_id_pk PRIMARY KEY,
    nama VARCHAR2(30) CONSTRAINT pustakawan_nama_nn NOT NULL,
    alamat VARCHAR2(60) CONSTRAINT pustakawan_alamat_nn NOT NULL,
    no_telp VARCHAR2(15) CONSTRAINT pustakawan_no_telp_nn NOT NULL,
    CONSTRAINT pustakawan_no_telp_uk UNIQUE (no_telp),
)
 
-- Tabel Pengarang
CREATE TABLE pengarang (
    id NUMBER(8,0) CONSTRAINT pengarang_id_pk PRIMARY KEY,
    nama_depan VARCHAR2(20),
    nama_belakang VARCHAR2(20) CONSTRAINT pengarang_namab_nn NOT NULL,
    CONSTRAINT pengarang_id_uk UNIQUE id,
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
    CONSTRAINT buku_id_uk UNIQUE id,
    CONSTRAINT buku_kat_id_fk FOREIGN KEY (id_kategori) REFERENCES kategori(id),
    CONSTRAINT check_ketersediaan CHECK (ketersediaan IN (1, 0))
)
 
 
-- Tabel Pengarang Buku
CREATE TABLE pengarang_buku (
    id_buku NUMBER(8,0) CONSTRAINT peng_buku_id_buku_fk REFERENCES buku(id),
    id_pengarang NUMBER(8,0) CONSTRAINT peng_buku_id_pengarang_fk REFERENCES pengarang(id),
    CONSTRAINT peng_buku_pk PRIMARY KEY (id_buku, id_pengarang)
)
 
 
-- Tabel Catatan Peminjaman
CREATE TABLE catatan_peminjaman (
    id_buku NUMBER(8,0) CONSTRAINT cat_pem_id_buku_fk REFERENCES buku(id),
    tanggal_peminjaman DATE CONSTRAINT cat_pem_tgl_pem_nn NOT NULL,
    tanggal_pengembalian DATE
    id_anggota NUMBER(8,0) CONSTRAINT cat_pem_id_anggota_fk REFERENCES anggota(id),
    id_pustakawan NUMBER(8,0) CONSTRAINT cat_pem_id_pustakawan_fk REFERENCES pustakawan(id),
    CONSTRAINT cat_pem_id_tgl_pk PRIMARY KEY (id_buku, tanggal_peminjaman),
    CONSTRAINT check_tgl_cat_pem CHECK (tanggal_peminjaman <= tanggal_pengembalian)
)
 
-- Tabel Denda
CREATE TABLE denda (
    id NUMBER(8,0) CONSTRAINT denda_id_pk PRIMARY KEY,
    id_anggota NUMBER(8,0) CONSTRAINT denda_id_anggota_fk REFERENCES anggota(id),
    tanggal_denda DATE,
    nominal NUMBER(8,0),
    CONSTRAINT check_nom_denda CHECK (nominal > 0)
)
 
-- Tabel Pembayaran Denda
CREATE TABLE pembayaran_denda (
    id NUMBER(8,0) CONSTRAINT pem_den_id_pk PRIMARY KEY,
    id_anggota NUMBER(8,0) CONSTRAINT denda_id_anggota_fk REFERENCES anggota(id),
    tanggal_pembayaran DATE,
    nominal_pembayaran NUMBER(8,0)
)
 
-- Tabel Shift
CREATE TABLE shift (
    kode NUMBER(2,0) CONSTRAINT shift_kode_pk PRIMARY KEY,
    deskripsi VARCHAR2(30),
    CONSTRAINT shift_kode_uk UNIQUE kode_shift
)
 
-- Tabel Pemberian Shift
CREATE TABLE pemberian_shift (
    kode_shift NUMBER(2,0) CONSTRAINT pem_shift_kode_fk REFERENCES shift(kode),
    id_pustakawan NUMBER(8,0) CONSTRAINT pem_shift_id_pustakawan REFERENCES pustakawan(id),
    tanggal_pemberian DATE NOT NULL,
    CONSTRAINT pem_shift_pk PRIMARY KEY (kode_shift, id_pustakawan)
)
 
-- Index

 
-- Sequence
CREATE SEQUENCE id_anggota_sequence
INCREMENT BY 1
START WITH 10
MAXVALUE 99999999
NOCYCLE
 
--contoh insert into pake sequence (setelah pakai synnonym)
 
 
 
-- Synonym
 
CREATE SYNONYM idseq FOR id_anggota_sequence;
CREATE SYNONYM cat_pem FOR catatan_peminjaman;
 
 
-- Isi data
 
--contoh insert into pake sequence (setelah pakai synnonym)
--id 10

INSERT ALL
--id 10
INTO anggota (id, nama, alamat, no_telp, nip) 
VALUES (idseq.NEXTVAL, 'Muhammad Agung Zuhdi', 'Desa Sukadami, Kecamatan Cikarang Selatan, Kabupaten Bekasi', '085212342580', '' );
--id 11
INTO anggota (id, nama, alamat, no_telp, nip) 
VALUES (idseq.NEXTVAL, 'Dewi Anbara Primayu', 'Condet, Kecamatan Kec. Kramat Jati, Jakarta Timur', '081213238605', '' )
--id 12
INTO anggota (id, nama, alamat, no_telp, nip) 
VALUES (idseq.NEXTVAL, 'Winda Oktaviona', 'Dramaga, Kabupaten Bogor, Jawa Barat', '081277653096', '' )
--id 13
INTO anggota (id, nama, alamat, no_telp, nip) 
VALUES (idseq.NEXTVAL, 'Indah Permatasari', 'Dramaga, Kabupaten Bogor, Jawa Barat', '081211376545', '' )
--id 14
INTO anggota (id, nama, alamat, no_telp, nip) 
VALUES (idseq.NEXTVAL, 'Budi Cahyono', 'Dramaga, Kabupaten Bogor, Jawa Barat', '081211376535', '54160033' )
--id 15
INTO anggota (id, nama, alamat, no_telp, nip) 
VALUES (idseq.NEXTVAL, 'Susi Susanti', 'Dramaga, Kabupaten Bogor, Jawa Barat', '081211393463', '54160098' )
SELECT * FROM dual;  

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
VALUES (11, 'Hujan', 2016, '978-602-032-478-4', 101, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (12, 'Rindu', 2016, '978-602-899-790-4', 101, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (13, 'Bintang', 2017, '978-602-035-117-9', 101, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (41,'Attack on Titan vol.1' , 2021, '978-602-021-751-2', 102, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (42,'Attack on Titan vol.2' , 2021, '978-602-021-875-2', 102, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (51,'Lobak Raksasa' , 2018, '978-602-455-402-6', 103, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (63,'Peniup Seruling dari Hamelin' , 2013, '978-979-074-027-3', 103, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (71,'Putri yang Rapi' , 2017, '978-602-455-213-8', 103, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (95,'Ensiklopedia Tubuh Manusia Ed 2' , 2016, '978-602-252-595-0', 201, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (33,'Ensiklopedia Kimia Vol. 5' , 2015, '978-602-252-595-0', 201, 1)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (25,'Mohammad Hatta : Biografi Singkat 1902 - 1904' , 2020, '978-623-721-963-7', 202, 0)
INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (96,'Ensiklopedia Tubuh Manusia Ed 2' , 2016, '978-602-252-595-0', 201, 1)
SELECT * FROM dual;  
 
-- Insert Pengarang Buku 
INSERT ALL  
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (11, 1)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (12, 1)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (13, 1)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (41, 2)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (42, 2)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (51, 3)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (63, 4)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (71, 5)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (95, 6)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (33, 7)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (33, 8)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (25, 9)
INTO pengarang_buku (id_buku, id_pengarang)
VALUES (96, 6)
SELECT * FROM dual;  
 
 
-- Insert catatan_peminjaman
 
INSERT INTO catatan_peminjaman (id_buku, tanggal_peminjaman, tanggal_pengembalian, id_anggota, id_pustakawan)
VALUES (1, TO_DATE('12-Aug-2021', 'DD-Mon-YYYY'), TO_DATE('19-Aug-2021', 'DD-Mon-YYYY'), 1, 1)
 
 
-- View
 
CREATE OR REPLACE FORCE VIEW "DETAIL_BUKU" AS
    SELECT 
        DISTINCT("ID"), "ISBN", "JUDUL", "TAHUN", "KATEGORI", LISTAGG("PENGARANG", '; ') WITHIN GROUP (ORDER BY "PENGARANG")OVER (PARTITION BY "JUDUL") as "PENGARANG"  
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
 
SELECT COUNT(*) FROM cat_pem GROUP BY id_kategori;

--SELECT kategori laris

--SELECT Denda sesoorang

--SELECT Jumlah Buku yang sama
SELECT COUNT(isbn) 
FROM buku 
WHERE isbn = '978-602-252-595-0';

-- 3 UPDATE/DELETE

--update isbn buku
UPDATE buku
SET isbn = '978-602-252-596-0'
WHERE id = 33

--update nominal denda jadi minus

UPDATE denda
SET nominal = -9000
WHERE id = 1

--delete buku
DELETE FROM buku
WHERE id = 96
 
 
 