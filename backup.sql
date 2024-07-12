--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

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
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: building; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.building (
    uuid uuid NOT NULL,
    country character varying NOT NULL,
    city character varying NOT NULL,
    street character varying NOT NULL,
    longitude double precision,
    latitude double precision,
    name character varying NOT NULL
);


ALTER TABLE public.building OWNER TO postgres;

--
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    uuid uuid NOT NULL,
    name character varying NOT NULL,
    room_uuid uuid,
    building_uuid uuid,
    teacher_uuid uuid,
    group_uuid uuid,
    day_of_week character varying NOT NULL,
    is_odd boolean NOT NULL,
    is_lecture boolean NOT NULL,
    start_time character varying NOT NULL,
    end_time character varying NOT NULL
);


ALTER TABLE public.course OWNER TO postgres;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    uuid uuid NOT NULL,
    room_uuid uuid,
    building_uuid uuid,
    name character varying NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."group" (
    uuid uuid NOT NULL,
    name character varying NOT NULL,
    major_uuid uuid
);


ALTER TABLE public."group" OWNER TO postgres;

--
-- Name: major; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.major (
    uuid uuid NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.major OWNER TO postgres;

--
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    uuid uuid NOT NULL,
    building_uuid uuid,
    name character varying NOT NULL
);


ALTER TABLE public.room OWNER TO postgres;

--
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    uuid uuid NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    email character varying NOT NULL,
    group_uuid uuid
);


ALTER TABLE public.student OWNER TO postgres;

--
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher (
    uuid uuid NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    department_uuid uuid
);


ALTER TABLE public.teacher OWNER TO postgres;

--
-- Data for Name: building; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building (uuid, country, city, street, longitude, latitude, name) FROM stdin;
56acd9a9-d4f6-4cd8-8485-bef43e4545b5	Armenia	Yerevan	Teryan 52	\N	\N	2 corpus
af4cc5c9-562b-45e1-af81-770d9f1c45e9	Armenia	Yerevan	Teryan 52	\N	\N	5 corpus
247d37b0-fe3c-4357-9936-680945e443b2	Armenia	Yerevan	Koryun 9	\N	\N	12 corpus
d1f63fc8-96ff-48e6-ab6d-0376300d3658	Armenia	Yerevan	Koryun 11	\N	\N	9 corpus
\.


