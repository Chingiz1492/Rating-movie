-- step 1 create a table with name users
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name    VARCHAR(100) NOT NULL
);
-- step 2 create table with name movies
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);
-- step 3 create table with name ratings
CREATE TABLE ratings (
    user_id INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    movie_id INTEGER REFERENCES movies(movie_id) ON DELETE CASCADE,
    rating INTEGER NOT NULL,

    -- limiting rating range
    CONSTRAINT check_rating_range CHECK (rating BETWEEN 1 AND 5),

    -- A composite key guarantees the uniqueness of the user-film pair.
    PRIMARY KEY (user_id, movie_id)
);
--step 4 insert names
INSERT INTO users (name) VALUES
('Alex'),
('Mary'),
('Arianna'),
('Ivan'),
('Darina');

-- Insert movies
INSERT INTO movies (title) VALUES
('Troy'),
('Departed'),
('Green Mile'),
('Escape from Showshank'),
('American Pie');

-- insert rating
INSERT INTO ratings (user_id, movie_id, rating) VALUES
-- Alex rated 3 movies
(1, 1, 5), (1, 2, 4), (1, 5, 5),
-- Mary rated 2 movies
(2, 1, 4), (2, 3, 5),
-- Arianna rated 3 movies
(3, 2, 3), (3, 4, 4), (3, 5, 2),
-- Ivan rated 5 movies
(4, 1, 5), (4, 2, 5), (4, 3, 4), (4, 4, 5), (4, 5, 5),
 -- darina rated 1 movie
(5, 3, 3);

--step 5 check a result

-- quarry: Name movie rating
SELECT
    u.name AS "Name",
    m.title AS "Movie",
    r.rating AS "Rating"
FROM ratings r
JOIN users u ON r.user_id = u.user_id
JOIN movies m ON r.movie_id = m.movie_id
ORDER BY u.name;