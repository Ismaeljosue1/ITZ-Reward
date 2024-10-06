CREATE TABLE welcome_packs_claimed (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(50) NOT NULL,
    hasClaimed BOOLEAN DEFAULT FALSE
);
