-- Query-9 *** List top 10 users who has read most books(have given ratings to more books). ***

select
	*
from
	(
	select
		user_id as user_id,
		count(isbn) as books_count,
		dense_rank() over(
		order by (count(isbn)) desc) as rank
	from
		rating_info
	group by
		user_id) as sub
where
	sub.rank <= 10;