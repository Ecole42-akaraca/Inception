CREATE DATABASE IF NOT EXISTS Yuandre;

CREATE USER IF NOT EXISTS 'akaraca'@'%' IDENTIFIED BY 'akaraca123'; -- Creating user and user's password from .env file.
GRANT ALL PRIVILEGES ON Yuandre.* TO 'akaraca'@'%'; -- Grants all permissions to the user.
FLUSH PRIVILEGES; -- Updating permissions table.

ALTER USER 'root'@'localhost' IDENTIFIED BY '123'; -- Editing User table and adding 'root'.

-- THIS FILE FOR CREATE A NEW DATABASE.