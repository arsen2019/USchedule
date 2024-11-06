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
-- TOC entry 224 (class 1259 OID 34335)
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
-- TOC entry 222 (class 1259 OID 34306)
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
-- TOC entry 218 (class 1259 OID 34258)
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."group" (
    uuid uuid NOT NULL,
    name character varying NOT NULL,
    major_uuid uuid
);


ALTER TABLE public."group" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 34270)
-- Name: lab; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lab (
    uuid uuid NOT NULL,
    name character varying NOT NULL,
    major_uuid uuid
);


ALTER TABLE public.lab OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 34244)
-- Name: major; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.major (
    uuid uuid NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.major OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 34282)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    uuid uuid NOT NULL,
    building_uuid uuid,
    name character varying NOT NULL
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 34294)
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
-- TOC entry 223 (class 1259 OID 34323)
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
-- TOC entry 4894 (class 0 OID 34251)
-- Dependencies: 217
-- Data for Name: building; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building (uuid, country, city, street, longitude, latitude, name) FROM stdin;
108e1304-38e3-4419-b1de-a132480763fa	Armenia	Yerevan	Teryan 52	\N	\N	2
58439e57-8a29-4ae4-bd2a-644a8041fc49	Armenia	Yerevan	Teryan 52	\N	\N	5
58b215ad-708d-41a9-ab2a-007693f4970a	Armenia	Yerevan	Koryun 9	\N	\N	12
646b0369-464c-49c1-bb53-ebc6cfd72b0b	Armenia	Yerevan	Koryun 11	\N	\N	9
\.


