-- ==========================================================
-- Healthcare Claims Intelligence Platform
-- Triggers
-- ==========================================================

-- ==========================================================
-- CLAIM AUDIT TABLE
-- ==========================================================

CREATE TABLE IF NOT EXISTS claim_audit (

    audit_id INT AUTO_INCREMENT PRIMARY KEY,

    claim_id INT,

    action_type VARCHAR(20),

    old_status VARCHAR(20),

    new_status VARCHAR(20),

    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    changed_by VARCHAR(100)

);

DELIMITER $$

-- ==========================================================
-- AFTER INSERT TRIGGER
-- ==========================================================

DROP TRIGGER IF EXISTS trg_after_claim_insert $$

CREATE TRIGGER trg_after_claim_insert

AFTER INSERT

ON claims

FOR EACH ROW

BEGIN

    INSERT INTO claim_audit
    (
        claim_id,
        action_type,
        old_status,
        new_status,
        changed_by
    )

    VALUES
    (
        NEW.claim_id,
        'INSERT',
        NULL,
        NEW.status,
        CURRENT_USER()
    );

END $$


-- ==========================================================
-- AFTER UPDATE TRIGGER
-- Logs only if claim status changes
-- ==========================================================

DROP TRIGGER IF EXISTS trg_after_claim_update $$

CREATE TRIGGER trg_after_claim_update

AFTER UPDATE

ON claims

FOR EACH ROW

BEGIN

    IF OLD.status <> NEW.status THEN

        INSERT INTO claim_audit
        (
            claim_id,
            action_type,
            old_status,
            new_status,
            changed_by
        )

        VALUES
        (
            NEW.claim_id,
            'UPDATE',
            OLD.status,
            NEW.status,
            CURRENT_USER()
        );

    END IF;

END $$


-- ==========================================================
-- AFTER DELETE TRIGGER
-- ==========================================================

DROP TRIGGER IF EXISTS trg_after_claim_delete $$

CREATE TRIGGER trg_after_claim_delete

AFTER DELETE

ON claims

FOR EACH ROW

BEGIN

    INSERT INTO claim_audit
    (
        claim_id,
        action_type,
        old_status,
        new_status,
        changed_by
    )

    VALUES
    (
        OLD.claim_id,
        'DELETE',
        OLD.status,
        NULL,
        CURRENT_USER()
    );

END $$

DELIMITER ;