--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.10
-- Dumped by pg_dump version 9.4.10
-- Started on 2017-10-23 15:29:52

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE ntkp;
--
-- TOC entry 2259 (class 1262 OID 24576)
-- Name: ntkp; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE ntkp WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


ALTER DATABASE ntkp OWNER TO postgres;

\connect ntkp

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 32865)
-- Name: request; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE request (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    request_type_id integer NOT NULL,
    init_member_id integer NOT NULL,
    status_id integer NOT NULL,
    request_domain_id integer NOT NULL,
    activity_of_interest character varying(100),
    submission_date timestamp without time zone NOT NULL
);


ALTER TABLE request OWNER TO postgres;

--
-- TOC entry 2263 (class 0 OID 0)
-- Dependencies: 198
-- Name: TABLE request; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE request IS 'Table of collaboration requests.';


--
-- TOC entry 197 (class 1259 OID 32863)
-- Name: collaboration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE collaboration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collaboration_id_seq OWNER TO postgres;

--
-- TOC entry 2264 (class 0 OID 0)
-- Dependencies: 197
-- Name: collaboration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE collaboration_id_seq OWNED BY request.id;


--
-- TOC entry 200 (class 1259 OID 32890)
-- Name: request_member_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE request_member_type (
    id integer NOT NULL,
    request_id integer NOT NULL,
    member_type_id integer NOT NULL
);


ALTER TABLE request_member_type OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 32888)
-- Name: collaboration_member_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE collaboration_member_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collaboration_member_type_id_seq OWNER TO postgres;

--
-- TOC entry 2265 (class 0 OID 0)
-- Dependencies: 199
-- Name: collaboration_member_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE collaboration_member_type_id_seq OWNED BY request_member_type.id;


--
-- TOC entry 202 (class 1259 OID 32898)
-- Name: request_property_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE request_property_type (
    id integer NOT NULL,
    request_id integer NOT NULL,
    property_type_id integer NOT NULL
);


ALTER TABLE request_property_type OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 32896)
-- Name: collaboration_property_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE collaboration_property_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collaboration_property_type_id_seq OWNER TO postgres;

--
-- TOC entry 2266 (class 0 OID 0)
-- Dependencies: 201
-- Name: collaboration_property_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE collaboration_property_type_id_seq OWNED BY request_property_type.id;


