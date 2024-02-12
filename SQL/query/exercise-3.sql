-- Query-3 *** List out top 10 books by average rating. ***
select
       *
from
       (
              select
                     isbn,
                     avg(book_rating) as book_rating,
                     rank() over(
                            order by
                                   avg(book_rating) desc
                     ) as rank
              from
                     rating_info
              group by
                     (isbn)
              having
                     avg(book_rating) between 0
                     and 10
       )
where
       rank <= 10;