--
-- TOC entry 4901 (class 0 OID 34335)
-- Dependencies: 224
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (uuid, name_en, name_hy, name_ru, room_uuid, building_uuid, teacher_uuid, group_uuid, lab_uuid, type, day_of_week, is_odd, start_time, end_time) FROM stdin;
7bae866c-859d-47cb-877e-61da16e92e36	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	5093f881-29b9-47e7-9208-5159f8b3b918	Laboratory	Monday	t	12:50	14:10
49aca84f-f115-4795-8fb7-d8e7103d3dda	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	5093f881-29b9-47e7-9208-5159f8b3b918	Laboratory	Monday	f	12:50	14:10
ec36fac9-612c-4a68-9e33-df11c42226b3	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	68d896c7-6b69-4635-9517-18974f69945a	58b215ad-708d-41a9-ab2a-007693f4970a	08e9e068-6b00-43b0-8b10-1fdc43fa9c30	e3089044-5f4d-4c4f-978a-c7b4663e4c03	\N	Practical	Monday	t	9:30	10:50
cf3a2ef7-5de7-41d0-ad69-bb38e36dc5d9	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	0ac77ba7-3b21-40c3-b134-fad2ac8e510e	58b215ad-708d-41a9-ab2a-007693f4970a	08e9e068-6b00-43b0-8b10-1fdc43fa9c30	e3089044-5f4d-4c4f-978a-c7b4663e4c03	\N	Practical	Monday	f	9:30	10:50
ad86c9a1-530f-4075-961f-d260a746daf1	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	0ac77ba7-3b21-40c3-b134-fad2ac8e510e	58b215ad-708d-41a9-ab2a-007693f4970a	367f66d7-a457-4191-a3d3-f952822fea0d	4e6b443e-be3b-456d-aa7f-6ba55e4d7c61	\N	Practical	Monday	t	9:30	10:50
00f8f1a7-f701-43ca-ba84-c657568846bb	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	a6d1afd6-977e-41bd-899f-5ed2dfcee4f8	58b215ad-708d-41a9-ab2a-007693f4970a	4c6d7168-01ce-4b78-bf6c-5f492672a4be	\N	\N	Lecture	Monday	t	11:00	12:20
e11b9ceb-1c5e-49fb-a671-9b61e422b2a3	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	0e5c070a-3db4-484d-8a17-c90cbc886000	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	d03fb752-9508-4722-b402-413f3d25dfd1	Laboratory	Monday	t	12:50	14:10
26dcd3ea-af25-401f-b183-c8b4cd5c347f	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	0e5c070a-3db4-484d-8a17-c90cbc886000	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	d03fb752-9508-4722-b402-413f3d25dfd1	Laboratory	Monday	f	12:50	14:10
f1ece92b-e1c6-4439-8826-931f7066ba8d	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	4c6d7168-01ce-4b78-bf6c-5f492672a4be	\N	\N	CourseWork	Monday	t	14:20	15:40
6c20a944-e052-4c44-a64b-330dc8ff4ea1	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	4c6d7168-01ce-4b78-bf6c-5f492672a4be	\N	\N	CourseWork	Monday	f	14:20	15:40
b170acd0-f720-46e4-b574-b11e36f67593	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	a6d1afd6-977e-41bd-899f-5ed2dfcee4f8	58b215ad-708d-41a9-ab2a-007693f4970a	08e9e068-6b00-43b0-8b10-1fdc43fa9c30	\N	\N	Lecture	Monday	f	11:00	12:20
9a0e68e7-a761-4da1-aa12-0d4a5fa8e964	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	\N	Lecture	Tuesday	f	9:30	10:50
981622df-a0f9-4a9c-bb55-6b4f5619fa87	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	\N	Lecture	Tuesday	t	9:30	10:50
36d66846-0dfa-4b3b-88fe-bc613361805b	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	68d896c7-6b69-4635-9517-18974f69945a	58b215ad-708d-41a9-ab2a-007693f4970a	4c6d7168-01ce-4b78-bf6c-5f492672a4be	12e73255-9673-48ac-9960-efcfe47a0563	\N	Practical	Tuesday	t	11:00	12:20
7597fae4-523c-4ce5-b1df-2ae3ab79d078	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	d03fb752-9508-4722-b402-413f3d25dfd1	Laboratory	Tuesday	t	11:00	12:20
1e0d8639-1a40-4221-bac2-343702f039c9	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	d03fb752-9508-4722-b402-413f3d25dfd1	Laboratory	Tuesday	f	11:00	12:20
dd70625d-5856-432e-83ea-7cf864bfa11a	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	7242dea5-ad50-45aa-a122-6f16eac1fd38	Laboratory	Tuesday	t	12:50	14:10
7903d377-3f2e-46f5-8931-2ee992b4a242	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	7242dea5-ad50-45aa-a122-6f16eac1fd38	Laboratory	Tuesday	f	12:50	14:10
831b0c33-c128-4ece-a8dc-9c80df7c2ee6	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	a9e474df-61a6-48b0-97c9-1aa03b1cde31	Laboratory	Tuesday	t	14:20	15:40
5b954a91-f84b-4cda-88c4-3300efc37063	Programming Theory	Ծրագրավորման Տեսություն	Теория Программирования	cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	ad501b23-8d32-4165-b327-c30188e55de0	\N	a9e474df-61a6-48b0-97c9-1aa03b1cde31	Laboratory	Tuesday	f	14:20	15:40
cd937e8b-2e12-46d7-8cb9-ff49b18efe2a	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	a9e474df-61a6-48b0-97c9-1aa03b1cde31	Laboratory	Tuesday	f	12:50	14:10
6a49359e-cc97-49e3-bd4e-6c640fb49c76	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	a9e474df-61a6-48b0-97c9-1aa03b1cde31	Laboratory	Tuesday	t	12:50	14:10
8e9c5df4-63e9-4c5c-9bb6-5ce644c51aa6	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	5093f881-29b9-47e7-9208-5159f8b3b918	Laboratory	Tuesday	t	14:20	15:40
c8db9327-c6e2-4cac-8819-32e3c978cc90	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	5093f881-29b9-47e7-9208-5159f8b3b918	Laboratory	Tuesday	f	14:20	15:40
338bfd41-d819-48c8-a267-3854bdcb052f	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	0ac77ba7-3b21-40c3-b134-fad2ac8e510e	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	5093f881-29b9-47e7-9208-5159f8b3b918	Laboratory	Tuesday	f	12:50	14:10
c02ff804-3787-4471-863a-128df416b658	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	0ac77ba7-3b21-40c3-b134-fad2ac8e510e	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	5093f881-29b9-47e7-9208-5159f8b3b918	Laboratory	Tuesday	t	12:50	14:10
59052315-5dac-4442-99b2-a7b51e6e26a3	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	effd6097-ec9f-4335-9896-5304f0143993	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	7242dea5-ad50-45aa-a122-6f16eac1fd38	Laboratory	Tuesday	f	14:20	15:40
9a283fea-1438-4a41-9f37-9349c2ee8aed	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	effd6097-ec9f-4335-9896-5304f0143993	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	7242dea5-ad50-45aa-a122-6f16eac1fd38	Laboratory	Tuesday	t	14:20	15:40
5eabb73e-cbde-4b59-a0db-6572820323f6	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	a6d1afd6-977e-41bd-899f-5ed2dfcee4f8	58b215ad-708d-41a9-ab2a-007693f4970a	85cbdc60-9500-4c90-abb4-e8e50541848d	e3089044-5f4d-4c4f-978a-c7b4663e4c03	\N	Practical	Wednesday	t	9:30	10:50
53c882cc-d2ec-460e-8c37-f93a5ed95544	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	0e5c070a-3db4-484d-8a17-c90cbc886000	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	\N	Lecture	Thursday	f	11:00	12:20
e5ca3a30-49d0-4dcd-99a8-9a51a53472d0	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	0e5c070a-3db4-484d-8a17-c90cbc886000	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	\N	Lecture	Thursday	t	11:00	12:20
af99f4d7-366c-4666-b199-ecdf2a9ce7d3	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	\N	Lecture	Wednesday	f	12:50	14:10
1e8c55b3-1c27-4c7c-99f3-d90b1c384b56	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	\N	Lecture	Wednesday	t	12:50	14:10
82ae1dd8-ef80-4951-ac33-496df98da207	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	367f66d7-a457-4191-a3d3-f952822fea0d	\N	\N	Lecture	Wednesday	t	14:20	15:40
7b0a843c-577c-4a53-b670-bac75e1870a3	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	367f66d7-a457-4191-a3d3-f952822fea0d	\N	\N	Lecture	Wednesday	f	14:20	15:40
e3f1f084-527a-425b-aef4-18b1b4688fef	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	68d896c7-6b69-4635-9517-18974f69945a	58b215ad-708d-41a9-ab2a-007693f4970a	4c6d7168-01ce-4b78-bf6c-5f492672a4be	e3089044-5f4d-4c4f-978a-c7b4663e4c03	\N	Practical	Thursday	t	9:30	10:50
f6d21fab-eb0c-4a6b-90f0-7fa42d243d3d	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	68d896c7-6b69-4635-9517-18974f69945a	58b215ad-708d-41a9-ab2a-007693f4970a	4c6d7168-01ce-4b78-bf6c-5f492672a4be	e3089044-5f4d-4c4f-978a-c7b4663e4c03	\N	Practical	Thursday	f	9:30	10:50
c800ce89-fd5a-4aa9-a236-356742815643	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	a6d1afd6-977e-41bd-899f-5ed2dfcee4f8	58b215ad-708d-41a9-ab2a-007693f4970a	85cbdc60-9500-4c90-abb4-e8e50541848d	4e6b443e-be3b-456d-aa7f-6ba55e4d7c61	\N	Practical	Thursday	t	9:30	10:50
f0724156-eb5d-4f4b-a432-2ead8f6f0382	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	effd6097-ec9f-4335-9896-5304f0143993	58b215ad-708d-41a9-ab2a-007693f4970a	85cbdc60-9500-4c90-abb4-e8e50541848d	4e6b443e-be3b-456d-aa7f-6ba55e4d7c61	\N	Practical	Thursday	f	9:30	10:50
e6b9886f-c2cc-4134-803c-5f4a6abd01ba	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	53326c78-e0d7-4d33-839c-fd48df4944ae	58b215ad-708d-41a9-ab2a-007693f4970a	08e9e068-6b00-43b0-8b10-1fdc43fa9c30	\N	\N	CourseWork	Friday	f	9:30	10:50
6a3bc803-551b-412e-80e5-af61a0d2c662	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	4c6d7168-01ce-4b78-bf6c-5f492672a4be	4e6b443e-be3b-456d-aa7f-6ba55e4d7c61	\N	Practical	Thursday	t	14:20	15:40
3d7c21f4-c2b2-44c6-bccb-9aca5a0f87ce	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	0e5c070a-3db4-484d-8a17-c90cbc886000	58b215ad-708d-41a9-ab2a-007693f4970a	367f66d7-a457-4191-a3d3-f952822fea0d	12e73255-9673-48ac-9960-efcfe47a0563	\N	Practical	Thursday	t	14:20	15:40
eded95d2-e1fb-4f93-9bd2-8a95bc013008	Coding Theory	Կոդավորման Տեսություն	Теория кодирования	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	4c6d7168-01ce-4b78-bf6c-5f492672a4be	4e6b443e-be3b-456d-aa7f-6ba55e4d7c61	\N	Practical	Thursday	f	14:20	15:40
6bf3942c-c92f-4b01-b32a-1fb7c30c6f43	Math-Physics Equations	Մաթ-Ֆիզիկական Հավասարումներ	Математико-физические уравнения	0e5c070a-3db4-484d-8a17-c90cbc886000	58b215ad-708d-41a9-ab2a-007693f4970a	367f66d7-a457-4191-a3d3-f952822fea0d	e3089044-5f4d-4c4f-978a-c7b4663e4c03	\N	Practical	Thursday	f	14:20	15:40
40272b91-aa91-4a4d-9360-c88d42d9db4d	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	6a03ff90-f8eb-46b7-935f-7dc05a2669f8	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	a9e474df-61a6-48b0-97c9-1aa03b1cde31	Laboratory	Thursday	t	12:50	14:10
6503dbcf-cdef-457f-a535-6ad2f25fad44	Discrete Mathematics	Դիսկրետ Մաթեմատիկա	Дискретная математика	6a03ff90-f8eb-46b7-935f-7dc05a2669f8	58b215ad-708d-41a9-ab2a-007693f4970a	b3608d87-4bc1-4928-97f2-314278853177	\N	a9e474df-61a6-48b0-97c9-1aa03b1cde31	Laboratory	Thursday	f	12:50	14:10
e7ae23eb-9012-45b0-9478-12f0610d2c69	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	7242dea5-ad50-45aa-a122-6f16eac1fd38	Laboratory	Thursday	t	12:50	14:10
8e87bbf2-fcb3-4d80-9fea-50dffb2c7e66	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	7242dea5-ad50-45aa-a122-6f16eac1fd38	Laboratory	Thursday	f	12:50	14:10
1ab52bc9-348c-4cca-8c81-c7df4d993a82	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	a6d1afd6-977e-41bd-899f-5ed2dfcee4f8	58b215ad-708d-41a9-ab2a-007693f4970a	85cbdc60-9500-4c90-abb4-e8e50541848d	\N	\N	Lecture	Friday	t	9:30	10:50
e39516b5-00b8-4443-b1f2-192750fbe921	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	d03fb752-9508-4722-b402-413f3d25dfd1	Laboratory	Friday	t	11:00	12:20
37abe2cf-1633-432e-ba40-d6f81602669e	Math Programming	Մաթ․ Ծրագրավորում	Математическое программирование	4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	d2e9836e-4572-4bee-af7e-000be864282b	\N	d03fb752-9508-4722-b402-413f3d25dfd1	Laboratory	Friday	f	11:00	12:20
da7fb46d-c8a3-465b-b95c-1a68166f1a9c	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	effd6097-ec9f-4335-9896-5304f0143993	58b215ad-708d-41a9-ab2a-007693f4970a	85cbdc60-9500-4c90-abb4-e8e50541848d	12e73255-9673-48ac-9960-efcfe47a0563	\N	Practical	Friday	t	11:00	12:20
a23465b8-90b1-4175-bb54-17c8265506d6	Probability Theory	Հավանականության Տեսություն	Теория Вероятностей	effd6097-ec9f-4335-9896-5304f0143993	58b215ad-708d-41a9-ab2a-007693f4970a	85cbdc60-9500-4c90-abb4-e8e50541848d	12e73255-9673-48ac-9960-efcfe47a0563	\N	Practical	Friday	f	11:00	12:20
3e1d0f9e-095e-4267-8de5-8d8920fbf4b0	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	2a0cef64-9eb8-49ff-938e-59440d530304	58b215ad-708d-41a9-ab2a-007693f4970a	08e9e068-6b00-43b0-8b10-1fdc43fa9c30	12e73255-9673-48ac-9960-efcfe47a0563	\N	Practical	Monday	t	12:50	14:10
a9ee35f8-5d79-4da5-829b-a585fe7fbc5b	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	2a0cef64-9eb8-49ff-938e-59440d530304	58b215ad-708d-41a9-ab2a-007693f4970a	08e9e068-6b00-43b0-8b10-1fdc43fa9c30	4e6b443e-be3b-456d-aa7f-6ba55e4d7c61	\N	Practical	Wednesday	t	11:00	12:20
2f087f43-efd1-4539-ae96-d8e18f58916a	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	2a0cef64-9eb8-49ff-938e-59440d530304	58b215ad-708d-41a9-ab2a-007693f4970a	08e9e068-6b00-43b0-8b10-1fdc43fa9c30	12e73255-9673-48ac-9960-efcfe47a0563	\N	Practical	Monday	f	12:50	14:10
9121003b-5b3e-4840-84d8-16775992d382	Computer Architecture	ԷՀՄ  Ճարտարագիտություն	ЭВМ Архитектура	2a0cef64-9eb8-49ff-938e-59440d530304	58b215ad-708d-41a9-ab2a-007693f4970a	08e9e068-6b00-43b0-8b10-1fdc43fa9c30	4e6b443e-be3b-456d-aa7f-6ba55e4d7c61	\N	Practical	Wednesday	f	11:00	12:20
\.