--
-- TOC entry 190 (class 1259 OID 32810)
-- Name: request_domain; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE request_domain (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE request_domain OWNER TO postgres;

--
-- TOC entry 2267 (class 0 OID 0)
-- Dependencies: 190
-- Name: TABLE request_domain; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE request_domain IS 'Possible types/areas of collaboration.';


--
-- TOC entry 189 (class 1259 OID 32808)
-- Name: collaboration_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE collaboration_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collaboration_type_id_seq OWNER TO postgres;

--
-- TOC entry 2268 (class 0 OID 0)
-- Dependencies: 189
-- Name: collaboration_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE collaboration_type_id_seq OWNED BY request_domain.id;


--
-- TOC entry 192 (class 1259 OID 32823)
-- Name: member; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE member (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    member_type_id integer NOT NULL,
    role_id integer NOT NULL,
    property_type_id integer NOT NULL,
    request_domain_id integer NOT NULL,
    activities character varying(100),
    email character varying(100) NOT NULL,
    url character varying(100) NOT NULL
);


ALTER TABLE member OWNER TO postgres;

--
-- TOC entry 2269 (class 0 OID 0)
-- Dependencies: 192
-- Name: TABLE member; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE member IS 'Table of collaboration platform members.';


--
-- TOC entry 191 (class 1259 OID 32821)
-- Name: member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE member_id_seq OWNER TO postgres;

--
-- TOC entry 2270 (class 0 OID 0)
-- Dependencies: 191
-- Name: member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE member_id_seq OWNED BY member.id;


--
-- TOC entry 186 (class 1259 OID 32784)
-- Name: member_role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE member_role (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE member_role OWNER TO postgres;

--
-- TOC entry 2271 (class 0 OID 0)
-- Dependencies: 186
-- Name: TABLE member_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE member_role IS 'Table of possible member roles in the system.';


--
-- TOC entry 185 (class 1259 OID 32782)
-- Name: member_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE member_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE member_role_id_seq OWNER TO postgres;

--
-- TOC entry 2272 (class 0 OID 0)
-- Dependencies: 185
-- Name: member_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE member_role_id_seq OWNED BY member_role.id;


--
-- TOC entry 184 (class 1259 OID 32771)
-- Name: member_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE member_type (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    "Description" text
);


ALTER TABLE member_type OWNER TO postgres;

--
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 184
-- Name: TABLE member_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE member_type IS 'Table with the possible types of collaboration system members.';


--
-- TOC entry 183 (class 1259 OID 32769)
-- Name: member_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE member_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE member_type_id_seq OWNER TO postgres;

--
-- TOC entry 2274 (class 0 OID 0)
-- Dependencies: 183
-- Name: member_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE member_type_id_seq OWNED BY member_type.id;


--
-- TOC entry 176 (class 1259 OID 24644)
-- Name: permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE permission OWNER TO postgres;

--
-- TOC entry 2275 (class 0 OID 0)
-- Dependencies: 176
-- Name: TABLE permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE permission IS 'Defines the permissions for the users.';


--
-- TOC entry 175 (class 1259 OID 24642)
-- Name: permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permission_id_seq OWNER TO postgres;

--
-- TOC entry 2276 (class 0 OID 0)
-- Dependencies: 175
-- Name: permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permission_id_seq OWNED BY permission.id;


--
-- TOC entry 188 (class 1259 OID 32797)
-- Name: property_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE property_type (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    "Description" text
);


ALTER TABLE property_type OWNER TO postgres;

--
-- TOC entry 2277 (class 0 OID 0)
-- Dependencies: 188
-- Name: TABLE property_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE property_type IS 'Type of property.';


--
-- TOC entry 187 (class 1259 OID 32795)
-- Name: property_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE property_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE property_type_id_seq OWNER TO postgres;

--
-- TOC entry 2278 (class 0 OID 0)
-- Dependencies: 187
-- Name: property_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE property_type_id_seq OWNED BY property_type.id;


--
-- TOC entry 209 (class 1259 OID 32928)
-- Name: request_response; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE request_response (
    id integer NOT NULL,
    request_id integer NOT NULL,
    response_id integer NOT NULL
);


ALTER TABLE request_response OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 32926)
-- Name: request_response_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE request_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE request_response_id_seq OWNER TO postgres;

--
-- TOC entry 2279 (class 0 OID 0)
-- Dependencies: 208
-- Name: request_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE request_response_id_seq OWNED BY request_response.id;


--
-- TOC entry 194 (class 1259 OID 32840)
-- Name: request_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE request_type (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE request_type OWNER TO postgres;

--
-- TOC entry 2280 (class 0 OID 0)
-- Dependencies: 194
-- Name: TABLE request_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE request_type IS 'Types of collaboration request.';


--
-- TOC entry 193 (class 1259 OID 32838)
-- Name: request_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE request_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE request_type_id_seq OWNER TO postgres;

--
-- TOC entry 2281 (class 0 OID 0)
-- Dependencies: 193
-- Name: request_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE request_type_id_seq OWNED BY request_type.id;


--
-- TOC entry 205 (class 1259 OID 32908)
-- Name: response; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE response (
    id integer NOT NULL,
    request_id integer NOT NULL,
    member_id integer NOT NULL,
    response_text text NOT NULL,
    submission_date integer NOT NULL
);


ALTER TABLE response OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 32920)
-- Name: response_document; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE response_document (
    id integer NOT NULL,
    response_id integer NOT NULL,
    document_name character varying(100) NOT NULL,
    document_path character varying(100) NOT NULL
);


ALTER TABLE response_document OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 32918)
-- Name: response_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE response_document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE response_document_id_seq OWNER TO postgres;

--
-- TOC entry 2282 (class 0 OID 0)
-- Dependencies: 206
-- Name: response_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE response_document_id_seq OWNED BY response_document.id;


--
-- TOC entry 203 (class 1259 OID 32904)
-- Name: response_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE response_id_seq OWNER TO postgres;

--
-- TOC entry 2283 (class 0 OID 0)
-- Dependencies: 203
-- Name: response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE response_id_seq OWNED BY response.id;


