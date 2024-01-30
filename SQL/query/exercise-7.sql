-- Query-7 *** List publishers with the author who has published highest number of books with that publisher. also show number of books. ***
select
    publisher as publisher,
    book_author as author,
    count(isbn) as book_count
from
    books_details
group by
    publisher,
    book_author
order by
    count(isbn) desc;