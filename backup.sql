--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-10-01 02:54:53

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
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 33755)
-- Name: building; Type: TABLE; Schema: public; Owner: postgres
--
DROP TABLE IF EXISTS building CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS "group" CASCADE;
DROP TABLE IF EXISTS "lab" CASCADE;
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
-- TOC entry 224 (class 1259 OID 33839)
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
    lab_uuid uuid,
    type character varying NOT NULL,
    day_of_week character varying NOT NULL,
    is_odd boolean NOT NULL,
    start_time character varying NOT NULL,
    end_time character varying NOT NULL
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 33810)
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
-- TOC entry 218 (class 1259 OID 33762)
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."group" (
    uuid uuid NOT NULL,
    name character varying NOT NULL,
    major_uuid uuid
);


ALTER TABLE public."group" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33774)
-- Name: lab; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lab (
    uuid uuid NOT NULL,
    name character varying NOT NULL,
    major_uuid uuid
);


ALTER TABLE public.lab OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 33748)
-- Name: major; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.major (
    uuid uuid NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.major OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 33786)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    uuid uuid NOT NULL,
    building_uuid uuid,
    name character varying NOT NULL
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 33798)
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
-- TOC entry 223 (class 1259 OID 33827)
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
-- TOC entry 4894 (class 0 OID 33755)
-- Dependencies: 217
-- Data for Name: building; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building (uuid, country, city, street, longitude, latitude, name) FROM stdin;
a1a5dc14-79d7-48ce-baf8-2e8d2ea97394	Armenia	Yerevan	Teryan 52	\N	\N	2
f69e0d5c-8a58-443c-b4f2-a4ebdbd30582	Armenia	Yerevan	Teryan 52	\N	\N	5
8003aa6e-8411-4adc-a218-c9df6235a309	Armenia	Yerevan	Koryun 9	\N	\N	12
aee7c8ca-1ac8-4ef2-a33d-fe93b6cb7705	Armenia	Yerevan	Koryun 11	\N	\N	9
\.


