BEGIN;
DELETE FROM blobs;
DELETE FROM owns_on_tape;
DELETE FROM owns_on_cd;
DELETE FROM songs;
DELETE FROM records;
DELETE FROM popular_artists;
DELETE FROM users_groups;
DELETE FROM "group";
DELETE FROM user;
COMMIT;
DELETE FROM sqlite_sequence WHERE name = 'songs';
DELETE FROM sqlite_sequence WHERE name = 'records';
DELETE FROM sqlite_sequence WHERE name = 'popular_artists';
DELETE FROM sqlite_sequence WHERE name = 'group';
DELETE FROM sqlite_sequence WHERE name = 'user';