--
-- TOC entry 204 (class 1259 OID 32906)
-- Name: response_submission_date_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE response_submission_date_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE response_submission_date_seq OWNER TO postgres;

--
-- TOC entry 2284 (class 0 OID 0)
-- Dependencies: 204
-- Name: response_submission_date_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE response_submission_date_seq OWNED BY response.submission_date;


--
-- TOC entry 174 (class 1259 OID 24630)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text
);


ALTER TABLE role OWNER TO postgres;

--
-- TOC entry 2285 (class 0 OID 0)
-- Dependencies: 174
-- Name: TABLE role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE role IS 'Table defining user roles.';


--
-- TOC entry 173 (class 1259 OID 24628)
-- Name: role_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE role_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_id_seq1 OWNER TO postgres;

--
-- TOC entry 2286 (class 0 OID 0)
-- Dependencies: 173
-- Name: role_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE role_id_seq1 OWNED BY role.id;


--
-- TOC entry 178 (class 1259 OID 24657)
-- Name: role_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE role_permission (
    id integer NOT NULL,
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE role_permission OWNER TO postgres;

--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 178
-- Name: TABLE role_permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE role_permission IS 'Table which connects a role with the permissions.';


--
-- TOC entry 177 (class 1259 OID 24655)
-- Name: role_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE role_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_permission_id_seq OWNER TO postgres;

--
-- TOC entry 2288 (class 0 OID 0)
-- Dependencies: 177
-- Name: role_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE role_permission_id_seq OWNED BY role_permission.id;


--
-- TOC entry 196 (class 1259 OID 32853)
-- Name: status; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE status (
    id integer NOT NULL,
    tekst character varying(25) NOT NULL
);


ALTER TABLE status OWNER TO postgres;

--
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 196
-- Name: TABLE status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE status IS 'Status kolaboracionog zahteva.';


--
-- TOC entry 195 (class 1259 OID 32851)
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE status_id_seq OWNER TO postgres;

--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 195
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE status_id_seq OWNED BY status.id;


--
-- TOC entry 180 (class 1259 OID 24665)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(50) NOT NULL,
    role_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    description text
);


ALTER TABLE "user" OWNER TO postgres;

--
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 180
-- Name: TABLE "user"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "user" IS 'Table of users.';


--
-- TOC entry 179 (class 1259 OID 24663)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO postgres;

--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 179
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- TOC entry 182 (class 1259 OID 24681)
-- Name: user_member; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_member (
    id integer NOT NULL,
    user_id integer NOT NULL,
    member_id integer NOT NULL
);


ALTER TABLE user_member OWNER TO postgres;

--
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 182
-- Name: TABLE user_member; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE user_member IS 'Table that connects users and members.';


--
-- TOC entry 181 (class 1259 OID 24679)
-- Name: user_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_member_id_seq OWNER TO postgres;

--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 181
-- Name: user_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_member_id_seq OWNED BY user_member.id;


--
-- TOC entry 2005 (class 2604 OID 32826)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY member ALTER COLUMN id SET DEFAULT nextval('member_id_seq'::regclass);


--
-- TOC entry 2002 (class 2604 OID 32787)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY member_role ALTER COLUMN id SET DEFAULT nextval('member_role_id_seq'::regclass);


--
-- TOC entry 2001 (class 2604 OID 32774)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY member_type ALTER COLUMN id SET DEFAULT nextval('member_type_id_seq'::regclass);


--
-- TOC entry 1997 (class 2604 OID 24647)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permission ALTER COLUMN id SET DEFAULT nextval('permission_id_seq'::regclass);


--
-- TOC entry 2003 (class 2604 OID 32800)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY property_type ALTER COLUMN id SET DEFAULT nextval('property_type_id_seq'::regclass);


--
-- TOC entry 2008 (class 2604 OID 32868)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request ALTER COLUMN id SET DEFAULT nextval('collaboration_id_seq'::regclass);


--
-- TOC entry 2004 (class 2604 OID 32813)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_domain ALTER COLUMN id SET DEFAULT nextval('collaboration_type_id_seq'::regclass);


