--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-09-09 22:11:47

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
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 33510)
-- Name: building; Type: TABLE; Schema: public; Owner: postgres
--

DROP TABLE IF EXISTS building CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS "group" CASCADE;
DROP TABLE IF EXISTS major CASCADE;
DROP TABLE IF EXISTS room CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS teacher CASCADE;


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
-- TOC entry 223 (class 1259 OID 33582)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    uuid uuid NOT NULL,
    name_en character varying NOT NULL,
    name_hy character varying NOT NULL,
    name_ru character varying NOT NULL,
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
-- TOC entry 221 (class 1259 OID 33553)
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
-- TOC entry 218 (class 1259 OID 33517)
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."group" (
    uuid uuid NOT NULL,
    name character varying NOT NULL,
    major_uuid uuid
);


ALTER TABLE public."group" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 33503)
-- Name: major; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.major (
    uuid uuid NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.major OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33529)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    uuid uuid NOT NULL,
    building_uuid uuid,
    name character varying NOT NULL
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 33541)
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
-- TOC entry 222 (class 1259 OID 33570)
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher (
    uuid uuid NOT NULL,
    first_name_en character varying NOT NULL,
    last_name_en character varying NOT NULL,
    first_name_hy character varying NOT NULL,
    last_name_hy character varying NOT NULL,
    first_name_ru character varying NOT NULL,
    last_name_ru character varying NOT NULL,
    department_uuid uuid
);


ALTER TABLE public.teacher OWNER TO postgres;

--
-- TOC entry 4886 (class 0 OID 33510)
-- Dependencies: 217
-- Data for Name: building; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building (uuid, country, city, street, longitude, latitude, name) FROM stdin;
6cd58cc9-1507-4ca6-8f9a-e5b2ce630248	Armenia	Yerevan	Teryan 52	\N	\N	2
6244b087-0264-4cb9-a37e-eaf724c8c74c	Armenia	Yerevan	Teryan 52	\N	\N	5
f35683ca-0868-4fec-99a5-1d62db20a7e4	Armenia	Yerevan	Koryun 9	\N	\N	12
460dc98d-bac2-4b58-8aaa-42c83fa9aa41	Armenia	Yerevan	Koryun 11	\N	\N	9
\.


