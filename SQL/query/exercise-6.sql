-- Query-6 *** Which years had most books published. (also show count)(top 10 only) ***
select
    *
from
    (
        select
            year_of_publication as publication_year,
            count(*) as count,
            dense_rank() over(
                order by
                    count(*) desc
            ) as rank
        from
            books_details
        group by
            year_of_publication
    ) as subquery
where
    rank <= 10;