-- Query-8 *** List publisher wise most rated book. Show rating as well. ***
select
    sub.publisher,
    sub.isbn,
    sub.avg_rating as book_rating
from
    (
        select
            b.publisher as publisher,
            b.isbn as isbn,
            avg(r.book_rating) as avg_rating,
            rank() over (
                partition by b.publisher
                order by
                    avg(r.book_rating) desc
            ) as rank
        from
            books_details as b
            inner join rating_info as r on b.isbn = r.isbn
        group by
            b.publisher,
            b.isbn
    ) as sub
where
    rank = 1;