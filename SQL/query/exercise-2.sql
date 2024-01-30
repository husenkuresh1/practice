-- Query-2 *** List out top 10 publishers who published most books. ***
select
        *
from
        (
                select
                        publisher as publisher,
                        count(publisher) as count,
                        dense_rank() over(
                                order by
                                        count(publisher) desc
                        ) as rank
                from
                        books_details
                group by
                        publisher
        )
where
        rank <= 10;