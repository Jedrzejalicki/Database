SELECT delivery.driver_id, courier.num_of_order, SUM(package.price) as value_of_packages, courier.sector_of_work
FROM end_road
INNER JOIN delivery ON delivery.delivery_id = end_road.delivery_id
INNER JOIN package ON package.package_id = end_road.package_id
INNER JOIN courier ON courier.courier_id = delivery.driver_id
GROUP BY delivery.driver_id,courier.num_of_order,courier.sector_of_work
ORDER BY value_of_packages DESC
