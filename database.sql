
CREATE DATABASE crowdhub;

CREATE TABLE crowdhub.pa_company (
    siren INT(9) PRIMARY KEY,
    company_name VARCHAR(45) NOT NULL,
    phone_number INT(10),
    billing_address VARCHAR(120),
    billing_zipcode INT(5),
    city VARCHAR(30),
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

-- DROP the email column from the pa_company table

ALTER TABLE crowdhub.pa_company DROP COLUMN email;

CREATE TABLE crowdhub.pa_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pwd VARCHAR(255),
    token VARCHAR(255),
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    gender INT(1) NOT NULL,
    birthdate DATE NOT NULL,
    scope INT(1) DEFAULT 1,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    postal_code VARCHAR(20),
    postal_address VARCHAR(255),
    city VARCHAR(255),
    phone_number VARCHAR(20),
    siren INT(9) DEFAULT NULL,
    FOREIGN KEY (siren) REFERENCES crowdhub.pa_company(siren)
);

CREATE TABLE crowdhub.pa_financement (
  id int(11) NOT NULL,
  projectTitle varchar(255) NOT NULL,
  companyName varchar(255) NOT NULL,
  requestedAmount int(11) NOT NULL,
  contactInfo varchar(535) NOT NULL,
  projectDescription text NOT NULL,
  argentactuel int(11) NOT NULL DEFAULT 0,
  fundingGoals text NOT NULL
);
ALTER TABLE crowdhub.pa_financement ADD PRIMARY KEY (id);
ALTER TABLE crowdhub.pa_financement MODIFY id INT AUTO_INCREMENT;


CREATE TABLE crowdhub.pa_relation (
  id INT NOT NULL AUTO_INCREMENT,
  id_demandeur INT NOT NULL,
  id_receveur INT NOT NULL,
  statut INT NOT NULL,
  id_bloqueur INT DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE crowdhub.pa_logs (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    visit_date VARCHAR(255) NOT NULL,
    visit_hour VARCHAR(255) NOT NULL,
    ip VARCHAR(255) NOT NULL,
    region VARCHAR(255) NOT NULL,
    page_visited VARCHAR(255) NOT NULL,
    user VARCHAR(255) NULL
);

CREATE TABLE crowdhub.pa_newsletter (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title varchar(255) NOT NULL,
    content text NOT NULL,
    recipient int(11) NOT NULL,
    send_date date NOT NULL
);

CREATE TABLE crowdhub.pa_message (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    lastname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    status INT NOT NULL DEFAULT 0
);

CREATE TABLE crowdhub.pa_relation (
  id INT NOT NULL AUTO_INCREMENT,
  id_demandeur INT NOT NULL,
  id_receveur INT NOT NULL,
  statut INT NOT NULL,
  id_bloqueur INT DEFAULT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE crowdhub.pa_financement MODIFY id INT AUTO_INCREMENT;

CREATE TABLE crowdhub.pa_friendship (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user1_id INT NOT NULL,
    user2_id INT NOT NULL,
    status ENUM('pending', 'accepted', 'declined') NOT NULL,
    request_sent_by INT NOT NULL,
    FOREIGN KEY (user1_id) REFERENCES pa_user(id),
    FOREIGN KEY (user2_id) REFERENCES pa_user(id)
);


CREATE TABLE crowdhub.messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT NOT NULL,
  recipient_id INT NOT NULL,
  content TEXT NOT NULL,
  sent_at DATETIME NOT NULL,
  is_read BOOLEAN NOT NULL DEFAULT 0,
  FOREIGN KEY (sender_id) REFERENCES pa_user(id),
  FOREIGN KEY (recipient_id) REFERENCES pa_user(id)
);


CREATE TABLE crowdhub.pa_performance (
    page VARCHAR(255) PRIMARY KEY,
    time FLOAT NOT NULL,
    status INT NOT NULL DEFAULT 1
);