--
-- TOC entry 2009 (class 2604 OID 32893)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_member_type ALTER COLUMN id SET DEFAULT nextval('collaboration_member_type_id_seq'::regclass);


--
-- TOC entry 2010 (class 2604 OID 32901)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_property_type ALTER COLUMN id SET DEFAULT nextval('collaboration_property_type_id_seq'::regclass);


--
-- TOC entry 2014 (class 2604 OID 32931)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_response ALTER COLUMN id SET DEFAULT nextval('request_response_id_seq'::regclass);


--
-- TOC entry 2006 (class 2604 OID 32843)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_type ALTER COLUMN id SET DEFAULT nextval('request_type_id_seq'::regclass);


--
-- TOC entry 2011 (class 2604 OID 32911)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY response ALTER COLUMN id SET DEFAULT nextval('response_id_seq'::regclass);


--
-- TOC entry 2012 (class 2604 OID 32912)
-- Name: submission_date; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY response ALTER COLUMN submission_date SET DEFAULT nextval('response_submission_date_seq'::regclass);


--
-- TOC entry 2013 (class 2604 OID 32923)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY response_document ALTER COLUMN id SET DEFAULT nextval('response_document_id_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 24633)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq1'::regclass);


--
-- TOC entry 1998 (class 2604 OID 24660)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_permission ALTER COLUMN id SET DEFAULT nextval('role_permission_id_seq'::regclass);


--
-- TOC entry 2007 (class 2604 OID 32856)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);


--
-- TOC entry 1999 (class 2604 OID 24668)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- TOC entry 2000 (class 2604 OID 24684)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_member ALTER COLUMN id SET DEFAULT nextval('user_member_id_seq'::regclass);


--
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 197
-- Name: collaboration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('collaboration_id_seq', 1, false);


--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 199
-- Name: collaboration_member_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('collaboration_member_type_id_seq', 1, false);


--
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 201
-- Name: collaboration_property_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('collaboration_property_type_id_seq', 1, false);


--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 189
-- Name: collaboration_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('collaboration_type_id_seq', 2, true);


--
-- TOC entry 2237 (class 0 OID 32823)
-- Dependencies: 192
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY member (id, name, description, member_type_id, role_id, property_type_id, request_domain_id, activities, email, url) FROM stdin;
\.


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 191
-- Name: member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('member_id_seq', 1, false);


--
-- TOC entry 2231 (class 0 OID 32784)
-- Dependencies: 186
-- Data for Name: member_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY member_role (id, name, description) FROM stdin;
1	Konsultant	
2	Predstavnik	
\.


--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 185
-- Name: member_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('member_role_id_seq', 2, true);


--
-- TOC entry 2229 (class 0 OID 32771)
-- Dependencies: 184
-- Data for Name: member_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY member_type (id, name, "Description") FROM stdin;
1	NIO	Naučno istraživačka organizacija.
2	Preduzeće	Preduzeće
3	Kapital fond	
4	Inovaciona organizacija	
\.


--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 183
-- Name: member_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('member_type_id_seq', 4, true);


--
-- TOC entry 2221 (class 0 OID 24644)
-- Dependencies: 176
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permission (id, name, description) FROM stdin;
1	all_enquiries_read	Can see enquiries from all users.
2	all_enquiries_write	Can change details of all enquiries.
3	all_users_change	Can change details on all users, as well ad adding and deleting them.
4	member_users_change	Can change details on all users of the member, as well as adding and deleting them.
5	member_enquiries_read	Can read the details on enquiries made by users that belong to a member as well as the enquiries from other members that match the current member.
6	member_enquiries_change	Can change the details on enquiries made by users that belong to a member as well as the enquiries from other members that match the current member.
7	member_enquiries_add_remove	Can add or remove the member enquiries.
\.


--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 175
-- Name: permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permission_id_seq', 7, true);


--
-- TOC entry 2233 (class 0 OID 32797)
-- Dependencies: 188
-- Data for Name: property_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY property_type (id, name, "Description") FROM stdin;
1	Državna	
2	Privatna	
3	Mešovita	
4	Neprofitna	
\.


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 187
-- Name: property_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('property_type_id_seq', 4, true);


