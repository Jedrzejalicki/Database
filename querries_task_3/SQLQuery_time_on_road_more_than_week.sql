SELECT  receiver.cust_id, package.package_id,  delivery.num_of_attempt, delivery.driver_id, delivery.isDelivered, (
                                                                                                    CASE
                                                                                                        WHEN package.date_of_receiv is NULL
                                                                                                            THEN DATEDIFF(day, package.date_of_dispatch, GETDATE())
                                                                                                        ELSE DATEDIFF(day, package.date_of_dispatch, package.date_of_receiv) 
                                                                                                    END) AS time_on_road
FROM end_road
INNER JOIN delivery ON delivery.delivery_id = end_road.delivery_id
INNER JOIN package ON package.package_id = end_road.package_id
INNER JOIN receiver ON receiver.cust_id = package.rece_id
WHERE (DATEDIFF(day, package.date_of_dispatch, package.date_of_receiv) > 6) OR
(package.date_of_receiv is NULL AND DATEDIFF(day, package.date_of_dispatch, GETDATE()) > 2)
AND package.package_id IN
(SELECT package_id FROM end_road)

ORDER BY time_on_road DESC
