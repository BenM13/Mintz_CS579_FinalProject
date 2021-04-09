-- List customers who used a payment 
-- method that begins with "visa"
SELECT customer_id, fname, lname, payment_method FROM customer
WHERE payment_method LIKE 'visa%';

-- List the names of all customers who purchased a rental
-- for 2 days or fewer
SELECT fname, lname, agreement_id FROM customer
JOIN agreement ON customer.customer_id = agreement.customer_id
WHERE DATEDIFF(due_by, time_of_rental) <= 2;

-- List the names of all skiers who have rented a helmet
SELECT fname, lname, agreement FROM skier
JOIN skier_item ON skier.skier_id = skier_item.skier
JOIN inventory ON skier_item.item_used = inventory.item_no
WHERE item_type = 'Helmet'
ORDER BY lname;



INSERT INTO agreement VALUES (
	104,
    '2020-05-03',
    '2020-05-03',
    149,
    24.50
);

INSERT INTO skier_item (agreement, skier, item_used) VALUES (
	104,
    348,
    201
);

INSERT INTO skier_item (agreement, skier, item_used) VALUES (
	104,
    391,
    201
);

SELECT * FROM skier_item
WHERE agreement = 104;

SELECT * FROM inventory
WHERE item_no = 201;