--
-- TOC entry 4892 (class 0 OID 33582)
-- Dependencies: 223
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (uuid, name_en, name_hy, name_ru, room_uuid, building_uuid, teacher_uuid, group_uuid, day_of_week, is_odd, is_lecture, start_time, end_time) FROM stdin;
b9b15a00-fb33-4f98-bab4-b1c3ab8bb553	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	bf810a4b-0907-4ea9-97f3-e77b87142a53	f35683ca-0868-4fec-99a5-1d62db20a7e4	375e3d31-2049-4630-a7f0-a7851bdcd0a3	bd0857d8-2532-4fcc-a2fb-024b4d0cc40e	Monday	t	f	9:30	10:50
2991f769-0304-4424-b379-2f81c3ab83c0	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	21552455-0272-4eef-8387-6fb134893ebf	f35683ca-0868-4fec-99a5-1d62db20a7e4	27983696-3728-4459-98aa-05257e0824e2	b3689d2f-7579-46e7-bcc9-104d9a732204	Monday	t	f	9:30	10:50
522553b5-ad2a-40d8-8da7-7a18e26bb400	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	7be2c817-540f-4e7d-9dd7-8a8082bb7b79	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Monday	t	f	9:30	10:50
c504f9cd-440f-432c-89b6-0d5c0e057bc6	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	880e7823-5fbe-4564-af41-90a9704d0c6b	f35683ca-0868-4fec-99a5-1d62db20a7e4	375e3d31-2049-4630-a7f0-a7851bdcd0a3	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Monday	t	t	11:00	12:20
8374578c-43d5-469d-af3f-2961168371d2	Coding Theory - Course Work	Կոդավորման Տեսություն - Կուրսային	Теория кодирования - Курсовая	bf810a4b-0907-4ea9-97f3-e77b87142a53	f35683ca-0868-4fec-99a5-1d62db20a7e4	375e3d31-2049-4630-a7f0-a7851bdcd0a3	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Monday	t	t	14:20	15:40
c9513ac2-511a-4c4e-bf5b-3affcf79519d	Coding Theory - Course Work	Կոդավորման Տեսություն - Կուրսային	Теория кодирования - Курсовая	bf810a4b-0907-4ea9-97f3-e77b87142a53	f35683ca-0868-4fec-99a5-1d62db20a7e4	375e3d31-2049-4630-a7f0-a7851bdcd0a3	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Monday	f	t	14:20	15:40
ffe3f7d7-6219-4a95-8cd7-ff590ec2fb66	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	bf810a4b-0907-4ea9-97f3-e77b87142a53	f35683ca-0868-4fec-99a5-1d62db20a7e4	375e3d31-2049-4630-a7f0-a7851bdcd0a3	bd0857d8-2532-4fcc-a2fb-024b4d0cc40e	Monday	f	f	9:30	10:50
c1aefe74-bcbb-44f3-89e4-bc3070d36e1d	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	21552455-0272-4eef-8387-6fb134893ebf	f35683ca-0868-4fec-99a5-1d62db20a7e4	27983696-3728-4459-98aa-05257e0824e2	b3689d2f-7579-46e7-bcc9-104d9a732204	Monday	f	f	9:30	10:50
69aee5aa-2fa4-4a19-89d4-8ec463615b43	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	880e7823-5fbe-4564-af41-90a9704d0c6b	f35683ca-0868-4fec-99a5-1d62db20a7e4	27983696-3728-4459-98aa-05257e0824e2	b3689d2f-7579-46e7-bcc9-104d9a732204	Monday	f	t	11:00	12:20
24297f0b-de91-46f5-a66a-ba28b7156595	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	016fc3fa-ded7-41c6-9538-4f3327ef3b5c	b3689d2f-7579-46e7-bcc9-104d9a732204	Tuesday	f	t	11:00	12:20
8ddd821c-241b-4636-bbf6-01316b0ed682	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	016fc3fa-ded7-41c6-9538-4f3327ef3b5c	b3689d2f-7579-46e7-bcc9-104d9a732204	Tuesday	t	t	11:00	12:20
b68ab6ff-20b9-41bc-8ca1-6dbd31cb1f57	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	2531db5d-2874-4f1f-a7e2-f876d76eb09f	b3689d2f-7579-46e7-bcc9-104d9a732204	Wednesday	f	t	11:00	12:20
901b1a58-a637-4a15-8bd2-9ca04994ede4	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	2531db5d-2874-4f1f-a7e2-f876d76eb09f	b3689d2f-7579-46e7-bcc9-104d9a732204	Wednesday	t	t	11:00	12:20
737ee8e6-a031-43b5-b4c9-09926b6d8586	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	373b8c18-704c-49da-bafe-dea7966d6250	b3689d2f-7579-46e7-bcc9-104d9a732204	Wednesday	f	t	12:50	14:10
cab2dc71-941a-4fa8-b8ce-89d1746abd11	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	373b8c18-704c-49da-bafe-dea7966d6250	b3689d2f-7579-46e7-bcc9-104d9a732204	Wednesday	t	t	12:50	14:10
f51906d7-7c40-40be-ac89-53dea1e21214	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	ead6fd49-3a28-41b3-9dd1-5e38f9bfd41b	f35683ca-0868-4fec-99a5-1d62db20a7e4	7be2c817-540f-4e7d-9dd7-8a8082bb7b79	b3689d2f-7579-46e7-bcc9-104d9a732204	Wednesday	t	t	14:20	15:40
17c7b022-f68f-4c28-a552-e5949119f6e7	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	ead6fd49-3a28-41b3-9dd1-5e38f9bfd41b	f35683ca-0868-4fec-99a5-1d62db20a7e4	7be2c817-540f-4e7d-9dd7-8a8082bb7b79	b3689d2f-7579-46e7-bcc9-104d9a732204	Wednesday	f	t	14:20	15:40
94e9d385-b351-49d4-9bdb-9fbe429bafcb	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	ac0828fe-8489-469b-b9e4-b06da7e02472	f35683ca-0868-4fec-99a5-1d62db20a7e4	375e3d31-2049-4630-a7f0-a7851bdcd0a3	b3689d2f-7579-46e7-bcc9-104d9a732204	Thursday	t	f	9:30	10:50
b5a2fb09-3a82-4ce0-9cd1-87cd269e83db	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	ac0828fe-8489-469b-b9e4-b06da7e02472	f35683ca-0868-4fec-99a5-1d62db20a7e4	375e3d31-2049-4630-a7f0-a7851bdcd0a3	b3689d2f-7579-46e7-bcc9-104d9a732204	Thursday	f	f	9:30	10:50
3a9b0f61-73be-464a-9b44-04e9f0c0ccee	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	37275fbf-c86f-4030-be34-9f495164bd1f	f35683ca-0868-4fec-99a5-1d62db20a7e4	a5805cf6-4d43-4d6b-9d50-2d4784a22837	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Thursday	t	f	9:30	10:50
72409d04-8b7f-48f2-b2be-3acdb187a6d7	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	37275fbf-c86f-4030-be34-9f495164bd1f	f35683ca-0868-4fec-99a5-1d62db20a7e4	a5805cf6-4d43-4d6b-9d50-2d4784a22837	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Thursday	f	f	9:30	10:50
02d70d81-ca22-41ae-983b-1d3a3566ad32	Computer Architecture - Course Work	ԷՀՄ  Ճարտարագիտություն - Կուրսային	ЭВМ Архитектура - Курсовая	ac0828fe-8489-469b-b9e4-b06da7e02472	f35683ca-0868-4fec-99a5-1d62db20a7e4	27983696-3728-4459-98aa-05257e0824e2	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Thursday	t	t	11:00	12:20
5bfb5190-7024-4dcd-953a-907f45dd971b	Computer Architecture - Course Work	ԷՀՄ  Ճարտարագիտություն - Կուրսային	ЭВМ Архитектура - Курсовая	ac0828fe-8489-469b-b9e4-b06da7e02472	f35683ca-0868-4fec-99a5-1d62db20a7e4	27983696-3728-4459-98aa-05257e0824e2	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Thursday	f	t	11:00	12:20
2c3b4a98-793d-40c4-987b-869d43ceac87	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	bf810a4b-0907-4ea9-97f3-e77b87142a53	f35683ca-0868-4fec-99a5-1d62db20a7e4	375e3d31-2049-4630-a7f0-a7851bdcd0a3	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Thursday	t	f	14:20	15:40
104a48b2-9c4d-46de-b7c7-60ad710016a0	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	7be2c817-540f-4e7d-9dd7-8a8082bb7b79	b3689d2f-7579-46e7-bcc9-104d9a732204	Thursday	t	f	14:20	15:40
02f2cb73-7916-4dda-b811-db8f9dda97d7	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	bf810a4b-0907-4ea9-97f3-e77b87142a53	f35683ca-0868-4fec-99a5-1d62db20a7e4	375e3d31-2049-4630-a7f0-a7851bdcd0a3	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Thursday	f	f	14:20	15:40
1b3fa6ba-c066-4ffb-9644-417218ab5b0a	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	7be2c817-540f-4e7d-9dd7-8a8082bb7b79	bd0857d8-2532-4fcc-a2fb-024b4d0cc40e	Thursday	f	f	14:20	15:40
e6883122-a069-403a-920e-ee7cda430c3b	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	880e7823-5fbe-4564-af41-90a9704d0c6b	f35683ca-0868-4fec-99a5-1d62db20a7e4	a5805cf6-4d43-4d6b-9d50-2d4784a22837	bd0857d8-2532-4fcc-a2fb-024b4d0cc40e	Friday	t	t	9:30	10:50
242d6b55-4614-4df2-bc55-4f0a473d3ee8	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	37275fbf-c86f-4030-be34-9f495164bd1f	f35683ca-0868-4fec-99a5-1d62db20a7e4	a5805cf6-4d43-4d6b-9d50-2d4784a22837	bd0857d8-2532-4fcc-a2fb-024b4d0cc40e	Friday	t	f	11:00	12:20
8c433688-c474-4dd5-9fc4-a5656b54a7d1	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	37275fbf-c86f-4030-be34-9f495164bd1f	f35683ca-0868-4fec-99a5-1d62db20a7e4	a5805cf6-4d43-4d6b-9d50-2d4784a22837	bd0857d8-2532-4fcc-a2fb-024b4d0cc40e	Friday	f	f	11:00	12:20
b12eac1a-a397-4d2a-9b6f-e0bdc2430b78	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	21552455-0272-4eef-8387-6fb134893ebf	f35683ca-0868-4fec-99a5-1d62db20a7e4	27983696-3728-4459-98aa-05257e0824e2	bd0857d8-2532-4fcc-a2fb-024b4d0cc40e	Friday	t	f	12:50	14:10
1aaf983a-6e3c-45cc-9ba4-4b28e0fdf040	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	21552455-0272-4eef-8387-6fb134893ebf	f35683ca-0868-4fec-99a5-1d62db20a7e4	27983696-3728-4459-98aa-05257e0824e2	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Friday	t	f	12:50	14:10
a9c8c691-ec74-43f6-9908-993e90b558fb	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	21552455-0272-4eef-8387-6fb134893ebf	f35683ca-0868-4fec-99a5-1d62db20a7e4	27983696-3728-4459-98aa-05257e0824e2	bd0857d8-2532-4fcc-a2fb-024b4d0cc40e	Friday	f	f	12:50	14:10
77ad8075-2e5f-46b4-a4ef-50c7789d6b92	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	21552455-0272-4eef-8387-6fb134893ebf	f35683ca-0868-4fec-99a5-1d62db20a7e4	27983696-3728-4459-98aa-05257e0824e2	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	Friday	f	f	12:50	14:10
\.


