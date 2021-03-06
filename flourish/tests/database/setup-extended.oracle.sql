CREATE TABLE user_details (
	user_id INTEGER PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
	photo VARCHAR(255)
);

CREATE TABLE other_user_details (
	id INTEGER PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
	avatar VARCHAR(255)
);

CREATE TABLE record_labels (
	name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE record_deals (
	record_label VARCHAR(255) NOT NULL REFERENCES record_labels(name) ON DELETE CASCADE,
	artist_id INTEGER NOT NULL REFERENCES artists(artist_id) ON DELETE CASCADE,
	PRIMARY KEY (record_label, artist_id)
);

CREATE TABLE favorite_albums (
	email VARCHAR(200) NOT NULL REFERENCES users(email_address) ON DELETE CASCADE,
	album_id INTEGER NOT NULL REFERENCES albums(album_id) ON DELETE CASCADE,
	position INTEGER NOT NULL,
	UNIQUE (email, position),
	PRIMARY KEY (email, album_id)
);

CREATE TABLE year_favorite_albums (
	email VARCHAR(200) NOT NULL REFERENCES users(email_address) ON DELETE CASCADE,
	year INTEGER NOT NULL,
	album_id INTEGER NOT NULL REFERENCES albums(album_id) ON DELETE CASCADE,
	position INTEGER NOT NULL,
	UNIQUE (email, year, position),
	PRIMARY KEY (email, year, album_id)
);

CREATE TABLE top_albums (
	top_album_id INTEGER PRIMARY KEY,
	album_id INTEGER NOT NULL UNIQUE REFERENCES albums(album_id) ON DELETE CASCADE,
	position INTEGER NOT NULL UNIQUE
);

CREATE SEQUENCE top_albums_top_album_id_seq;

CREATE OR REPLACE TRIGGER top_albums_top_album_id_trg
BEFORE INSERT ON top_albums
FOR EACH ROW
BEGIN
  IF :new.top_album_id IS NULL THEN
	SELECT top_albums_top_album_id_seq.nextval INTO :new.top_album_id FROM dual\;
  END IF\;
END\;
;

CREATE TABLE invalid_tables (
	not_primary_key VARCHAR(200)
);

CREATE TABLE event_slots (
	id INTEGER PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

CREATE SEQUENCE event_slots_id_seq;

CREATE OR REPLACE TRIGGER event_slots_id_trg
BEFORE INSERT ON event_slots
FOR EACH ROW
BEGIN
  IF :new.id IS NULL THEN
	SELECT event_slots_id_seq.nextval INTO :new.id FROM dual\;
  END IF\;
END\;
;

CREATE TABLE events (
	event_id INTEGER PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE,
	event_slot_id INTEGER UNIQUE REFERENCES event_slots(id) ON DELETE SET NULL,
	registration_url VARCHAR(255)
);

CREATE SEQUENCE events_event_id_seq;

CREATE OR REPLACE TRIGGER events_event_id_trg
BEFORE INSERT ON events
FOR EACH ROW
BEGIN
  IF :new.event_id IS NULL THEN
	SELECT events_event_id_seq.nextval INTO :new.event_id FROM dual\;
  END IF\;
END\;
;

CREATE TABLE registrations (
	event_id INTEGER NOT NULL REFERENCES events(event_id),
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY(event_id, name)
);

CREATE TABLE event_details (
	event_id INTEGER NOT NULL PRIMARY KEY REFERENCES events(event_id),
	allows_registration NUMBER(1) NOT NULL CHECK(allows_registration IN (0,1))
);

CREATE TABLE events_artists (
	event_id INTEGER NOT NULL REFERENCES events(event_id),
	artist_id INTEGER NOT NULL REFERENCES artists(artist_id) ON DELETE CASCADE,
	PRIMARY KEY(event_id, artist_id)
);

CREATE TABLE certification_levels (
	name VARCHAR(200) PRIMARY KEY
);

CREATE TABLE certifications (
	"LEVEL" VARCHAR(200) NOT NULL REFERENCES certification_levels(name) ON DELETE CASCADE,
	album_id INTEGER NOT NULL REFERENCES albums(album_id) ON DELETE CASCADE,
	year INTEGER NOT NULL,
	PRIMARY KEY (album_id, "LEVEL")
);

CREATE TABLE categories (
	category_id INTEGER PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	parent INTEGER REFERENCES categories(category_id) ON DELETE CASCADE
);

CREATE SEQUENCE categories_category_id_seq;

CREATE OR REPLACE TRIGGER categories_category_id_trg
BEFORE INSERT ON categories
FOR EACH ROW
BEGIN
  IF :new.category_id IS NULL THEN
	SELECT categories_category_id_seq.nextval INTO :new.category_id FROM dual\;
  END IF\;
END\;
;

CREATE TABLE people (
	person_id INTEGER PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	category_id INTEGER REFERENCES categories(category_id) ON DELETE CASCADE
);

CREATE SEQUENCE people_person_id_seq;

CREATE OR REPLACE TRIGGER people_person_id_trg
BEFORE INSERT ON people
FOR EACH ROW
BEGIN
  IF :new.person_id IS NULL THEN
	SELECT people_person_id_seq.nextval INTO :new.person_id FROM dual\;
  END IF\;
END\;
;