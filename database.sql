-- Tabel Anggota
CREATE TABLE anggota (
    id NUMBER(8,0) CONSTRAINT anggota_id_pk PRIMARY KEY,
    nama VARCHAR2(30) CONSTRAINT anggota_nama_nn NOT NULL,
    alamat VARCHAR2(60) CONSTRAINT anggota_alamat_nn NOT NULL,
    no_telp VARCHAR2(15) CONSTRAINT anggota_no_telp_nn NOT NULL,
    nip VARCHAR2(8),
    CONSTRAINT anggota_id_uk UNIQUE (id),
    CONSTRAINT anggota_no_telp_uk UNIQUE (no_telp)
);

-- Tabel Pustakawan
CREATE TABLE pustakawan (
    id NUMBER(4,0) CONSTRAINT pustakawan_id_pk PRIMARY KEY,
    nama VARCHAR2(30) CONSTRAINT pustakawan_nama_nn NOT NULL,
    alamat VARCHAR2(60) CONSTRAINT pustakawan_alamat_nn NOT NULL,
    no_telp VARCHAR2(15) CONSTRAINT pustakawan_no_telp_nn NOT NULL,
    CONSTRAINT pustakawan_id_uk UNIQUE (id),
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
    judul VARCHAR2(40) CONSTRAINT buku_judul_nn NOT NULL,
    tahun NUMBER(4),
    isbn VARCHAR2(17),
    id_kategori VARCHAR2(2),
    id_pengarang VARCHAR2(8),
    ketersediaan VARCHAR2(1) CONSTRAINT buku_keter_nn NOT NULL,
    CONSTRAINT buku_id_uk UNIQUE id,
    CONSTRAINT buku_kat_id_fk FOREIGN KEY (id_kategori) REFERENCES kategori(id),
    CONSTRAINT check_ketersediaan CHECK (ketersediaan IN ("1", "0"))
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
    id_pustakawan NUMBER(4,0) CONSTRAINT cat_pem_id_pustakawan_fk REFERENCES pustakawan(id),
    CONSTRAINT cat_pem_id_tgl_pk PRIMARY KEY (id_buku, tanggal_peminjaman),
    CONSTRAINT check_tgl_cat_pem CHECK (tanggal_peminjaman <= tanggal_pengembalian)
)

-- Tabel Denda
CREATE TABLE denda (
    id VARCHAR2(8) CONSTRAINT denda_id_pk PRIMARY KEY
    tanggal_denda DATE,
    nominal NUMBER(8,0),
    id_anggota NUMBER(8,0) CONSTRAINT denda_id_anggota_fk REFERENCES anggota(id),
    CONSTRAINT check_nom_denda CHECK (nominal > 0)
)

-- Tabel Pembayaran Denda
CREATE TABLE pembayaran_denda (
    tanggal_pembayaran DATE,
    nominal_pembayaran NUMBER(8,0)
)

-- Tabel Shift
CREATE TABLE shift (
    kode_shift VARCHAR2(2) CONSTRAINT shift_kode_pk PRIMARY KEY,
    deskripsi VARCHAR2(30),
    CONSTRAINT shift_kode_uk UNIQUE kode_shift
)

-- Tabel Pemberian Shift
CREATE TABLE pemberian_shift (
    kode_shift VARCHAR2(2) CONSTRAINT pem_shift_kode_fk REFERENCES shift(kode),
    id_pustakawan VARCHAR2(8) CONSTRAINT pem_shift_id_pustakawan REFERENCES pustakawan(id),
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
INSERT INTO anggota (id, nama, alamat, no_telp, nip) 
VALUES (idseq.NEXTVAL, 'Muhammad Agung Zuhdi', 'Desa Sukadami, Kecamatan Cikarang Selatan, Kabupaten Bekasi', 085212342580, '' );

-- Insert pengarang
INSERT INTO pengarang (id, nama_depan, nama_belakang)
VALUES (1, "Depan", "Belakang")


-- Insert Kategori
INSERT INTO kategori (id, nama)
VALUES (1, "Kategori 1")


-- Insert Buku
INSERT INTO buku (id, judul, tahun, isbn, id_kategori, ketersediaan)
VALUES (1, "Ini Judul Buku", "2021", "3024234256783", "1", "1")


-- Insert Pengarang Buku 

INSERT INTO pengarang_buku (id_buku, id_pengarang)
VALUES (1, 2)

-- Insert catatan_peminjaman

INSERT INTO catatan_peminjaman (id_buku, tanggal_peminjaman, tanggal_pengembalian, id_anggota, id_pustakawan)
VALUES (1, SYSDATE, nah ini mau ditentuin apa gimana?, 1, 1)



-- Rencana buat view dan case

-- detail buku (kategori dan pengarang)
-- misal ada yang nyari buku yang sama, berapa salinan buku yang ada (select count(isbn) from buku)
-- view jadwal pustakawan


-- View

CREATE VIEW detail_buku 
AS SELECT b.id, b.judul, b.tahun, k.nama
FROM buku b JOIN kategori k ON (b.id_kategori = k.id) JOIN 

CREATE VIEW jadwal_pustakawan

CREATE VIEW riwayat_denda

-- Case Testing

-- 3 SELECT

SELECT COUNT(isbn) FROM buku GROUP BY isbn;
SELECT COUNT(isbn) FROM buku WHERE isbn = "3024234256783";

SELECT COUNT(*) FROM cat_pem GROUP BY id_kategori;



-- 3 UPDATE/DELETE