--
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (uuid, name, room_uuid, building_uuid, teacher_uuid, group_uuid, day_of_week, is_odd, is_lecture, start_time, end_time) FROM stdin;
43b02a17-da68-45e7-9466-7d4f7144c8bc	Programming	f177b4e7-4ffb-4b3d-9d06-02b708e9e706	af4cc5c9-562b-45e1-af81-770d9f1c45e9	c6e5164a-d558-495a-9127-89fe349d9d66	595dadd7-e8bf-4b70-bb5e-210cc5741654	Monday	f	f	11:00	12:20
a3a16685-990f-423d-ac4c-5e1f5ff7396a	Programming	a4e5d3a0-8270-4d7e-bd41-60a169363d45	af4cc5c9-562b-45e1-af81-770d9f1c45e9	6100f3fc-f24c-4166-afd1-f86035a0ef88	a743e7d3-2859-4215-a5f9-757d153576e4	Monday	f	f	11:00	12:20
9f62e69f-cc3e-4d68-9890-50475903358c	Programming	271582ff-32ba-4769-bacb-d30a81527740	af4cc5c9-562b-45e1-af81-770d9f1c45e9	58135a9c-94df-4264-9038-04ce9fca70d2	58be6994-171f-4d5b-980d-3a5db738c0e5	Monday	f	f	11:00	12:20
eac058fb-3a43-4425-be02-c0ccac5499c8	Web Development	1706588e-3c37-40e7-9c59-541f18a62935	247d37b0-fe3c-4357-9936-680945e443b2	9a6312ca-ccae-4bc3-89ea-746cf2bec417	a743e7d3-2859-4215-a5f9-757d153576e4	Thursday	t	f	12:50	14:10
873bf141-c873-4c3d-9138-4e4ac3afb7a2	Mathematical Logic	98877d4e-0c1a-479c-bf45-276bf3564e79	247d37b0-fe3c-4357-9936-680945e443b2	18b81a42-ba43-4343-b31f-ec33b18fdc4a	a743e7d3-2859-4215-a5f9-757d153576e4	Wednesday	t	f	11:00	12:20
ca35f005-f89a-4570-9ccf-c6432fea47a6	Philosophy	f9b278e9-ac19-49df-8dc3-db0f16910919	247d37b0-fe3c-4357-9936-680945e443b2	e5396190-6d6a-413e-a966-6ef463e0bb5a	a743e7d3-2859-4215-a5f9-757d153576e4	Friday	f	f	12:50	14:10
9cc9fa44-9f9c-413c-bdea-f5818a99eee4	Mechanics	9f1dd809-c6de-4917-9741-818762058541	d1f63fc8-96ff-48e6-ab6d-0376300d3658	a73beb9b-89a9-470f-a7e8-a1791c5ba112	a743e7d3-2859-4215-a5f9-757d153576e4	Thursday	f	f	11:00	12:20
22db8c6e-d0a8-4197-93a6-1679b9166d6d	Mechanics	9f1dd809-c6de-4917-9741-818762058541	d1f63fc8-96ff-48e6-ab6d-0376300d3658	a73beb9b-89a9-470f-a7e8-a1791c5ba112	a743e7d3-2859-4215-a5f9-757d153576e4	Thursday	t	f	11:00	12:20
d6b9eec9-42f2-4eca-b2f4-075030fdd8c0	Mathematical Equations	271582ff-32ba-4769-bacb-d30a81527740	247d37b0-fe3c-4357-9936-680945e443b2	be9023b9-1aac-4fa4-8ec5-62fee2494828	58be6994-171f-4d5b-980d-3a5db738c0e5	Monday	t	f	14:20	15:40
a57bdda6-c63b-4c63-9c68-62770f9ea406	Probability Theory	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	afc0cef3-7f18-4149-80bb-470271a13896	58be6994-171f-4d5b-980d-3a5db738c0e5	Wednesday	f	f	9:30	10:50
d06b5561-342d-44fa-8f8e-5f7987d8844a	Programming	a4e5d3a0-8270-4d7e-bd41-60a169363d45	af4cc5c9-562b-45e1-af81-770d9f1c45e9	c6e5164a-d558-495a-9127-89fe349d9d66	595dadd7-e8bf-4b70-bb5e-210cc5741654	Monday	t	f	9:30	10:50
024ce882-04fd-4c16-ac92-77e933216c8d	Mathematical Logic	0945b54e-9922-4dd2-bc72-24e0bcffcf7c	247d37b0-fe3c-4357-9936-680945e443b2	18b81a42-ba43-4343-b31f-ec33b18fdc4a	595dadd7-e8bf-4b70-bb5e-210cc5741654	Monday	t	f	11:00	12:20
5221e6e4-80d8-4b90-a596-85c5fe30de64	Mathematical Logic	0945b54e-9922-4dd2-bc72-24e0bcffcf7c	247d37b0-fe3c-4357-9936-680945e443b2	18b81a42-ba43-4343-b31f-ec33b18fdc4a	595dadd7-e8bf-4b70-bb5e-210cc5741654	Monday	f	f	11:00	12:20
140d7d03-f371-4696-889c-ebf6966e9e85	Mathematical Equations	271582ff-32ba-4769-bacb-d30a81527740	247d37b0-fe3c-4357-9936-680945e443b2	be9023b9-1aac-4fa4-8ec5-62fee2494828	a743e7d3-2859-4215-a5f9-757d153576e4	Monday	f	f	14:20	15:40
0b2a9644-f22b-47db-909f-2e0a07eecead	Programming	65844a7e-401a-4646-9abd-7c10917925cb	af4cc5c9-562b-45e1-af81-770d9f1c45e9	58135a9c-94df-4264-9038-04ce9fca70d2	58be6994-171f-4d5b-980d-3a5db738c0e5	Tuesday	f	f	11:00	12:20
336fd89a-2e98-4540-85cd-1d2a38c5900b	Web Development	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	9a6312ca-ccae-4bc3-89ea-746cf2bec417	595dadd7-e8bf-4b70-bb5e-210cc5741654	Tuesday	f	f	9:30	10:50
c022380f-b551-4e06-bfbc-28ebdb2aacaf	Mathematical Logic	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	18b81a42-ba43-4343-b31f-ec33b18fdc4a	a743e7d3-2859-4215-a5f9-757d153576e4	Tuesday	f	f	11:00	12:20
b58190db-6136-4dc9-89ac-8f4f5dfc956f	Web Development	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	9a6312ca-ccae-4bc3-89ea-746cf2bec417	595dadd7-e8bf-4b70-bb5e-210cc5741654	Tuesday	t	f	9:30	10:50
1e195248-061f-4dd8-94a1-471d5ce7de11	Mathematical Logic	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	18b81a42-ba43-4343-b31f-ec33b18fdc4a	a743e7d3-2859-4215-a5f9-757d153576e4	Tuesday	t	f	11:00	12:20
fd2efcb8-aa4c-4caa-a395-500da9cfcd2d	Mathematical Logic	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	18b81a42-ba43-4343-b31f-ec33b18fdc4a	58be6994-171f-4d5b-980d-3a5db738c0e5	Tuesday	f	f	12:50	14:10
b0a5a77b-b954-4bbb-a41e-8a2bac8eb1e4	Web Development	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	9a6312ca-ccae-4bc3-89ea-746cf2bec417	a743e7d3-2859-4215-a5f9-757d153576e4	Tuesday	f	f	12:50	14:10
681fe03b-82c6-42b8-a8cd-353a45005e4c	Programming	65844a7e-401a-4646-9abd-7c10917925cb	af4cc5c9-562b-45e1-af81-770d9f1c45e9	58135a9c-94df-4264-9038-04ce9fca70d2	595dadd7-e8bf-4b70-bb5e-210cc5741654	Tuesday	f	f	14:20	15:40
70719e03-0e33-4e19-a931-a42af3867105	Mechanics	96a80161-23d4-4eb2-a7bf-ccc9d1c1d2d3	d1f63fc8-96ff-48e6-ab6d-0376300d3658	a73beb9b-89a9-470f-a7e8-a1791c5ba112	595dadd7-e8bf-4b70-bb5e-210cc5741654	Wednesday	f	f	9:30	10:50
65cc1bd1-3f6e-46f8-9929-152b1a74fd3b	Mechanics	96a80161-23d4-4eb2-a7bf-ccc9d1c1d2d3	d1f63fc8-96ff-48e6-ab6d-0376300d3658	a73beb9b-89a9-470f-a7e8-a1791c5ba112	58be6994-171f-4d5b-980d-3a5db738c0e5	Wednesday	f	f	11:00	12:20
f0668f05-9fdc-4011-91fa-419c5608e5df	Mechanics	96a80161-23d4-4eb2-a7bf-ccc9d1c1d2d3	d1f63fc8-96ff-48e6-ab6d-0376300d3658	a73beb9b-89a9-470f-a7e8-a1791c5ba112	58be6994-171f-4d5b-980d-3a5db738c0e5	Wednesday	t	f	11:00	12:20
cabbf781-7fa4-41d4-87eb-f8507b5d4fa4	Probability Theory	98877d4e-0c1a-479c-bf45-276bf3564e79	247d37b0-fe3c-4357-9936-680945e443b2	afc0cef3-7f18-4149-80bb-470271a13896	595dadd7-e8bf-4b70-bb5e-210cc5741654	Wednesday	f	f	11:00	12:20
1c14e6da-4a6b-4d9f-b388-3582e274217e	Probability Theory	98877d4e-0c1a-479c-bf45-276bf3564e79	247d37b0-fe3c-4357-9936-680945e443b2	afc0cef3-7f18-4149-80bb-470271a13896	595dadd7-e8bf-4b70-bb5e-210cc5741654	Wednesday	t	f	11:00	12:20
3a84e060-9028-4a4c-a758-1054fa8ec33d	Complex Analysis	98877d4e-0c1a-479c-bf45-276bf3564e79	247d37b0-fe3c-4357-9936-680945e443b2	e0624d4f-451b-45b1-82ab-cd79739033ab	58be6994-171f-4d5b-980d-3a5db738c0e5	Wednesday	t	t	12:50	14:10
b58272b9-e596-4f38-b323-aa01632f0de5	Complex Analysis	98877d4e-0c1a-479c-bf45-276bf3564e79	247d37b0-fe3c-4357-9936-680945e443b2	e0624d4f-451b-45b1-82ab-cd79739033ab	58be6994-171f-4d5b-980d-3a5db738c0e5	Wednesday	f	t	12:50	14:10
59d48a98-76cc-4164-b936-c88f357273cd	Mathematical Logic	98877d4e-0c1a-479c-bf45-276bf3564e79	247d37b0-fe3c-4357-9936-680945e443b2	18b81a42-ba43-4343-b31f-ec33b18fdc4a	595dadd7-e8bf-4b70-bb5e-210cc5741654	Wednesday	f	f	14:20	15:40
7e14c51e-2f43-44ab-a2cf-d5bdfc39d251	Philosophy	98877d4e-0c1a-479c-bf45-276bf3564e79	247d37b0-fe3c-4357-9936-680945e443b2	e5396190-6d6a-413e-a966-6ef463e0bb5a	a743e7d3-2859-4215-a5f9-757d153576e4	Wednesday	t	f	14:20	15:40
82902748-be5c-43ea-9c32-ef5e0f474760	Mathematical Equtions	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	be9023b9-1aac-4fa4-8ec5-62fee2494828	595dadd7-e8bf-4b70-bb5e-210cc5741654	Thursday	f	f	9:30	10:50
064ccaa6-9b83-430a-8ff9-aa28f8b8fe5d	Mechanics	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	be9023b9-1aac-4fa4-8ec5-62fee2494828	595dadd7-e8bf-4b70-bb5e-210cc5741654	Thursday	t	f	12:50	14:10
44d008fa-5a07-4bfa-8911-2dd4985e4559	Probability Theory	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	afc0cef3-7f18-4149-80bb-470271a13896	58be6994-171f-4d5b-980d-3a5db738c0e5	Thursday	f	f	9:30	10:50
279ed74d-141a-43de-bd4c-fd454bb0dfdd	Mathematical Equations	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	be9023b9-1aac-4fa4-8ec5-62fee2494828	595dadd7-e8bf-4b70-bb5e-210cc5741654	Thursday	t	f	9:30	10:50
7f00af22-487a-457a-a282-72203c775185	Probability Theory	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	afc0cef3-7f18-4149-80bb-470271a13896	58be6994-171f-4d5b-980d-3a5db738c0e5	Thursday	t	f	9:30	10:50
4a741642-8e3f-4f9c-b31e-177757a5a373	Complex Analysis	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	e0624d4f-451b-45b1-82ab-cd79739033ab	595dadd7-e8bf-4b70-bb5e-210cc5741654	Thursday	f	f	11:00	12:20
798ebb4e-4ed7-4adf-bd88-e3752c6b9ade	Mathematical Equations	f9b278e9-ac19-49df-8dc3-db0f16910919	247d37b0-fe3c-4357-9936-680945e443b2	be9023b9-1aac-4fa4-8ec5-62fee2494828	58be6994-171f-4d5b-980d-3a5db738c0e5	Thursday	f	f	11:00	12:20
113399c8-d118-4395-a11b-c74239dfa4f0	Complex Analysis	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	e0624d4f-451b-45b1-82ab-cd79739033ab	595dadd7-e8bf-4b70-bb5e-210cc5741654	Thursday	t	f	11:00	12:20
dd1c2323-f9c7-4cdb-9363-af70e9e703ba	Mathematical Equations	f9b278e9-ac19-49df-8dc3-db0f16910919	247d37b0-fe3c-4357-9936-680945e443b2	be9023b9-1aac-4fa4-8ec5-62fee2494828	58be6994-171f-4d5b-980d-3a5db738c0e5	Thursday	t	f	11:00	12:20
7bbf7983-e37b-4983-ab9a-c26142621133	Probability Theory	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	afc0cef3-7f18-4149-80bb-470271a13896	595dadd7-e8bf-4b70-bb5e-210cc5741654	Friday	t	t	9:30	10:50
d352f271-2e40-46dd-b33c-4bea8b5b9196	Philosophy	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	e5396190-6d6a-413e-a966-6ef463e0bb5a	58be6994-171f-4d5b-980d-3a5db738c0e5	Friday	t	t	11:00	12:20
d7d4fad3-f102-41c1-a748-7322a20cb7aa	Philosophy	f9b278e9-ac19-49df-8dc3-db0f16910919	247d37b0-fe3c-4357-9936-680945e443b2	e5396190-6d6a-413e-a966-6ef463e0bb5a	595dadd7-e8bf-4b70-bb5e-210cc5741654	Friday	t	f	12:50	14:10
832ba71f-e1a0-4a4a-8be8-768fd4f2bc36	Web Development	1706588e-3c37-40e7-9c59-541f18a62935	247d37b0-fe3c-4357-9936-680945e443b2	9a6312ca-ccae-4bc3-89ea-746cf2bec417	58be6994-171f-4d5b-980d-3a5db738c0e5	Friday	t	t	14:20	15:40
ba38e34d-e303-431e-aa44-fa1b3df649c1	Mathematical Equations	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	be9023b9-1aac-4fa4-8ec5-62fee2494828	a743e7d3-2859-4215-a5f9-757d153576e4	Friday	f	f	11:00	12:20
95c586c1-9bad-4995-a064-e066321909d7	Web Development	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	9a6312ca-ccae-4bc3-89ea-746cf2bec417	a743e7d3-2859-4215-a5f9-757d153576e4	Thursday	f	f	12:50	14:10
40e57c99-362a-43ff-9fcd-e74811ea3a8b	Complex Analysis	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	e0624d4f-451b-45b1-82ab-cd79739033ab	595dadd7-e8bf-4b70-bb5e-210cc5741654	Friday	f	f	11:00	12:20
36dd1bee-8972-4cd3-bc2c-7fcd5f88847c	Complex Analysis	6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	e0624d4f-451b-45b1-82ab-cd79739033ab	58be6994-171f-4d5b-980d-3a5db738c0e5	Friday	f	f	12:50	14:10
6a0fe3da-3e83-4b92-9c98-728a735fc06a	Mathematical Equations	62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	be9023b9-1aac-4fa4-8ec5-62fee2494828	595dadd7-e8bf-4b70-bb5e-210cc5741654	Friday	f	f	12:50	14:10
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (uuid, room_uuid, building_uuid, name) FROM stdin;
40e37722-fb94-4b2e-8301-5ceec7d6b2ae	bdcf6c3e-73ea-45bd-a6ae-139908b43e2c	af4cc5c9-562b-45e1-af81-770d9f1c45e9	Informatics
c763a80e-974d-4745-a84f-d79ec12062e0	a2bdebdd-5f00-4b51-872a-9e424875edff	247d37b0-fe3c-4357-9936-680945e443b2	Mathematics
1004f62b-3662-4012-bfcd-2f6506a9ac81	2970b640-31df-46c6-90fd-eb569ab790a8	af4cc5c9-562b-45e1-af81-770d9f1c45e9	Programming and Algorithms
09d0ecb2-5bfb-4a33-8d73-e11f1bc3a5ac	f05fa02e-84de-4c9a-b314-321ee3e74134	56acd9a9-d4f6-4cd8-8485-bef43e4545b5	Philosophy
9c02c764-eca5-42b5-90d7-19df7fc1de16	96a80161-23d4-4eb2-a7bf-ccc9d1c1d2d3	d1f63fc8-96ff-48e6-ab6d-0376300d3658	Mechanics
\.


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."group" (uuid, name, major_uuid) FROM stdin;
595dadd7-e8bf-4b70-bb5e-210cc5741654	240-1	9de4b7ff-5d7c-47a2-9e6c-a0583af5a634
a743e7d3-2859-4215-a5f9-757d153576e4	240-2	9de4b7ff-5d7c-47a2-9e6c-a0583af5a634
58be6994-171f-4d5b-980d-3a5db738c0e5	240-3	9de4b7ff-5d7c-47a2-9e6c-a0583af5a634
\.


