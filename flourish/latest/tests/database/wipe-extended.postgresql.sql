BEGIN;
DELETE FROM people;
DELETE FROM categories;
DELETE FROM certifications;
DELETE FROM certification_levels;
DELETE FROM events_artists;
DELETE FROM event_details;
DELETE FROM registrations;
DELETE FROM event_slots;
DELETE FROM events;
DELETE FROM invalid_tables;
DELETE FROM top_albums;
DELETE FROM year_favorite_albums;
DELETE FROM favorite_albums;
DELETE FROM record_deals;
DELETE FROM record_labels;
DELETE FROM other_user_details;
DELETE FROM user_details;
COMMIT;
SELECT pg_catalog.setval(pg_get_serial_sequence('people', 'person_id'), 1, FALSE);
SELECT pg_catalog.setval(pg_get_serial_sequence('categories', 'category_id'), 1, FALSE);
SELECT pg_catalog.setval(pg_get_serial_sequence('event_slots', 'id'), 1, FALSE);
SELECT pg_catalog.setval(pg_get_serial_sequence('events', 'event_id'), 1, FALSE);
SELECT pg_catalog.setval(pg_get_serial_sequence('top_albums', 'top_album_id'), 1, FALSE);