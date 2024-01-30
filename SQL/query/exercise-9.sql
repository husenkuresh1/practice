-- Query-9 *** List top 10 users who has read most books(have given ratings to more books). ***
select
    user_id as user_id,
    count(isbn) as isbn,
    avg(book_rating) as book_rating
from
    rating_info
group by
    user_id
order by
    count(*) desc
limit
    10;