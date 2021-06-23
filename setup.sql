-- Create database
CREATE DATABASE dhukuti;
-- Use database
USE dhukuti;
-- Create Users table
CREATE TABLE Users (userId INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY, FirstName VARCHAR(255) NOT NULL, LastName VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL UNIQUE,  password VARCHAR(255) NOT NULL);
-- Create Loans table
CREATE TABLE Loans (loanId INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY, loanAmount INT NOT NULL, totalParticipants INT NOT NULL, openSpaces INT NOT NULL,  proposerUserId INT NOT NULL, loanFrequencyInDays INT NOT NULL, loanInterestRate DECIMAL(4,2), loanStartDate DATE);
-- Create Loan Order Table
CREATE TABLE loanOrder (loanOrderId INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY, userId INT, loanId INT NOT NULL, turn NOT NULL INT,  interestRate DECIMAL(4,2) NOT NULL);