--
-- TOC entry 2243 (class 0 OID 32865)
-- Dependencies: 198
-- Data for Name: request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY request (id, name, description, request_type_id, init_member_id, status_id, request_domain_id, activity_of_interest, submission_date) FROM stdin;
\.


--
-- TOC entry 2235 (class 0 OID 32810)
-- Dependencies: 190
-- Data for Name: request_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY request_domain (id, name, description) FROM stdin;
1	Domaća	Saradnja sa subjektima u zemlji.
2	Međunarodna	Saradnja sa međunarodnim subjektima.
\.


--
-- TOC entry 2245 (class 0 OID 32890)
-- Dependencies: 200
-- Data for Name: request_member_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY request_member_type (id, request_id, member_type_id) FROM stdin;
\.


--
-- TOC entry 2247 (class 0 OID 32898)
-- Dependencies: 202
-- Data for Name: request_property_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY request_property_type (id, request_id, property_type_id) FROM stdin;
\.


--
-- TOC entry 2254 (class 0 OID 32928)
-- Dependencies: 209
-- Data for Name: request_response; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY request_response (id, request_id, response_id) FROM stdin;
\.


--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 208
-- Name: request_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('request_response_id_seq', 1, false);


--
-- TOC entry 2239 (class 0 OID 32840)
-- Dependencies: 194
-- Data for Name: request_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY request_type (id, name, description) FROM stdin;
1	Predlaganje saradnje	
2	Zajednička realizacija	
3	Sufinansiranje	
4	Učešće na projektu	
5	Nabavka	
6	Ponuda	
\.


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 193
-- Name: request_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('request_type_id_seq', 6, true);


--
-- TOC entry 2250 (class 0 OID 32908)
-- Dependencies: 205
-- Data for Name: response; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY response (id, request_id, member_id, response_text, submission_date) FROM stdin;
\.


--
-- TOC entry 2252 (class 0 OID 32920)
-- Dependencies: 207
-- Data for Name: response_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY response_document (id, response_id, document_name, document_path) FROM stdin;
\.


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 206
-- Name: response_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('response_document_id_seq', 1, false);


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 203
-- Name: response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('response_id_seq', 1, false);


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 204
-- Name: response_submission_date_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('response_submission_date_seq', 1, false);


--
-- TOC entry 2219 (class 0 OID 24630)
-- Dependencies: 174
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY role (id, name, description) FROM stdin;
1	sa	Super administrator - Administrator of the whole system. Sees all, can change all. 
3	user	Common user.
2	admin	Administrator of the member. 
\.


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 173
-- Name: role_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('role_id_seq1', 3, true);


--
-- TOC entry 2223 (class 0 OID 24657)
-- Dependencies: 178
-- Data for Name: role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY role_permission (id, role_id, permission_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	4
5	2	5
6	2	6
7	3	5
8	3	6
9	3	7
\.


--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 177
-- Name: role_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('role_permission_id_seq', 9, true);


--
-- TOC entry 2241 (class 0 OID 32853)
-- Dependencies: 196
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY status (id, tekst) FROM stdin;
1	Novi
3	Obustavljen
4	Zaključen
5	Arhiviran
2	Aktivan
\.


--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 195
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('status_id_seq', 5, true);


--
-- TOC entry 2225 (class 0 OID 24665)
-- Dependencies: 180
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "user" (id, name, email, role_id, username, password, description) FROM stdin;
1	Sinisa Ristic	sinisa.ristic@gmail.com	1	lucky1603	ed84391b9e0e044fd793033655c32170	Glavni administrator i tvorac sistema.
\.


--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 179
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_id_seq', 1, true);


--
-- TOC entry 2227 (class 0 OID 24681)
-- Dependencies: 182
-- Data for Name: user_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_member (id, user_id, member_id) FROM stdin;
\.


--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 181
-- Name: user_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_member_id_seq', 1, false);


--
-- TOC entry 2070 (class 2606 OID 32873)
-- Name: collaboration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request
    ADD CONSTRAINT collaboration_pkey PRIMARY KEY (id);


--
-- TOC entry 2050 (class 2606 OID 32820)
-- Name: collaboration_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_domain
    ADD CONSTRAINT collaboration_type_name_key UNIQUE (name);


--
-- TOC entry 2052 (class 2606 OID 32818)
-- Name: collaboration_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_domain
    ADD CONSTRAINT collaboration_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2054 (class 2606 OID 32835)
-- Name: member_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_email_key UNIQUE (email);


--
-- TOC entry 2056 (class 2606 OID 32833)
-- Name: member_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_name_key UNIQUE (name);


--
-- TOC entry 2058 (class 2606 OID 32831)
-- Name: member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- TOC entry 2042 (class 2606 OID 32794)
-- Name: member_role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member_role
    ADD CONSTRAINT member_role_name_key UNIQUE (name);


--
-- TOC entry 2044 (class 2606 OID 32792)
-- Name: member_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member_role
    ADD CONSTRAINT member_role_pkey PRIMARY KEY (id);


--
-- TOC entry 2038 (class 2606 OID 32781)
-- Name: member_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member_type
    ADD CONSTRAINT member_type_name_key UNIQUE (name);


--
-- TOC entry 2040 (class 2606 OID 32779)
-- Name: member_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member_type
    ADD CONSTRAINT member_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2060 (class 2606 OID 32837)
-- Name: member_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_url_key UNIQUE (url);


--
-- TOC entry 2020 (class 2606 OID 24654)
-- Name: permission_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT permission_name_key UNIQUE (name);


--
-- TOC entry 2022 (class 2606 OID 24652)
-- Name: permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);


