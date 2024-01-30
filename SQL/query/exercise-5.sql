-- Query-5 *** List out rating wise books count. (take ceiling of rating) (e.g. 10 - 10012 , 9 - 34344, 8 - 123121). ***
select
    avg(ceil(book_rating)) as avg_rating,
    count(ceil(book_rating)) as count
from
    rating_info
where
    book_rating between 0
    and 10
group by
    book_rating
order by
    ceil(book_rating) desc;