    CREATE VIEW [Companies]
AS
SELECT sender.name, sender.nip,  package.send_id, COUNT(package.package_id) as num_of_packages,SUM(package.price) as total_value
FROM package
INNER JOIN sender ON sender.cust_id = package.send_id
WHERE sender.isPerson = 0
GROUP BY sender.name, package.send_id, sender.nip
UNION
SELECT receiver.name, receiver.nip, package.rece_id, COUNT(package.package_id) as num_of_packages ,SUM(package.price) as total_value
FROM package
INNER JOIN receiver ON receiver.cust_id = package.rece_id
WHERE receiver.isPerson = 0
GROUP BY receiver.name, package.rece_id, receiver.nip
