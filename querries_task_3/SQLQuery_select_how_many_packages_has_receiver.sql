SELECT package.rece_id, COUNT(end_road.package_id) AS num_of_deliveries, receiver.name, receiver.surname
FROM end_road
INNER JOIN delivery ON delivery.delivery_id = end_road.delivery_id
INNER JOIN package ON package.package_id = end_road.package_id
INNER JOIN receiver ON receiver.cust_id = package.rece_id
GROUP BY package.rece_id, receiver.name,receiver.surname
ORDER BY COUNT(end_road.package_id) DESC