--
-- Data for Name: major; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.major (uuid, name) FROM stdin;
9de4b7ff-5d7c-47a2-9e6c-a0583af5a634	Applied Mathematics and Informatics
a42acab2-bec5-410f-aa79-a34417d9249a	Cyber Security
001688ff-d013-4044-98b6-c146b09c7606	Artificial Inteligence
672838b0-5a38-4b2c-b678-3667818bc882	Programming Architecture
\.


--
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (uuid, building_uuid, name) FROM stdin;
0945b54e-9922-4dd2-bc72-24e0bcffcf7c	247d37b0-fe3c-4357-9936-680945e443b2	208
f177b4e7-4ffb-4b3d-9d06-02b708e9e706	af4cc5c9-562b-45e1-af81-770d9f1c45e9	106
a4e5d3a0-8270-4d7e-bd41-60a169363d45	af4cc5c9-562b-45e1-af81-770d9f1c45e9	119
271582ff-32ba-4769-bacb-d30a81527740	af4cc5c9-562b-45e1-af81-770d9f1c45e9	105
a4085980-4af7-455d-99ea-976cfd745142	247d37b0-fe3c-4357-9936-680945e443b2	105
6e7d1057-247d-408b-bf0b-bec6246819cc	247d37b0-fe3c-4357-9936-680945e443b2	103
f9b278e9-ac19-49df-8dc3-db0f16910919	247d37b0-fe3c-4357-9936-680945e443b2	102
1706588e-3c37-40e7-9c59-541f18a62935	247d37b0-fe3c-4357-9936-680945e443b2	101
65844a7e-401a-4646-9abd-7c10917925cb	af4cc5c9-562b-45e1-af81-770d9f1c45e9	120
98877d4e-0c1a-479c-bf45-276bf3564e79	247d37b0-fe3c-4357-9936-680945e443b2	305
9f1dd809-c6de-4917-9741-818762058541	d1f63fc8-96ff-48e6-ab6d-0376300d3658	205
96a80161-23d4-4eb2-a7bf-ccc9d1c1d2d3	d1f63fc8-96ff-48e6-ab6d-0376300d3658	112
bdcf6c3e-73ea-45bd-a6ae-139908b43e2c	d1f63fc8-96ff-48e6-ab6d-0376300d3658	108
2c38608d-ec6c-4db5-a8fb-d628958eb761	247d37b0-fe3c-4357-9936-680945e443b2	208
62ab9290-6a20-4b64-8f65-b2ffe47d18c7	247d37b0-fe3c-4357-9936-680945e443b2	201
f05fa02e-84de-4c9a-b314-321ee3e74134	56acd9a9-d4f6-4cd8-8485-bef43e4545b5	401
56f8576d-1ad9-447d-ab77-7cc33a248692	af4cc5c9-562b-45e1-af81-770d9f1c45e9	108
a2bdebdd-5f00-4b51-872a-9e424875edff	247d37b0-fe3c-4357-9936-680945e443b2	209
2970b640-31df-46c6-90fd-eb569ab790a8	af4cc5c9-562b-45e1-af81-770d9f1c45e9	905
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (uuid, first_name, last_name, email, group_uuid) FROM stdin;
d1aeb999-1876-42c1-ac02-cef7144a26e8	Arsen	Grigoryan	arsen.grigoryan555@gmail.com	a743e7d3-2859-4215-a5f9-757d153576e4
eef0fa4f-1435-4bf4-878e-46580cfbee17	Niko	Isaxanyan	niko.isaxanyan@gmail.com	58be6994-171f-4d5b-980d-3a5db738c0e5
\.


