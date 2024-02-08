-- Query-7 *** List publishers with the author who has published highest number of books with that publisher. also show number of books. ***
with author_book_with_publisher as 
(
select
    publisher as publisher,
    book_author as author,
    count(isbn) as book_count,
    dense_rank() over (partition by publisher order by count(isbn) desc) as rank
from
    books_details
group by
    publisher,
    book_author
)
    
select publisher, author, book_count from author_book_with_publisher where rank = 1;