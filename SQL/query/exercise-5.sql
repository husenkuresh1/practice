-- Query-5 *** List out rating wise books count. (take ceiling of rating) (e.g. 10 - 10012 , 9 - 34344, 8 - 123121). ***


with avg_book_rating as (

	select
	isbn,
	ceil(avg(book_rating)) as avg
from
	rating_info
group by
	isbn
order by
	avg(book_rating) desc 
)
select
	avg_book_rating.avg as avg_rating,
	count(isbn) as count
from
	avg_book_rating
where avg_book_rating.avg is not null 
group by
	avg_book_rating.avg
order by
	avg_rating desc;