--
-- TOC entry 2046 (class 2606 OID 32807)
-- Name: property_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY property_type
    ADD CONSTRAINT property_type_name_key UNIQUE (name);


--
-- TOC entry 2048 (class 2606 OID 32805)
-- Name: property_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY property_type
    ADD CONSTRAINT property_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2072 (class 2606 OID 32938)
-- Name: request_member_type_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_member_type
    ADD CONSTRAINT request_member_type_pk PRIMARY KEY (id);


--
-- TOC entry 2074 (class 2606 OID 32952)
-- Name: request_member_type_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_member_type
    ADD CONSTRAINT request_member_type_uk UNIQUE (request_id, member_type_id);


--
-- TOC entry 2076 (class 2606 OID 32936)
-- Name: request_property_type_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_property_type
    ADD CONSTRAINT request_property_type_pk PRIMARY KEY (id);


--
-- TOC entry 2078 (class 2606 OID 32964)
-- Name: request_property_type_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_property_type
    ADD CONSTRAINT request_property_type_uk UNIQUE (request_id, property_type_id);


--
-- TOC entry 2084 (class 2606 OID 32933)
-- Name: request_response_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_response
    ADD CONSTRAINT request_response_pkey PRIMARY KEY (id);


--
-- TOC entry 2086 (class 2606 OID 32976)
-- Name: request_response_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_response
    ADD CONSTRAINT request_response_uk UNIQUE (request_id, response_id);


--
-- TOC entry 2062 (class 2606 OID 32850)
-- Name: request_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_type
    ADD CONSTRAINT request_type_name_key UNIQUE (name);


--
-- TOC entry 2064 (class 2606 OID 32848)
-- Name: request_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY request_type
    ADD CONSTRAINT request_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2082 (class 2606 OID 32925)
-- Name: response_document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY response_document
    ADD CONSTRAINT response_document_pkey PRIMARY KEY (id);


--
-- TOC entry 2080 (class 2606 OID 32917)
-- Name: response_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY response
    ADD CONSTRAINT response_pkey PRIMARY KEY (id);


--
-- TOC entry 2016 (class 2606 OID 24640)
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- TOC entry 2024 (class 2606 OID 24662)
-- Name: role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 2026 (class 2606 OID 32940)
-- Name: role_permission_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_uk UNIQUE (permission_id, role_id);


--
-- TOC entry 2018 (class 2606 OID 24638)
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 2066 (class 2606 OID 32858)
-- Name: status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- TOC entry 2068 (class 2606 OID 32860)
-- Name: status_tekst_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_tekst_key UNIQUE (tekst);


--
-- TOC entry 2028 (class 2606 OID 24675)
-- Name: user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 2034 (class 2606 OID 24686)
-- Name: user_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_pkey PRIMARY KEY (id);


