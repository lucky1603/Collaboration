PGDMP                  	        u            ntkp    10.1    10.0 �    X           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            Y           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            Z           1262    16798    ntkp    DATABASE     �   CREATE DATABASE ntkp WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE ntkp;
             postgres    false            [           1262    16798    ntkp    COMMENT     =   COMMENT ON DATABASE ntkp IS 'Baza kolaboracione platforme.';
                  postgres    false    3162                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            \           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            ]           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16799    user    TABLE     C  CREATE TABLE "user" (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(50) NOT NULL,
    role_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    description text,
    user_status_id integer DEFAULT 1 NOT NULL
);
    DROP TABLE public."user";
       public         postgres    false    3            ^           0    0    TABLE "user"    COMMENT     .   COMMENT ON TABLE "user" IS 'Table of users.';
            public       postgres    false    196            �            1259    16806 	   UserMaxId    VIEW     I   CREATE VIEW "UserMaxId" AS
 SELECT max("user".id) AS max
   FROM "user";
    DROP VIEW public."UserMaxId";
       public       postgres    false    196    3            �            1259    16810    activity    TABLE     �   CREATE TABLE activity (
    id integer NOT NULL,
    section character varying(1) NOT NULL,
    class integer NOT NULL,
    description text NOT NULL
);
    DROP TABLE public.activity;
       public         postgres    false    3            _           0    0    COLUMN activity.id    COMMENT     1   COMMENT ON COLUMN activity.id IS 'Kljuc tabele';
            public       postgres    false    198            `           0    0    COLUMN activity.section    COMMENT     ?   COMMENT ON COLUMN activity.section IS 'Sekcija po ISIC rev.4';
            public       postgres    false    198            a           0    0    COLUMN activity.class    COMMENT     ;   COMMENT ON COLUMN activity.class IS 'Klasa po ISIC rev.4';
            public       postgres    false    198            b           0    0    COLUMN activity.description    COMMENT     >   COMMENT ON COLUMN activity.description IS 'Opis aktivnosti.';
            public       postgres    false    198            �            1259    16816    activity_id_seq    SEQUENCE     q   CREATE SEQUENCE activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.activity_id_seq;
       public       postgres    false    198    3            c           0    0    activity_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE activity_id_seq OWNED BY activity.id;
            public       postgres    false    199            �            1259    16818    activity_section    TABLE     l   CREATE TABLE activity_section (
    key character(1) NOT NULL,
    value character varying(100) NOT NULL
);
 $   DROP TABLE public.activity_section;
       public         postgres    false    3            �            1259    16821    request    TABLE     ?  CREATE TABLE request (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    request_type_id integer NOT NULL,
    init_member_id integer NOT NULL,
    status_id integer NOT NULL,
    request_domain_id integer NOT NULL,
    submission_date timestamp without time zone NOT NULL
);
    DROP TABLE public.request;
       public         postgres    false    3            d           0    0    TABLE request    COMMENT     @   COMMENT ON TABLE request IS 'Table of collaboration requests.';
            public       postgres    false    201            �            1259    16827    collaboration_id_seq    SEQUENCE     v   CREATE SEQUENCE collaboration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.collaboration_id_seq;
       public       postgres    false    3    201            e           0    0    collaboration_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE collaboration_id_seq OWNED BY request.id;
            public       postgres    false    202            �            1259    16829    request_member_type    TABLE     �   CREATE TABLE request_member_type (
    id integer NOT NULL,
    request_id integer NOT NULL,
    member_type_id integer NOT NULL
);
 '   DROP TABLE public.request_member_type;
       public         postgres    false    3            �            1259    16832     collaboration_member_type_id_seq    SEQUENCE     �   CREATE SEQUENCE collaboration_member_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.collaboration_member_type_id_seq;
       public       postgres    false    3    203            f           0    0     collaboration_member_type_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE collaboration_member_type_id_seq OWNED BY request_member_type.id;
            public       postgres    false    204            �            1259    16834    request_property_type    TABLE     �   CREATE TABLE request_property_type (
    id integer NOT NULL,
    request_id integer NOT NULL,
    property_type_id integer NOT NULL
);
 )   DROP TABLE public.request_property_type;
       public         postgres    false    3            �            1259    16837 "   collaboration_property_type_id_seq    SEQUENCE     �   CREATE SEQUENCE collaboration_property_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.collaboration_property_type_id_seq;
       public       postgres    false    205    3            g           0    0 "   collaboration_property_type_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE collaboration_property_type_id_seq OWNED BY request_property_type.id;
            public       postgres    false    206            �            1259    16839    request_domain    TABLE     x   CREATE TABLE request_domain (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);
 "   DROP TABLE public.request_domain;
       public         postgres    false    3            h           0    0    TABLE request_domain    COMMENT     M   COMMENT ON TABLE request_domain IS 'Possible types/areas of collaboration.';
            public       postgres    false    207            �            1259    16845    collaboration_type_id_seq    SEQUENCE     {   CREATE SEQUENCE collaboration_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.collaboration_type_id_seq;
       public       postgres    false    207    3            i           0    0    collaboration_type_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE collaboration_type_id_seq OWNED BY request_domain.id;
            public       postgres    false    208            �            1259    16847    member    TABLE     �  CREATE TABLE member (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    member_type_id integer NOT NULL,
    member_role_id integer NOT NULL,
    property_type_id integer NOT NULL,
    request_domain_id integer NOT NULL,
    email character varying(100) NOT NULL,
    url character varying(100) NOT NULL,
    member_status_id integer NOT NULL,
    kontakt_osoba character varying(100)
);
    DROP TABLE public.member;
       public         postgres    false    3            j           0    0    TABLE member    COMMENT     G   COMMENT ON TABLE member IS 'Table of collaboration platform members.';
            public       postgres    false    209            k           0    0    COLUMN member.member_role_id    COMMENT     O   COMMENT ON COLUMN member.member_role_id IS 'Referenca na tabelu member_role.';
            public       postgres    false    209            l           0    0    COLUMN member.kontakt_osoba    COMMENT     =   COMMENT ON COLUMN member.kontakt_osoba IS 'Contact person.';
            public       postgres    false    209            �            1259    16853    member_activity    TABLE     |   CREATE TABLE member_activity (
    id integer NOT NULL,
    member_id integer NOT NULL,
    activity_id integer NOT NULL
);
 #   DROP TABLE public.member_activity;
       public         postgres    false    3            �            1259    16856    member_activity_id_seq    SEQUENCE     x   CREATE SEQUENCE member_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.member_activity_id_seq;
       public       postgres    false    3    210            m           0    0    member_activity_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE member_activity_id_seq OWNED BY member_activity.id;
            public       postgres    false    211            �            1259    16858    member_id_seq    SEQUENCE     o   CREATE SEQUENCE member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.member_id_seq;
       public       postgres    false    3    209            n           0    0    member_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE member_id_seq OWNED BY member.id;
            public       postgres    false    212            �            1259    16860    member_role    TABLE     u   CREATE TABLE member_role (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);
    DROP TABLE public.member_role;
       public         postgres    false    3            o           0    0    TABLE member_role    COMMENT     Q   COMMENT ON TABLE member_role IS 'Table of possible member roles in the system.';
            public       postgres    false    213            �            1259    16866    member_role_id_seq    SEQUENCE     t   CREATE SEQUENCE member_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.member_role_id_seq;
       public       postgres    false    213    3            p           0    0    member_role_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE member_role_id_seq OWNED BY member_role.id;
            public       postgres    false    214            �            1259    16868    member_status    TABLE     w   CREATE TABLE member_status (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);
 !   DROP TABLE public.member_status;
       public         postgres    false    3            �            1259    16874    member_type    TABLE     u   CREATE TABLE member_type (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);
    DROP TABLE public.member_type;
       public         postgres    false    3            q           0    0    TABLE member_type    COMMENT     b   COMMENT ON TABLE member_type IS 'Table with the possible types of collaboration system members.';
            public       postgres    false    216            �            1259    16880    member_type_id_seq    SEQUENCE     t   CREATE SEQUENCE member_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.member_type_id_seq;
       public       postgres    false    216    3            r           0    0    member_type_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE member_type_id_seq OWNED BY member_type.id;
            public       postgres    false    217            �            1259    16882 
   permission    TABLE     t   CREATE TABLE permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);
    DROP TABLE public.permission;
       public         postgres    false    3            s           0    0    TABLE permission    COMMENT     I   COMMENT ON TABLE permission IS 'Defines the permissions for the users.';
            public       postgres    false    218            �            1259    16888    permission_id_seq    SEQUENCE     s   CREATE SEQUENCE permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.permission_id_seq;
       public       postgres    false    218    3            t           0    0    permission_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE permission_id_seq OWNED BY permission.id;
            public       postgres    false    219            �            1259    16890    property_type    TABLE     y   CREATE TABLE property_type (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    "Description" text
);
 !   DROP TABLE public.property_type;
       public         postgres    false    3            u           0    0    TABLE property_type    COMMENT     7   COMMENT ON TABLE property_type IS 'Type of property.';
            public       postgres    false    220            �            1259    16896    property_type_id_seq    SEQUENCE     v   CREATE SEQUENCE property_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.property_type_id_seq;
       public       postgres    false    220    3            v           0    0    property_type_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE property_type_id_seq OWNED BY property_type.id;
            public       postgres    false    221            �            1259    17217    request_activity_seq    SEQUENCE     v   CREATE SEQUENCE request_activity_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.request_activity_seq;
       public       postgres    false    3            �            1259    17204    request_activity    TABLE     �   CREATE TABLE request_activity (
    id integer DEFAULT nextval('request_activity_seq'::regclass) NOT NULL,
    request_id integer NOT NULL,
    activity_id integer NOT NULL
);
 $   DROP TABLE public.request_activity;
       public         postgres    false    243    3            �            1259    17234    request_document    TABLE     �   CREATE TABLE request_document (
    id integer NOT NULL,
    request_id integer NOT NULL,
    document_name character varying(200) NOT NULL
);
 $   DROP TABLE public.request_document;
       public         postgres    false    3            �            1259    17232    request_document_id_seq    SEQUENCE     �   CREATE SEQUENCE request_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.request_document_id_seq;
       public       postgres    false    245    3            w           0    0    request_document_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE request_document_id_seq OWNED BY request_document.id;
            public       postgres    false    244            �            1259    16898    request_response    TABLE     ~   CREATE TABLE request_response (
    id integer NOT NULL,
    request_id integer NOT NULL,
    response_id integer NOT NULL
);
 $   DROP TABLE public.request_response;
       public         postgres    false    3            �            1259    16901    request_response_id_seq    SEQUENCE     y   CREATE SEQUENCE request_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.request_response_id_seq;
       public       postgres    false    3    222            x           0    0    request_response_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE request_response_id_seq OWNED BY request_response.id;
            public       postgres    false    223            �            1259    16903    request_type    TABLE     v   CREATE TABLE request_type (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);
     DROP TABLE public.request_type;
       public         postgres    false    3            y           0    0    TABLE request_type    COMMENT     D   COMMENT ON TABLE request_type IS 'Types of collaboration request.';
            public       postgres    false    224            �            1259    16909    request_type_id_seq    SEQUENCE     u   CREATE SEQUENCE request_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.request_type_id_seq;
       public       postgres    false    3    224            z           0    0    request_type_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE request_type_id_seq OWNED BY request_type.id;
            public       postgres    false    225            �            1259    16911    response    TABLE     �   CREATE TABLE response (
    id integer NOT NULL,
    request_id integer NOT NULL,
    member_id integer NOT NULL,
    response_text text NOT NULL,
    submission_date integer NOT NULL
);
    DROP TABLE public.response;
       public         postgres    false    3            �            1259    16917    response_document    TABLE     �   CREATE TABLE response_document (
    id integer NOT NULL,
    response_id integer NOT NULL,
    document_name character varying(100) NOT NULL,
    document_path character varying(100) NOT NULL
);
 %   DROP TABLE public.response_document;
       public         postgres    false    3            �            1259    16920    response_document_id_seq    SEQUENCE     z   CREATE SEQUENCE response_document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.response_document_id_seq;
       public       postgres    false    3    227            {           0    0    response_document_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE response_document_id_seq OWNED BY response_document.id;
            public       postgres    false    228            �            1259    16922    response_id_seq    SEQUENCE     q   CREATE SEQUENCE response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.response_id_seq;
       public       postgres    false    226    3            |           0    0    response_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE response_id_seq OWNED BY response.id;
            public       postgres    false    229            �            1259    16924    response_submission_date_seq    SEQUENCE     ~   CREATE SEQUENCE response_submission_date_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.response_submission_date_seq;
       public       postgres    false    3    226            }           0    0    response_submission_date_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE response_submission_date_seq OWNED BY response.submission_date;
            public       postgres    false    230            �            1259    16926    role    TABLE     n   CREATE TABLE role (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text
);
    DROP TABLE public.role;
       public         postgres    false    3            ~           0    0 
   TABLE role    COMMENT     7   COMMENT ON TABLE role IS 'Table defining user roles.';
            public       postgres    false    231            �            1259    16932    role_id_seq1    SEQUENCE     n   CREATE SEQUENCE role_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.role_id_seq1;
       public       postgres    false    231    3                       0    0    role_id_seq1    SEQUENCE OWNED BY     .   ALTER SEQUENCE role_id_seq1 OWNED BY role.id;
            public       postgres    false    232            �            1259    16934    role_permission    TABLE     |   CREATE TABLE role_permission (
    id integer NOT NULL,
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);
 #   DROP TABLE public.role_permission;
       public         postgres    false    3            �           0    0    TABLE role_permission    COMMENT     Y   COMMENT ON TABLE role_permission IS 'Table which connects a role with the permissions.';
            public       postgres    false    233            �            1259    16937    role_permission_id_seq    SEQUENCE     x   CREATE SEQUENCE role_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.role_permission_id_seq;
       public       postgres    false    233    3            �           0    0    role_permission_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE role_permission_id_seq OWNED BY role_permission.id;
            public       postgres    false    234            �            1259    16939    status    TABLE     [   CREATE TABLE status (
    id integer NOT NULL,
    tekst character varying(25) NOT NULL
);
    DROP TABLE public.status;
       public         postgres    false    3            �           0    0    TABLE status    COMMENT     =   COMMENT ON TABLE status IS 'Status kolaboracionog zahteva.';
            public       postgres    false    235            �            1259    16942    status_id_seq    SEQUENCE     o   CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.status_id_seq;
       public       postgres    false    3    235            �           0    0    status_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE status_id_seq OWNED BY status.id;
            public       postgres    false    236            �            1259    16944    user_id_seq    SEQUENCE     m   CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public       postgres    false    3    196            �           0    0    user_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE user_id_seq OWNED BY "user".id;
            public       postgres    false    237            �            1259    16946    user_member    TABLE     t   CREATE TABLE user_member (
    id integer NOT NULL,
    user_id integer NOT NULL,
    member_id integer NOT NULL
);
    DROP TABLE public.user_member;
       public         postgres    false    3            �           0    0    TABLE user_member    COMMENT     J   COMMENT ON TABLE user_member IS 'Table that connects users and members.';
            public       postgres    false    238            �            1259    16949    user_member_id_seq    SEQUENCE     t   CREATE SEQUENCE user_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.user_member_id_seq;
       public       postgres    false    238    3            �           0    0    user_member_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE user_member_id_seq OWNED BY user_member.id;
            public       postgres    false    239            �            1259    16951    user_status    TABLE     v   CREATE TABLE user_status (
    id integer NOT NULL,
    value character varying(20) NOT NULL,
    description text
);
    DROP TABLE public.user_status;
       public         postgres    false    3            �            1259    16957    user_status_id_seq    SEQUENCE     t   CREATE SEQUENCE user_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.user_status_id_seq;
       public       postgres    false    240    3            �           0    0    user_status_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE user_status_id_seq OWNED BY user_status.id;
            public       postgres    false    241                       2604    16959    activity id    DEFAULT     \   ALTER TABLE ONLY activity ALTER COLUMN id SET DEFAULT nextval('activity_id_seq'::regclass);
 :   ALTER TABLE public.activity ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    199    198                       2604    16960 	   member id    DEFAULT     X   ALTER TABLE ONLY member ALTER COLUMN id SET DEFAULT nextval('member_id_seq'::regclass);
 8   ALTER TABLE public.member ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    212    209                       2604    16961    member_activity id    DEFAULT     j   ALTER TABLE ONLY member_activity ALTER COLUMN id SET DEFAULT nextval('member_activity_id_seq'::regclass);
 A   ALTER TABLE public.member_activity ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    211    210                       2604    16962    member_role id    DEFAULT     b   ALTER TABLE ONLY member_role ALTER COLUMN id SET DEFAULT nextval('member_role_id_seq'::regclass);
 =   ALTER TABLE public.member_role ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    214    213                       2604    16963    member_type id    DEFAULT     b   ALTER TABLE ONLY member_type ALTER COLUMN id SET DEFAULT nextval('member_type_id_seq'::regclass);
 =   ALTER TABLE public.member_type ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    217    216                       2604    16964    permission id    DEFAULT     `   ALTER TABLE ONLY permission ALTER COLUMN id SET DEFAULT nextval('permission_id_seq'::regclass);
 <   ALTER TABLE public.permission ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    219    218                       2604    16965    property_type id    DEFAULT     f   ALTER TABLE ONLY property_type ALTER COLUMN id SET DEFAULT nextval('property_type_id_seq'::regclass);
 ?   ALTER TABLE public.property_type ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    221    220                       2604    16966 
   request id    DEFAULT     `   ALTER TABLE ONLY request ALTER COLUMN id SET DEFAULT nextval('collaboration_id_seq'::regclass);
 9   ALTER TABLE public.request ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    202    201            &           2604    17237    request_document id    DEFAULT     l   ALTER TABLE ONLY request_document ALTER COLUMN id SET DEFAULT nextval('request_document_id_seq'::regclass);
 B   ALTER TABLE public.request_document ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    244    245    245                       2604    16967    request_domain id    DEFAULT     l   ALTER TABLE ONLY request_domain ALTER COLUMN id SET DEFAULT nextval('collaboration_type_id_seq'::regclass);
 @   ALTER TABLE public.request_domain ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    208    207                       2604    16968    request_member_type id    DEFAULT     x   ALTER TABLE ONLY request_member_type ALTER COLUMN id SET DEFAULT nextval('collaboration_member_type_id_seq'::regclass);
 E   ALTER TABLE public.request_member_type ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    204    203                       2604    16969    request_property_type id    DEFAULT     |   ALTER TABLE ONLY request_property_type ALTER COLUMN id SET DEFAULT nextval('collaboration_property_type_id_seq'::regclass);
 G   ALTER TABLE public.request_property_type ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    206    205                       2604    16970    request_response id    DEFAULT     l   ALTER TABLE ONLY request_response ALTER COLUMN id SET DEFAULT nextval('request_response_id_seq'::regclass);
 B   ALTER TABLE public.request_response ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    223    222                       2604    16971    request_type id    DEFAULT     d   ALTER TABLE ONLY request_type ALTER COLUMN id SET DEFAULT nextval('request_type_id_seq'::regclass);
 >   ALTER TABLE public.request_type ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    225    224                       2604    16972    response id    DEFAULT     \   ALTER TABLE ONLY response ALTER COLUMN id SET DEFAULT nextval('response_id_seq'::regclass);
 :   ALTER TABLE public.response ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    229    226                       2604    16973    response submission_date    DEFAULT     v   ALTER TABLE ONLY response ALTER COLUMN submission_date SET DEFAULT nextval('response_submission_date_seq'::regclass);
 G   ALTER TABLE public.response ALTER COLUMN submission_date DROP DEFAULT;
       public       postgres    false    230    226                       2604    16974    response_document id    DEFAULT     n   ALTER TABLE ONLY response_document ALTER COLUMN id SET DEFAULT nextval('response_document_id_seq'::regclass);
 C   ALTER TABLE public.response_document ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    228    227                        2604    16975    role id    DEFAULT     U   ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq1'::regclass);
 6   ALTER TABLE public.role ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    232    231            !           2604    16976    role_permission id    DEFAULT     j   ALTER TABLE ONLY role_permission ALTER COLUMN id SET DEFAULT nextval('role_permission_id_seq'::regclass);
 A   ALTER TABLE public.role_permission ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    234    233            "           2604    16977 	   status id    DEFAULT     X   ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);
 8   ALTER TABLE public.status ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    236    235                       2604    16978    user id    DEFAULT     V   ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);
 8   ALTER TABLE public."user" ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    237    196            #           2604    16979    user_member id    DEFAULT     b   ALTER TABLE ONLY user_member ALTER COLUMN id SET DEFAULT nextval('user_member_id_seq'::regclass);
 =   ALTER TABLE public.user_member ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    239    238            $           2604    16980    user_status id    DEFAULT     b   ALTER TABLE ONLY user_status ALTER COLUMN id SET DEFAULT nextval('user_status_id_seq'::regclass);
 =   ALTER TABLE public.user_status ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    241    240            &          0    16810    activity 
   TABLE DATA               <   COPY activity (id, section, class, description) FROM stdin;
    public       postgres    false    198   �      (          0    16818    activity_section 
   TABLE DATA               /   COPY activity_section (key, value) FROM stdin;
    public       postgres    false    200   �      1          0    16847    member 
   TABLE DATA               �   COPY member (id, name, description, member_type_id, member_role_id, property_type_id, request_domain_id, email, url, member_status_id, kontakt_osoba) FROM stdin;
    public       postgres    false    209   �!      2          0    16853    member_activity 
   TABLE DATA               >   COPY member_activity (id, member_id, activity_id) FROM stdin;
    public       postgres    false    210   �"      5          0    16860    member_role 
   TABLE DATA               5   COPY member_role (id, name, description) FROM stdin;
    public       postgres    false    213   �"      7          0    16868    member_status 
   TABLE DATA               7   COPY member_status (id, name, description) FROM stdin;
    public       postgres    false    215   2#      8          0    16874    member_type 
   TABLE DATA               5   COPY member_type (id, name, description) FROM stdin;
    public       postgres    false    216   $      :          0    16882 
   permission 
   TABLE DATA               4   COPY permission (id, name, description) FROM stdin;
    public       postgres    false    218   {$      <          0    16890    property_type 
   TABLE DATA               9   COPY property_type (id, name, "Description") FROM stdin;
    public       postgres    false    220   z%      )          0    16821    request 
   TABLE DATA               �   COPY request (id, name, description, request_type_id, init_member_id, status_id, request_domain_id, submission_date) FROM stdin;
    public       postgres    false    201   �%      R          0    17204    request_activity 
   TABLE DATA               @   COPY request_activity (id, request_id, activity_id) FROM stdin;
    public       postgres    false    242   �%      U          0    17234    request_document 
   TABLE DATA               B   COPY request_document (id, request_id, document_name) FROM stdin;
    public       postgres    false    245   �%      /          0    16839    request_domain 
   TABLE DATA               8   COPY request_domain (id, name, description) FROM stdin;
    public       postgres    false    207   &      +          0    16829    request_member_type 
   TABLE DATA               F   COPY request_member_type (id, request_id, member_type_id) FROM stdin;
    public       postgres    false    203   z&      -          0    16834    request_property_type 
   TABLE DATA               J   COPY request_property_type (id, request_id, property_type_id) FROM stdin;
    public       postgres    false    205   �&      >          0    16898    request_response 
   TABLE DATA               @   COPY request_response (id, request_id, response_id) FROM stdin;
    public       postgres    false    222   �&      @          0    16903    request_type 
   TABLE DATA               6   COPY request_type (id, name, description) FROM stdin;
    public       postgres    false    224   �&      B          0    16911    response 
   TABLE DATA               V   COPY response (id, request_id, member_id, response_text, submission_date) FROM stdin;
    public       postgres    false    226   Z'      C          0    16917    response_document 
   TABLE DATA               S   COPY response_document (id, response_id, document_name, document_path) FROM stdin;
    public       postgres    false    227   w'      G          0    16926    role 
   TABLE DATA               .   COPY role (id, name, description) FROM stdin;
    public       postgres    false    231   �'      I          0    16934    role_permission 
   TABLE DATA               >   COPY role_permission (id, role_id, permission_id) FROM stdin;
    public       postgres    false    233   (      K          0    16939    status 
   TABLE DATA               $   COPY status (id, tekst) FROM stdin;
    public       postgres    false    235   \(      %          0    16799    user 
   TABLE DATA               d   COPY "user" (id, name, email, role_id, username, password, description, user_status_id) FROM stdin;
    public       postgres    false    196   �(      N          0    16946    user_member 
   TABLE DATA               6   COPY user_member (id, user_id, member_id) FROM stdin;
    public       postgres    false    238   *      P          0    16951    user_status 
   TABLE DATA               6   COPY user_status (id, value, description) FROM stdin;
    public       postgres    false    240   E*      �           0    0    activity_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('activity_id_seq', 11, true);
            public       postgres    false    199            �           0    0    collaboration_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('collaboration_id_seq', 1, false);
            public       postgres    false    202            �           0    0     collaboration_member_type_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('collaboration_member_type_id_seq', 1, false);
            public       postgres    false    204            �           0    0 "   collaboration_property_type_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('collaboration_property_type_id_seq', 1, false);
            public       postgres    false    206            �           0    0    collaboration_type_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('collaboration_type_id_seq', 2, true);
            public       postgres    false    208            �           0    0    member_activity_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('member_activity_id_seq', 31, true);
            public       postgres    false    211            �           0    0    member_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('member_id_seq', 59, true);
            public       postgres    false    212            �           0    0    member_role_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('member_role_id_seq', 2, true);
            public       postgres    false    214            �           0    0    member_type_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('member_type_id_seq', 4, true);
            public       postgres    false    217            �           0    0    permission_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('permission_id_seq', 7, true);
            public       postgres    false    219            �           0    0    property_type_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('property_type_id_seq', 4, true);
            public       postgres    false    221            �           0    0    request_activity_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('request_activity_seq', 1, false);
            public       postgres    false    243            �           0    0    request_document_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('request_document_id_seq', 1, false);
            public       postgres    false    244            �           0    0    request_response_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('request_response_id_seq', 1, false);
            public       postgres    false    223            �           0    0    request_type_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('request_type_id_seq', 6, true);
            public       postgres    false    225            �           0    0    response_document_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('response_document_id_seq', 1, false);
            public       postgres    false    228            �           0    0    response_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('response_id_seq', 1, false);
            public       postgres    false    229            �           0    0    response_submission_date_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('response_submission_date_seq', 1, false);
            public       postgres    false    230            �           0    0    role_id_seq1    SEQUENCE SET     3   SELECT pg_catalog.setval('role_id_seq1', 3, true);
            public       postgres    false    232            �           0    0    role_permission_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('role_permission_id_seq', 9, true);
            public       postgres    false    234            �           0    0    status_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('status_id_seq', 5, true);
            public       postgres    false    236            �           0    0    user_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('user_id_seq', 56, true);
            public       postgres    false    237            �           0    0    user_member_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('user_member_id_seq', 18, true);
            public       postgres    false    239            �           0    0    user_status_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('user_status_id_seq', 3, true);
            public       postgres    false    241            .           2606    16982    activity activity_class_key 
   CONSTRAINT     P   ALTER TABLE ONLY activity
    ADD CONSTRAINT activity_class_key UNIQUE (class);
 E   ALTER TABLE ONLY public.activity DROP CONSTRAINT activity_class_key;
       public         postgres    false    198            0           2606    16984    activity activity_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY activity
    ADD CONSTRAINT activity_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.activity DROP CONSTRAINT activity_pkey;
       public         postgres    false    198            2           2606    16986 &   activity_section activity_section_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY activity_section
    ADD CONSTRAINT activity_section_pkey PRIMARY KEY (key);
 P   ALTER TABLE ONLY public.activity_section DROP CONSTRAINT activity_section_pkey;
       public         postgres    false    200            4           2606    16988 +   activity_section activity_section_value_key 
   CONSTRAINT     `   ALTER TABLE ONLY activity_section
    ADD CONSTRAINT activity_section_value_key UNIQUE (value);
 U   ALTER TABLE ONLY public.activity_section DROP CONSTRAINT activity_section_value_key;
       public         postgres    false    200            6           2606    16990    request collaboration_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY request
    ADD CONSTRAINT collaboration_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.request DROP CONSTRAINT collaboration_pkey;
       public         postgres    false    201            @           2606    16992 *   request_domain collaboration_type_name_key 
   CONSTRAINT     ^   ALTER TABLE ONLY request_domain
    ADD CONSTRAINT collaboration_type_name_key UNIQUE (name);
 T   ALTER TABLE ONLY public.request_domain DROP CONSTRAINT collaboration_type_name_key;
       public         postgres    false    207            B           2606    16994 &   request_domain collaboration_type_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY request_domain
    ADD CONSTRAINT collaboration_type_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.request_domain DROP CONSTRAINT collaboration_type_pkey;
       public         postgres    false    207            M           2606    16996 $   member_activity member_activity_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY member_activity
    ADD CONSTRAINT member_activity_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.member_activity DROP CONSTRAINT member_activity_pkey;
       public         postgres    false    210            O           2606    16998 "   member_activity member_activity_uk 
   CONSTRAINT     h   ALTER TABLE ONLY member_activity
    ADD CONSTRAINT member_activity_uk UNIQUE (member_id, activity_id);
 L   ALTER TABLE ONLY public.member_activity DROP CONSTRAINT member_activity_uk;
       public         postgres    false    210    210            D           2606    17000    member member_email_key 
   CONSTRAINT     L   ALTER TABLE ONLY member
    ADD CONSTRAINT member_email_key UNIQUE (email);
 A   ALTER TABLE ONLY public.member DROP CONSTRAINT member_email_key;
       public         postgres    false    209            F           2606    17002    member member_name_key 
   CONSTRAINT     J   ALTER TABLE ONLY member
    ADD CONSTRAINT member_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.member DROP CONSTRAINT member_name_key;
       public         postgres    false    209            H           2606    17004    member member_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.member DROP CONSTRAINT member_pkey;
       public         postgres    false    209            Q           2606    17006     member_role member_role_name_key 
   CONSTRAINT     T   ALTER TABLE ONLY member_role
    ADD CONSTRAINT member_role_name_key UNIQUE (name);
 J   ALTER TABLE ONLY public.member_role DROP CONSTRAINT member_role_name_key;
       public         postgres    false    213            S           2606    17008    member_role member_role_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY member_role
    ADD CONSTRAINT member_role_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.member_role DROP CONSTRAINT member_role_pkey;
       public         postgres    false    213            U           2606    17010 $   member_status member_status_name_key 
   CONSTRAINT     X   ALTER TABLE ONLY member_status
    ADD CONSTRAINT member_status_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.member_status DROP CONSTRAINT member_status_name_key;
       public         postgres    false    215            W           2606    17012     member_status member_status_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY member_status
    ADD CONSTRAINT member_status_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.member_status DROP CONSTRAINT member_status_pkey;
       public         postgres    false    215            Y           2606    17014     member_type member_type_name_key 
   CONSTRAINT     T   ALTER TABLE ONLY member_type
    ADD CONSTRAINT member_type_name_key UNIQUE (name);
 J   ALTER TABLE ONLY public.member_type DROP CONSTRAINT member_type_name_key;
       public         postgres    false    216            [           2606    17016    member_type member_type_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY member_type
    ADD CONSTRAINT member_type_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.member_type DROP CONSTRAINT member_type_pkey;
       public         postgres    false    216            J           2606    17018    member member_url_key 
   CONSTRAINT     H   ALTER TABLE ONLY member
    ADD CONSTRAINT member_url_key UNIQUE (url);
 ?   ALTER TABLE ONLY public.member DROP CONSTRAINT member_url_key;
       public         postgres    false    209            ]           2606    17020    permission permission_name_key 
   CONSTRAINT     R   ALTER TABLE ONLY permission
    ADD CONSTRAINT permission_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.permission DROP CONSTRAINT permission_name_key;
       public         postgres    false    218            _           2606    17022    permission permission_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.permission DROP CONSTRAINT permission_pkey;
       public         postgres    false    218            a           2606    17024 $   property_type property_type_name_key 
   CONSTRAINT     X   ALTER TABLE ONLY property_type
    ADD CONSTRAINT property_type_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.property_type DROP CONSTRAINT property_type_name_key;
       public         postgres    false    220            c           2606    17026     property_type property_type_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY property_type
    ADD CONSTRAINT property_type_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.property_type DROP CONSTRAINT property_type_pkey;
       public         postgres    false    220            �           2606    17208 &   request_activity request_activity_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY request_activity
    ADD CONSTRAINT request_activity_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.request_activity DROP CONSTRAINT request_activity_pkey;
       public         postgres    false    242            �           2606    17210 $   request_activity request_activity_uk 
   CONSTRAINT     k   ALTER TABLE ONLY request_activity
    ADD CONSTRAINT request_activity_uk UNIQUE (request_id, activity_id);
 N   ALTER TABLE ONLY public.request_activity DROP CONSTRAINT request_activity_uk;
       public         postgres    false    242    242            �           2606    17239 &   request_document request_document_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY request_document
    ADD CONSTRAINT request_document_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.request_document DROP CONSTRAINT request_document_pkey;
       public         postgres    false    245            �           2606    17246 &   request_document request_document_ukey 
   CONSTRAINT     o   ALTER TABLE ONLY request_document
    ADD CONSTRAINT request_document_ukey UNIQUE (request_id, document_name);
 P   ALTER TABLE ONLY public.request_document DROP CONSTRAINT request_document_ukey;
       public         postgres    false    245    245            8           2606    17028 *   request_member_type request_member_type_pk 
   CONSTRAINT     a   ALTER TABLE ONLY request_member_type
    ADD CONSTRAINT request_member_type_pk PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.request_member_type DROP CONSTRAINT request_member_type_pk;
       public         postgres    false    203            :           2606    17030 *   request_member_type request_member_type_uk 
   CONSTRAINT     t   ALTER TABLE ONLY request_member_type
    ADD CONSTRAINT request_member_type_uk UNIQUE (request_id, member_type_id);
 T   ALTER TABLE ONLY public.request_member_type DROP CONSTRAINT request_member_type_uk;
       public         postgres    false    203    203            <           2606    17032 .   request_property_type request_property_type_pk 
   CONSTRAINT     e   ALTER TABLE ONLY request_property_type
    ADD CONSTRAINT request_property_type_pk PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.request_property_type DROP CONSTRAINT request_property_type_pk;
       public         postgres    false    205            >           2606    17034 .   request_property_type request_property_type_uk 
   CONSTRAINT     z   ALTER TABLE ONLY request_property_type
    ADD CONSTRAINT request_property_type_uk UNIQUE (request_id, property_type_id);
 X   ALTER TABLE ONLY public.request_property_type DROP CONSTRAINT request_property_type_uk;
       public         postgres    false    205    205            e           2606    17036 &   request_response request_response_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY request_response
    ADD CONSTRAINT request_response_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.request_response DROP CONSTRAINT request_response_pkey;
       public         postgres    false    222            g           2606    17038 $   request_response request_response_uk 
   CONSTRAINT     k   ALTER TABLE ONLY request_response
    ADD CONSTRAINT request_response_uk UNIQUE (request_id, response_id);
 N   ALTER TABLE ONLY public.request_response DROP CONSTRAINT request_response_uk;
       public         postgres    false    222    222            i           2606    17040 "   request_type request_type_name_key 
   CONSTRAINT     V   ALTER TABLE ONLY request_type
    ADD CONSTRAINT request_type_name_key UNIQUE (name);
 L   ALTER TABLE ONLY public.request_type DROP CONSTRAINT request_type_name_key;
       public         postgres    false    224            k           2606    17042    request_type request_type_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY request_type
    ADD CONSTRAINT request_type_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.request_type DROP CONSTRAINT request_type_pkey;
       public         postgres    false    224            o           2606    17044 (   response_document response_document_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY response_document
    ADD CONSTRAINT response_document_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.response_document DROP CONSTRAINT response_document_pkey;
       public         postgres    false    227            m           2606    17046    response response_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY response
    ADD CONSTRAINT response_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.response DROP CONSTRAINT response_pkey;
       public         postgres    false    226            q           2606    17048    role role_name_key 
   CONSTRAINT     F   ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);
 <   ALTER TABLE ONLY public.role DROP CONSTRAINT role_name_key;
       public         postgres    false    231            u           2606    17050 $   role_permission role_permission_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT role_permission_pkey;
       public         postgres    false    233            w           2606    17052 "   role_permission role_permission_uk 
   CONSTRAINT     h   ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_uk UNIQUE (permission_id, role_id);
 L   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT role_permission_uk;
       public         postgres    false    233    233            s           2606    17054    role role_pkey 
   CONSTRAINT     E   ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
       public         postgres    false    231            y           2606    17056    status status_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.status DROP CONSTRAINT status_pkey;
       public         postgres    false    235            {           2606    17058    status status_tekst_key 
   CONSTRAINT     L   ALTER TABLE ONLY status
    ADD CONSTRAINT status_tekst_key UNIQUE (tekst);
 A   ALTER TABLE ONLY public.status DROP CONSTRAINT status_tekst_key;
       public         postgres    false    235            (           2606    17060    user user_email_key 
   CONSTRAINT     J   ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_email_key;
       public         postgres    false    196            }           2606    17062    user_member user_member_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.user_member DROP CONSTRAINT user_member_pkey;
       public         postgres    false    238                       2606    17064    user_member user_member_uk 
   CONSTRAINT     \   ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_uk UNIQUE (user_id, member_id);
 D   ALTER TABLE ONLY public.user_member DROP CONSTRAINT user_member_uk;
       public         postgres    false    238    238            *           2606    17066    user user_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public         postgres    false    196            �           2606    17068    user_status user_status_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY user_status
    ADD CONSTRAINT user_status_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.user_status DROP CONSTRAINT user_status_pkey;
       public         postgres    false    240            �           2606    17070 !   user_status user_status_value_key 
   CONSTRAINT     V   ALTER TABLE ONLY user_status
    ADD CONSTRAINT user_status_value_key UNIQUE (value);
 K   ALTER TABLE ONLY public.user_status DROP CONSTRAINT user_status_value_key;
       public         postgres    false    240            ,           2606    17072    user user_username_key 
   CONSTRAINT     P   ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_username_key;
       public         postgres    false    196            K           1259    17216    fki_member_activity_fk_activity    INDEX     [   CREATE INDEX fki_member_activity_fk_activity ON member_activity USING btree (activity_id);
 3   DROP INDEX public.fki_member_activity_fk_activity;
       public         postgres    false    210            �           1259    17231     fki_request_activity_fk_activity    INDEX     ]   CREATE INDEX fki_request_activity_fk_activity ON request_activity USING btree (activity_id);
 4   DROP INDEX public.fki_request_activity_fk_activity;
       public         postgres    false    242            �           1259    17225    fki_request_activity_fk_request    INDEX     [   CREATE INDEX fki_request_activity_fk_request ON request_activity USING btree (request_id);
 3   DROP INDEX public.fki_request_activity_fk_request;
       public         postgres    false    242            �           2606    17073 $   activity activity_fk_activity_member    FK CONSTRAINT     �   ALTER TABLE ONLY activity
    ADD CONSTRAINT activity_fk_activity_member FOREIGN KEY (section) REFERENCES activity_section(key) ON UPDATE CASCADE ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.activity DROP CONSTRAINT activity_fk_activity_member;
       public       postgres    false    2866    198    200            �           2606    17211 +   member_activity member_activity_fk_activity    FK CONSTRAINT     �   ALTER TABLE ONLY member_activity
    ADD CONSTRAINT member_activity_fk_activity FOREIGN KEY (activity_id) REFERENCES activity(id) ON UPDATE CASCADE ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.member_activity DROP CONSTRAINT member_activity_fk_activity;
       public       postgres    false    2864    210    198            �           2606    17083 )   member_activity member_activity_fk_member    FK CONSTRAINT     �   ALTER TABLE ONLY member_activity
    ADD CONSTRAINT member_activity_fk_member FOREIGN KEY (member_id) REFERENCES member(id) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.member_activity DROP CONSTRAINT member_activity_fk_member;
       public       postgres    false    210    209    2888            �           2606    17088    member member_fk_member_role    FK CONSTRAINT     �   ALTER TABLE ONLY member
    ADD CONSTRAINT member_fk_member_role FOREIGN KEY (member_role_id) REFERENCES member_role(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.member DROP CONSTRAINT member_fk_member_role;
       public       postgres    false    213    2899    209            �           2606    17093    member member_fk_member_status    FK CONSTRAINT     �   ALTER TABLE ONLY member
    ADD CONSTRAINT member_fk_member_status FOREIGN KEY (member_status_id) REFERENCES member_status(id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.member DROP CONSTRAINT member_fk_member_status;
       public       postgres    false    215    209    2903            �           2606    17098    member member_fk_member_type    FK CONSTRAINT     �   ALTER TABLE ONLY member
    ADD CONSTRAINT member_fk_member_type FOREIGN KEY (member_type_id) REFERENCES member_type(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.member DROP CONSTRAINT member_fk_member_type;
       public       postgres    false    2907    216    209            �           2606    17103    member member_fk_property_type    FK CONSTRAINT     �   ALTER TABLE ONLY member
    ADD CONSTRAINT member_fk_property_type FOREIGN KEY (property_type_id) REFERENCES property_type(id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.member DROP CONSTRAINT member_fk_property_type;
       public       postgres    false    2915    220    209            �           2606    17108    member member_fk_request_domain    FK CONSTRAINT     �   ALTER TABLE ONLY member
    ADD CONSTRAINT member_fk_request_domain FOREIGN KEY (request_domain_id) REFERENCES request_domain(id) ON UPDATE CASCADE ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.member DROP CONSTRAINT member_fk_request_domain;
       public       postgres    false    209    207    2882            �           2606    17226 -   request_activity request_activity_fk_activity    FK CONSTRAINT     �   ALTER TABLE ONLY request_activity
    ADD CONSTRAINT request_activity_fk_activity FOREIGN KEY (activity_id) REFERENCES activity(id) ON UPDATE CASCADE ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.request_activity DROP CONSTRAINT request_activity_fk_activity;
       public       postgres    false    198    242    2864            �           2606    17220 ,   request_activity request_activity_fk_request    FK CONSTRAINT     �   ALTER TABLE ONLY request_activity
    ADD CONSTRAINT request_activity_fk_request FOREIGN KEY (request_id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.request_activity DROP CONSTRAINT request_activity_fk_request;
       public       postgres    false    201    2870    242            �           2606    17240 ,   request_document request_document_fk_request    FK CONSTRAINT     �   ALTER TABLE ONLY request_document
    ADD CONSTRAINT request_document_fk_request FOREIGN KEY (id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.request_document DROP CONSTRAINT request_document_fk_request;
       public       postgres    false    201    245    2870            �           0    0 :   CONSTRAINT request_document_fk_request ON request_document    COMMENT     m   COMMENT ON CONSTRAINT request_document_fk_request ON request_document IS 'Referenca na tabelu request-ova.';
            public       postgres    false    2986            �           2606    17113    request request_fk_init_member    FK CONSTRAINT     �   ALTER TABLE ONLY request
    ADD CONSTRAINT request_fk_init_member FOREIGN KEY (init_member_id) REFERENCES member(id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.request DROP CONSTRAINT request_fk_init_member;
       public       postgres    false    2888    201    209            �           2606    17118 !   request request_fk_request_domain    FK CONSTRAINT     �   ALTER TABLE ONLY request
    ADD CONSTRAINT request_fk_request_domain FOREIGN KEY (request_domain_id) REFERENCES request_domain(id) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.request DROP CONSTRAINT request_fk_request_domain;
       public       postgres    false    2882    207    201            �           2606    17123    request request_fk_request_type    FK CONSTRAINT     �   ALTER TABLE ONLY request
    ADD CONSTRAINT request_fk_request_type FOREIGN KEY (request_type_id) REFERENCES request_type(id) ON UPDATE RESTRICT ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.request DROP CONSTRAINT request_fk_request_type;
       public       postgres    false    2923    224    201            �           2606    17128    request request_fk_status    FK CONSTRAINT     �   ALTER TABLE ONLY request
    ADD CONSTRAINT request_fk_status FOREIGN KEY (status_id) REFERENCES status(id) ON UPDATE CASCADE ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.request DROP CONSTRAINT request_fk_status;
       public       postgres    false    2937    201    235            �           2606    17133 6   request_member_type request_member_type_fk_member_type    FK CONSTRAINT     �   ALTER TABLE ONLY request_member_type
    ADD CONSTRAINT request_member_type_fk_member_type FOREIGN KEY (member_type_id) REFERENCES member_type(id) ON UPDATE CASCADE ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.request_member_type DROP CONSTRAINT request_member_type_fk_member_type;
       public       postgres    false    203    216    2907            �           2606    17138 2   request_member_type request_member_type_fk_request    FK CONSTRAINT     �   ALTER TABLE ONLY request_member_type
    ADD CONSTRAINT request_member_type_fk_request FOREIGN KEY (request_id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.request_member_type DROP CONSTRAINT request_member_type_fk_request;
       public       postgres    false    203    2870    201            �           2606    17143 <   request_property_type request_property_type_fk_property_type    FK CONSTRAINT     �   ALTER TABLE ONLY request_property_type
    ADD CONSTRAINT request_property_type_fk_property_type FOREIGN KEY (property_type_id) REFERENCES property_type(id) ON UPDATE CASCADE ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.request_property_type DROP CONSTRAINT request_property_type_fk_property_type;
       public       postgres    false    205    2915    220            �           2606    17148 6   request_property_type request_property_type_fk_request    FK CONSTRAINT     �   ALTER TABLE ONLY request_property_type
    ADD CONSTRAINT request_property_type_fk_request FOREIGN KEY (request_id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.request_property_type DROP CONSTRAINT request_property_type_fk_request;
       public       postgres    false    2870    205    201            �           2606    17153 ,   request_response request_response_fk_request    FK CONSTRAINT     �   ALTER TABLE ONLY request_response
    ADD CONSTRAINT request_response_fk_request FOREIGN KEY (request_id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.request_response DROP CONSTRAINT request_response_fk_request;
       public       postgres    false    2870    222    201            �           2606    17158 -   request_response request_response_fk_response    FK CONSTRAINT     �   ALTER TABLE ONLY request_response
    ADD CONSTRAINT request_response_fk_response FOREIGN KEY (response_id) REFERENCES response(id) ON UPDATE CASCADE ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.request_response DROP CONSTRAINT request_response_fk_response;
       public       postgres    false    222    2925    226            �           2606    17163 /   response_document response_document_fk_response    FK CONSTRAINT     �   ALTER TABLE ONLY response_document
    ADD CONSTRAINT response_document_fk_response FOREIGN KEY (response_id) REFERENCES response(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.response_document DROP CONSTRAINT response_document_fk_response;
       public       postgres    false    2925    227    226            �           2606    17168    response response_fk_member    FK CONSTRAINT     �   ALTER TABLE ONLY response
    ADD CONSTRAINT response_fk_member FOREIGN KEY (member_id) REFERENCES member(id) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.response DROP CONSTRAINT response_fk_member;
       public       postgres    false    2888    209    226            �           2606    17173    response response_fk_request    FK CONSTRAINT     �   ALTER TABLE ONLY response
    ADD CONSTRAINT response_fk_request FOREIGN KEY (request_id) REFERENCES request(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.response DROP CONSTRAINT response_fk_request;
       public       postgres    false    2870    226    201            �           2606    17178 /   role_permission role_permission_permission_vkey    FK CONSTRAINT     �   ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_permission_vkey FOREIGN KEY (permission_id) REFERENCES permission(id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT role_permission_permission_vkey;
       public       postgres    false    233    218    2911            �           2606    17183 )   role_permission role_permission_role_pkey    FK CONSTRAINT     �   ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_role_pkey FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT role_permission_role_pkey;
       public       postgres    false    231    233    2931            �           2606    17188    user user_fk_role    FK CONSTRAINT     �   ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_fk_role FOREIGN KEY (role_id) REFERENCES role(id) ON UPDATE CASCADE ON DELETE CASCADE;
 =   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_fk_role;
       public       postgres    false    196    2931    231            �           2606    17193 !   user_member user_member_fk_member    FK CONSTRAINT     �   ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_fk_member FOREIGN KEY (member_id) REFERENCES member(id) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.user_member DROP CONSTRAINT user_member_fk_member;
       public       postgres    false    238    2888    209            �           2606    17198    user_member user_member_fk_user    FK CONSTRAINT     �   ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_fk_user FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.user_member DROP CONSTRAINT user_member_fk_user;
       public       postgres    false    196    2858    238            &     x�U�=R�0�k�> Ð,�W���h�Dd;v���p��6�B�l:[�ӓ�
��<F�!f'���*��l4��;��]e<��eփ�/�L����2�Q���J�?R{�tx#ې��6��ں_�u21y�psؤ�-զAf����(�/�ʻL��s$�:���\-k(/O�Z�h��I�%�du��k�2.�Gw�-Y+�p�g��#�X�d�*�j:�&��(.��?+�i���0wS�ST=}��TR9����=�x<B|���      (   �  x�UQIr1<�������ŉ;V���$"#���>�	�HNֿ�*�U5UC6�n`���'>&j	-��\�\2�v�����W���o�#�j�0	H����P�5�D��!��b�^���/O����i���`F��w�$8�)@���YR��Fc�a%�#�3��4?-.G��NV\t��R�yL`����~��E0�5��z� �W��]�	\8E:H˙<t� {r�A��A��<X:=�>�Q���M(L���!AD}�6��@y�*Q9�(��>���J,�LSvh�j�s���4VQ�����W	2��%,Q��[�PR��� Y���<DY�E�M�m�H�:�`'V�r�/xw���mzO�v'~`ex�!���y9��E�Uwy٣�~�}��k���`d_U߫� y�8�v瞩�<���;��_�	      1     x�u�An�0E��)|� AT��EmPD��
�,P7S0h�ј��t�C�.ɽ��m�t�m����x	���BnE�5Dx=�h���� V�ޘ�Xf����q�@���|�aG:g,�Vv,�����x���>LD�A��0ڌJ4�|H!�=;F�r�5� u���&�;����������آx�M˺�It� ���PC]&�R����Pk=H��bKX�#</�8\�^�t 1@V��?�I��TH��i56�K]2�Sg��2��+�漹��|���a      2   >   x���	�P��b$�7��&�p�寒\ܸ�z���L8nCG5#z�T=w�|��X
z      5   *   x�3����+.�)I�+��2�(JM).I,��������� ��
      7   �   x�U�Mn1���)|�*�� !���b�g2v�d��]�B��^dPՕ����-�7�U��O@ɥ�ٍ��z,�D�B
�9��_��O����IǾp�#w��j������ؐ	ԟ�jz_�>��K����Z2��q���� ��J�C����mm"_��KҤ��~���WC�H�u�ڕ�&��CƄ^:2vוּ��b�      8   e   x�3������K,=қ���Y\R�xt_fY���D����ļ̪��̬D=.#΀�ԔҪ�#��HL.cN�Ă̒�����N.Nϼ�2���<T#8�b���� �@)B      :   �   x��RYj�0��O�C����Ě�����}eǝ1��п�?,�mH�й���j�R��o ���	k"NZ=\�Nl3U޼`8�h]�x��3R��J�:����;�'��c�0�:ʥ�y��O~"��v	(tب�S��������ʥ*vn�9z4�W��f��Ţ[�>DQ�ZC�7h���b留Bn�Z��������d�>~n���Ȱu���_�]+��	�       <   :   x�3�t):�/�,/��ˈ3�(�,��6��M=�0�,��1��K-(�O�K��qqq #X      )      x������ � �      R      x������ � �      U      x������ � �      /   O   x�3�t��M<Ҟ��X������PD�IY��%���
�
U��9Y�z\F���G&��%�䡪�EHd�"������� \�$N      +      x������ � �      -      x������ � �      >      x������ � �      @   y   x�˽1��ڞ" �;:	� �b����.,@uC�K؋��)�wI�K�q�%	#��xE'$��u�.����&��Pnj�Q�xC�:��S���C�<�-�q�3�kG�`%6����O(K      B      x������ � �      C      x������ � �      G   u   x�m�A�0��+�	x�	7.�R)���
�{ʱRo;��=�0�ő:�)��n��a���^�bU��	�H ׺Øƒ�K���GZ�i�ME��}�k���T�a^r�[b�M=      I   3   x���  �wn��P`���|,�BAڤl1��,�h�l�ls�����      K   B   x�3���/��2��O*-.I,��J��2�J���*=��r:ed�e%�qq:f�d�Y1z\\\ h7      %   G  x���Mj�0���S�F�N���E	��݌e9�*�h.�s�.ͽ*;�$]4t��{��a�v��H�]��8�<��nۣ�r�{`��L��
*�VK)4+���JYW-��RFp�����~p�~�6} ��{А�,�c<��nq@����}��6�>�8�1�!"Gf�Z֒ʺ�9�Jc����B�K�<i��	�`G?��\��';��d������/��8� ����-���y�)ƪ���.�'�i��6>L16�k΍��^�5�3v{��	@a���N�t��N�	��1���s���T(U*dE�Z�ɲF�J��kHk_�,˾ ���      N   0   x��� C��K1F�|���:�ˆ�*���%/��M��&����      P   �   x�E�1�0E��>A$�������*N ��4��[�`�T�����;w�g���ZĲ$4�X-�H=�8j�G����S�F�]ְw���	�
�7igF���>Z����N6r�l��X�i�Y����^��� � >�     