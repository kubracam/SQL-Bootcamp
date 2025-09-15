DROP TABLE IF EXISTS books;

CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(50),
    price DECIMAL(10, 2) CHECK (price >= 0),
    stock INTEGER CHECK (stock>= 0),
    published_year INTEGER CHECK (published_year BETWEEN 1800 AND 2025),
    added_at DATE
);


INSERT INTO books (book_id, title, author, genre, price, stock, published_year, added_at) VALUES
(1, 'Kayıp Zamanın İzinde', 'M. Proust', 'roman', 129.90, 25, 1913, '2025-08-20'),
(2, 'Simyacı', 'P. Coelho', 'roman', 89.50, 40, 1988, '2025-08-21'),
(3, 'Sapiens', 'Y. N. Harari', 'tarih', 159.00, 18, 2011, '2025-08-25'),
(4, 'İnce Memed', 'Y. Kemal', 'roman', 99.90, 12, 1955, '2025-08-22'),
(5, 'Körlük', 'J. Saramago', 'roman', 119.00, 7, 1995, '2025-08-28'),
(6, 'Dune', 'F. Herbert', 'bilim', 149.00, 30, 1965, '2025-09-01'),
(7, 'Hayvan Çiftliği', 'G. Orwell', 'roman', 79.90, 55, 1945, '2025-08-23'),
(8, '1984', 'G. Orwell', 'roman', 99.00, 35, 1949, '2025-08-24'),
(9, 'Nutuk', 'M. K. Atatürk', 'tarih', 139.00, 20, 1927, '2025-08-27'),
(10, 'Küçük Prens', 'A. de Saint-Exupéry', 'çocuk', 69.90, 80, 1943, '2025-08-26'),
(11, 'Başlangıç', 'D. Brown', 'roman', 109.00, 22, 2017, '2025-09-02'),
(12, 'Atomik Alışkanlıklar', 'J. Clear', 'kişisel gelişim', 129.00, 28, 2018, '2025-09-03'),
(13, 'Zamanın Kısa Tarihi', 'S. Hawking', 'bilim', 119.50, 16, 1988, '2025-08-29'),
(14, 'Şeker Portakalı', 'J. M. de Vasconcelos', 'roman', 84.90, 45, 1968, '2025-08-30'),
(15, 'Bir İdam Mahkûmunun Son Günü', 'V. Hugo', 'roman', 74.90, 26, 1829, '2025-08-31');




-- 1. Tüm kitapların title, author, price alanlarını fiyatı artan şekilde sıralayarak listeleyin.
select title , author, price from books
order by price 


-- 2. Türü 'roman' olan kitapları A→Z title sırasıyla gösterin.
select * from books
where genre= 'roman' order by title asc;


--3. Fiyatı 80 ile 120 (dahil) arasındaki kitapları listeleyin (BETWEEN).
select * from books
where price between 80 and 120


--4. Stok adedi 20’den az olan kitapları bulun (title, stock_qty).
select title, stock from books
where stock < 20


--5. title içinde 'zaman' geçen kitapları LIKE ile filtreleyin (büyük/küçük harf durumunu not edin).
select title from books
where title like '%zaman%'


--6. genre değeri 'roman' veya 'bilim' olanları IN ile listeleyin
select title, genre from books
where genre in ('roman', 'bilim') 


--7. published_year değeri 2000 ve sonrası olan kitapları, en yeni yıldan eskiye doğru sıralayın.
select * from books
where published_year >= 2000 order by published_year desc


-- 8.Son 10 gün içinde eklenen kitapları bulun (added_at tarihine göre).
select top 10 * from books
order by added_at desc


-- 9.En pahalı 5 kitabı price azalan sırada listeleyin.
select top 5 * from books 
order by price desc 


--10.Stok adedi 30 ile 60 arasında olan kitapları price artan şekilde sıralayın.
select * from books
where stock between 30 and 60 
order by price asc 








