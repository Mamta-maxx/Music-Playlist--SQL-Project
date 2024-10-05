create database music_database;
use music_database;

-- SQL PROJECT- MUSIC STORE DATA ANALYSIS

-- 1. Who is the senior most employee based on job title?
select * from employee;
select * from employee order by levels desc limit 1;


-- 2. Which countries have the most Invoices?
select * from invoice;
select billing_country, count(billing_country) as tot from invoice
group by billing_country order by tot desc;


-- 3. What are top 3 values of total invoice?
select * from invoice;
select * from invoice order by total desc limit 3;


-- 4. Which city has the best customers? We would like to throw a promotional Music
-- Festival in the city we made the most money. Write a query that returns one city that
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice
-- totals
select billing_city, sum(total) as tot from invoice group by billing_city order by tot desc ;


-- 5. Who is the best customer? The customer who has spent the most money will be
-- declared the best customer. Write a query that returns the person who has spent the
-- most money
select * from customer;
select * from invoice;

select customer.customer_id,customer.first_name,customer.last_name, sum(total) as tot
from customer join invoice
on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by tot desc;
-- ==============================================================================================================================================================================

-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music
-- listeners. Return your list ordered alphabetically by email starting with A
select * from genre;
select * from track;

select distinct customer.email, customer.first_name, customer.last_name, genre.name
from customer join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
where genre.name IN ("rock")
order by email asc;



-- 2. Let's invite the artists who have written the most rock music in our dataset. Write a
-- query that returns the Artist name and total track count of the top 10 rock bands
select * from genre;
select * from track;
select * from album2;
select * from artist;

select artist.name, count(track.track_id) as num_of_songs
from artist join album2 on artist.artist_id = album2.artist_id
join track on album2.album_id = track.album_id
join genre on track.genre_id = genre.genre_id
where genre.name = "rock"
group by artist.name
order by num_of_songs desc;


-- 3. Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the
-- longest songs listed first
select avg(milliseconds) from track;


select track.name, track.milliseconds from track 
where
     (select avg(milliseconds) from track) < track.milliseconds
     order by track.milliseconds desc;

-- =============================================================================================================================================================================

-- 1. Find how much amount spent by each customer on artists? Write a query to return
-- customer name, artist name and total spent
select * from customer;
select * from invoice;
select * from invoice_line;
select * from artist;

select concat(first_name, " ",last_name) as customer_name, invoice.total as total_amount, artist.name as artist_name
from customer join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join album2 on track.album_id = album2.album_id
join artist on album2.artist_id = artist.artist_id
order by total_amount desc;




-- 2. We want to find out the most popular music Genre for each country. We determine the
-- most popular genre as the genre with the highest amount of purchases. Write a query
-- that returns each country along with the top Genre. For countries where the maximum
-- number of purchases is shared return all Genres
select * from genre;
select * from customer;
select * from invoice;

select genre.name as genre_name, invoice.billing_country, sum(invoice.total)
from invoice join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id;


-- 3. Write a query that determines the customer that has spent the most on music for each
-- country. Write a query that returns the country along with the top customer and how
-- much they spent. For countries where the top amount spent is shared, provide all
-- customers who spent this amount.