--
-- TOC entry 4890 (class 0 OID 33553)
-- Dependencies: 221
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (uuid, room_uuid, building_uuid, name) FROM stdin;
964f537f-1644-4e74-bca4-c31f5c6db698	f036ad1e-cdee-4da5-a0f3-79214db590b6	6244b087-0264-4cb9-a37e-eaf724c8c74c	Informatics
1235fbe9-13ee-48f7-999e-6d195e1ae086	ae5c9174-42f4-4fa9-b382-2b5176fe06db	f35683ca-0868-4fec-99a5-1d62db20a7e4	Mathematics
856940d2-f2a8-460a-9e85-7f85edd67c23	93ed3bb2-0dad-4123-9b6d-657ba4d9f016	6244b087-0264-4cb9-a37e-eaf724c8c74c	Programming and Algorithms
96e404fa-9b36-4820-8d9a-1962b86efd9b	e537501c-2799-4640-a384-3ad3d406e881	6cd58cc9-1507-4ca6-8f9a-e5b2ce630248	Philosophy
5d284150-b98e-4af0-9e54-780c18074d8c	bd93ab67-532a-47c9-ab8a-bec784434a50	460dc98d-bac2-4b58-8aaa-42c83fa9aa41	Mechanics
\.


--
-- TOC entry 4887 (class 0 OID 33517)
-- Dependencies: 218
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."group" (uuid, name, major_uuid) FROM stdin;
bd0857d8-2532-4fcc-a2fb-024b4d0cc40e	240-1	ed7e01bc-8bbd-4001-aa88-e7a3599ff299
cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a	240-2	ed7e01bc-8bbd-4001-aa88-e7a3599ff299
b3689d2f-7579-46e7-bcc9-104d9a732204	240-3	ed7e01bc-8bbd-4001-aa88-e7a3599ff299
\.


