-- Make sure to attach design image/pdf in the same folder.
-- Write your DDL queries here.


-- Query-1 *** List out top 10 authors who have written most books. ***

select * from (
        select book_author as author, count(book_author) as count, dense_rank() over(order by count(book_author) desc) as rank from book_details group by book_author) 
where rank <= 10;


-- Query-2 *** List out top 10 publishers who published most books. ***

select * from (
        select publlisher as publisher, count(publlisher) as count, dense_rank() over(order by count(publlisher) desc) as rank from book_details group by publlisher) 
where rank <= 10;


-- Query-3 *** List out top 10 books by average rating. ***

-- Query-4 *** List out top 10 books by count of ratings. ***

-- Query-5 *** List out rating wise books count. (take ceiling of rating) (e.g. 10 - 10012 , 9 - 34344, 8 - 123121). ***

-- Query-6 *** Which years had most books published. (also show count)(top 10 only) ***

-- Query-7 *** List publishers with the author who has published highest number of books with that publisher. also show number of books. ***

-- Query-8 *** List publisher wise most rated book. Show rating as well. ***

-- Query-9 *** List top 10 users who has read most books(have given ratings to more books). ***

-- Query-10 *** List top 10 author by average rating (with rating). (author with his average ratings from all books)***

-- Query-11 *** List top 5 user per publisher who has read more books of the same publisher. (given more number of ratings to the same publisher) ***

-- Query-12 *** List each author’s publisher wise average rating order by rating(higher to lower). ***


