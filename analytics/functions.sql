-- ============================================================
-- Healthcare Claims Intelligence Platform
-- User Defined Functions
-- ============================================================

DELIMITER $$

-- ============================================================
-- 1. Calculate Approval Percentage
-- ============================================================

DROP FUNCTION IF EXISTS CalculateApprovalPercentage $$

CREATE FUNCTION CalculateApprovalPercentage(
    claim_amount DECIMAL(10,2),
    approved_amount DECIMAL(10,2)
)
RETURNS DECIMAL(5,2)

DETERMINISTIC

BEGIN

    IF claim_amount = 0 THEN
        RETURN 0;
    END IF;

    RETURN ROUND((approved_amount / claim_amount) * 100,2);

END $$


-- ============================================================
-- 2. Claim Category
-- ============================================================

DROP FUNCTION IF EXISTS GetClaimCategory $$

CREATE FUNCTION GetClaimCategory(
    claim_amount DECIMAL(10,2)
)
RETURNS VARCHAR(20)

DETERMINISTIC

BEGIN

    IF claim_amount < 10000 THEN
        RETURN 'Low';

    ELSEIF claim_amount < 50000 THEN
        RETURN 'Medium';

    ELSE
        RETURN 'High';

    END IF;

END $$


-- ============================================================
-- 3. Patient Age
-- ============================================================

DROP FUNCTION IF EXISTS GetPatientAge $$

CREATE FUNCTION GetPatientAge(
    dob DATE
)
RETURNS INT

DETERMINISTIC

BEGIN

    RETURN TIMESTAMPDIFF(YEAR,dob,CURDATE());

END $$


-- ============================================================
-- 4. Revenue Category
-- ============================================================

DROP FUNCTION IF EXISTS GetRevenueCategory $$

CREATE FUNCTION GetRevenueCategory(
    revenue DECIMAL(12,2)
)
RETURNS VARCHAR(20)

DETERMINISTIC

BEGIN

    IF revenue < 500000 THEN
        RETURN 'Low Revenue';

    ELSEIF revenue < 2000000 THEN
        RETURN 'Medium Revenue';

    ELSE
        RETURN 'High Revenue';

    END IF;

END $$


-- ============================================================
-- 5. Doctor Experience Level
-- ============================================================

DROP FUNCTION IF EXISTS GetExperienceLevel $$

CREATE FUNCTION GetExperienceLevel(
    exp INT
)
RETURNS VARCHAR(20)

DETERMINISTIC

BEGIN

    IF exp < 5 THEN
        RETURN 'Junior';

    ELSEIF exp < 15 THEN
        RETURN 'Mid-Level';

    ELSE
        RETURN 'Senior';

    END IF;

END $$


-- ============================================================
-- 6. Remaining Claim Amount
-- ============================================================

DROP FUNCTION IF EXISTS CalculateRemainingAmount $$

CREATE FUNCTION CalculateRemainingAmount(

    claim_amount DECIMAL(10,2),

    approved_amount DECIMAL(10,2)

)

RETURNS DECIMAL(10,2)

DETERMINISTIC

BEGIN

    RETURN claim_amount-approved_amount;

END $$

DELIMITER ;