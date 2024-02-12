-- Query-1 *** List out top 10 authors who have written most books. ***
select
    *
from
    (
        select
            book_author as author,
            count(book_author) as count,
            dense_rank() over (
                order by
                    count(book_author) desc
            ) as rank
        from
            books_details
        group by
            book_author
    )
where
    rank <= 10;