-- Query-4 *** List out top 10 books by count of ratings. ***
select
	*
from
	(
	select
		isbn,
		count(book_rating),
		rank() over(
	order by
		count(book_rating) desc
                     ) as rank
	from
		rating_info
	group by
		isbn
       )
where
	rank <= 10;