CREATE DATABASE Alisveris_Platformu;
GO

USE Alisveris_Platformu;
GO

CREATE TABLE dbo.Musteri( 
       id INT IDENTITY (1,1) PRIMARY KEY,
	   ad NVARCHAR(50) NOT NULL ,
	   soyad NVARCHAR(50) NOT NULL ,
	   email NVARCHAR(120) NOT NULL UNIQUE,
	   sehir NVARCHAR(50) NULL,
	   kayit_tarihi DATE 
);


CREATE TABLE dbo.Kategori(
       id INT IDENTITY (1,1) PRIMARY KEY,
	   ad NVARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE dbo.Satici(
       id INT IDENTITY(1,1) PRIMARY KEY,
	   ad NVARCHAR(120) NOT NULL,
	   adres NVARCHAR(200) NULL 
);

CREATE TABLE dbo.Urun (
       id INT IDENTITY (1,1) PRIMARY KEY,
	   ad NVARCHAR(120) NOT NULL ,
	   fiyat DECIMAL(10,2) NOT NULL CHECK (fiyat>=0), 
	   stok INT NOT NULL CHECK (stok>=0),
	   kategori_id INT NOT NULL,
	   satici_id INT NOT NULL,

	   CONSTRAINT FK_Urun_Kategori FOREIGN KEY (kategori_id) REFERENCES dbo.Kategori(id),
	   CONSTRAINT FK_Urun_Satici FOREIGN KEY (satici_id) REFERENCES dbo.Satici(id)
);


CREATE TABLE dbo.Siparis(
       id INT IDENTITY(1,1) PRIMARY KEY,
	   musteri_id INT NOT NULL,
	   tarih DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
	   toplam_tutar DECIMAL(12,2) NOT NULL CHECK (toplam_tutar>=0),
	   odeme_turu NVARCHAR(20) NOT NULL CHECK(odeme_turu IN (N'KrediKarti', N'Nakit',N'Havale', N'Kapida')),

	   CONSTRAINT FK_Siparis_Musteri FOREIGN KEY (musteri_id) REFERENCES dbo.Musteri(id),
);


CREATE TABLE dbo.Siparis_Detay (
       id INT IDENTITY(1,1) PRIMARY KEY,
	   siparis_id INT NOT NULL,
	   urun_id INT NOT NULL,
	   adet INT NOT NULL CHECK(adet>=0),
	   fiyat DECIMAL(10,2) NOT NULL CHECK (fiyat>=0),

	   CONSTRAINT FK_SDetay_Siparis FOREIGN KEY (siparis_id) REFERENCES dbo.Siparis(id),
	   CONSTRAINT FK_SDetay_Urun FOREIGN KEY (urun_id) REFERENCES dbo.Urun(id)

);




INSERT INTO dbo.Kategori (ad) VALUES 
       (N'Elektronik'),
	   (N'Giyim'),
	   (N'Kozmetik'),
	   (N'Kitap'),
	   (N'Yiyecek ve Ýçecek'),
	   (N'Saat'); 

INSERT INTO dbo.Musteri (ad, soyad, email, sehir, kayit_tarihi) VALUES 
       (N'Sevgi', N'Asil', N'sevgi.asil@gmail.com', N'Ýstanbul', '2025-01-10'),
	   (N'Hakan', N'Yýlmaz', N'hakan.yilmaz@gmail.com', N'Ýzmir', '2025-02-15'),
	   (N'Ayþe', N'Yýldýz', N'ayse.yildiz@gmail.com', N'Kocaeli', '2025-04-01'),
	   (N'Bahar', N'Ateþ', N'bahar.ates@gmail.com', N'Ankara', '2025-03-09'),
	   (N'Coþkun', N'Atmaca', N'coskun.atmaca@gmail.com', N'Ýstanbul', '2025-02-18'),
	   (N'Haluk', N'Boz', N'haluk.boz@gmail.com', N'Ankara', '2025-03-25'),
	   (N'Mahmut', N'Çelik', N'mahmut.celik@gmail.com', N'Ýzmir', '2025-01-17'),
	   (N'Melike', N'Çýnar', N'melike.cinar@gmail.com', N'Kocaeli', '2025-05-11'),
	   (N'Gamze', N'Deveci', N'gamze.deveci@gmail.com', N'Ýstanbul', '2025-03-10'),
	   (N'Ahmet', N'Parlak', N'ahmet.parlak@gmail.com', N'Kocaeli', '2025-04-12'),
	   (N'Beyza', N'Þanlý', N'beyza.sanlii@gmail.com', N'Ýstanbul', '2025-03-14');



INSERT INTO dbo.Satici (ad, adres) VALUES 
      (N'GlobalTech Ticaret', N'Fatih-Ýstanbul'),
      (N'Beyaz Moda Evi', N'Mamak-Ankara'),
	  (N'Renkli Bakým', N'Konak-Ýzmir'),
	  (N'Kitap Kurdu', N'Gebze-Kocaeli'),
	  (N'Aslan Süpermarket', N'Sarýyer-Ýstanbul');


INSERT INTO dbo.Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
      (N'Akýllý Telefon', 25000.00, 50, 1, 1),
	  (N'Kablosuz Kulaklýk', 2500.00, 120, 1, 1),
	  (N'Akýllý Saat', 7500.00, 100, 1, 1),
	  (N'Tablet', 40000.00, 160, 1, 1),
	  (N'Adaptör', 550.00, 200, 1, 1),
	  (N'Elbise', 850.50, 200, 2, 2),
	  (N'Erkek T-Shirt', 350.00, 300, 2, 2),
	  (N'Erkek Ceket', 2000.00, 130, 2, 2),
	  (N'Kadýn Pantolon', 1000.00, 150, 2, 2),
	  (N'Erkek Pantolon', 1200.00, 140, 2, 2),
	  (N'Ruj', 250.00, 200, 3, 3),
	  (N'Göz Kalemi', 120.00, 300, 3, 3),
	  (N'Oje', 100.00, 240, 3, 3),
	  (N'Þampuan', 170.00, 250, 3, 3),
	  (N'Kadýn Deodorant', 145.00, 150, 3, 3),
	  (N'Erkek Deodorant', 160.00, 170, 3, 3),
	  (N'Güneþ Kremi', 350.00, 100, 3, 3),
	  (N'Þeker Portakalý', 200.00, 80, 4, 4),
	  (N'Kürk Mantolu Madonna', 30.00, 150, 4, 4),
	  (N'Simyacý', 175.00, 90, 4, 4),
	  (N'Sol Ayaðým', 180.00, 110, 4, 4),
	  (N'Küçük Prens', 75.00, 145, 4, 4),
	  (N'Cips', 50.00, 200, 5, 5),
	  (N'Çekirdek', 80.00, 250, 5, 5),
	  (N'Kuruyemiþ', 200.00, 140, 5, 5),
	  (N'Süt', 30.00, 150, 5, 5),
	  (N'Gazoz', 90.00, 220, 5, 5),
	  (N'Meyve Suyu', 70.00, 200, 5, 5),
	  (N'Sývý Yað', 450.00, 130, 5, 5),
	  (N'Hazýr Çorba', 50.00, 300, 5, 5),
	  (N'Pirinç', 400.00, 180, 5, 5);


INSERT INTO dbo.Siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES
      (1, '2025-05-01 10:30:00', 22500.00, N'KrediKarti'),  
	  (2, '2025-05-10 14:00:00', 200.00, N'Kapida'),     
	  (5, '2025-05-10 14:23:45', 330.00, N'KrediKarti'),     
	  (1, '2025-05-10 16:30:00', 850.50, N'Kapida'),    
	  (10,'2025-05-19 14:23:50', 7820.00, N'KrediKarti'),  
	  (3, '2025-05-28 13:23:53', 1850.00, N'Havale'),   
	  (2, '2025-05-29 14:34:20', 550.00, N'Kapida'),    
	  (7, '2025-05-31 12:49:49', 1360.00, N'Kapida'),   
	  (1, '2025-06-03 13:32:12', 370.00, N'Havale'),          
	  (5, '2025-06-04 12:42:20', 10000.00, N'KrediKarti'),   
	  (3, '2025-06-06 15:03:42', 355.00, N'Havale'),     
	  (3, '2025-06-11 15:21:19', 250.00, N'Kapida'),  
	  (9, '2025-06-12 19:09:41', 1195.00, N'KrediKarti'),   
	  (6, '2025-06-13 18:21:42', 27500.00, N'KrediKarti'),   
	  (1, '2025-07-05 20:13:04', 900.00, N'KrediKarti'),   
	  (4, '2025-07-10 16:45:04', 2575.00, N'KrediKarti'),  
	  (5, '2025-07-11 19:10:32', 175.00, N'Havale'),         
	  (8, '2025-07-13 12:09:38', 40550.00, N'KrediKarti'),   
	  (8, '2025-07-17 13:46:28', 790.00, N'Kapida'),    
	  (7, '2025-07-17 16:48:30', 25550.00, N'KrediKarti'),   
	  (10,'2025-07-21 18:12:17', 1550.00, N'KrediKarti' ),    
	  (5, '2025-07-28 17:11:38', 530.00, N'Havale'),  
	  (4, '2025-08-06 13:50:21', 665.00, N'KrediKarti'),  
	  (4, '2025-08-06 19:23:18', 1170.00, N'Havale'),   
	  (8, '2025-09-03 19:54:39', 580.00, N'Kapida'),   
	  (10,'2025-09-14 14:07:33', 675.00, N'Havale'),     
	  (7, '2025-09-14 17:10:22', 175.00, N'Kapida'), 
	  (3, '2025-09-14 17:18:10', 350.00, N'Havale'),  
	  (7, '2025-09-18 20:05:44', 270.00, N'Havale'),   
	  (8, '2025-09-20 15:54:57', 40850.00, N'KrediKarti'),    
	  (1, '2025-09-24 19:09:54', 200.00, N'Havale'),    
	  (3, '2025-09-25 16:29:47', 42500.00, N'KrediKarti'),    
	  (8, '2025-09-30 20:42:18', 25000.00, N'KrediKarti'),   
	  (8, '2025-10-02 12:39:13', 7500.00, N'KrediKarti');  
	  
	  
	  

INSERT INTO dbo.Siparis_Detay(siparis_id, urun_id, adet, fiyat) VALUES
       (1, 1, 1, 25000.00),
	   (1, 3, 1, 7500.00),
	   (2, 18, 1, 200.00),
	   (3, 14, 1, 170.00),
	   (3, 16, 1, 160.00),
	   (4, 6, 1, 850.00),
	   (5, 3, 1, 7500),
	   (5, 16, 2, 160),
	   (6, 6, 1, 850.00),
	   (6, 9, 1, 1000.00),
	   (7, 30, 3, 50.00),
	   (7, 31, 2, 400.00),
	   (8, 10, 1, 1200.00),
	   (8, 16, 1, 160.00),
	   (9, 11, 1, 250.00),
	   (9, 14, 1, 170.00),
	   (10, 2, 1, 2500.00),
	   (10, 3, 1, 7500.00),
	   (11, 20, 1, 175.00),
	   (11, 21, 1, 180.00),
	   (12, 23, 1, 50.00),
	   (12, 25, 1, 200.00),
	   (13, 6, 1, 850.00),
	   (13, 13, 2, 100.00),
	   (13, 15, 2, 145.00),
	   (14, 1, 1, 25000.00),
	   (14, 2, 1, 2500.00),
	   (15, 29, 1, 450.00),
	   (15, 30, 1, 50.00),
	   (15, 31, 1, 400.00),
	   (16, 2, 1, 2500.00),
	   (16, 22, 1, 75.00),
	   (17, 20, 1, 175.00),
	   (18, 4, 1, 40000.00),
	   (18, 5, 1, 550.00),
	   (19, 12, 1, 120.00),
	   (19, 13, 3, 100.00),
	   (19, 14, 1, 170.00),
	   (19, 18, 1, 200.00),
	   (20, 1, 1, 25000.00),
	   (20, 5, 1, 550.00),
	   (21, 7, 1, 350.00),
	   (21, 10, 1, 1200.00),
	   (22, 17, 1, 350.00),
	   (22, 21, 1, 180.00),
	   (23, 14, 1, 170.00),
	   (23, 15, 1, 145.00),
	   (23, 17, 1, 350.00),
	   (24, 6, 1, 850.00),
	   (24, 15, 2, 145.00),
	   (24, 19, 1, 30.00),
	   (25, 23, 2, 50.00),
	   (25, 26, 1, 30.00),
	   (25, 30, 1, 50.00),
	   (25, 31, 1, 400.00),
	   (26, 7, 1, 350.00),
	   (26, 16, 1, 160.00),
	   (26, 21, 1, 180.00),
	   (27, 20, 1, 175.00),
	   (28, 24, 1, 80.00),
	   (28, 25, 1, 200.00),
	   (28, 28, 1, 70.00),
	   (29, 23, 2, 50.00),
	   (29, 24, 1, 80.00),
	   (29, 27, 1, 90.00),
	   (30, 4, 1, 40000.00),
	   (30, 11, 2, 250.00),
	   (30, 17, 1, 350.00),
	   (31, 18, 1, 200.00),
	   (32, 2, 1, 2500.00),
	   (32, 4, 1, 40000.00),
	   (33, 1, 1, 25000.00),
	   (34, 3, 1, 7500.00),
	   (34, 7, 1, 350.00);







-- DELETE KULLANIMI

-- Hatalý olan satýrý silme.

DELETE FROM dbo.Siparis_Detay  
WHERE id = 74;

--Satýcýsý olmayan kategoriyi silme

DELETE FROM dbo.Kategori
WHERE id = 6;




-- TRUNCATE KULLANIMI

-- Tablodaki verileri siler ama tabloyu silmez.

TRUNCATE TABLE dbo.Siparis_Detay
TRUNCATE TABLE dbo.Siparis;
TRUNCATE TABLE dbo.Urun;



-- UPDATE KULLANIMI

-- UPDATE ile stok güncelleme.

UPDATE U
SET stok = U.stok - SD.SatilanAdet FROM dbo.Urun U
JOIN (
    SELECT urun_id, SUM(adet) SatilanAdet FROM dbo.Siparis_Detay
    GROUP BY urun_id
) SD ON U.id = SD.urun_id;



--TEMEL SORGULAR

-- En çok sipariþ veren 5 müþteri.

SELECT TOP 5 M.id, M.ad, M.soyad, COUNT(S.id) Siparis_Sayisi FROM dbo.Musteri M
JOIN dbo.Siparis S ON M.id = S.musteri_id
GROUP BY M.id, M.ad, M.soyad
ORDER BY Siparis_Sayisi DESC;

-- En çok satýlan ürünler.

SELECT U.id, U.ad, COUNT(SD.adet) Satilan_Urun_Sayisi FROM dbo.Urun U
JOIN dbo.Siparis_Detay SD ON U.id = SD.urun_id
GROUP BY U.id, U.ad
ORDER BY Satilan_Urun_Sayisi DESC;

--En yüksek cirosu olan satýcýlar. 

SELECT St.id, St.ad, SUM(SD.fiyat*SD.adet) Satici_Cirosu FROM dbo.Satici St
JOIN dbo.Urun U ON St.id = U.satici_id
JOIN dbo.Siparis_Detay SD ON U.id = SD.urun_id
GROUP BY St.id, St.ad
ORDER BY Satici_Cirosu DESC;


-- AGGREGATE & GROUP BY 
 
-- Þehirlere göre müþteri sayýsý. 

 SELECT M.sehir, COUNT(M.id) Musteri_Sayisi  FROM dbo.Musteri M
 GROUP BY M.sehir 
 ORDER BY Musteri_Sayisi DESC;

-- Kategori bazlý toplam satýþlar. 

SELECT K.id, K.ad, SUM(SD.fiyat) Toplam_Satislar FROM dbo.Kategori K
JOIN dbo.Urun U ON K.id = U.kategori_id
JOIN dbo.Siparis_Detay SD ON U.id = SD.urun_id 
GROUP BY K.id, K.ad
ORDER BY Toplam_Satislar DESC;

-- Aylara göre sipariþ sayýsý. 

SELECT MONTH(tarih) Ay, COUNT(id) Siparis_Sayisi FROM dbo.Siparis
GROUP BY MONTH(tarih)
ORDER BY Siparis_Sayisi DESC;


--JOIN

-- Sipariþlerde müþteri bilgisi + ürün bilgisi + satýcý bilgisi. 

SELECT S.id AS Musteri_ID, S.tarih AS Tarih, M.ad+ ' '+M.soyad AS Musteri_Adi, U.ad AS Urun_Adi, SD.adet AS SatilanAdet, SD.fiyat AS BirimFiyat, (SD.adet*SD.fiyat) AS UrunToplamFiyati, SAT.ad AS SaticiAdi 
FROM dbo.Siparis S
JOIN dbo.Musteri M ON S.musteri_id = M.id
JOIN dbo.Siparis_Detay SD ON S.id = SD.siparis_id
JOIN dbo.Urun U ON U.id = SD.urun_id
JOIN dbo.Satici Sat ON Sat.id = U.satici_id
ORDER BY S.id ASC, UrunToplamFiyati DESC;


-- Hiç satýlmamýþ ürünler.

SELECT U.id UrunID, U.ad Urun_Adi, U.fiyat Urun_Fiyati FROM dbo.Urun U
LEFT JOIN dbo.Siparis_Detay SD ON U.id = SD.urun_id
WHERE SD.urun_id IS NULL;


-- Hiç sipariþ vermemiþ müþteriler. 

SELECT M.id MusteriID,M.ad+ ' '+M.soyad Musteri_Adi, M.sehir Sehir FROM dbo.Musteri M
LEFT JOIN dbo.Siparis S ON M.id = S.musteri_id
WHERE S.musteri_id IS NULL;


--ÝLERÝ SEVÝYE GÖREVLER

--En çok kazanç saðlayan ilk 3 kategori. 

SELECT TOP 3 K.id KategoriID, K.ad Kategori_Adi, SUM(SD.fiyat * SD.adet) Toplam_Kazanc FROM dbo.Kategori K
JOIN dbo. Urun U ON K.id = U.kategori_id
JOIN dbo.Siparis_Detay SD ON U.id = SD.urun_id
GROUP BY K.id , K.ad
ORDER BY Toplam_Kazanc DESC;

--Ortalama sipariþ tutarýný geçen sipariþleri bul. 

SELECT S.id SiparisID, S.toplam_tutar Toplam_Tutar FROM dbo.Siparis S
WHERE S.toplam_tutar > (SELECT AVG(S.toplam_tutar) FROM dbo.Siparis S) 
ORDER BY S.toplam_tutar DESC;

-- En az bir kez elektronik ürün satýn alan müþteriler.

SELECT M.id MusteriID, M.ad+' '+M.soyad Musteri_Adi FROM dbo.Musteri M
JOIN dbo.Siparis S ON M.id = S.musteri_id
JOIN dbo.Siparis_Detay SD ON  S.id = SD.siparis_id
JOIN dbo.Urun U ON SD.urun_id = U.id
JOIN dbo.Kategori K ON K.id = U.kategori_id
WHERE K.id =1 AND SD.adet>=1
GROUP BY M.id, M.ad+' '+M.soyad


--Proje rapor linki: https://github.com/kubracam/SQL-Bootcamp/blob/main/Bitirme%20Projesi%20Raporu.pdf