--
-- TOC entry 4899 (class 0 OID 34306)
-- Dependencies: 222
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (uuid, room_uuid, building_uuid, name) FROM stdin;
957ad9d5-4e94-4649-a301-194ea863e878	8927422c-9db6-43bb-ab93-ad263220b02f	58439e57-8a29-4ae4-bd2a-644a8041fc49	Informatics
3d1d9d6d-f3e0-4d05-ba66-45e52b8f1bc3	bb21757a-a2cd-4b0c-82d3-cd1bc04c2461	58b215ad-708d-41a9-ab2a-007693f4970a	Mathematics
4e494530-66bb-43c9-a0c3-5de48e6be0b5	8547b43a-007e-40f4-893d-895718456668	58439e57-8a29-4ae4-bd2a-644a8041fc49	Programming and Algorithms
032e1d7f-3e23-491d-bdfe-9a0ca753df5b	64ac5087-13de-4858-a532-36cbb8c5d334	108e1304-38e3-4419-b1de-a132480763fa	Philosophy
1877435f-488e-4d8d-9b88-6ec1b99b29fd	2ee06dfa-4b46-4c4d-95c1-2212eb993993	646b0369-464c-49c1-bb53-ebc6cfd72b0b	Mechanics
\.


--
-- TOC entry 4895 (class 0 OID 34258)
-- Dependencies: 218
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."group" (uuid, name, major_uuid) FROM stdin;
e3089044-5f4d-4c4f-978a-c7b4663e4c03	240-1	9a99be68-d8db-4269-9e27-fc77ca184daa
4e6b443e-be3b-456d-aa7f-6ba55e4d7c61	240-2	9a99be68-d8db-4269-9e27-fc77ca184daa
12e73255-9673-48ac-9960-efcfe47a0563	240-3	9a99be68-d8db-4269-9e27-fc77ca184daa
\.