--
-- TOC entry 4901 (class 0 OID 33839)
-- Dependencies: 224
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (uuid, name_en, name_hy, name_ru, room_uuid, building_uuid, teacher_uuid, group_uuid, lab_uuid, type, day_of_week, is_odd, start_time, end_time) FROM stdin;
b5a21599-a1f2-4c14-a7d9-17fe3bd29836	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	087b75d9-df4c-4e40-aad6-b474f6d3fa44	8003aa6e-8411-4adc-a218-c9df6235a309	bf3068ad-bfc7-419b-ae92-4e6930b44d2d	92cc84f2-3149-463e-8a87-7f47ca6fc7ad	\N	Practical	Monday	t	9:30	10:50
260e34e4-1898-47f5-af56-8b38c5e918df	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	6c380377-12e8-4de2-ae71-01e445da5a47	8003aa6e-8411-4adc-a218-c9df6235a309	bf3068ad-bfc7-419b-ae92-4e6930b44d2d	92cc84f2-3149-463e-8a87-7f47ca6fc7ad	\N	Practical	Monday	f	9:30	10:50
c2ddabda-bec4-4902-94f5-12dc388028b1	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	6c380377-12e8-4de2-ae71-01e445da5a47	8003aa6e-8411-4adc-a218-c9df6235a309	912d51e4-baba-4ace-8c07-dc0c8181f725	135cc20b-58af-447b-a25f-10201326c4ba	\N	Practical	Monday	t	9:30	10:50
75c4d026-0fc2-4398-a13f-b5e6cf706856	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	ec1e562b-64fa-4082-a2b0-9db5bd30816b	8003aa6e-8411-4adc-a218-c9df6235a309	6e157099-e7ea-4cca-97d5-86bf18fb6a7d	\N	\N	Lecture	Monday	t	11:00	12:20
21b6345c-27b4-4e39-b511-347ad5415543	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	1675d9ca-9f12-4c87-82d7-b018a9e1ac19	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	a023c56b-f9ed-41e2-a1d1-5bc754f81b2c	Laboratory	Monday	t	12:50	14:10
6836e516-4e81-411c-b08a-f495ac239ffe	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	1675d9ca-9f12-4c87-82d7-b018a9e1ac19	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	a023c56b-f9ed-41e2-a1d1-5bc754f81b2c	Laboratory	Monday	f	12:50	14:10
699614c2-9f94-44c8-b3d8-46166580d8b2	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	bc8799ae-cdfc-4197-bc25-2a400007c08b	8003aa6e-8411-4adc-a218-c9df6235a309	6e157099-e7ea-4cca-97d5-86bf18fb6a7d	\N	\N	CourseWork	Monday	t	14:20	15:40
6bdf986a-a2a2-46cf-a73a-4d4030e9416f	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	bc8799ae-cdfc-4197-bc25-2a400007c08b	8003aa6e-8411-4adc-a218-c9df6235a309	6e157099-e7ea-4cca-97d5-86bf18fb6a7d	\N	\N	CourseWork	Monday	f	14:20	15:40
01bc7ecb-0df0-4b38-8146-e6211018488a	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	ec1e562b-64fa-4082-a2b0-9db5bd30816b	8003aa6e-8411-4adc-a218-c9df6235a309	bf3068ad-bfc7-419b-ae92-4e6930b44d2d	\N	\N	Lecture	Monday	f	11:00	12:20
5841de71-1961-4d09-aa2f-744b2fe89836	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	6988a51d-209b-4d91-a99d-26fcdb74d0e4	\N	\N	Lecture	Tuesday	f	9:30	10:50
12dac70f-8ea2-4d05-a5cf-50ef8c093752	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	6988a51d-209b-4d91-a99d-26fcdb74d0e4	\N	\N	Lecture	Tuesday	t	9:30	10:50
d7a51d81-7c47-4cea-b70b-88884b269c82	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	087b75d9-df4c-4e40-aad6-b474f6d3fa44	8003aa6e-8411-4adc-a218-c9df6235a309	6e157099-e7ea-4cca-97d5-86bf18fb6a7d	92cc84f2-3149-463e-8a87-7f47ca6fc7ad	\N	Practical	Tuesday	t	11:00	12:20
9bb3899d-ce2f-43f2-8cae-3d9d1038273c	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	bc8799ae-cdfc-4197-bc25-2a400007c08b	8003aa6e-8411-4adc-a218-c9df6235a309	6988a51d-209b-4d91-a99d-26fcdb74d0e4	\N	a023c56b-f9ed-41e2-a1d1-5bc754f81b2c	Laboratory	Tuesday	t	11:00	12:20
5a5f8a3c-8544-483d-a3d5-b53f4ffd0d94	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	bc8799ae-cdfc-4197-bc25-2a400007c08b	8003aa6e-8411-4adc-a218-c9df6235a309	6988a51d-209b-4d91-a99d-26fcdb74d0e4	\N	a023c56b-f9ed-41e2-a1d1-5bc754f81b2c	Laboratory	Tuesday	f	11:00	12:20
a785aa13-38e2-42cd-b953-853fa16ce365	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	bc8799ae-cdfc-4197-bc25-2a400007c08b	8003aa6e-8411-4adc-a218-c9df6235a309	6988a51d-209b-4d91-a99d-26fcdb74d0e4	\N	4c906e13-dddb-451e-aef6-84b81ed0a55f	Laboratory	Tuesday	t	12:50	14:10
4a035a1e-4449-4379-81ef-c5dd472602c0	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	bc8799ae-cdfc-4197-bc25-2a400007c08b	8003aa6e-8411-4adc-a218-c9df6235a309	6988a51d-209b-4d91-a99d-26fcdb74d0e4	\N	4c906e13-dddb-451e-aef6-84b81ed0a55f	Laboratory	Tuesday	f	12:50	14:10
b20b9429-dd83-414c-9751-f5836bd6917d	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	bc8799ae-cdfc-4197-bc25-2a400007c08b	8003aa6e-8411-4adc-a218-c9df6235a309	6988a51d-209b-4d91-a99d-26fcdb74d0e4	\N	77e1157c-fd29-42c0-b614-d87fe09511a4	Laboratory	Tuesday	t	14:20	15:40
a20531b0-3718-4dd9-9d6c-f1668f50bb03	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	bc8799ae-cdfc-4197-bc25-2a400007c08b	8003aa6e-8411-4adc-a218-c9df6235a309	6988a51d-209b-4d91-a99d-26fcdb74d0e4	\N	77e1157c-fd29-42c0-b614-d87fe09511a4	Laboratory	Tuesday	f	14:20	15:40
b9c0bc70-c5cd-46df-be9a-0d01d7d4a2b7	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	77e1157c-fd29-42c0-b614-d87fe09511a4	Laboratory	Tuesday	f	12:50	14:10
360ccae8-443b-4d54-ac81-0c93ff56f210	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	77e1157c-fd29-42c0-b614-d87fe09511a4	Laboratory	Tuesday	t	12:50	14:10
4c962e64-ac95-47c0-8356-d0904e09adfc	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	5fecc709-26b8-4901-b275-483969a214ba	Laboratory	Tuesday	t	14:20	15:40
97addea0-3ad2-402e-8e2b-8996f4f98526	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	5fecc709-26b8-4901-b275-483969a214ba	Laboratory	Tuesday	f	14:20	15:40
d1209624-f1ab-42b2-9487-001a59e2fb9a	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	6c380377-12e8-4de2-ae71-01e445da5a47	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	5fecc709-26b8-4901-b275-483969a214ba	Laboratory	Tuesday	f	12:50	14:10
c7ff2776-4c00-4a86-b1ce-b344a42a3154	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	6c380377-12e8-4de2-ae71-01e445da5a47	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	5fecc709-26b8-4901-b275-483969a214ba	Laboratory	Tuesday	t	12:50	14:10
5dadef1e-b9ca-4636-bde9-7e0d438cff72	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	27aa3bd5-630a-4199-b649-4566dd683c53	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	4c906e13-dddb-451e-aef6-84b81ed0a55f	Laboratory	Tuesday	f	14:20	15:40
7eceb165-30b3-4527-8e87-1b43bfad1bf3	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	27aa3bd5-630a-4199-b649-4566dd683c53	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	4c906e13-dddb-451e-aef6-84b81ed0a55f	Laboratory	Tuesday	t	14:20	15:40
148b5047-8eaf-4a58-aca2-03778427a978	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	ec1e562b-64fa-4082-a2b0-9db5bd30816b	8003aa6e-8411-4adc-a218-c9df6235a309	2e510a4e-3b76-451c-a74f-07b539a15437	b872f8a1-8f50-4f0e-b824-0c9ee103b703	\N	Practical	Wednesday	t	9:30	10:50
6ad909d5-be0c-42ba-a2ad-d6deb679e68b	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	\N	Lecture	Wednesday	f	11:00	12:20
b8b1af1c-5e52-422c-8ce9-4a722eea591d	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	\N	Lecture	Wednesday	t	11:00	12:20
0e35b452-be90-4a0e-9180-c8f77bd690c9	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	\N	Lecture	Wednesday	f	12:50	14:10
df5be483-190a-4a11-a30c-f6b7d393517b	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	\N	Lecture	Wednesday	t	12:50	14:10
026a7cf3-9b70-41ed-ae2c-0b352bd8c2df	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	912d51e4-baba-4ace-8c07-dc0c8181f725	\N	\N	Lecture	Wednesday	t	14:20	15:40
6b59ff7c-4ff5-4d6e-a5c5-43941957f2c2	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	912d51e4-baba-4ace-8c07-dc0c8181f725	\N	\N	Lecture	Wednesday	f	14:20	15:40
089cf6ad-78ad-4287-97a9-7b4415800f55	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	087b75d9-df4c-4e40-aad6-b474f6d3fa44	8003aa6e-8411-4adc-a218-c9df6235a309	6e157099-e7ea-4cca-97d5-86bf18fb6a7d	b872f8a1-8f50-4f0e-b824-0c9ee103b703	\N	Practical	Thursday	t	9:30	10:50
7324fba4-3963-4724-84d9-7f680c22c74d	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	087b75d9-df4c-4e40-aad6-b474f6d3fa44	8003aa6e-8411-4adc-a218-c9df6235a309	6e157099-e7ea-4cca-97d5-86bf18fb6a7d	b872f8a1-8f50-4f0e-b824-0c9ee103b703	\N	Practical	Thursday	f	9:30	10:50
1697d290-e437-4007-949c-db98fe2c6b20	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	ec1e562b-64fa-4082-a2b0-9db5bd30816b	8003aa6e-8411-4adc-a218-c9df6235a309	2e510a4e-3b76-451c-a74f-07b539a15437	135cc20b-58af-447b-a25f-10201326c4ba	\N	Practical	Thursday	t	9:30	10:50
530cfb98-1c9e-4b4a-bd2e-ceb500b10f29	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	27aa3bd5-630a-4199-b649-4566dd683c53	8003aa6e-8411-4adc-a218-c9df6235a309	2e510a4e-3b76-451c-a74f-07b539a15437	135cc20b-58af-447b-a25f-10201326c4ba	\N	Practical	Thursday	f	9:30	10:50
ecf868a6-6e59-4068-bf3a-3f1f7017ebc6	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	83a5fb28-fef9-4837-9d3e-fa0ff1e996fa	8003aa6e-8411-4adc-a218-c9df6235a309	bf3068ad-bfc7-419b-ae92-4e6930b44d2d	\N	\N	CourseWork	Thursday	t	11:00	12:20
bdc30ad0-a1d8-4ff4-9660-132124bf2bb4	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	83a5fb28-fef9-4837-9d3e-fa0ff1e996fa	8003aa6e-8411-4adc-a218-c9df6235a309	bf3068ad-bfc7-419b-ae92-4e6930b44d2d	\N	\N	CourseWork	Thursday	f	11:00	12:20
a0cc6cc8-b7c4-424d-afc7-272b7ef5a6f6	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	6e157099-e7ea-4cca-97d5-86bf18fb6a7d	135cc20b-58af-447b-a25f-10201326c4ba	\N	Practical	Thursday	t	14:20	15:40
b4027873-78cc-466d-9091-a118168e3c4c	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	1675d9ca-9f12-4c87-82d7-b018a9e1ac19	8003aa6e-8411-4adc-a218-c9df6235a309	912d51e4-baba-4ace-8c07-dc0c8181f725	92cc84f2-3149-463e-8a87-7f47ca6fc7ad	\N	Practical	Thursday	t	14:20	15:40
3986d010-fc51-4b9d-b7fd-9ab091bb68b5	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	6e157099-e7ea-4cca-97d5-86bf18fb6a7d	135cc20b-58af-447b-a25f-10201326c4ba	\N	Practical	Thursday	f	14:20	15:40
66d5db38-9149-455b-b0dd-aa010609183d	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	1675d9ca-9f12-4c87-82d7-b018a9e1ac19	8003aa6e-8411-4adc-a218-c9df6235a309	912d51e4-baba-4ace-8c07-dc0c8181f725	b872f8a1-8f50-4f0e-b824-0c9ee103b703	\N	Practical	Thursday	f	14:20	15:40
be458d1b-7681-492c-8c08-3e1d4b443cc6	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	5ea6b204-fdf5-483f-a6c7-5c7b6f740499	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	77e1157c-fd29-42c0-b614-d87fe09511a4	Laboratory	Thursday	t	12:50	14:10
c8a5a070-685e-41ec-939d-66cfec25d7ae	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	5ea6b204-fdf5-483f-a6c7-5c7b6f740499	8003aa6e-8411-4adc-a218-c9df6235a309	5588b7d4-4eea-4059-a444-f45a202df4ec	\N	77e1157c-fd29-42c0-b614-d87fe09511a4	Laboratory	Thursday	f	12:50	14:10
6dcda474-05ea-4390-9dde-8944d929f94d	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	4c906e13-dddb-451e-aef6-84b81ed0a55f	Laboratory	Thursday	t	12:50	14:10
47a48281-c8a1-4ba0-a5ce-96f6f64659b7	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	4c906e13-dddb-451e-aef6-84b81ed0a55f	Laboratory	Thursday	f	12:50	14:10
18cb7921-7845-4be4-8122-099dc6b988aa	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	ec1e562b-64fa-4082-a2b0-9db5bd30816b	8003aa6e-8411-4adc-a218-c9df6235a309	2e510a4e-3b76-451c-a74f-07b539a15437	\N	\N	Lecture	Friday	t	9:30	10:50
f9b069eb-3a73-495e-8095-585f9058c79b	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	a023c56b-f9ed-41e2-a1d1-5bc754f81b2c	Laboratory	Friday	t	11:00	12:20
0a0c5544-4026-4e45-92f9-34dcc6afe2b5	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	481b3111-46fd-4d00-ac75-d8b5ab366902	\N	a023c56b-f9ed-41e2-a1d1-5bc754f81b2c	Laboratory	Friday	f	11:00	12:20
f90ab304-535b-46c3-904d-1d0ded2760b3	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	27aa3bd5-630a-4199-b649-4566dd683c53	8003aa6e-8411-4adc-a218-c9df6235a309	2e510a4e-3b76-451c-a74f-07b539a15437	92cc84f2-3149-463e-8a87-7f47ca6fc7ad	\N	Practical	Friday	t	11:00	12:20
b3e661b6-d25c-42f6-afe7-35cbb28da310	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	27aa3bd5-630a-4199-b649-4566dd683c53	8003aa6e-8411-4adc-a218-c9df6235a309	2e510a4e-3b76-451c-a74f-07b539a15437	92cc84f2-3149-463e-8a87-7f47ca6fc7ad	\N	Practical	Friday	f	11:00	12:20
5b2cea75-46ab-4836-bbf8-3af9b183889b	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	0975873c-d93f-4be4-a33e-5c28511f6078	8003aa6e-8411-4adc-a218-c9df6235a309	bf3068ad-bfc7-419b-ae92-4e6930b44d2d	b872f8a1-8f50-4f0e-b824-0c9ee103b703	\N	Practical	Friday	t	12:50	14:10
6a524d01-49e8-46a5-948b-4364e878dcf0	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	0975873c-d93f-4be4-a33e-5c28511f6078	8003aa6e-8411-4adc-a218-c9df6235a309	bf3068ad-bfc7-419b-ae92-4e6930b44d2d	135cc20b-58af-447b-a25f-10201326c4ba	\N	Practical	Friday	t	14:20	15:40
0ccaa941-9a92-4a5b-9ee3-4773ca43cc75	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	0975873c-d93f-4be4-a33e-5c28511f6078	8003aa6e-8411-4adc-a218-c9df6235a309	bf3068ad-bfc7-419b-ae92-4e6930b44d2d	b872f8a1-8f50-4f0e-b824-0c9ee103b703	\N	Practical	Friday	f	12:50	14:10
63bed299-3b9c-4111-80e6-501cc847670a	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	0975873c-d93f-4be4-a33e-5c28511f6078	8003aa6e-8411-4adc-a218-c9df6235a309	bf3068ad-bfc7-419b-ae92-4e6930b44d2d	135cc20b-58af-447b-a25f-10201326c4ba	\N	Practical	Friday	f	14:20	15:40
\.


