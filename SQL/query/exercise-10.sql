-- Query-10 *** List top 10 author by average rating (with rating). (author with his average ratings from all books)***

SELECT *
FROM   (SELECT b.book_author AS author,
               Avg(r.book_rating) AS author_avg_rating,
               Dense_rank()
                 OVER(
                   ORDER BY Avg(r.book_rating) DESC) AS rank
        FROM   books_details AS b
               INNER JOIN rating_info AS r
                       ON b.isbn = r.isbn
        GROUP  BY book_author) AS sub
WHERE  rank <= 10; 