--
-- TOC entry 4896 (class 0 OID 34270)
-- Dependencies: 219
-- Data for Name: lab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lab (uuid, name, major_uuid) FROM stdin;
5093f881-29b9-47e7-9208-5159f8b3b918	1	9a99be68-d8db-4269-9e27-fc77ca184daa
d03fb752-9508-4722-b402-413f3d25dfd1	2	9a99be68-d8db-4269-9e27-fc77ca184daa
a9e474df-61a6-48b0-97c9-1aa03b1cde31	3	9a99be68-d8db-4269-9e27-fc77ca184daa
7242dea5-ad50-45aa-a122-6f16eac1fd38	4	9a99be68-d8db-4269-9e27-fc77ca184daa
\.


--
-- TOC entry 4893 (class 0 OID 34244)
-- Dependencies: 216
-- Data for Name: major; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.major (uuid, name) FROM stdin;
9a99be68-d8db-4269-9e27-fc77ca184daa	Applied Mathematics and Informatics
7431e33c-4e0b-434d-86ab-30bc56df7406	Cyber Security
86373c93-80ae-49a0-93e1-642d9e1b4943	Artificial Inteligence
1fbb285b-a3b8-43c8-8985-7483bd92c184	Programming Architecture
\.


--
-- TOC entry 4897 (class 0 OID 34282)
-- Dependencies: 220
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (uuid, building_uuid, name) FROM stdin;
a6d1afd6-977e-41bd-899f-5ed2dfcee4f8	58b215ad-708d-41a9-ab2a-007693f4970a	208
0397c2da-d5ac-4f94-b491-f79fac5dec2f	58439e57-8a29-4ae4-bd2a-644a8041fc49	106
8704ced8-3870-4701-ad99-5ef0dbfa0603	58439e57-8a29-4ae4-bd2a-644a8041fc49	119
effd6097-ec9f-4335-9896-5304f0143993	58439e57-8a29-4ae4-bd2a-644a8041fc49	105
d74d1abe-0243-4234-aca3-07816a5b242e	58b215ad-708d-41a9-ab2a-007693f4970a	105
4455c1f6-8af7-41e4-9aba-0b23180d1378	58b215ad-708d-41a9-ab2a-007693f4970a	103
2a0cef64-9eb8-49ff-938e-59440d530304	58b215ad-708d-41a9-ab2a-007693f4970a	102
68d896c7-6b69-4635-9517-18974f69945a	58b215ad-708d-41a9-ab2a-007693f4970a	101
ac7f43a7-e964-41db-92b3-834b690c6d44	58439e57-8a29-4ae4-bd2a-644a8041fc49	120
0e5c070a-3db4-484d-8a17-c90cbc886000	58b215ad-708d-41a9-ab2a-007693f4970a	305
3cd3292c-f156-4c81-9b65-887568855fb9	646b0369-464c-49c1-bb53-ebc6cfd72b0b	205
2ee06dfa-4b46-4c4d-95c1-2212eb993993	646b0369-464c-49c1-bb53-ebc6cfd72b0b	112
8927422c-9db6-43bb-ab93-ad263220b02f	646b0369-464c-49c1-bb53-ebc6cfd72b0b	108
0ac77ba7-3b21-40c3-b134-fad2ac8e510e	58b215ad-708d-41a9-ab2a-007693f4970a	201
64ac5087-13de-4858-a532-36cbb8c5d334	108e1304-38e3-4419-b1de-a132480763fa	401
11b39e59-639a-4051-b768-55a502f24f67	58439e57-8a29-4ae4-bd2a-644a8041fc49	108
bb21757a-a2cd-4b0c-82d3-cd1bc04c2461	58b215ad-708d-41a9-ab2a-007693f4970a	209
cae26c7e-ea27-414c-aedc-e0075c49ef51	58b215ad-708d-41a9-ab2a-007693f4970a	206
8547b43a-007e-40f4-893d-895718456668	58439e57-8a29-4ae4-bd2a-644a8041fc49	905
53326c78-e0d7-4d33-839c-fd48df4944ae	58b215ad-708d-41a9-ab2a-007693f4970a	106/208
6a03ff90-f8eb-46b7-935f-7dc05a2669f8	58b215ad-708d-41a9-ab2a-007693f4970a	304
\.


