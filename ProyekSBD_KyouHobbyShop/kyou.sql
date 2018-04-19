-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 15, 2017 at 12:06 AM
-- Server version: 5.7.20
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kyou`
--

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE `akun` (
  `username` varchar(15) NOT NULL,
  `password` varchar(8) DEFAULT NULL,
  `jenis_akun` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`username`, `password`, `jenis_akun`) VALUES
('ahmad_99', 'kepoaja', 'pembeli'),
('akriptonn', 'tusbal26', 'pembeli'),
('athinaangelica', 'kuching', 'karyawan'),
('athinamaria', 'kuching', 'pembeli'),
('bimotomtom', 'kyouid88', 'pemilik'),
('goldyTW', 'setnov9', 'karyawan'),
('ian_jo', 'jojoba', 'pembeli'),
('ichiyose_29', 'qwerty', 'pembeli'),
('kukuhama', '123456', 'pembeli'),
('rama_26', '123456', 'pembeli'),
('sebastian', 'stardew', 'pembeli');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_bar` int(11) DEFAULT NULL,
  `nama` text NOT NULL,
  `harga` int(11) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_bar`, `nama`, `harga`, `stok`) VALUES
(1, 'Genjutsu Figure', 100000, 10),
(33, 'Nankatsu Tsubasa', 400000, 8),
(34, 'Furabit', 6000000, 21),
(36, 'Nankatsu Hyuga', 400000, 34),
(37, 'Nankatsu Kojiro', 500000, 12),
(40, 'Kurisu Standing Figure', 100000, 11),
(42, 'Yoshimitzu figure', 30000, 5),
(9, 'Eli Figure', 1000000, 5),
(15, 'Genos', 100000, 7),
(77, 'Anguished One Alcor Figure', 500000, 28);

-- --------------------------------------------------------

--
-- Table structure for table `berisi`
--

CREATE TABLE `berisi` (
  `invoice` int(11) NOT NULL,
  `id_bar` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `berisi`
--

INSERT INTO `berisi` (`invoice`, `id_bar`) VALUES
(1, 9),
(4, 1),
(15, 34),
(16, 1),
(17, 1),
(18, 15),
(19, 15),
(20, 15),
(21, 77),
(22, 1),
(24, 77);

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id_peg` int(11) DEFAULT NULL,
  `nama_peg` text NOT NULL,
  `username` varchar(15) NOT NULL,
  `status` varchar(12) NOT NULL COMMENT 'apakah pegawai masih bekerja untuk kyou'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id_peg`, `nama_peg`, `username`, `status`) VALUES
(23, 'Goldy', 'goldyTW', 'aktif'),
(1, 'Bimo', 'bimotomtom', 'aktif'),
(25, 'Athina', 'athinaangelica', 'non-aktif');

--
-- Triggers `pegawai`
--
DELIMITER $$
CREATE TRIGGER `valid_pegawai` BEFORE INSERT ON `pegawai` FOR EACH ROW BEGIN
    
   IF NEW.Nama_PEG REGEXP '^[ qwertyuiopasdfghjklzxcvbnm]+$'
          THEN
           Set NEW.Nama_PEG = NEW.Nama_PEG;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nama hanya huruf';
          END IF;
     END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `valid_pegawai_2` BEFORE UPDATE ON `pegawai` FOR EACH ROW BEGIN
    
   IF NEW.Nama_PEG REGEXP '^[ qwertyuiopasdfghjklzxcvbnm]+$'
          THEN
           Set NEW.Nama_PEG = NEW.Nama_PEG;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nama hanya huruf';
          END IF;
     END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pembeli`
--