--
-- TOC entry 4885 (class 0 OID 33503)
-- Dependencies: 216
-- Data for Name: major; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.major (uuid, name) FROM stdin;
ed7e01bc-8bbd-4001-aa88-e7a3599ff299	Applied Mathematics and Informatics
f59f62a3-3abe-41c8-8141-d6b035ddb764	Cyber Security
18cfdc20-5511-4ba6-955e-bf352f34065b	Artificial Inteligence
75005f20-6f1a-488b-9ede-02550d626177	Programming Architecture
\.


--
-- TOC entry 4888 (class 0 OID 33529)
-- Dependencies: 219
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (uuid, building_uuid, name) FROM stdin;
880e7823-5fbe-4564-af41-90a9704d0c6b	f35683ca-0868-4fec-99a5-1d62db20a7e4	208
d33cb4e5-782d-4e14-ba27-84e9b2c989e5	6244b087-0264-4cb9-a37e-eaf724c8c74c	106
7e4c8151-ace8-4908-9a7e-473f86545df7	6244b087-0264-4cb9-a37e-eaf724c8c74c	119
37275fbf-c86f-4030-be34-9f495164bd1f	6244b087-0264-4cb9-a37e-eaf724c8c74c	105
985da360-b341-4734-a910-39bd51e40671	f35683ca-0868-4fec-99a5-1d62db20a7e4	105
0a86cd46-f573-49ee-9589-e5957c3e451e	f35683ca-0868-4fec-99a5-1d62db20a7e4	103
21552455-0272-4eef-8387-6fb134893ebf	f35683ca-0868-4fec-99a5-1d62db20a7e4	102
ac0828fe-8489-469b-b9e4-b06da7e02472	f35683ca-0868-4fec-99a5-1d62db20a7e4	101
768b730e-fb4b-4bd1-9e35-c8696fb06da2	6244b087-0264-4cb9-a37e-eaf724c8c74c	120
ead6fd49-3a28-41b3-9dd1-5e38f9bfd41b	f35683ca-0868-4fec-99a5-1d62db20a7e4	305
9e3cc2b7-17da-4a81-beb3-6ba98f3dde9b	460dc98d-bac2-4b58-8aaa-42c83fa9aa41	205
bd93ab67-532a-47c9-ab8a-bec784434a50	460dc98d-bac2-4b58-8aaa-42c83fa9aa41	112
f036ad1e-cdee-4da5-a0f3-79214db590b6	460dc98d-bac2-4b58-8aaa-42c83fa9aa41	108
d675bce5-1e63-4881-a98d-e1f8742ee42b	f35683ca-0868-4fec-99a5-1d62db20a7e4	201
e537501c-2799-4640-a384-3ad3d406e881	6cd58cc9-1507-4ca6-8f9a-e5b2ce630248	401
279546b2-469c-4524-adda-2d7698a7db96	6244b087-0264-4cb9-a37e-eaf724c8c74c	108
ae5c9174-42f4-4fa9-b382-2b5176fe06db	f35683ca-0868-4fec-99a5-1d62db20a7e4	209
bf810a4b-0907-4ea9-97f3-e77b87142a53	f35683ca-0868-4fec-99a5-1d62db20a7e4	206
93ed3bb2-0dad-4123-9b6d-657ba4d9f016	6244b087-0264-4cb9-a37e-eaf724c8c74c	905
\.