--
-- TOC entry 4898 (class 0 OID 34294)
-- Dependencies: 221
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (uuid, first_name, last_name, email, group_uuid) FROM stdin;
01b70e22-0fb3-4bec-8d9d-f93372cfd1d2	Arsen	Grigoryan	arsen.grigoryan555@gmail.com	4e6b443e-be3b-456d-aa7f-6ba55e4d7c61
25e3da89-8d16-4108-bff0-e1f25935b9f4	Niko	Isaxanyan	niko.isaxanyan@gmail.com	12e73255-9673-48ac-9960-efcfe47a0563
\.


--
-- TOC entry 4900 (class 0 OID 34323)
-- Dependencies: 223
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher (uuid, first_name_en, last_name_en, first_name_hy, last_name_hy, first_name_ru, last_name_ru, department_uuid) FROM stdin;
ea05bce7-9ca8-4374-a081-51f0292a00eb	S	Episkoposyan	Ս	Եպիսկոպոսյան	С	Епископосян	3d1d9d6d-f3e0-4d05-ba66-45e52b8f1bc3
a6b375a2-3915-4ab3-a17e-cb3c7c987b5f	N	Sahakyan	Ն	Սահակյան	Н	Саакян	957ad9d5-4e94-4649-a301-194ea863e878
367f66d7-a457-4191-a3d3-f952822fea0d	S	Hayrapetyan	Ս	Հայրապետյան	С	Гайрапетян	3d1d9d6d-f3e0-4d05-ba66-45e52b8f1bc3
b3608d87-4bc1-4928-97f2-314278853177	N	Badalyan	Ն	Բադալան	Н	Бадалян	3d1d9d6d-f3e0-4d05-ba66-45e52b8f1bc3
1cd3788c-a6f1-4405-8527-aa7a979867c1	V	Saroyan	Վ	Սարոյան	В	Сароян	1877435f-488e-4d8d-9b88-6ec1b99b29fd
85cbdc60-9500-4c90-abb4-e8e50541848d	P	Hakobyan	Պ	Հակոբյան	П	Хакопян	3d1d9d6d-f3e0-4d05-ba66-45e52b8f1bc3
4fba504a-3b3c-4b50-bf4b-14d65ec79357	J	Srapionyan	Ջ	Սրապիոնյան	Д	Срапионян	3d1d9d6d-f3e0-4d05-ba66-45e52b8f1bc3
ad501b23-8d32-4165-b327-c30188e55de0	G	Zaprosyan	Գ	Զապրոսյան	Г	Запросян	4e494530-66bb-43c9-a0c3-5de48e6be0b5
6bce83ae-4a33-4bee-9973-0708ae9e4165	S	Meliqyan	Ս	Մելիքյան	С	Меликян	4e494530-66bb-43c9-a0c3-5de48e6be0b5
8af5859f-093e-416d-bb3d-10505fe0cf2c	I	Saghatelyan	Ի	Սաղաթելայան	И	Сахателян	4e494530-66bb-43c9-a0c3-5de48e6be0b5
fa57cd4b-3bf1-4219-a575-0beca831ba73	N	Baxdasaryan	Ն	Բաղդասարյան	Н	Бахдасарян	032e1d7f-3e23-491d-bdfe-9a0ca753df5b
4c6d7168-01ce-4b78-bf6c-5f492672a4be	S	Khachatryan	Ս	Խաչատրյան	С	Хачатрян	3d1d9d6d-f3e0-4d05-ba66-45e52b8f1bc3
08e9e068-6b00-43b0-8b10-1fdc43fa9c30	A	Qamalyan	Ա	Քամալյան	А	Камалян	3d1d9d6d-f3e0-4d05-ba66-45e52b8f1bc3
d2e9836e-4572-4bee-af7e-000be864282b	I	Hovhannisyan	Ի	Հովհաննիսյան	И	Оганисян	3d1d9d6d-f3e0-4d05-ba66-45e52b8f1bc3
\.


