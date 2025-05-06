--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Debian 14.17-1.pgdg120+1)
-- Dumped by pg_dump version 14.17 (Debian 14.17-1.pgdg120+1)

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
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.account OWNER TO postgres;

--
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_id_seq OWNER TO postgres;

--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer,
    name character varying(64)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: zoomania; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zoomania (
    id integer,
    name character varying(64)
);


ALTER TABLE public.zoomania OWNER TO postgres;

--
-- Name: account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (id, username, email, password_hash, created_at) FROM stdin;
1	john_doe	john@example.com	hashed_pass_1	2025-05-05 12:52:34.139106
2	alice88	alice@example.com	hashed_pass_2	2025-05-05 12:52:34.139106
3	bob_admin	bob@example.com	hashed_pass_3	2025-05-05 12:52:34.139106
4	charlie01	charlie@example.com	hashed_pass_4	2025-05-05 12:52:34.139106
5	diana_s	diana@example.com	hashed_pass_5	2025-05-05 12:52:34.139106
6	eva_k	eva@example.com	hashed_pass_6	2025-05-05 12:52:34.139106
7	frank007	frank@example.com	hashed_pass_7	2025-05-05 12:52:34.139106
8	george_b	george@example.com	hashed_pass_8	2025-05-05 12:52:34.139106
9	hannah123	hannah@example.com	hashed_pass_9	2025-05-05 12:52:34.139106
10	ivan99	ivan@example.com	hashed_pass_10	2025-05-05 12:52:34.139106
11	julia_x	julia@example.com	hashed_pass_11	2025-05-05 12:52:34.139106
12	kevin_m	kevin@example.com	hashed_pass_12	2025-05-05 12:52:34.139106
13	lara_c	lara@example.com	hashed_pass_13	2025-05-05 12:52:34.139106
14	mike_w	mike@example.com	hashed_pass_14	2025-05-05 12:52:34.139106
15	nina_v	nina@example.com	hashed_pass_15	2025-05-05 12:52:34.139106
16	oliver_t	oliver@example.com	hashed_pass_16	2025-05-05 12:52:34.139106
17	paula_q	paula@example.com	hashed_pass_17	2025-05-05 12:52:34.139106
18	quentin_r	quentin@example.com	hashed_pass_18	2025-05-05 12:52:34.139106
19	rachel_m	rachel@example.com	hashed_pass_19	2025-05-05 12:52:34.139106
20	samuel_l	samuel@example.com	hashed_pass_20	2025-05-05 12:52:34.139106
21	tina_z	tina@example.com	hashed_pass_21	2025-05-05 12:52:34.139106
22	ulysses_k	ulysses@example.com	hashed_pass_22	2025-05-05 12:52:34.139106
23	vicky_d	vicky@example.com	hashed_pass_23	2025-05-05 12:52:34.139106
24	william_b	william@example.com	hashed_pass_24	2025-05-05 12:52:34.139106
25	xena_p	xena@example.com	hashed_pass_25	2025-05-05 12:52:34.139106
26	yuri_n	yuri@example.com	hashed_pass_26	2025-05-05 12:52:34.139106
27	zoe_s	zoe@example.com	hashed_pass_27	2025-05-05 12:52:34.139106
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name) FROM stdin;
\.


--
-- Data for Name: zoomania; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zoomania (id, name) FROM stdin;
\.


--
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_id_seq', 27, true);


--
-- Name: account account_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_email_key UNIQUE (email);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

