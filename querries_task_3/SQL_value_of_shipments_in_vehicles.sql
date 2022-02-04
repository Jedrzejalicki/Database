SELECT shipment.vin, COUNT(shipment.shipment_id) AS num_of_shipments, shipment.courier_id,SUM(package.price) AS total_value
FROM package
INNER JOIN shipment ON shipment.shipment_id = package.ship_id
GROUP BY vin, shipment.courier_id