--
-- TOC entry 4899 (class 0 OID 33810)
-- Dependencies: 222
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (uuid, room_uuid, building_uuid, name) FROM stdin;
f7440f4c-21bf-4652-aad0-98501930ee7b	ce7c1b5a-f3a1-4d2b-bafd-ab4b2edc403e	f69e0d5c-8a58-443c-b4f2-a4ebdbd30582	Informatics
09373d78-ce5c-47f8-b89b-0300b6eaa428	82a5b612-d5e6-4006-b8f2-38ed34b45b02	8003aa6e-8411-4adc-a218-c9df6235a309	Mathematics
47361c69-8535-4f7f-95bc-9f19ee68ac7b	d9e8bd2a-a1e7-4284-9e6c-e9958d8d64e4	f69e0d5c-8a58-443c-b4f2-a4ebdbd30582	Programming and Algorithms
c31726ba-ed3c-4173-b250-5e47cb05b3f0	afd955a3-6149-4023-b3d2-9d01f893940a	a1a5dc14-79d7-48ce-baf8-2e8d2ea97394	Philosophy
4c22473e-4d1c-436f-b10d-0c3f2ec70780	66f355de-985c-4537-96b2-7503578147ca	aee7c8ca-1ac8-4ef2-a33d-fe93b6cb7705	Mechanics
\.