--
-- TOC entry 4889 (class 0 OID 33541)
-- Dependencies: 220
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (uuid, first_name, last_name, email, group_uuid) FROM stdin;
b888211f-a607-4ce3-b9d8-f104d6b6d299	Arsen	Grigoryan	arsen.grigoryan555@gmail.com	cca8d0cb-2d1d-4fd5-b1c1-a49ce2f4c77a
f7b1bdb0-6fa9-493e-b3f9-6a7d85c2873a	Niko	Isaxanyan	niko.isaxanyan@gmail.com	b3689d2f-7579-46e7-bcc9-104d9a732204
\.


--
-- TOC entry 4891 (class 0 OID 33570)
-- Dependencies: 222
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher (uuid, first_name_en, last_name_en, first_name_hy, last_name_hy, first_name_ru, last_name_ru, department_uuid) FROM stdin;
8584569a-241e-45bb-9be9-92af9c503ced	S	Episkoposyan	Ս	Եպիսկոպոսյան	С	Епископосян	1235fbe9-13ee-48f7-999e-6d195e1ae086
fb1d589d-c136-4165-aaee-c3bd7aa4fc0f	N	Sahakyan	Ն	Սահակյան	Н	Саакян	964f537f-1644-4e74-bca4-c31f5c6db698
7be2c817-540f-4e7d-9dd7-8a8082bb7b79	S	Hayrapetyan	Ս	Հայրապետյան	С	Гайрапетян	1235fbe9-13ee-48f7-999e-6d195e1ae086
373b8c18-704c-49da-bafe-dea7966d6250	N	Badalyan	Ն	Բադալան	Н	Бадалян	1235fbe9-13ee-48f7-999e-6d195e1ae086
1e4b058c-538c-44df-baae-dc691aa4aa6a	V	Saroyan	Վ	Սարոյան	В	Сароян	5d284150-b98e-4af0-9e54-780c18074d8c
a5805cf6-4d43-4d6b-9d50-2d4784a22837	P	Hakobyan	Պ	Հակոբյան	П	Хакопян	1235fbe9-13ee-48f7-999e-6d195e1ae086
2840bc6e-a3d8-440c-b590-ad6f8b9c221d	J	Srapionyan	Ջ	Սրապիոնյան	Д	Срапионян	1235fbe9-13ee-48f7-999e-6d195e1ae086
016fc3fa-ded7-41c6-9538-4f3327ef3b5c	G	Zaprosyan	Գ	Զապրոսյան	Г	Запросян	856940d2-f2a8-460a-9e85-7f85edd67c23
d685e542-57e2-4f45-88ed-241f19c8f24f	S	Meliqyan	Ս	Մելիքյան	С	Меликян	856940d2-f2a8-460a-9e85-7f85edd67c23
96869ce1-b2e4-4662-8aa4-5b116262d7fc	I	Saghatelyan	Ի	Սաղաթելայան	И	Сахателян	856940d2-f2a8-460a-9e85-7f85edd67c23
eeef61ae-a4a6-4b3d-b46a-57ae6b9912c3	N	Baxdasaryan	Ն	Բաղդասարյան	Н	Бахдасарян	96e404fa-9b36-4820-8d9a-1962b86efd9b
375e3d31-2049-4630-a7f0-a7851bdcd0a3	S	Khachatryan	Ս	Խաչատրյան	С	Хачатрян	1235fbe9-13ee-48f7-999e-6d195e1ae086
27983696-3728-4459-98aa-05257e0824e2	M	Haykazyan	Մ	Հայկազյան	М	Хайказян	1235fbe9-13ee-48f7-999e-6d195e1ae086
2531db5d-2874-4f1f-a7e2-f876d76eb09f	I	Hovhannisyan	Ի	Հովհաննիսյան	И	Оганисян	1235fbe9-13ee-48f7-999e-6d195e1ae086
\.


