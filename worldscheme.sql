USE world;

CREATE TABLE country (
	Code char(3) NOT NULL DEFAULT '',
	Name varchar(255) NOT NULL DEFAULT '',
	Continent varchar(255),
	Region varchar(255),
	SurfaceArea decimal(10,2) NOT NULL DEFAULT '0.0',
	IndepYear smallint,
	Population int,
	LifeExpectancy decimal(3,1) DEFAULT NULL,
	GNP decimal(10,2) DEFAULT NULL,
	GNPOld decimal(10,2) DEFAULT NULL,
	LocalName varchar(255),
	GovernmentForm varchar(255),
	HeadOfState varchar(255),
	Capital int,
	Code2 char(2),
	PRIMARY KEY(Code)
);

CREATE TABLE city (
	ID int,
	Name varchar(255),
	CountryCode char(3),
	District varchar(255),
	Population int,
	PRIMARY KEY(ID),
	FOREIGN KEY (CountryCode) 
		REFERENCES country(Code)
);

CREATE TABLE countrylanguage (
	CountryCode char(3),
	Language varchar (255),
	IsOfficial enum('T','F') NOT NULL DEFAULT 'F',
	Percentage decimal(4,1) NOT NULL DEFAULT '0.0',
	PRIMARY KEY(CountryCode, Language),
	FOREIGN KEY(CountryCode) REFERENCES country(Code)
);
