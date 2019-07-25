SELECT *
FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;


SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id

SELECT a.title, ar.name
FROM album a
JOIN artist ar ON a.artist_id = ar.artist_id



SELECT tr.name
FROM track tr
JOIN playlist_track pt ON pt.track_id = tr.track_id
WHERE pt.playlist_id = 5

SELECT tr.name, pl.name
FROM track tr
JOIN playlist_track pt ON pt.track_id = tr.track_id
JOIN playlist pl ON pt.playlist_id = pl.playlist_id

SELECT tr.name, al.title
FROM track tr
JOIN genre gr ON tr.genre_id = gr.genre_id
JOIN album al ON tr.album_id = al.album_id
WHERE gr.name = 'Alternative & Punk'

SELECT tr.name, gr.name, al.name, ar.name
FROM track tr
JOIN playlist_track pt ON tr.track_id = pt.track_id
JOIN playlist pl ON pt.playlist_id = pl.playlist_id
JOIN genre gr ON tr.genre_id = gr.genre_id
JOIN album al ON tr.album_id = al.album_id
JOIN artist ar ON al.artist_id = ar.artist_id
WHERE pl.name = 'Music'

SELECT *
FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99);

SELECT *
FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');

SELECT name
FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5);

SELECT *
FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy');

SELECT *
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball');

SELECT *
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE artist_id IN (SELECT artist_id FROM artist WHERE name = 'Queen')
);

UPDATE customer
SET fax = null
WHERE fax IS NOT NULL

UPDATE customer
SET company = 'Self'
WHERE company IS null;


UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null;

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;


SELECT COUNT(*), ar.name
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;


SELECT DISTINCT composer
FROM track;

SELECT DISTINCT billing_postal_code
FROM invoice

SELECT DISTINCT company
FROM customer

DELETE FROM practice_delete
WHERE type = 'bronze'

DELETE FROM practice_delete
WHERE type = 'silver'

DELETE FROM practice_delete

DELETE FROM practice_delete
WHERE value = 150




CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(100), email VARCHAR(100))

CREATE TABLE product (id SERIAL PRIMARY KEY, name TEXT NOT NULL, price FLOAT NOT NULL);

CREATE TABLE orders (
  id INT,
  user_id INT REFERENCES users(id),
  product_id INT REFERENCES product(id)
)

INSERT INTO users (name, email)
VALUES ('Brandon', 'brandon@gmail.com'), ('John', 'john@gmail.com'), ('June', 'june@gmail.com');

INSERT INTO product (name, price)
VALUES ('drug', 420), ('pizza', 80), ('cocaine', 1)

INSERT INTO orders (id, user_id, product_id)
VALUES (1,1,1), (1,1,3), (2, 3, 3), (2, 3, 1), (3, 2, 2), (3, 2, 2), (3, 2, 2), (4, 1, 3);

SELECT * FROM orders o
JOIN product p ON p.id = o.product_id
WHERE o.id = 1;

SELECT * FROM orders

SELECT o.id AS order_id, SUM(p.price) FROM product p
JOIN orders o ON o.product_id = p.id
WHERE o.id = 1
GROUP BY o.id

SELECT * FROM orders o
JOIN users u ON u.id = o.user_id
WHERE o.user_id = 1

SELECT o.user_id, COUNT(*) FROM orders o
JOIN users u ON u.id = o.user_id
GROUP BY o.user_id
ORDER BY o.user_id ASC;

SELECT u.name, SUM(p.price) FROM users u
JOIN orders o ON o.user_id = u.id
JOIN product p ON p.id = o.product_id
GROUP BY u.name