--
-- TOC entry 2036 (class 2606 OID 33048)
-- Name: user_member_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_uk UNIQUE (user_id, member_id);


--
-- TOC entry 2030 (class 2606 OID 24673)
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 2032 (class 2606 OID 24677)
-- Name: user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- TOC entry 2092 (class 2606 OID 32987)
-- Name: member_fk_member_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_fk_member_type FOREIGN KEY (member_type_id) REFERENCES member_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2094 (class 2606 OID 32997)
-- Name: member_fk_property_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_fk_property_type FOREIGN KEY (property_type_id) REFERENCES property_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2095 (class 2606 OID 33002)
-- Name: member_fk_request_domain; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_fk_request_domain FOREIGN KEY (request_domain_id) REFERENCES request_domain(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2093 (class 2606 OID 32992)
-- Name: member_fk_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_fk_role FOREIGN KEY (role_id) REFERENCES role(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2097 (class 2606 OID 33012)
-- Name: request_fk_init_member; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request
    ADD CONSTRAINT request_fk_init_member FOREIGN KEY (init_member_id) REFERENCES member(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2099 (class 2606 OID 33022)
-- Name: request_fk_request_domain; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request
    ADD CONSTRAINT request_fk_request_domain FOREIGN KEY (request_domain_id) REFERENCES request_domain(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2096 (class 2606 OID 33007)
-- Name: request_fk_request_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request
    ADD CONSTRAINT request_fk_request_type FOREIGN KEY (request_type_id) REFERENCES request_type(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2098 (class 2606 OID 33017)
-- Name: request_fk_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request
    ADD CONSTRAINT request_fk_status FOREIGN KEY (status_id) REFERENCES status(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2101 (class 2606 OID 32958)
-- Name: request_member_type_fk_member_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_member_type
    ADD CONSTRAINT request_member_type_fk_member_type FOREIGN KEY (member_type_id) REFERENCES member_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2100 (class 2606 OID 32953)
-- Name: request_member_type_fk_request; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_member_type
    ADD CONSTRAINT request_member_type_fk_request FOREIGN KEY (request_id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2103 (class 2606 OID 32970)
-- Name: request_property_type_fk_property_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_property_type
    ADD CONSTRAINT request_property_type_fk_property_type FOREIGN KEY (property_type_id) REFERENCES property_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2102 (class 2606 OID 32965)
-- Name: request_property_type_fk_request; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_property_type
    ADD CONSTRAINT request_property_type_fk_request FOREIGN KEY (request_id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2107 (class 2606 OID 32977)
-- Name: request_response_fk_request; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_response
    ADD CONSTRAINT request_response_fk_request FOREIGN KEY (request_id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2108 (class 2606 OID 32982)
-- Name: request_response_fk_response; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY request_response
    ADD CONSTRAINT request_response_fk_response FOREIGN KEY (response_id) REFERENCES response(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2106 (class 2606 OID 33037)
-- Name: response_document_fk_response; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY response_document
    ADD CONSTRAINT response_document_fk_response FOREIGN KEY (response_id) REFERENCES response(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2105 (class 2606 OID 33032)
-- Name: response_fk_member; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY response
    ADD CONSTRAINT response_fk_member FOREIGN KEY (member_id) REFERENCES member(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2104 (class 2606 OID 33027)
-- Name: response_fk_request; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY response
    ADD CONSTRAINT response_fk_request FOREIGN KEY (request_id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2088 (class 2606 OID 32946)
-- Name: role_permission_permission_vkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_permission_vkey FOREIGN KEY (permission_id) REFERENCES permission(id) ON DELETE CASCADE;


--
-- TOC entry 2087 (class 2606 OID 32941)
-- Name: role_permission_role_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_role_pkey FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE;


--
-- TOC entry 2089 (class 2606 OID 33042)
-- Name: user_fk_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_fk_role FOREIGN KEY (role_id) REFERENCES role(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2091 (class 2606 OID 33054)
-- Name: user_member_fk_member; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_fk_member FOREIGN KEY (member_id) REFERENCES member(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2090 (class 2606 OID 33049)
-- Name: user_member_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_fk_user FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-10-23 15:29:52

--
-- PostgreSQL database dump complete
--