--
-- TOC entry 4719 (class 2606 OID 33516)
-- Name: building building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4731 (class 2606 OID 33588)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4727 (class 2606 OID 33559)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4721 (class 2606 OID 33523)
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4717 (class 2606 OID 33509)
-- Name: major major_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4723 (class 2606 OID 33535)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4725 (class 2606 OID 33547)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4729 (class 2606 OID 33576)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4738 (class 2606 OID 33594)
-- Name: course course_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- TOC entry 4739 (class 2606 OID 33604)
-- Name: course course_group_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_group_uuid_fkey FOREIGN KEY (group_uuid) REFERENCES public."group"(uuid);


--
-- TOC entry 4740 (class 2606 OID 33589)
-- Name: course course_room_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_room_uuid_fkey FOREIGN KEY (room_uuid) REFERENCES public.room(uuid);


--
-- TOC entry 4741 (class 2606 OID 33599)
-- Name: course course_teacher_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_teacher_uuid_fkey FOREIGN KEY (teacher_uuid) REFERENCES public.teacher(uuid);


--
-- TOC entry 4735 (class 2606 OID 33565)
-- Name: department department_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- TOC entry 4736 (class 2606 OID 33560)
-- Name: department department_room_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_room_uuid_fkey FOREIGN KEY (room_uuid) REFERENCES public.room(uuid);


--
-- TOC entry 4732 (class 2606 OID 33524)
-- Name: group group_major_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_major_uuid_fkey FOREIGN KEY (major_uuid) REFERENCES public.major(uuid);


--
-- TOC entry 4733 (class 2606 OID 33536)
-- Name: room room_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- TOC entry 4734 (class 2606 OID 33548)
-- Name: student student_group_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_group_uuid_fkey FOREIGN KEY (group_uuid) REFERENCES public."group"(uuid);


--
-- TOC entry 4737 (class 2606 OID 33577)
-- Name: teacher teacher_department_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_department_uuid_fkey FOREIGN KEY (department_uuid) REFERENCES public.department(uuid);


-- Completed on 2024-09-09 22:11:47

--
-- PostgreSQL database dump complete
--