--
-- TOC entry 4895 (class 0 OID 33762)
-- Dependencies: 218
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."group" (uuid, name, major_uuid) FROM stdin;
b872f8a1-8f50-4f0e-b824-0c9ee103b703	240-1	aa4d8d4f-21df-4e57-b813-c63635d38c5c
135cc20b-58af-447b-a25f-10201326c4ba	240-2	aa4d8d4f-21df-4e57-b813-c63635d38c5c
92cc84f2-3149-463e-8a87-7f47ca6fc7ad	240-3	aa4d8d4f-21df-4e57-b813-c63635d38c5c
\.


--
-- TOC entry 4896 (class 0 OID 33774)
-- Dependencies: 219
-- Data for Name: lab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lab (uuid, name, major_uuid) FROM stdin;
5fecc709-26b8-4901-b275-483969a214ba	1	aa4d8d4f-21df-4e57-b813-c63635d38c5c
a023c56b-f9ed-41e2-a1d1-5bc754f81b2c	2	aa4d8d4f-21df-4e57-b813-c63635d38c5c
77e1157c-fd29-42c0-b614-d87fe09511a4	3	aa4d8d4f-21df-4e57-b813-c63635d38c5c
4c906e13-dddb-451e-aef6-84b81ed0a55f	4	aa4d8d4f-21df-4e57-b813-c63635d38c5c
\.


