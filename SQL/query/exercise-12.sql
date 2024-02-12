-- Query-12 *** List each author’s publisher wise average rating order by rating(higher to lower). ***

select 
	b.book_author as author,
	b.publisher as publisher,
	avg(r.book_rating) as avg_rating,
	row_number() over(partition by b.book_author
order by
	avg(r.book_rating) desc) as rank
from
	books_details as b
inner join rating_info as r on
	b.isbn = r.isbn

group by
	b.book_author,
	b.publisher
order by
b.book_author;