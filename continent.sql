USE world;

CREATE INDEX idx_city_name ON city(Name);

CREATE table continent(
	Name varchar(255),
	Area int,
	Percent decimal(3,1),
	MostPopulousCity varchar(255),
	PRIMARY KEY(Name),
	FOREIGN KEY(MostPopulousCity) REFERENCES city(Name)
);