--
-- TOC entry 4893 (class 0 OID 33748)
-- Dependencies: 216
-- Data for Name: major; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.major (uuid, name) FROM stdin;
aa4d8d4f-21df-4e57-b813-c63635d38c5c	Applied Mathematics and Informatics
cb45ff07-d41b-4258-a477-88cd1754ae30	Cyber Security
77666755-a1c6-4e69-a8ab-93eb4e20d9b1	Artificial Inteligence
0c648cad-df0a-444d-9ea8-43c20192a124	Programming Architecture
\.


--
-- TOC entry 4897 (class 0 OID 33786)
-- Dependencies: 220
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (uuid, building_uuid, name) FROM stdin;
ec1e562b-64fa-4082-a2b0-9db5bd30816b	8003aa6e-8411-4adc-a218-c9df6235a309	208
fd0d4542-6518-4b08-aecc-ce769db3822d	f69e0d5c-8a58-443c-b4f2-a4ebdbd30582	106
dead6d1d-6a74-47b9-91fe-f1569ad40c13	f69e0d5c-8a58-443c-b4f2-a4ebdbd30582	119
27aa3bd5-630a-4199-b649-4566dd683c53	f69e0d5c-8a58-443c-b4f2-a4ebdbd30582	105
882c26b4-78e1-409e-8e1e-2221918c32b4	8003aa6e-8411-4adc-a218-c9df6235a309	105
e3e52821-4e17-46b0-851e-d01d0923f93b	8003aa6e-8411-4adc-a218-c9df6235a309	103
0975873c-d93f-4be4-a33e-5c28511f6078	8003aa6e-8411-4adc-a218-c9df6235a309	102
087b75d9-df4c-4e40-aad6-b474f6d3fa44	8003aa6e-8411-4adc-a218-c9df6235a309	101
0339855b-4fdf-4b50-9a3c-3d057d574e5c	f69e0d5c-8a58-443c-b4f2-a4ebdbd30582	120
1675d9ca-9f12-4c87-82d7-b018a9e1ac19	8003aa6e-8411-4adc-a218-c9df6235a309	305
f1a4bd1c-5592-457b-91ed-08358e4d042d	aee7c8ca-1ac8-4ef2-a33d-fe93b6cb7705	205
66f355de-985c-4537-96b2-7503578147ca	aee7c8ca-1ac8-4ef2-a33d-fe93b6cb7705	112
ce7c1b5a-f3a1-4d2b-bafd-ab4b2edc403e	aee7c8ca-1ac8-4ef2-a33d-fe93b6cb7705	108
6c380377-12e8-4de2-ae71-01e445da5a47	8003aa6e-8411-4adc-a218-c9df6235a309	201
afd955a3-6149-4023-b3d2-9d01f893940a	a1a5dc14-79d7-48ce-baf8-2e8d2ea97394	401
584b1ac8-06f5-48e6-aa51-166edfca50bc	f69e0d5c-8a58-443c-b4f2-a4ebdbd30582	108
82a5b612-d5e6-4006-b8f2-38ed34b45b02	8003aa6e-8411-4adc-a218-c9df6235a309	209
bc8799ae-cdfc-4197-bc25-2a400007c08b	8003aa6e-8411-4adc-a218-c9df6235a309	206
d9e8bd2a-a1e7-4284-9e6c-e9958d8d64e4	f69e0d5c-8a58-443c-b4f2-a4ebdbd30582	905
83a5fb28-fef9-4837-9d3e-fa0ff1e996fa	8003aa6e-8411-4adc-a218-c9df6235a309	206/201
5ea6b204-fdf5-483f-a6c7-5c7b6f740499	8003aa6e-8411-4adc-a218-c9df6235a309	304
\.


