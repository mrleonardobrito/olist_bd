CREATE TABLE IF NOT EXISTS audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(255) NOT NULL,
    record_id VARCHAR(36) NOT NULL,
    action ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_data JSON,
    new_data JSON,
    audit_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER IF NOT EXISTS customer_BEFORE_UPDATE
BEFORE UPDATE ON customer
FOR EACH ROW
BEGIN
    INSERT INTO audit (
        table_name,
        record_id,
        action,
        old_data,
        new_data
    )
    VALUES (
        'customer',
        OLD.customer_id,
        'UPDATE',
        JSON_OBJECT(
            'customer_zip_code_prefix', OLD.customer_zip_code_prefix,
            'customer_city', OLD.customer_city,
            'customer_state', OLD.customer_state
        ),
        JSON_OBJECT(
            'customer_zip_code_prefix', NEW.customer_zip_code_prefix,
            'customer_city', NEW.customer_city,
            'customer_state', NEW.customer_state
        )
    );
END;

CREATE TRIGGER IF NOT EXISTS customer_BEFORE_DELETE
BEFORE DELETE ON customer
FOR EACH ROW
BEGIN
    INSERT INTO audit (
        table_name,
        record_id,
        action,
        old_data,
        new_data
    )
    VALUES (
        'customer',
        OLD.customer_id,
        'DELETE',
        JSON_OBJECT(
            'customer_zip_code_prefix', OLD.customer_zip_code_prefix,
            'customer_city', OLD.customer_city,
            'customer_state', OLD.customer_state
        ),
        NULL
    );
END;

CREATE TRIGGER IF NOT EXISTS seller_BEFORE_UPDATE
BEFORE UPDATE ON seller
FOR EACH ROW
BEGIN
    INSERT INTO audit (
        table_name,
        record_id,
        action,
        old_data,
        new_data
    )
    VALUES (
        'seller',
        OLD.seller_id,
        'UPDATE',
        JSON_OBJECT(
            'seller_zip_code_prefix', OLD.seller_zip_code_prefix,
            'seller_city', OLD.seller_city,
            'seller_state', OLD.seller_state
        ),
        JSON_OBJECT(
            'seller_zip_code_prefix', NEW.seller_zip_code_prefix,
            'seller_city', NEW.seller_city,
            'seller_state', NEW.seller_state
        )
    );
END;

CREATE TRIGGER IF NOT EXISTS seller_BEFORE_DELETE
BEFORE DELETE ON seller
FOR EACH ROW
BEGIN
    INSERT INTO audit (
        table_name,
        record_id,
        action,
        old_data,
        new_data
    )
    VALUES (
        'seller',
        OLD.seller_id,
        'DELETE',
        JSON_OBJECT(
            'seller_zip_code_prefix', OLD.seller_zip_code_prefix,
            'seller_city', OLD.seller_city,
            'seller_state', OLD.seller_state
        ),
        NULL
    );
END;

CREATE TRIGGER IF NOT EXISTS product_BEFORE_UPDATE
BEFORE UPDATE ON product
FOR EACH ROW
BEGIN
    INSERT INTO audit (
        table_name,
        record_id,
        action,
        old_data,
        new_data
    )
    VALUES (
        'product',
        OLD.product_id,
        'UPDATE',
        JSON_OBJECT(
            'product_category_name', OLD.product_category_name,
            'product_name_lenght', OLD.product_name_lenght,
            'product_description_lenght', OLD.product_description_lenght,
            'product_photos_qty', OLD.product_photos_qty,
            'product_weight_g', OLD.product_weight_g,
            'product_length_cm', OLD.product_length_cm,
            'product_height_cm', OLD.product_height_cm,
            'product_width_cm', OLD.product_width_cm
        ),
        JSON_OBJECT(
            'product_category_name', NEW.product_category_name,
            'product_name_lenght', NEW.product_name_lenght,
            'product_description_lenght', NEW.product_description_lenght,
            'product_photos_qty', NEW.product_photos_qty,
            'product_weight_g', NEW.product_weight_g,
            'product_length_cm', NEW.product_length_cm,
            'product_height_cm', NEW.product_height_cm,
            'product_width_cm', NEW.product_width_cm
        )
    );
END;

CREATE TRIGGER IF NOT EXISTS product_BEFORE_DELETE
BEFORE DELETE ON product
FOR EACH ROW
BEGIN
    INSERT INTO audit (
        table_name,
        record_id,
        action,
        old_data,
        new_data
    )
    VALUES (
        'product',
        OLD.product_id,
        'DELETE',
        JSON_OBJECT(
            'product_category_name', OLD.product_category_name,
            'product_name_lenght', OLD.product_name_lenght,
            'product_description_lenght', OLD.product_description_lenght,
            'product_photos_qty', OLD.product_photos_qty,
            'product_weight_g', OLD.product_weight_g,
            'product_length_cm', OLD.product_length_cm,
            'product_height_cm', OLD.product_height_cm,
            'product_width_cm', OLD.product_width_cm
        ),
        NULL
    );
END;