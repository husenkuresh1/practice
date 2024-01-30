-- Query-11 *** List top 5 user per publisher who has read more books of the same publisher. (given more number of ratings to the same publisher) ***

select
	*
from
	(
	select
		b.publisher as publisher,
		r.user_id as user_id,
		count(book_rating) as read_count,
		dense_rank () over (partition by b.publisher
	order by
		count(book_rating) desc) as rank
	from
		books_details as b
	inner join rating_info as r on
		b.isbn = r.isbn
	group by
		b.publisher,
		r.user_id
) as sub
where
	rank <= 5;
