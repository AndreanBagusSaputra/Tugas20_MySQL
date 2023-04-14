-- Soal 3.1 
-- Tampilkan produk yang asset nya diatas 20jt
SELECT * FROM produk WHERE harga_beli * stok > 20000000;

-- Tampilkan data produk beserta selisih stok dengan minimal stok
MariaDB [dbtoko1]> SELECT SUM(stok - min_stok) as selisih from produk;

-- Tampilkan total asset produk secara keseluruhan
MariaDB [dbtoko1]> SELECT sum(stok) as total_asset from produk;

-- Tampilkan data pelanggan yang lahirnya antara tahun 1999 sampai 2004
MariaDB [dbtoko1]> SELECT * FROM pelanggan WHERE YEAR(tgl_lahir) BETWEEN 1999 AND 2004;

-- Tampilkan data pelanggan yang lahirnya tahun 1998
MariaDB [dbtoko1]> SELECT * FROM pelanggan WHERE YEAR(tgl_lahir)=1998;

-- Tampilkan data pelanggan yang berulang tahun bulan agustus
MariaDB [dbtoko1]> SELECT * FROM pelanggan WHERE MONTH(tgl_lahir)=08;

-- Tampilkan data pelanggan : nama, tmp_lahir, tgl_lahir dan umur (selisih tahun sekarang dikurang tahun kelahiran)
MariaDB [dbtoko1]> SELECT nama, tmp_lahir, tgl_lahir, (YEAR(NOW())-YEAR(tgl_lahir)) AS umur FROM pelanggan;

-- Soal 3.2
-- Berapa jumlah pelanggan yang tahun lahirnya 1998
select count(*) from pelanggan where year (tgl_lahir) = 1998;

-- Berapa jumlah pelanggan perempuan yang tempat lahirnya di Jakarta
select count(*) from pelanggan where jk = 'P' and tmp_lahir = 'Jakarta';

-- Berapa jumlah total stok semua produk yang harga jualnya dibawah 10rb
select sum(stok) from produk where harga_jual < 10000;

-- Ada berapa produk yang mempunyai kode awal K
 select count(*) from produk where kode like 'k%';

-- Berapa harga jual rata-rata produk yang diatas 1jt
select avg(harga_jual) from produk where harga_jual > 1000000;

-- Tampilkan jumlah stok yang paling besar
select max(stok) from produk;

-- Ada berapa produk yang stoknya kurang dari minimal stok
SELECT COUNT(*) FROM produk WHERE stok < 2;

-- Berapa total asset dari keseluruhan produk
 select sum(harga_beli) from produk;

-- Soal 3.3
-- Tampilkan data produk : id, nama, stok dan informasi jika stok telah sampai batas minimal atau kurang dari minimum stok dengan informasi ‘segera belanja’ jika tidak ‘stok aman’.
SELECT id, nama, stok,
    -> IF(stok <= min_stok, 'segera belanja', 'stok aman') AS status_stok
    -> from produk;

-- Tampilkan data pelanggan: id, nama, umur dan kategori umur : jika umur < 17 → ‘muda’ , 17-55 → ‘Dewasa’, selainnya ‘Tua’
SELECT id, nama_pelanggan, (YEAR(CURRENT_DATE()) - YEAR(tgl_lahir)) AS umur,
    -> CASE
    ->  WHEN (YEAR(CURRENT_DATE()) - YEAR(tgl_lahir)) < 17 THEN 'muda'
    ->  WHEN (YEAR(CURRENT_DATE()) - YEAR(tgl_lahir)) >= 17 AND (YEAR(CURRENT_DATE()) - YEAR(tgl_lahir)) <= 55 THEN 'Dewasa'
    ->  ELSE 'Tua'
    -> END AS kategori_umur
    -> from pelanggan;

-- Tampilkan data produk: id, kode, nama, dan bonus untuk kode ‘TV01’ →’DVD Player’ , ‘K001’ → ‘Rice Cooker’ selain dari diatas ‘Tidak Ada’
SELECT id, kode, nama,
    ->   CASE
    ->     WHEN kode = 'TV01' THEN 'DVD Player'
    ->     WHEN kode = 'K001' THEN 'Rice Cooker'
    ->     ELSE 'Tidak Ada'
    ->   END AS bonus
    -> FROM produk;

-- Tugas 3.4
-- Tampilkan data statistik jumlah tempat lahir pelanggan
SELECT tmp_lahir, COUNT(*) AS jumlah_pelanggan,
    ->   MIN(tgl_lahir) AS tanggal_lahir_terbaru,
    ->   MAX(tgl_lahir) AS tanggal_lahir_terlama,
    ->   AVG(YEAR(CURRENT_DATE()) - YEAR(tgl_lahir)) AS rata_rata_umur
    -> from pelanggan
    -> group by tmp_lahir;
    
-- Tampilkan jumlah statistik produk berdasarkan jenis produk
SELECT nama, COUNT(*) AS jumlah_produk,
    ->   MIN(harga_jual) AS harga_terendah,
    ->   MAX(harga_jual) AS harga_tertinggi,
    ->   AVG(harga_jual) AS harga_rata_rata
    -> from produk
    -> group by nama;
-- Tampilkan data pelanggan yang usianya dibawah rata usia pelanggan
SELECT id, nama_pelanggan, YEAR(CURDATE()) - YEAR(tgl_lahir) AS umur
    -> from pelanggan
    -> WHERE YEAR(CURDATE()) - YEAR(tgl_lahir) <
    ->     (SELECT AVG(YEAR(CURDATE()) - YEAR(tgl_lahir)) FROM pelanggan);

-- SELECT id, nama, harga_jual
    -> FROM produk
    -> WHERE harga_jual >
    ->     (SELECT AVG(harga_jual) FROM produk);

-- Tampilkan data pelanggan yang memiliki kartu dimana iuran tahunan kartu diatas 90rb
SELECT id, nama_pelanggan, kartu_id
    -> FROM pelanggan
    -> JOIN kartu ON kartu_id = id
    -> WHERE iuran > 90000;

-- Tampilkan statistik data produk dimana harga produknya dibawah rata-rata harga produk secara keseluruhan
SELECT COUNT(*) AS jumlah_produk, AVG(harga_jual) AS rata_rata_harga
    -> from produk
    -> WHERE harga_jual < (SELECT AVG(harga_jual) FROM produk);

-- Tampilkan data pelanggan yang memiliki kartu dimana diskon kartu yang diberikan diatas 3%
select id, nama_pelanggan, kartu_id
    -> from pelanggan
    -> join kartu on pelanggan.kartu_id = kartu.id
    -> where kartu.diskon > 0.03;