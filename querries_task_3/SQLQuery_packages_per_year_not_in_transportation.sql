    SELECT COUNT(*) as num_of_pack, YEAR(date_of_dispatch) as year
    FROM package
    WHERE package_id NOT IN
      (SELECT transportation.package_id
    FROM transportation
   )
    GROUP BY YEAR(date_of_dispatch)