--
-- TOC entry 4898 (class 0 OID 33798)
-- Dependencies: 221
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (uuid, first_name, last_name, email, group_uuid) FROM stdin;
285440b9-f89b-4497-b8bf-3cc661a2008c	Arsen	Grigoryan	arsen.grigoryan555@gmail.com	135cc20b-58af-447b-a25f-10201326c4ba
e47ec487-cd91-4dcd-9309-f53304230076	Niko	Isaxanyan	niko.isaxanyan@gmail.com	92cc84f2-3149-463e-8a87-7f47ca6fc7ad
\.


--
-- TOC entry 4900 (class 0 OID 33827)
-- Dependencies: 223
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher (uuid, first_name_en, last_name_en, first_name_hy, last_name_hy, first_name_ru, last_name_ru, department_uuid) FROM stdin;
e05a1753-5887-4a93-950b-5f9bec6ed52f	S	Episkoposyan	Ս	Եպիսկոպոսյան	С	Епископосян	09373d78-ce5c-47f8-b89b-0300b6eaa428
006270d8-7733-49d1-8e28-8c2a3261d809	N	Sahakyan	Ն	Սահակյան	Н	Саакян	f7440f4c-21bf-4652-aad0-98501930ee7b
912d51e4-baba-4ace-8c07-dc0c8181f725	S	Hayrapetyan	Ս	Հայրապետյան	С	Гайрапетян	09373d78-ce5c-47f8-b89b-0300b6eaa428
5588b7d4-4eea-4059-a444-f45a202df4ec	N	Badalyan	Ն	Բադալան	Н	Бадалян	09373d78-ce5c-47f8-b89b-0300b6eaa428
2982e205-0322-408a-a72a-cf598dc76b8a	V	Saroyan	Վ	Սարոյան	В	Сароян	4c22473e-4d1c-436f-b10d-0c3f2ec70780
2e510a4e-3b76-451c-a74f-07b539a15437	P	Hakobyan	Պ	Հակոբյան	П	Хакопян	09373d78-ce5c-47f8-b89b-0300b6eaa428
f6f21636-a993-4e6a-b760-b9f53d070725	J	Srapionyan	Ջ	Սրապիոնյան	Д	Срапионян	09373d78-ce5c-47f8-b89b-0300b6eaa428
6988a51d-209b-4d91-a99d-26fcdb74d0e4	G	Zaprosyan	Գ	Զապրոսյան	Г	Запросян	47361c69-8535-4f7f-95bc-9f19ee68ac7b
fbd6e8e0-1e48-45a3-b26e-563f392a72ca	S	Meliqyan	Ս	Մելիքյան	С	Меликян	47361c69-8535-4f7f-95bc-9f19ee68ac7b
81beaa17-aa15-4c05-82d3-ceefba5fef07	I	Saghatelyan	Ի	Սաղաթելայան	И	Сахателян	47361c69-8535-4f7f-95bc-9f19ee68ac7b
b0067bbe-355a-4d0c-a1bc-4398457b2905	N	Baxdasaryan	Ն	Բաղդասարյան	Н	Бахдасарян	c31726ba-ed3c-4173-b250-5e47cb05b3f0
6e157099-e7ea-4cca-97d5-86bf18fb6a7d	S	Khachatryan	Ս	Խաչատրյան	С	Хачатрян	09373d78-ce5c-47f8-b89b-0300b6eaa428
bf3068ad-bfc7-419b-ae92-4e6930b44d2d	M	Haykazyan	Մ	Հայկազյան	М	Хайказян	09373d78-ce5c-47f8-b89b-0300b6eaa428
481b3111-46fd-4d00-ac75-d8b5ab366902	I	Hovhannisyan	Ի	Հովհաննիսյան	И	Оганисян	09373d78-ce5c-47f8-b89b-0300b6eaa428
\.