--
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher (uuid, first_name, last_name, department_uuid) FROM stdin;
e0624d4f-451b-45b1-82ab-cd79739033ab	S	Episkoposyan	c763a80e-974d-4745-a84f-d79ec12062e0
c6e5164a-d558-495a-9127-89fe349d9d66	N	Sahakyan	40e37722-fb94-4b2e-8301-5ceec7d6b2ae
be9023b9-1aac-4fa4-8ec5-62fee2494828	S	Hayrapetyan	c763a80e-974d-4745-a84f-d79ec12062e0
18b81a42-ba43-4343-b31f-ec33b18fdc4a	N	Badalyan	c763a80e-974d-4745-a84f-d79ec12062e0
a73beb9b-89a9-470f-a7e8-a1791c5ba112	V	Saroyan	9c02c764-eca5-42b5-90d7-19df7fc1de16
afc0cef3-7f18-4149-80bb-470271a13896	P	Hakobyan	c763a80e-974d-4745-a84f-d79ec12062e0
d060d9fd-63de-4570-95f5-d188212e79a3	J	Srapionyan	c763a80e-974d-4745-a84f-d79ec12062e0
9a6312ca-ccae-4bc3-89ea-746cf2bec417	G	Zaprosyan	1004f62b-3662-4012-bfcd-2f6506a9ac81
6100f3fc-f24c-4166-afd1-f86035a0ef88	S	Meliqyan	1004f62b-3662-4012-bfcd-2f6506a9ac81
58135a9c-94df-4264-9038-04ce9fca70d2	I	Saghatelyan	1004f62b-3662-4012-bfcd-2f6506a9ac81
e5396190-6d6a-413e-a966-6ef463e0bb5a	N	Baxdasaryan	09d0ecb2-5bfb-4a33-8d73-e11f1bc3a5ac
\.


