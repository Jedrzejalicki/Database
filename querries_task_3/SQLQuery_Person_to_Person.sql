SELECT package_id, price, volume,
    sender.city as dispatch_city,sender.street as dispatch_street,sender.street_no as dispatch_street_no,
    receiver.city as dest_city,receiver.street as dest_street,receiver.street_no as dest_street_no
    FROM package
    INNER JOIN sender ON sender.cust_id = package.send_id
    INNER JOIN receiver ON receiver.cust_id = package.rece_id
    WHERE package_id IN 
    (SELECT end_road.package_id
    FROM end_road )
