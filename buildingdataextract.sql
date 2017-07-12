
CREATE SCHEMA tilemill;

CREATE TABLE tilemill.buildings AS
SELECT
  p.identificatie::bigint, bouwjaar::int,
  ST_Transform(p.geovlak, 4326) AS geom
  
FROM bagaveen.verblijfsobjectactueelbestaand v
JOIN bagaveen.verblijfsobjectpandactueel vp
  ON vp.identificatie = v.identificatie
JOIN bagaveen.pandactueelbestaand p
  ON vp.gerelateerdpand = p.identificatie
JOIN bagaveen.verblijfsobjectgebruiksdoelactueel vg
  ON v.identificatie = vg.identificatie
GROUP BY
  p.identificatie, bouwjaar, p.geovlak;

CREATE INDEX buildings_geom_idx
  ON tilemill.buildings
  USING gist (geom);