-- Query-4 *** List out top 10 books by count of ratings. ***
select
    isbn,
    count(isbn)
from
    rating_info
group by
    isbn
order by
    count(isbn) desc
limit
    10;