--
-- TOC entry 4723 (class 2606 OID 33761)
-- Name: building building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4737 (class 2606 OID 33845)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4733 (class 2606 OID 33816)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4725 (class 2606 OID 33768)
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4727 (class 2606 OID 33780)
-- Name: lab lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab
    ADD CONSTRAINT lab_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4721 (class 2606 OID 33754)
-- Name: major major_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4729 (class 2606 OID 33792)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4731 (class 2606 OID 33804)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4735 (class 2606 OID 33833)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4745 (class 2606 OID 33851)
-- Name: course course_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- TOC entry 4746 (class 2606 OID 33861)
-- Name: course course_group_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_group_uuid_fkey FOREIGN KEY (group_uuid) REFERENCES public."group"(uuid);


--
-- TOC entry 4747 (class 2606 OID 33866)
-- Name: course course_lab_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_lab_uuid_fkey FOREIGN KEY (lab_uuid) REFERENCES public.lab(uuid);


--
-- TOC entry 4748 (class 2606 OID 33846)
-- Name: course course_room_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_room_uuid_fkey FOREIGN KEY (room_uuid) REFERENCES public.room(uuid);


--
-- TOC entry 4749 (class 2606 OID 33856)
-- Name: course course_teacher_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_teacher_uuid_fkey FOREIGN KEY (teacher_uuid) REFERENCES public.teacher(uuid);