--
-- TOC entry 4723 (class 2606 OID 34257)
-- Name: building building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4737 (class 2606 OID 34341)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4733 (class 2606 OID 34312)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4725 (class 2606 OID 34264)
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4727 (class 2606 OID 34276)
-- Name: lab lab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab
    ADD CONSTRAINT lab_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4721 (class 2606 OID 34250)
-- Name: major major_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4729 (class 2606 OID 34288)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4731 (class 2606 OID 34300)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4735 (class 2606 OID 34329)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (uuid);


--
-- TOC entry 4745 (class 2606 OID 34347)
-- Name: course course_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- TOC entry 4746 (class 2606 OID 34357)
-- Name: course course_group_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_group_uuid_fkey FOREIGN KEY (group_uuid) REFERENCES public."group"(uuid);


--
-- TOC entry 4747 (class 2606 OID 34362)
-- Name: course course_lab_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_lab_uuid_fkey FOREIGN KEY (lab_uuid) REFERENCES public.lab(uuid);


--
-- TOC entry 4748 (class 2606 OID 34342)
-- Name: course course_room_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_room_uuid_fkey FOREIGN KEY (room_uuid) REFERENCES public.room(uuid);


--
-- TOC entry 4749 (class 2606 OID 34352)
-- Name: course course_teacher_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_teacher_uuid_fkey FOREIGN KEY (teacher_uuid) REFERENCES public.teacher(uuid);


