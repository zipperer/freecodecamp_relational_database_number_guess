--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer,
    secret_number integer NOT NULL,
    count_guesses_so_far integer DEFAULT 0 NOT NULL,
    user_guessed_correctly boolean DEFAULT false
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22)
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (2, 2, 638, 0, false);
INSERT INTO public.games VALUES (3, 3, 240, 0, false);
INSERT INTO public.games VALUES (13, 6, 418, 1, false);
INSERT INTO public.games VALUES (4, 3, 119, 2, false);
INSERT INTO public.games VALUES (14, 6, 847, 3, false);
INSERT INTO public.games VALUES (5, 3, 721, 12, false);
INSERT INTO public.games VALUES (15, 7, 673, 10, false);
INSERT INTO public.games VALUES (6, 4, 470, 9, false);
INSERT INTO public.games VALUES (7, 4, 412, 5, false);
INSERT INTO public.games VALUES (16, 7, 333, 10, false);
INSERT INTO public.games VALUES (17, 6, 889, 1, false);
INSERT INTO public.games VALUES (8, 5, 687, 10, false);
INSERT INTO public.games VALUES (9, 5, 668, 6, false);
INSERT INTO public.games VALUES (18, 6, 433, 11, false);
INSERT INTO public.games VALUES (10, 4, 47, 4, false);
INSERT INTO public.games VALUES (19, 6, 371, 10, false);
INSERT INTO public.games VALUES (11, 4, 721, 12, false);
INSERT INTO public.games VALUES (20, 8, 208, 1, false);
INSERT INTO public.games VALUES (21, 9, 492, 8, false);
INSERT INTO public.games VALUES (12, 4, 510, 12, false);
INSERT INTO public.games VALUES (22, 9, 109, 2, false);
INSERT INTO public.games VALUES (23, 10, 146, 10, false);
INSERT INTO public.games VALUES (24, 10, 828, 1, false);
INSERT INTO public.games VALUES (25, 9, 118, 11, false);
INSERT INTO public.games VALUES (26, 9, 255, 10, false);
INSERT INTO public.games VALUES (27, 9, 10, 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (2, '');
INSERT INTO public.users VALUES (3, 'hello');
INSERT INTO public.users VALUES (4, 'user_1690732593188');
INSERT INTO public.users VALUES (5, 'user_1690732593187');
INSERT INTO public.users VALUES (6, 'user_1690732904559');
INSERT INTO public.users VALUES (7, 'user_1690732904558');
INSERT INTO public.users VALUES (8, 'k');
INSERT INTO public.users VALUES (9, 'user_1690733153715');
INSERT INTO public.users VALUES (10, 'user_1690733153714');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 27, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

