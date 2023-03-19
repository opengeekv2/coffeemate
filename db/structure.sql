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

--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


SET default_tablespace = '';

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: coffees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coffees (
    id bigint NOT NULL,
    title character varying,
    ecommerce_link character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    taste_notes_vector public.cube
);


--
-- Name: coffees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coffees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coffees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coffees_id_seq OWNED BY public.coffees.id;


--
-- Name: coffees_taste_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coffees_taste_notes (
    coffee_id bigint NOT NULL,
    taste_note_id bigint NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: taste_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.taste_notes (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    color character varying,
    is_basic boolean,
    parent_id bigint,
    level integer
);


--
-- Name: taste_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.taste_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taste_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.taste_notes_id_seq OWNED BY public.taste_notes.id;


--
-- Name: coffees id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coffees ALTER COLUMN id SET DEFAULT nextval('public.coffees_id_seq'::regclass);


--
-- Name: taste_notes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taste_notes ALTER COLUMN id SET DEFAULT nextval('public.taste_notes_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: coffees coffees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coffees
    ADD CONSTRAINT coffees_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: taste_notes taste_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taste_notes
    ADD CONSTRAINT taste_notes_pkey PRIMARY KEY (id);


--
-- Name: index_taste_notes_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taste_notes_on_parent_id ON public.taste_notes USING btree (parent_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20230216183450'),
('20230301225812'),
('20230301231434'),
('20230303174009'),
('20230319092348'),
('20230319095730'),
('20230319095740'),
('20230319165550'),
('20230319173737'),
('20230319213306'),
('20230319213329');


