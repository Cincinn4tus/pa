
CREATE DATABASE crowdhub;

CREATE TABLE crowdhub.pa_enterprise (
    siren INT(9) PRIMARY KEY,
    enterprise_name VARCHAR(45) NOT NULL,
    phone_number INT(10),
    billing_address VARCHAR(120),
    billing_zipcode INT(5),
    city VARCHAR(30)
);

CREATE TABLE crowdhub.pa_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pwd VARCHAR(255),
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
    siren INT(9),
    FOREIGN KEY (siren) REFERENCES crowdhub.pa_enterprise(siren)
);

ALTER TABLE crowdhub.pa_user ADD PRIMARY KEY (id);
ALTER TABLE crowdhub.pa_user MODIFY pwd VARCHAR(255) NULL;


CREATE TABLE crowdhub.pa_financement (
  id int(11) NOT NULL,
  projectTitle varchar(255) NOT NULL,
  companyName varchar(255) NOT NULL,
  requestedAmount int(11) NOT NULL,
  contactInfo varchar(535) NOT NULL,
  projectDescription text NOT NULL,
  fundingGoals text NOT NULL
);
ALTER TABLE crowdhub.pa_financement ADD PRIMARY KEY (id);

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