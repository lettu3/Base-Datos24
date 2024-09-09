USE world;

CREATE INDEX idx_continent_name ON continent(Name);

ALTER TABLE country ADD FOREIGN KEY(Continent) REFERENCES continent(Name);