--
-- Name: building building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (uuid);


--
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (uuid);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (uuid);


--
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (uuid);


--
-- Name: major major_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_pkey PRIMARY KEY (uuid);


--
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (uuid);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (uuid);


--
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (uuid);


--
-- Name: course course_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- Name: course course_group_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_group_uuid_fkey FOREIGN KEY (group_uuid) REFERENCES public."group"(uuid);


--
-- Name: course course_room_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_room_uuid_fkey FOREIGN KEY (room_uuid) REFERENCES public.room(uuid);


--
-- Name: course course_teacher_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_teacher_uuid_fkey FOREIGN KEY (teacher_uuid) REFERENCES public.teacher(uuid);


--
-- Name: department department_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- Name: department department_room_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_room_uuid_fkey FOREIGN KEY (room_uuid) REFERENCES public.room(uuid);


--
-- Name: group group_major_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_major_uuid_fkey FOREIGN KEY (major_uuid) REFERENCES public.major(uuid);


--
-- Name: room room_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- Name: student student_group_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_group_uuid_fkey FOREIGN KEY (group_uuid) REFERENCES public."group"(uuid);


--
-- Name: teacher teacher_department_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_department_uuid_fkey FOREIGN KEY (department_uuid) REFERENCES public.department(uuid);


--
-- PostgreSQL database dump complete
--