--
-- TOC entry 4742 (class 2606 OID 33822)
-- Name: department department_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- TOC entry 4743 (class 2606 OID 33817)
-- Name: department department_room_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_room_uuid_fkey FOREIGN KEY (room_uuid) REFERENCES public.room(uuid);


--
-- TOC entry 4738 (class 2606 OID 33769)
-- Name: group group_major_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_major_uuid_fkey FOREIGN KEY (major_uuid) REFERENCES public.major(uuid);


--
-- TOC entry 4739 (class 2606 OID 33781)
-- Name: lab lab_major_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab
    ADD CONSTRAINT lab_major_uuid_fkey FOREIGN KEY (major_uuid) REFERENCES public.major(uuid);


--
-- TOC entry 4740 (class 2606 OID 33793)
-- Name: room room_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- TOC entry 4741 (class 2606 OID 33805)
-- Name: student student_group_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_group_uuid_fkey FOREIGN KEY (group_uuid) REFERENCES public."group"(uuid);


--
-- TOC entry 4744 (class 2606 OID 33834)
-- Name: teacher teacher_department_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_department_uuid_fkey FOREIGN KEY (department_uuid) REFERENCES public.department(uuid);


-- Completed on 2024-10-01 02:54:53

--
-- PostgreSQL database dump complete
--

