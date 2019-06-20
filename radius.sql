-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost
-- Üretim Zamanı: 20 Haz 2019, 10:18:30
-- Sunucu sürümü: 5.6.44
-- PHP Sürümü: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `radius`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `cui`
--

CREATE TABLE `cui` (
  `clientipaddress` varchar(15) NOT NULL DEFAULT '',
  `callingstationid` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `cui` varchar(32) NOT NULL DEFAULT '',
  `creationdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastaccounting` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `nas`
--

CREATE TABLE `nas` (
  `id` int(10) NOT NULL,
  `nasname` varchar(128) NOT NULL,
  `shortname` varchar(32) DEFAULT NULL,
  `type` varchar(30) DEFAULT 'other',
  `ports` int(5) DEFAULT NULL,
  `secret` varchar(60) NOT NULL DEFAULT 'secret',
  `server` varchar(64) DEFAULT NULL,
  `community` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT 'RADIUS Client'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `radacct`
--

CREATE TABLE `radacct` (
  `radacctid` bigint(21) NOT NULL,
  `acctsessionid` varchar(64) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `acctuniqueid` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `username` varchar(64) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `groupname` varchar(64) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `realm` varchar(64) CHARACTER SET latin1 DEFAULT '',
  `nasipaddress` varchar(15) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `nasportid` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `nasporttype` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `acctstarttime` datetime DEFAULT NULL,
  `acctstoptime` datetime DEFAULT NULL,
  `acctsessiontime` int(12) UNSIGNED DEFAULT NULL,
  `acctauthentic` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `connectinfo_start` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `connectinfo_stop` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `acctinputoctets` bigint(20) DEFAULT NULL,
  `acctoutputoctets` bigint(20) DEFAULT NULL,
  `calledstationid` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `callingstationid` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `acctterminatecause` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `servicetype` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `framedprotocol` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `framedipaddress` varchar(15) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `acctstartdelay` int(12) UNSIGNED DEFAULT NULL,
  `acctstopdelay` int(12) UNSIGNED DEFAULT NULL,
  `xascendsessionsvrkey` varchar(10) CHARACTER SET latin1 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `radcheck`
--

CREATE TABLE `radcheck` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(64) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `attribute` varchar(64) CHARACTER SET latin1 NOT NULL DEFAULT 'Cleartext-Password',
  `op` char(2) CHARACTER SET latin1 NOT NULL DEFAULT ':=',
  `value` varchar(253) CHARACTER SET latin1 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `radgroupcheck`
--

CREATE TABLE `radgroupcheck` (
  `id` int(11) UNSIGNED NOT NULL,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '==',
  `value` varchar(253) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `radgroupreply`
--

CREATE TABLE `radgroupreply` (
  `id` int(11) UNSIGNED NOT NULL,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `radippool`
--

CREATE TABLE `radippool` (
  `id` int(11) UNSIGNED NOT NULL,
  `pool_name` varchar(30) NOT NULL,
  `framedipaddress` varchar(15) NOT NULL DEFAULT '',
  `nasipaddress` varchar(15) NOT NULL DEFAULT '',
  `calledstationid` varchar(30) NOT NULL,
  `callingstationid` varchar(30) NOT NULL,
  `expiry_time` datetime DEFAULT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `pool_key` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `radpostauth`
--

CREATE TABLE `radpostauth` (
  `id` int(11) NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `pass` varchar(64) NOT NULL DEFAULT '',
  `reply` varchar(32) NOT NULL DEFAULT '',
  `authdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `radreply`
--

CREATE TABLE `radreply` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `radusergroup`
--

CREATE TABLE `radusergroup` (
  `username` varchar(64) NOT NULL DEFAULT '',
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `priority` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `reg_users`
--

CREATE TABLE `reg_users` (
  `id` int(11) NOT NULL,
  `familyName` varchar(150) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  `surName` varchar(50) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  `phoneNumber` varchar(15) DEFAULT NULL,
  `emailAddress` varchar(150) DEFAULT NULL,
  `macAddress` varchar(25) DEFAULT NULL,
  `ipAddress` varchar(45) DEFAULT NULL,
  `regDate` datetime DEFAULT NULL,
  `newsletter` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `wimax`
--

CREATE TABLE `wimax` (
  `id` int(11) NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `authdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `spi` varchar(16) NOT NULL DEFAULT '',
  `mipkey` varchar(400) NOT NULL DEFAULT '',
  `lifetime` int(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `cui`
--
ALTER TABLE `cui`
  ADD PRIMARY KEY (`username`,`clientipaddress`,`callingstationid`);

--
-- Tablo için indeksler `nas`
--
ALTER TABLE `nas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nasname` (`nasname`);

--
-- Tablo için indeksler `radacct`
--
ALTER TABLE `radacct`
  ADD PRIMARY KEY (`radacctid`),
  ADD UNIQUE KEY `acctuniqueid` (`acctuniqueid`),
  ADD KEY `username` (`username`),
  ADD KEY `framedipaddress` (`framedipaddress`),
  ADD KEY `acctsessionid` (`acctsessionid`),
  ADD KEY `acctsessiontime` (`acctsessiontime`),
  ADD KEY `acctstarttime` (`acctstarttime`),
  ADD KEY `acctstoptime` (`acctstoptime`),
  ADD KEY `nasipaddress` (`nasipaddress`);

--
-- Tablo için indeksler `radcheck`
--
ALTER TABLE `radcheck`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`(32));

--
-- Tablo için indeksler `radgroupcheck`
--
ALTER TABLE `radgroupcheck`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groupname` (`groupname`(32));

--
-- Tablo için indeksler `radgroupreply`
--
ALTER TABLE `radgroupreply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groupname` (`groupname`(32));

--
-- Tablo için indeksler `radippool`
--
ALTER TABLE `radippool`
  ADD PRIMARY KEY (`id`),
  ADD KEY `radippool_poolname_expire` (`pool_name`,`expiry_time`),
  ADD KEY `framedipaddress` (`framedipaddress`),
  ADD KEY `radippool_nasip_poolkey_ipaddress` (`nasipaddress`,`pool_key`,`framedipaddress`);

--
-- Tablo için indeksler `radpostauth`
--
ALTER TABLE `radpostauth`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `radreply`
--
ALTER TABLE `radreply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`(32));

--
-- Tablo için indeksler `radusergroup`
--
ALTER TABLE `radusergroup`
  ADD KEY `username` (`username`(32));

--
-- Tablo için indeksler `reg_users`
--
ALTER TABLE `reg_users`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `wimax`
--
ALTER TABLE `wimax`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`),
  ADD KEY `spi` (`spi`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `nas`
--
ALTER TABLE `nas`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `radacct`
--
ALTER TABLE `radacct`
  MODIFY `radacctid` bigint(21) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `radcheck`
--
ALTER TABLE `radcheck`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `radgroupcheck`
--
ALTER TABLE `radgroupcheck`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `radgroupreply`
--
ALTER TABLE `radgroupreply`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `radippool`
--
ALTER TABLE `radippool`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `radpostauth`
--
ALTER TABLE `radpostauth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `radreply`
--
ALTER TABLE `radreply`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `reg_users`
--
ALTER TABLE `reg_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `wimax`
--
ALTER TABLE `wimax`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
