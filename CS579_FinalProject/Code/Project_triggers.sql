CREATE TRIGGER checkout_item 
AFTER INSERT ON skier_item FOR EACH ROW
	UPDATE inventory SET quantity = (quantity - 1)
	WHERE item_no = NEW.item_used
;

DELIMITER $$
CREATE TRIGGER return_item
AFTER UPDATE ON skier_item FOR EACH ROW
BEGIN
	IF NEW.item_status = 'Returned' 
    AND OLD.item_status != 'Returned' THEN
		UPDATE inventory
        SET quantity = (quantity + 1)
        WHERE item_no = OLD.item_used;
	END IF;
END$$

SELECT * FROM inventory;