--
-- TOC entry 4742 (class 2606 OID 34318)
-- Name: department department_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- TOC entry 4743 (class 2606 OID 34313)
-- Name: department department_room_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_room_uuid_fkey FOREIGN KEY (room_uuid) REFERENCES public.room(uuid);


--
-- TOC entry 4738 (class 2606 OID 34265)
-- Name: group group_major_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_major_uuid_fkey FOREIGN KEY (major_uuid) REFERENCES public.major(uuid);


--
-- TOC entry 4739 (class 2606 OID 34277)
-- Name: lab lab_major_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab
    ADD CONSTRAINT lab_major_uuid_fkey FOREIGN KEY (major_uuid) REFERENCES public.major(uuid);


--
-- TOC entry 4740 (class 2606 OID 34289)
-- Name: room room_building_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_building_uuid_fkey FOREIGN KEY (building_uuid) REFERENCES public.building(uuid);


--
-- TOC entry 4741 (class 2606 OID 34301)
-- Name: student student_group_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_group_uuid_fkey FOREIGN KEY (group_uuid) REFERENCES public."group"(uuid);


--
-- TOC entry 4744 (class 2606 OID 34330)
-- Name: teacher teacher_department_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_department_uuid_fkey FOREIGN KEY (department_uuid) REFERENCES public.department(uuid);


-- Completed on 2024-10-16 02:44:41

--
-- PostgreSQL database dump complete
--