CREATE TABLE `pembeli` (
  `username` varchar(15) NOT NULL,
  `nama` text,
  `hp` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pembeli`
--

INSERT INTO `pembeli` (`username`, `nama`, `hp`) VALUES
('ahmad_99', 'Ahmad Suharjo', '081924101621'),
('akriptonn', 'Achmad Kripton', '81882827312'),
('athinamaria', 'Athina', '081231211423'),
('ian_jo', 'Ian Joseph', '88991110011'),
('ichiyose_29', 'Christian', '08159253017'),
('kukuhama', 'Verawati', '0819281521'),
('rama_26', 'Rama Bernadus', '081925102612'),
('sebastian', 'Sebastian', '081777888999');

--
-- Triggers `pembeli`
--
DELIMITER $$
CREATE TRIGGER `valid_pembeli` BEFORE INSERT ON `pembeli` FOR EACH ROW BEGIN
          IF NEW.hp REGEXP '^08[1234567890]+$'
          THEN
           Set NEW.hp = NEW.hp;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nomor Telepon hanya angka';
          END IF;
   IF NEW.Nama REGEXP '^[ qwertyuiopasdfghjklzxcvbnm]+$'
          THEN
           Set NEW.Nama = NEW.Nama;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nama hanya huruf';
          END IF;
     END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `valid_pembeli_2` BEFORE UPDATE ON `pembeli` FOR EACH ROW BEGIN
          IF NEW.hp REGEXP '^08[1234567890]+$'
          THEN
           Set NEW.hp = NEW.hp;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nomor Telepon hanya angka';
          END IF;
   IF NEW.Nama REGEXP '^[ qwertyuiopasdfghjklzxcvbnm]+$'
          THEN
           Set NEW.Nama = NEW.Nama;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nama hanya huruf';
          END IF;
     END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pembelian`
--

CREATE TABLE `pembelian` (
  `invoice` int(11) NOT NULL,
  `jml_pembelian` int(11) NOT NULL,
  `metode_bayar` text NOT NULL,
  `ket_status` text NOT NULL,
  `ongkir` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `username` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pembelian`
--

INSERT INTO `pembelian` (`invoice`, `jml_pembelian`, `metode_bayar`, `ket_status`, `ongkir`, `total`, `username`) VALUES
(1, 1, 'Credit Card', 'BELUM LUNAS', 5000, 1000000, 'akriptonn'),
(4, 1, 'Credit Card', 'BELUM LUNAS', 5000, 50000, 'akriptonn'),
(15, 1, 'Credit Card', 'BELUM LUNAS', 5000, 1000, 'akriptonn'),
(16, 1, 'Credit Card', 'BELUM LUNAS', 5000, 1000, 'ian_jo'),
(17, 1, 'Bank Transfer', 'BELUM LUNAS', 5000, 1000, 'ian_jo'),
(18, 2, 'Cash', 'BELUM LUNAS', 5000, 200000, 'akriptonn'),
(19, 9, 'Credit Card', 'BELUM LUNAS', 5000, 900000, 'akriptonn'),
(20, 2, 'Cash', 'BELUM LUNAS', 5000, 200000, 'akriptonn'),
(21, 3, 'Credit Card', 'BELUM LUNAS', 5000, 1500000, 'akriptonn'),
(22, 3, 'Cash', 'BELUM LUNAS', 5000, 300000, 'akriptonn'),
(24, 5, 'Credit Card', 'BELUM LUNAS', 5000, 2500000, 'sebastian');

-- --------------------------------------------------------

--
-- Table structure for table `penerima`
--

CREATE TABLE `penerima` (
  `hp` varchar(12) NOT NULL,
  `nama` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penerima`
--

INSERT INTO `penerima` (`hp`, `nama`) VALUES
('02147483647', 'Budi'),
('02178634252', 'Budi'),
('0217868625', 'Setia Laksono'),
('02178884261', 'Irfandi Kosasih'),
('0218252915', 'Sri Hartono '),
('02195162021', 'Juan'),
('0812111222', 'Kripton'),
('08169289111', 'Natasha Eliza'),
('081777888999', 'Sebastian'),
('081789789789', 'Sebby'),
('081902571921', 'Setia Mulyono'),
('085867981113', 'Quincy');

--
-- Triggers `penerima`
--
DELIMITER $$
CREATE TRIGGER `nama_only_huruf` BEFORE INSERT ON `penerima` FOR EACH ROW BEGIN
          IF NEW.hp REGEXP '^0[1234567890]+$'
          THEN
           Set NEW.hp = NEW.hp;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nomor Telepon hanya angka';
          END IF;
   IF NEW.Nama REGEXP '^[qwertyuiopasdfghjklzxcvbnm ]+$'
          THEN
           Set NEW.Nama = NEW.Nama;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nama hanya huruf';
          END IF;
     END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nama_only_huruf_2` BEFORE UPDATE ON `penerima` FOR EACH ROW BEGIN
          IF NEW.hp REGEXP '^0[1234567890]+$'
          THEN
           Set NEW.hp = NEW.hp;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nomor Telepon hanya angka';
          END IF;
   IF NEW.Nama REGEXP '^[qwertyuiopasdfghjklzxcvbnm ]+$'
          THEN
           Set NEW.Nama = NEW.Nama;    
          ELSE
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Nama hanya huruf';
          END IF;
     END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pengiriman`
--

CREATE TABLE `pengiriman` (
  `resi` int(11) NOT NULL,
  `waktu_kirim` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `waktu_terima` timestamp NULL DEFAULT NULL,
  `kurir` text,
  `invoice` int(11) NOT NULL,
  `penerima` varchar(12) NOT NULL,
  `pengirim` int(11) NOT NULL,
  `alamat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pengiriman`
--

INSERT INTO `pengiriman` (`resi`, `waktu_kirim`, `waktu_terima`, `kurir`, `invoice`, `penerima`, `pengirim`, `alamat`) VALUES
(1, '2017-12-15 04:12:47', '2017-12-13 05:35:14', 'JNE', 1, '02147483647', 23, 'Jl.Sudirman No. 4B, Jakarta Selatan'),
(15, '2017-12-15 04:12:54', NULL, 'JNE', 4, '02178634252', 23, 'Jl.Sudirman No. 4B, Jakarta Selatan'),
(19, '2017-12-15 04:13:12', NULL, 'Go-Send', 15, '02147483647', 25, 'Jl.Sudirman No. 4B, Jakarta Selatan'),
(20, '2017-12-15 04:13:56', NULL, 'Go-Send', 16, '0218252915', 25, 'Jl. Arif Rahman Hakim'),
(21, '2017-12-15 04:14:03', NULL, 'JNE', 17, '08169289111', 25, 'Jl. Arif Rahman Hakim'),
(22, '2017-12-15 04:14:09', NULL, 'JNE', 18, '02195162021', 23, 'Jl. Sudirman No. 4B, Jakarta Selatan'),
(23, '2017-12-15 04:14:16', NULL, 'Go-Send', 19, '02178884261', 1, 'Jl. Sudirman No. 4B, Jakarta Selatan'),
(24, '2017-12-15 04:14:23', NULL, 'Go-Send', 20, '081902571921', 1, 'Jl. Rasuna Said '),
(25, '2017-12-15 04:31:19', NULL, 'Go-Send', 21, '02147483647', 1, 'Jl. Raya Lenteng Agung'),
(26, '2017-12-15 05:36:33', NULL, 'JNE', 22, '02178884261', 1, 'Jl. Raya Lenteng Agung'),
(27, '2017-12-15 05:36:03', NULL, 'Go-Send', 24, '0812111222', 1, 'Kukel');

-- --------------------------------------------------------

--
-- Table structure for table `punya`
--

CREATE TABLE `punya` (
  `username` varchar(15) NOT NULL,
  `hp` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `punya`
--

INSERT INTO `punya` (`username`, `hp`) VALUES
('akriptonn', '02147483647'),
('akriptonn', '02178634252'),
('akriptonn', '0217868625'),
('akriptonn', '02178884261'),
('ian_jo', '0218252915'),
('akriptonn', '02195162021'),
('sebastian', '0812111222'),
('ian_jo', '08169289111'),
('akriptonn', '081777888999'),
('athinamaria', '081777888999'),
('athinamaria', '081789789789'),
('akriptonn', '081902571921'),
('athinamaria', '085867981113');

-- --------------------------------------------------------

--
-- Table structure for table `restock`
--

CREATE TABLE `restock` (
  `id_bar` int(11) NOT NULL,
  `id_peg` int(11) NOT NULL,
  `ket_kelola` text NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `restock`
--

INSERT INTO `restock` (`id_bar`, `id_peg`, `ket_kelola`, `time`) VALUES
(36, 23, '-> Restock ID 36: 10 unit\n-> Update harga ID 36: Rp 400000', '2017-12-15 03:41:02');

-- --------------------------------------------------------

--
-- Stand-in structure for view `status`
-- (See below for the actual view)
--
CREATE TABLE `status` (
`invoice` int(11)
,`pembeli` text
,`nama_barang` text
,`jml_pembelian` int(11)
,`total` int(11)
,`ket_status` text
,`resi` int(11)
,`waktu_kirim` timestamp
,`waktu_terima` timestamp
,`kurir` text
,`telp_penerima` varchar(12)
,`alamat` varchar(100)
,`pengirim` text
);

-- --------------------------------------------------------

--
-- Table structure for table `tujuan`
--

CREATE TABLE `tujuan` (
  `hp` varchar(12) CHARACTER SET latin1 NOT NULL,
  `alamat` varchar(100) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tujuan`
--

INSERT INTO `tujuan` (`hp`, `alamat`) VALUES
('02147483647', 'Jl.Sudirman No. 4B, Jakarta Selatan'),
('02178634252', 'Jl. Soekarno Hatta'),
('0217868625', 'Jl. Serua Raya'),
('02178884261', 'Jl. Raya Lenteng Agung'),
('0218252915', 'Jl. Raya Kukusan No.70A'),
('02195162021', 'Jl. Raya Serpong'),
('0812111222', 'Kukel'),
('08169289111', 'Jl. Arif rahman Hakim'),
('08169289111', 'Jl. Raya Tanah Baru'),
('081777888999', 'Jl. Cempaka Hitam No. 2B'),
('081777888999', 'Jl. Cempaka No 5'),
('081789789789', 'Jl. Asoka No.  55A'),
('081902571921', 'Jl. Rasuna Said '),
('085867981113', 'Jl. Melati No. 17');

-- --------------------------------------------------------

--
-- Structure for view `status`
--
DROP TABLE IF EXISTS `status`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `status`  AS  select `a`.`invoice` AS `invoice`,`c`.`nama` AS `pembeli`,`e`.`nama` AS `nama_barang`,`a`.`jml_pembelian` AS `jml_pembelian`,`a`.`total` AS `total`,`a`.`ket_status` AS `ket_status`,`b`.`resi` AS `resi`,`b`.`waktu_kirim` AS `waktu_kirim`,`b`.`waktu_terima` AS `waktu_terima`,`b`.`kurir` AS `kurir`,`b`.`penerima` AS `telp_penerima`,`b`.`alamat` AS `alamat`,`f`.`nama_peg` AS `pengirim` from ((((`pembelian` `a` join `pengiriman` `b` on((`a`.`invoice` = `b`.`invoice`))) join `pembeli` `c` on((`a`.`username` = `c`.`username`))) join `pegawai` `f` on((`b`.`pengirim` = `f`.`id_peg`))) join (`berisi` `d` join `barang` `e` on((`d`.`id_bar` = `e`.`id_bar`))) on((`a`.`invoice` = `d`.`invoice`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD UNIQUE KEY `id` (`id_bar`);

--
-- Indexes for table `berisi`
--
ALTER TABLE `berisi`
  ADD PRIMARY KEY (`invoice`,`id_bar`),
  ADD KEY `invoice` (`invoice`),
  ADD KEY `id_bar` (`id_bar`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD UNIQUE KEY `id_peg` (`id_peg`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `pembeli`
--
ALTER TABLE `pembeli`
  ADD PRIMARY KEY (`username`);
ALTER TABLE `pembeli` ADD FULLTEXT KEY `nama` (`nama`);

--
-- Indexes for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`invoice`),
  ADD UNIQUE KEY `invoice` (`invoice`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `penerima`
--
ALTER TABLE `penerima`
  ADD PRIMARY KEY (`hp`),
  ADD UNIQUE KEY `hp` (`hp`);

--
-- Indexes for table `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD PRIMARY KEY (`resi`),
  ADD UNIQUE KEY `resi` (`resi`),
  ADD KEY `invoice` (`invoice`),
  ADD KEY `penerima` (`penerima`),
  ADD KEY `pengirim` (`pengirim`);

--
-- Indexes for table `punya`
--
ALTER TABLE `punya`
  ADD PRIMARY KEY (`username`,`hp`),
  ADD KEY `username` (`username`),
  ADD KEY `hp` (`hp`);

--
-- Indexes for table `restock`
--
ALTER TABLE `restock`
  ADD PRIMARY KEY (`time`),
  ADD KEY `id_bar` (`id_bar`),
  ADD KEY `id_peg` (`id_peg`);

--
-- Indexes for table `tujuan`
--
ALTER TABLE `tujuan`
  ADD PRIMARY KEY (`hp`,`alamat`),
  ADD KEY `hp` (`hp`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pembelian`
--
ALTER TABLE `pembelian`
  MODIFY `invoice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `pengiriman`
--
ALTER TABLE `pengiriman`
  MODIFY `resi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `berisi`
--
ALTER TABLE `berisi`
  ADD CONSTRAINT `berisi_ibfk_2` FOREIGN KEY (`id_bar`) REFERENCES `barang` (`id_bar`) ON UPDATE CASCADE;

--
-- Constraints for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`username`) REFERENCES `akun` (`username`) ON UPDATE CASCADE;

--
-- Constraints for table `pembeli`
--
ALTER TABLE `pembeli`
  ADD CONSTRAINT `pembeli_ibfk_1` FOREIGN KEY (`username`) REFERENCES `akun` (`username`) ON DELETE CASCADE;

--
-- Constraints for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD CONSTRAINT `pembelian_ibfk_1` FOREIGN KEY (`username`) REFERENCES `pembeli` (`username`) ON UPDATE CASCADE;

--
-- Constraints for table `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD CONSTRAINT `pengiriman_ibfk_3` FOREIGN KEY (`pengirim`) REFERENCES `pegawai` (`id_peg`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pengiriman_ibfk_4` FOREIGN KEY (`penerima`) REFERENCES `penerima` (`hp`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pengiriman_ibfk_5` FOREIGN KEY (`invoice`) REFERENCES `pembelian` (`invoice`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `punya`
--
ALTER TABLE `punya`
  ADD CONSTRAINT `punya_ibfk_1` FOREIGN KEY (`username`) REFERENCES `pembeli` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `punya_ibfk_2` FOREIGN KEY (`hp`) REFERENCES `penerima` (`hp`) ON UPDATE CASCADE;

--
-- Constraints for table `restock`
--
ALTER TABLE `restock`
  ADD CONSTRAINT `restock_ibfk_1` FOREIGN KEY (`id_peg`) REFERENCES `pegawai` (`id_peg`) ON UPDATE CASCADE,
  ADD CONSTRAINT `restock_ibfk_2` FOREIGN KEY (`id_bar`) REFERENCES `barang` (`id_bar`) ON UPDATE CASCADE;

--
-- Constraints for table `tujuan`
--
ALTER TABLE `tujuan`
  ADD CONSTRAINT `tujuan_ibfk_1` FOREIGN KEY (`hp`) REFERENCES `penerima` (`hp`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
