
/* Drop Tables */

DROP TABLE IF EXISTS Comment CASCADE;

DROP TABLE IF EXISTS Community CASCADE;

DROP TABLE IF EXISTS CommunityCategory CASCADE;

DROP TABLE IF EXISTS Event CASCADE;

DROP TABLE IF EXISTS EventCategory CASCADE;

DROP TABLE IF EXISTS Friend CASCADE;

DROP TABLE IF EXISTS Invoice CASCADE;

DROP TABLE IF EXISTS Member CASCADE;

DROP TABLE IF EXISTS Notification CASCADE;

DROP TABLE IF EXISTS Report CASCADE;

DROP TABLE IF EXISTS Ticket CASCADE;

DROP TABLE IF EXISTS TicketType CASCADE;

DROP TABLE IF EXISTS Community_Member CASCADE;

DROP TABLE IF EXISTS Country CASCADE;

DROP TABLE IF EXISTS community_communitycategory CASCADE;

DROP TABLE IF EXISTS event_eventcategory CASCADE;

DROP TABLE IF EXISTS event_member CASCADE;

DROP TABLE IF EXISTS password_resets CASCADE;

DROP TYPE IF EXISTS notificationType;

DROP TYPE IF EXISTS reporttype;


CREATE TYPE notificationtype AS ENUM (
    'comment',
    'buddy',
    'event',
    'community'
);


--
-- Name: reporttype; Type: TYPE; Schema: lbaw1714; Owner: lbaw1714
--

CREATE TYPE reporttype AS ENUM (
    'comment',
    'member',
    'event',
    'community'
);


--
-- Name: comment; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE comment (
    idcomment SERIAL NOT NULL,
    text text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    event integer,
    author integer
);


--
-- Name: community; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE community (
    idcommunity SERIAL NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256) NOT NULL,
    creationdate date NOT NULL,
    imagepath text,
    publiclink text,
    ispublic boolean NOT NULL
);



--
-- Name: community_communitycategory; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE community_communitycategory (
    idcommunity integer NOT NULL,
    idcommunitycategory integer NOT NULL
);



--
-- Name: community_member; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE community_member (
    idcommunity integer NOT NULL,
    idmember integer NOT NULL,
    isadmin boolean DEFAULT false NOT NULL
);



--
-- Name: communitycategory; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE communitycategory (
    idcommunitycategory SERIAL NOT NULL,
    name character varying(50)
);



--
-- Name: event; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE event (
    idevent SERIAL NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(516) NOT NULL,
    imagepath text,
    startday date NOT NULL,
    endday date NOT NULL,
    starttime time without time zone NOT NULL,
    endtime time without time zone NOT NULL,
    idcountry integer NOT NULL,
    city character varying(50) NOT NULL,
    address character varying(100) NOT NULL,
    publiclink text,
    ispublic boolean NOT NULL,
    community integer,
    fts_vector tsvector
);


CREATE TABLE country (
    idcountry SERIAL NOT NULL,
    name character varying(50) NOT NULL
);


--
-- Name: event_eventcategory; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE event_eventcategory (
    idevent integer NOT NULL,
    ideventcategory integer NOT NULL
);



--
-- Name: event_member; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE event_member (
    idevent integer NOT NULL,
    idmember integer NOT NULL,
    isgoing boolean DEFAULT false NOT NULL,
    isadmin boolean NOT NULL
);



--
-- Name: eventcategory; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE eventcategory (
    ideventcategory SERIAL NOT NULL,
    name character varying(50) NOT NULL
);



--
-- Name: friend; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE friend (
    idf1 integer NOT NULL,
    idf2 integer NOT NULL,
    accepted boolean DEFAULT false NOT NULL
);



--
-- Name: invoice; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE invoice (
    idinvoice SERIAL NOT NULL,
    taxpayernumber integer,
    name character varying(50),
    address text,
    quantity integer NOT NULL,
    amount float NOT NULL,
    date date NOT NULL,
    idmember integer NOT NULL,
    CONSTRAINT invoice_amount_check CHECK ((amount > 0)),
    CONSTRAINT invoice_quantity_check CHECK ((quantity > 0))
);



--
-- Name: member; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE member (
    idmember SERIAL NOT NULL,
    name character varying(50) NOT NULL,
    username character varying(16) NOT NULL,
    password text NOT NULL,
    birthdate date,
    email character varying(50) NOT NULL,
    idcountry integer NOT NULL,
    city character varying(50),
    address text,
    taxpayernumber character varying(20),
    about character varying(256),
    profilepicture text,
    registrationdate date NOT NULL,
    verifiedemail boolean NOT NULL,
    iswebsiteadmin boolean NOT NULL,
    remember_token text
);



--
-- Name: notification; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE notification (
    idnotification SERIAL NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    type text NOT NULL,
    community integer,
    recipient integer,
    comment integer,
    event integer,
    buddy integer
);



--
-- Name: report; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE report (
    idreport SERIAL NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    context text NOT NULL,
    community integer,
    reporter integer,
    comment integer,
    event integer,
    solved boolean DEFAULT false NOT NULL,
    member integer
);



--
-- Name: ticket; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE ticket (
    idticket SERIAL NOT NULL,
    idtickettype integer NOT NULL,
    idinvoice integer NOT NULL,
    used boolean DEFAULT false NOT NULL,
    updated_at timestamp NULL
);



--
-- Name: tickettype; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE tickettype (
    idtickettype SERIAL NOT NULL,
    price double precision NOT NULL,
    initialquantity integer NOT NULL,
    availablequantity integer,
    description text,
    event integer NOT NULL,
    CONSTRAINT tickettype_initialquantity_check CHECK ((initialquantity > 0)),
    CONSTRAINT tickettype_price_check CHECK ((price > (0)::double precision))
);

CREATE TABLE password_resets(
    idpasswordreset SERIAL NOT NULL,
    email character varying(50) NOT NULL,
    token text NOT NULL,
    created_at timestamp NOT NULL

);



CREATE INDEX event_search ON event USING gist(fts_vector);


--
-- Data for Name: comment; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO comment (text, timestamp, event, author) VALUES ('Evento fixe, bro', '2017-11-07 00:53:39', 10, 102);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Evento fixe, bro', '2017-11-07 00:53:39', 12, 52);
insert into comment (text, timestamp, event, author) values ('Já comprei bilhete!', '2018-02-11 22:58:51', 9, 60);
insert into comment (text, timestamp, event, author) values ('Não me vou esquecer da câmara de filmar!', '2018-04-06 17:49:08', 14, 25);
insert into comment (text, timestamp, event, author) values ('[COMENTÁRIO GENÉRICO]', '2018-04-16 17:55:44', 4, 61);
insert into comment (text, timestamp, event, author) values ('Contem comigooooo', '2018-04-20 01:39:38', 19, 22);
insert into comment (text, timestamp, event, author) values ('Guardem-me um lugar!', '2018-03-27 16:41:30', 17, 76);
insert into comment (text, timestamp, event, author) values ('mas vai valer a pena!', '2018-01-07 20:08:39', 6, 98);
insert into comment (text, timestamp, event, author) values ('Já comprei bilhete!', '2018-04-15 16:20:08', 6, 4);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-01-30 04:55:19', 20, 91);
insert into comment (text, timestamp, event, author) values ('Sabem se vai chover?', '2018-04-18 12:43:22', 12, 42);
insert into comment (text, timestamp, event, author) values ('Vendo bilhete (não contem à organização)', '2018-01-09 20:39:35', 7, 9);
insert into comment (text, timestamp, event, author) values ('haha sim', '2018-03-18 06:43:19', 22, 52);
insert into comment (text, timestamp, event, author) values ('Contem comigooooo', '2018-03-13 23:14:24', 25, 47);
insert into comment (text, timestamp, event, author) values ('haha sim', '2018-01-01 03:26:42', 20, 26);
insert into comment (text, timestamp, event, author) values ('Acham que dá para adiar isto mais um dia?', '2018-03-17 03:25:18', 1, 58);
insert into comment (text, timestamp, event, author) values ('omg sim', '2018-04-13 00:44:54', 17, 83);
insert into comment (text, timestamp, event, author) values (':D', '2018-01-19 20:30:43', 4, 40);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-01-05 07:05:55', 15, 63);
insert into comment (text, timestamp, event, author) values ('Estou muitíssimo entusiasmado!', '2018-05-17 17:32:25', 13, 38);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-03-30 09:02:20', 2, 20);
insert into comment (text, timestamp, event, author) values ('Não me vou esquecer da câmara de filmar!', '2018-04-04 05:59:42', 20, 71);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-05-07 10:52:24', 9, 23);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-02-22 21:26:00', 17, 19);
insert into comment (text, timestamp, event, author) values ('Já comprei bilhete!', '2018-04-26 20:49:22', 20, 59);
insert into comment (text, timestamp, event, author) values ('Modelagem UML é melhor que sequesso', '2018-03-18 07:10:14', 14, 103);
insert into comment (text, timestamp, event, author) values ('omg sim', '2018-04-02 20:45:00', 6, 71);
insert into comment (text, timestamp, event, author) values ('Guardem-me um lugar!', '2018-03-15 17:39:49', 4, 29);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-03-12 21:12:04', 25, 91);
insert into comment (text, timestamp, event, author) values ('mas vai valer a pena!', '2018-03-26 02:48:35', 21, 47);
insert into comment (text, timestamp, event, author) values ('All aboard the hype train!', '2018-04-09 04:58:57', 9, 5);
insert into comment (text, timestamp, event, author) values ('Já comprei bilhete!', '2018-03-24 11:02:41', 16, 48);
insert into comment (text, timestamp, event, author) values ('Estou muitíssimo entusiasmado!', '2018-05-19 16:51:36', 23, 98);
insert into comment (text, timestamp, event, author) values ('[COMENTÁRIO GENÉRICO]', '2018-03-31 02:57:23', 7, 42);
insert into comment (text, timestamp, event, author) values ('Vendo bilhete (não contem à organização)', '2018-03-23 20:19:48', 15, 101);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-05-15 18:29:01', 12, 83);
insert into comment (text, timestamp, event, author) values ('Estou muitíssimo entusiasmado!', '2018-05-11 19:18:50', 5, 63);
insert into comment (text, timestamp, event, author) values ('Acham que dá para adiar isto mais um dia?', '2018-05-12 22:21:32', 8, 8);
insert into comment (text, timestamp, event, author) values (':D', '2018-01-08 17:31:20', 1, 35);
insert into comment (text, timestamp, event, author) values ('Há recurso para isto?', '2018-04-06 05:23:31', 8, 6);
insert into comment (text, timestamp, event, author) values ('[COMENTÁRIO GENÉRICO]', '2018-04-13 23:38:53', 19, 78);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-01-09 22:38:31', 25, 80);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-05-23 07:14:29', 22, 10);
insert into comment (text, timestamp, event, author) values ('Acham que dá para adiar isto mais um dia?', '2018-01-24 02:00:37', 13, 78);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-04-01 09:23:23', 11, 24);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-03-20 17:34:43', 2, 34);
insert into comment (text, timestamp, event, author) values ('Acham que dá para adiar isto mais um dia?', '2018-01-15 14:17:31', 8, 68);
insert into comment (text, timestamp, event, author) values (':D', '2018-02-01 23:26:24', 1, 41);
insert into comment (text, timestamp, event, author) values ('Contem comigooooo', '2018-03-06 00:10:52', 8, 11);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-05-07 10:16:06', 20, 83);
insert into comment (text, timestamp, event, author) values ('haha sim', '2018-05-13 00:22:30', 20, 97);
insert into comment (text, timestamp, event, author) values ('[COMENTÁRIO GENÉRICO]', '2018-05-08 21:16:04', 17, 45);
insert into comment (text, timestamp, event, author) values ('Vendo bilhete (não contem à organização)', '2018-03-13 19:06:00', 21, 79);
insert into comment (text, timestamp, event, author) values ('mas vai valer a pena!', '2018-04-16 18:00:19', 25, 54);
insert into comment (text, timestamp, event, author) values ('Estou muito entusiasmado!', '2018-05-19 07:46:38', 17, 18);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-03-02 08:34:06', 24, 98);
insert into comment (text, timestamp, event, author) values ('Há recurso para isto?', '2018-03-18 04:54:11', 1, 53);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-05-08 04:56:17', 13, 37);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-04-10 12:27:00', 12, 37);
insert into comment (text, timestamp, event, author) values ('Guardem-me um lugar!', '2018-02-13 11:55:37', 17, 79);
insert into comment (text, timestamp, event, author) values ('Estou muito entusiasmado!', '2018-03-19 04:42:32', 24, 80);
insert into comment (text, timestamp, event, author) values ('Acham que dá para adiar isto mais um dia?', '2018-02-17 08:56:05', 11, 85);
insert into comment (text, timestamp, event, author) values ('omg sim', '2018-01-27 12:01:27', 23, 65);
insert into comment (text, timestamp, event, author) values ('Já comprei bilhete!', '2018-02-24 02:05:49', 18, 63);
insert into comment (text, timestamp, event, author) values ('Vendo bilhete (não contem à organização)', '2018-04-27 13:05:47', 12, 99);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-01-29 23:11:07', 25, 45);
insert into comment (text, timestamp, event, author) values ('Contem comigooooo', '2018-04-05 17:26:38', 4, 67);
insert into comment (text, timestamp, event, author) values ('Não me vou esquecer da câmara de filmar!', '2018-02-26 08:32:32', 16, 31);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-04-27 03:35:09', 2, 34);
insert into comment (text, timestamp, event, author) values ('All aboard the hype train!', '2018-02-28 00:01:43', 23, 71);
insert into comment (text, timestamp, event, author) values ('O meu entusiasmo não consegue ser contido em meras palavras.', '2018-02-04 11:33:41', 15, 100);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-01-09 01:01:58', 23, 6);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-05-19 11:07:50', 10, 54);
insert into comment (text, timestamp, event, author) values ('Guardem-me um lugar!', '2018-02-06 08:48:00', 4, 82);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-03-26 09:55:10', 4, 91);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-01-08 22:46:19', 15, 87);
insert into comment (text, timestamp, event, author) values ('Guardem-me um lugar!', '2018-01-21 23:47:57', 15, 96);
insert into comment (text, timestamp, event, author) values ('Alguém vende bilhete?', '2018-05-04 23:57:32', 2, 70);
insert into comment (text, timestamp, event, author) values ('haha sim', '2018-02-15 09:05:09', 4, 70);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-04-01 19:26:50', 24, 16);
insert into comment (text, timestamp, event, author) values ('Sabem se vai chover?', '2018-05-23 01:50:15', 7, 15);
insert into comment (text, timestamp, event, author) values ('Guardem-me um lugar!', '2018-05-02 06:34:27', 17, 39);
insert into comment (text, timestamp, event, author) values ('Alguém vende bilhete?', '2018-05-05 02:38:02', 2, 68);
insert into comment (text, timestamp, event, author) values ('Alguém vende bilhete?', '2018-05-22 13:37:26', 6, 51);
insert into comment (text, timestamp, event, author) values ('Acham que dá para adiar isto mais um dia?', '2018-03-17 17:43:14', 24, 63);
insert into comment (text, timestamp, event, author) values ('haha sim', '2018-02-10 05:09:09', 19, 33);
insert into comment (text, timestamp, event, author) values ('Guardem-me um lugar!', '2018-03-19 00:04:00', 7, 40);
insert into comment (text, timestamp, event, author) values (':D', '2018-01-25 02:02:24', 6, 78);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-05-07 07:24:02', 8, 4);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-05-24 11:04:06', 19, 34);
insert into comment (text, timestamp, event, author) values ('Vendo bilhete (não contem à organização)', '2018-04-17 13:13:27', 8, 12);
insert into comment (text, timestamp, event, author) values ('mas vai valer a pena!', '2018-03-02 22:54:30', 20, 90);
insert into comment (text, timestamp, event, author) values ('Estou muito entusiasmado!', '2018-02-22 23:15:43', 11, 47);
insert into comment (text, timestamp, event, author) values ('Contem comigooooo', '2018-01-10 21:41:27', 25, 74);
insert into comment (text, timestamp, event, author) values ('mas vai valer a pena!', '2018-03-13 09:10:20', 16, 35);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-03-30 17:07:56', 5, 38);
insert into comment (text, timestamp, event, author) values ('Acham que dá para adiar isto mais um dia?', '2018-03-01 23:07:44', 9, 85);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-03-09 10:21:29', 23, 71);
insert into comment (text, timestamp, event, author) values ('[COMENTÁRIO GENÉRICO]', '2018-04-12 22:58:09', 19, 72);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-04-09 18:15:30', 5, 20);
insert into comment (text, timestamp, event, author) values ('All aboard the hype train!', '2018-02-01 23:45:09', 23, 59);
insert into comment (text, timestamp, event, author) values (':D', '2018-02-04 18:22:59', 14, 15);
insert into comment (text, timestamp, event, author) values ('Não me vou esquecer da câmara de filmar!', '2018-05-28 05:13:46', 22, 24);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-04-19 15:57:00', 8, 99);
insert into comment (text, timestamp, event, author) values (':D', '2018-02-28 03:46:37', 16, 89);
insert into comment (text, timestamp, event, author) values ('Não me vou esquecer da câmara de filmar!', '2018-04-30 19:41:04', 4, 10);
insert into comment (text, timestamp, event, author) values ('Acham que dá para adiar isto mais um dia?', '2018-05-07 13:39:06', 2, 73);
insert into comment (text, timestamp, event, author) values ('Guardem-me um lugar!', '2018-02-14 17:32:01', 22, 81);
insert into comment (text, timestamp, event, author) values ('omg sim', '2018-02-08 11:42:54', 12, 75);
insert into comment (text, timestamp, event, author) values ('Estou muito entusiasmado!', '2018-01-24 17:43:55', 25, 85);
insert into comment (text, timestamp, event, author) values ('haha sim', '2018-03-04 10:28:14', 14, 55);
insert into comment (text, timestamp, event, author) values ('Sabem se vai chover?', '2018-05-11 20:08:37', 10, 12);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-03-03 02:15:05', 7, 60);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-03-28 11:17:53', 20, 9);
insert into comment (text, timestamp, event, author) values ('Alguém vende bilhete?', '2018-02-01 09:19:29', 19, 101);
insert into comment (text, timestamp, event, author) values ('haha sim', '2018-04-02 04:23:05', 1, 31);
insert into comment (text, timestamp, event, author) values ('haha sim', '2018-02-01 20:53:46', 24, 54);
insert into comment (text, timestamp, event, author) values ('O meu entusiasmo não consegue ser contido em meras palavras.', '2018-03-13 23:18:58', 20, 28);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-02-08 14:15:48', 4, 34);
insert into comment (text, timestamp, event, author) values ('Estou muitíssimo entusiasmado!', '2018-02-08 05:13:57', 22, 17);
insert into comment (text, timestamp, event, author) values ('Vendo bilhete (não contem à organização)', '2018-04-22 19:55:09', 17, 93);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-05-05 06:06:48', 20, 84);
insert into comment (text, timestamp, event, author) values ('Já comprei bilhete!', '2018-05-24 16:24:30', 10, 98);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-03-16 17:09:01', 2, 99);
insert into comment (text, timestamp, event, author) values ('[COMENTÁRIO GENÉRICO]', '2018-01-29 19:19:40', 24, 29);
insert into comment (text, timestamp, event, author) values ('Vendo bilhete (não contem à organização)', '2018-01-20 18:43:09', 19, 60);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-03-19 08:41:18', 6, 23);
insert into comment (text, timestamp, event, author) values ('Há recurso para isto?', '2018-01-23 06:03:21', 10, 47);
insert into comment (text, timestamp, event, author) values ('mas vai valer a pena!', '2018-03-27 19:46:03', 5, 1);
insert into comment (text, timestamp, event, author) values ('Vendo bilhete (não contem à organização)', '2018-05-21 21:34:43', 2, 1);
insert into comment (text, timestamp, event, author) values ('Acham que dá para adiar isto mais um dia?', '2018-01-23 11:32:17', 25, 58);
insert into comment (text, timestamp, event, author) values ('Contem comigo!', '2018-05-08 08:51:10', 24, 73);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-03-02 01:55:31', 1, 79);
insert into comment (text, timestamp, event, author) values ('Há recurso para isto?', '2018-05-12 04:53:12', 22, 30);
insert into comment (text, timestamp, event, author) values ('All aboard the hype train!', '2018-05-04 06:49:39', 22, 95);
insert into comment (text, timestamp, event, author) values ('Há recurso para isto?', '2018-02-24 21:43:01', 2, 103);
insert into comment (text, timestamp, event, author) values ('omg omg omg', '2018-01-31 12:17:22', 3, 29);
insert into comment (text, timestamp, event, author) values ('All aboard the hype train!', '2018-05-10 10:28:39', 21, 44);
insert into comment (text, timestamp, event, author) values ('Venho de longe', '2018-05-06 09:07:02', 15, 94);
insert into comment (text, timestamp, event, author) values ('haha sim', '2018-02-06 17:05:18', 3, 27);
insert into comment (text, timestamp, event, author) values ('Há recurso para isto?', '2018-03-08 20:55:13', 6, 72);
insert into comment (text, timestamp, event, author) values ('[COMENTÁRIO GENÉRICO]', '2018-02-18 17:33:32', 4, 86);
insert into comment (text, timestamp, event, author) values (':D', '2018-05-18 00:32:57', 25, 73);
insert into comment (text, timestamp, event, author) values ('Estou muito entusiasmado!', '2018-02-17 00:33:11', 11, 46);
insert into comment (text, timestamp, event, author) values (':D', '2018-03-09 15:12:43', 12, 26);
insert into comment (text, timestamp, event, author) values ('Já comprei bilhete!', '2018-03-01 09:16:15', 12, 55);
insert into comment (text, timestamp, event, author) values ('Sabem se vai chover?', '2018-05-22 21:35:45', 10, 40);
insert into comment (text, timestamp, event, author) values ('[COMENTÁRIO GENÉRICO]', '2018-05-22 23:44:29', 1, 70);
insert into comment (text, timestamp, event, author) values ('Contem comigooooo', '2018-05-27 07:42:31', 11, 82);
insert into comment (text, timestamp, event, author) values ('Não me vou esquecer da câmara de filmar!', '2018-01-20 00:59:39', 1, 27);
insert into comment (text, timestamp, event, author) values ('Já comprei bilhete!', '2018-03-28 15:19:03', 11, 41);
insert into comment (text, timestamp, event, author) values ('[COMENTÁRIO GENÉRICO]', '2018-05-05 06:35:18', 25, 3);


--
-- Data for Name: community; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--
INSERT INTO community (name, description, creationdate, imagepath, ispublic) VALUES ('Feupinhos', 'O local onde todos os estudantes da FEUP devem estar.', '2018-03-08', 'img/community/feup.jpg', true);
INSERT INTO community (name, description, creationdate, imagepath, ispublic) VALUES ('Motinhas Vroom Vroom', 'O clube de fãs do Motinhas!', '2018-01-27', 'img/community/mota.jpg', true);
INSERT INTO community (name, description, creationdate, imagepath, ispublic) VALUES ('Vigia do bairro', 'O melhor sítio para planear as festas do bairro!', '2017-10-07', 'img/community/bairro.jpg', false);
INSERT INTO community (name, description, creationdate, imagepath, ispublic) VALUES ('Angélicos', 'A paz reina nesta comunidade. Só eventos serenos aqui.', '2017-08-19', 'img/community/burns.jpg', false);
INSERT INTO community (name, description, creationdate, imagepath, ispublic) VALUES ('Memes Picantes', 'haha sim', '2017-05-09', 'img/community/meme.jpg', true);


--
-- Data for Name: community_communitycategory; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO community_communitycategory VALUES (1, 8);
INSERT INTO community_communitycategory VALUES (1, 6);
INSERT INTO community_communitycategory VALUES (1, 5);
INSERT INTO community_communitycategory VALUES (2, 1);
INSERT INTO community_communitycategory VALUES (2, 6);
INSERT INTO community_communitycategory VALUES (2, 9);
INSERT INTO community_communitycategory VALUES (3, 2);
INSERT INTO community_communitycategory VALUES (4, 6);
INSERT INTO community_communitycategory VALUES (4, 7);
INSERT INTO community_communitycategory VALUES (5, 3);
INSERT INTO community_communitycategory VALUES (5, 8);


--
-- Data for Name: community_member; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--
insert into community_member values (5, 65, false);
insert into community_member values (3, 67, false);
insert into community_member values (3, 86, true);
insert into community_member values (5, 56, false);
insert into community_member values (4, 103, true);
insert into community_member values (3, 13, true);
insert into community_member values (4, 54, true);
insert into community_member values (1, 90, true);
insert into community_member values (4, 69, false);
insert into community_member values (3, 31, false);
insert into community_member values (1, 38, false);
insert into community_member values (1, 77, true);
insert into community_member values (1, 9, false);
insert into community_member values (4, 66, false);
insert into community_member values (4, 13, true);
insert into community_member values (4, 55, true);
insert into community_member values (4, 78, false);
insert into community_member values (4, 13, false);
insert into community_member values (3, 6, true);
insert into community_member values (5, 74, false);
insert into community_member values (4, 48, true);
insert into community_member values (5, 38, true);
insert into community_member values (4, 14, true);
insert into community_member values (1, 22, true);
insert into community_member values (4, 22, true);
insert into community_member values (3, 89, true);
insert into community_member values (3, 40, false);
insert into community_member values (2, 32, true);
insert into community_member values (4, 32, false);
insert into community_member values (4, 2, true);
insert into community_member values (1, 86, true);
insert into community_member values (4, 95, false);
insert into community_member values (5, 90, false);
insert into community_member values (1, 28, true);
insert into community_member values (5, 78, true);
insert into community_member values (2, 47, false);
insert into community_member values (4, 57, false);
insert into community_member values (1, 5, true);
insert into community_member values (2, 85, true);
insert into community_member values (3, 76, false);
insert into community_member values (2, 99, false);
insert into community_member values (1, 42, false);
insert into community_member values (2, 29, false);
insert into community_member values (1, 93, true);
insert into community_member values (4, 102, false);
insert into community_member values (5, 19, true);
insert into community_member values (3, 62, false);
insert into community_member values (2, 60, false);
insert into community_member values (2, 103, false);
insert into community_member values (5, 31, false);
insert into community_member values (1, 17, true);
insert into community_member values (3, 3, false);
insert into community_member values (2, 13, true);
insert into community_member values (3, 61, false);
insert into community_member values (3, 35, false);
insert into community_member values (5, 89, true);
insert into community_member values (4, 56, false);
insert into community_member values (5, 83, true);
insert into community_member values (3, 23, false);
insert into community_member values (4, 96, false);
insert into community_member values (5, 36, false);
insert into community_member values (4, 51, true);
insert into community_member values (1, 68, false);
insert into community_member values (3, 64, false);
insert into community_member values (3, 11, true);
insert into community_member values (2, 39, false);
insert into community_member values (2, 15, false);
insert into community_member values (3, 40, false);
insert into community_member values (2, 62, false);
insert into community_member values (2, 45, false);
insert into community_member values (4, 101, true);
insert into community_member values (5, 91, false);
insert into community_member values (4, 46, false);
insert into community_member values (5, 1, false);
insert into community_member values (3, 90, false);
insert into community_member values (3, 52, false);
insert into community_member values (5, 40, true);
insert into community_member values (3, 8, true);
insert into community_member values (4, 10, true);
insert into community_member values (1, 92, true);
insert into community_member values (1, 33, false);
insert into community_member values (1, 43, true);
insert into community_member values (1, 29, true);
insert into community_member values (2, 11, true);
insert into community_member values (1, 96, true);
insert into community_member values (1, 70, false);
insert into community_member values (5, 23, false);
insert into community_member values (1, 16, true);
insert into community_member values (5, 103, false);
insert into community_member values (2, 96, true);
insert into community_member values (4, 2, true);
insert into community_member values (3, 15, true);
insert into community_member values (4, 94, false);
insert into community_member values (2, 34, false);
insert into community_member values (3, 90, false);
insert into community_member values (5, 49, false);
insert into community_member values (4, 53, false);
insert into community_member values (5, 64, true);
insert into community_member values (4, 94, false);
insert into community_member values (5, 7, true);
insert into community_member values (4, 4, true);
insert into community_member values (3, 4, false);
insert into community_member values (1, 5, true);
insert into community_member values (5, 59, true);
insert into community_member values (4, 79, false);
insert into community_member values (4, 31, false);
insert into community_member values (2, 36, false);
insert into community_member values (5, 47, true);
insert into community_member values (5, 46, false);
insert into community_member values (5, 70, true);
insert into community_member values (1, 44, true);
insert into community_member values (2, 21, true);
insert into community_member values (5, 56, false);
insert into community_member values (3, 84, false);
insert into community_member values (4, 45, false);
insert into community_member values (2, 42, true);
insert into community_member values (4, 64, false);
insert into community_member values (3, 96, true);
insert into community_member values (3, 10, true);
insert into community_member values (3, 19, true);
insert into community_member values (1, 18, true);
insert into community_member values (3, 92, false);
insert into community_member values (2, 19, false);
insert into community_member values (2, 68, true);
insert into community_member values (5, 13, true);
insert into community_member values (5, 90, true);
insert into community_member values (5, 98, false);
insert into community_member values (3, 88, false);
insert into community_member values (1, 81, false);
insert into community_member values (5, 60, false);
insert into community_member values (5, 76, false);
insert into community_member values (2, 99, true);
insert into community_member values (4, 5, true);
insert into community_member values (5, 72, false);
insert into community_member values (5, 60, false);
insert into community_member values (1, 69, false);
insert into community_member values (2, 65, false);
insert into community_member values (3, 79, true);
insert into community_member values (3, 99, false);
insert into community_member values (1, 49, true);
insert into community_member values (2, 20, false);
insert into community_member values (4, 6, false);
insert into community_member values (4, 79, true);
insert into community_member values (1, 87, true);
insert into community_member values (1, 5, false);
insert into community_member values (1, 100, false);
insert into community_member values (3, 44, false);
insert into community_member values (4, 14, true);
insert into community_member values (5, 83, true);
insert into community_member values (1, 1, true);
insert into community_member values (2, 92, true);
insert into community_member values (1, 46, true);
insert into community_member values (5, 75, false);
insert into community_member values (4, 58, true);
insert into community_member values (4, 101, true);
insert into community_member values (1, 24, true);
insert into community_member values (5, 20, true);
insert into community_member values (2, 66, false);
insert into community_member values (5, 23, false);
insert into community_member values (2, 7, false);
insert into community_member values (4, 8, true);
insert into community_member values (4, 44, true);
insert into community_member values (3, 2, true);
insert into community_member values (3, 101, true);
insert into community_member values (4, 90, true);
insert into community_member values (1, 75, true);
insert into community_member values (4, 59, true);
insert into community_member values (1, 52, false);
insert into community_member values (4, 76, false);
insert into community_member values (3, 88, false);
insert into community_member values (2, 59, false);
insert into community_member values (5, 60, true);
insert into community_member values (5, 32, false);
insert into community_member values (1, 90, false);
insert into community_member values (3, 66, false);
insert into community_member values (1, 54, true);
insert into community_member values (2, 38, true);
insert into community_member values (5, 85, true);
insert into community_member values (2, 100, true);
insert into community_member values (3, 31, true);
insert into community_member values (2, 60, false);
insert into community_member values (3, 26, false);
insert into community_member values (2, 88, true);
insert into community_member values (5, 81, false);
insert into community_member values (5, 27, true);
insert into community_member values (4, 58, true);
insert into community_member values (3, 12, false);
insert into community_member values (5, 63, true);
insert into community_member values (4, 39, true);
insert into community_member values (4, 71, true);
insert into community_member values (5, 86, true);
insert into community_member values (2, 6, true);
insert into community_member values (2, 52, true);
insert into community_member values (4, 75, true);
insert into community_member values (1, 96, false);
insert into community_member values (2, 64, true);
insert into community_member values (3, 43, true);
insert into community_member values (2, 95, true);
insert into community_member values (5, 1, true);
insert into community_member values (1, 94, true);
insert into community_member values (1, 55, false);
insert into community_member values (1, 87, true);
insert into community_member values (3, 100, true);
insert into community_member values (5, 75, false);
insert into community_member values (5, 85, true);
insert into community_member values (3, 47, false);
insert into community_member values (5, 29, false);
insert into community_member values (5, 53, false);
insert into community_member values (3, 32, false);
insert into community_member values (4, 31, true);
insert into community_member values (3, 98, false);
insert into community_member values (2, 21, false);
insert into community_member values (2, 53, false);
insert into community_member values (1, 11, false);
insert into community_member values (5, 28, false);
insert into community_member values (1, 40, false);
insert into community_member values (5, 68, false);
insert into community_member values (4, 26, true);
insert into community_member values (4, 93, false);
insert into community_member values (5, 36, true);
insert into community_member values (4, 81, true);
insert into community_member values (3, 68, false);
insert into community_member values (4, 41, true);
insert into community_member values (3, 77, false);
insert into community_member values (2, 70, true);
insert into community_member values (2, 85, false);
insert into community_member values (3, 22, true);
insert into community_member values (4, 48, false);
insert into community_member values (5, 97, false);
insert into community_member values (1, 18, true);
insert into community_member values (3, 44, false);
insert into community_member values (5, 81, false);
insert into community_member values (1, 35, true);
insert into community_member values (5, 58, false);
insert into community_member values (1, 76, false);
insert into community_member values (5, 37, false);
insert into community_member values (1, 13, false);
insert into community_member values (5, 87, false);
insert into community_member values (2, 17, true);
insert into community_member values (4, 64, true);
insert into community_member values (5, 83, false);
insert into community_member values (5, 100, false);
insert into community_member values (3, 17, true);
insert into community_member values (3, 81, true);
insert into community_member values (1, 44, false);
insert into community_member values (3, 5, true);
insert into community_member values (5, 3, true);
insert into community_member values (5, 42, false);
insert into community_member values (3, 3, false);
insert into community_member values (5, 54, true);



--
-- Data for Name: communitycategory; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO communitycategory (name) VALUES ('cozinha');
INSERT INTO communitycategory (name) VALUES ('musica');
INSERT INTO communitycategory (name) VALUES ('vendas');
INSERT INTO communitycategory (name) VALUES ('exercito');
INSERT INTO communitycategory (name) VALUES ('trabalho');
INSERT INTO communitycategory (name) VALUES ('vinhos');
INSERT INTO communitycategory (name) VALUES ('jardim');
INSERT INTO communitycategory (name) VALUES ('restauração');
INSERT INTO communitycategory (name) VALUES ('animais');
INSERT INTO communitycategory (name) VALUES ('feminitas');
INSERT INTO communitycategory (name) VALUES ('masculos');
INSERT INTO communitycategory (name) VALUES ('desporto');


--
-- Data for Name: event; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Pedir um adiamento a LBAW', 'podemos adiar para quinta à hora de almoço pls', 'img/event/1.jpg', '2018-05-29', '2018-05-30', '06:10 AM', '11:30 AM', 178 , 'Porto', 'Rua Dr. Roberto Frias, s/n', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Queima das Fitas do Porto', 'Chegou o teu porto de encontro! Vive a vida académica ao máximo nas Noites da Queima!', 'img/event/2.jpg', '2018-05-06', '2018-05-13', '00:01 AM', '06:00 AM', 178 , 'Porto', 'Queimódromo', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Festa de aniversário da Josefina', ':)', 'img/event/3.jpg', '2018-07-31', '2018-06-25', '11:58 AM', '10:00 AM', 178 , 'Lisbon', 'Praça do Comércio', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Funeral da Josefina', ':(', 'img/event/4.jpg', '2018-08-01', '2018-08-01', '10:00 AM', '08:30 PM', 178 , 'Porto', 'Rua de Santa Catarina', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('MEO Marés Vivas', 'O Marés Vivas voltou ao Grande Porto para te trazer muita música!', 'img/event/5.jpg', '2018-07-30', '2018-08-10', '03:00 PM', '07:30 PM', 178 , 'Vila Nova de Gaia', 'Rua da Praia', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Lançamento das notas de PLOG', 'podemos finalmente ter notas de plog pls', 'img/event/6.jpg', '2038-02-01', '2038-02-01', '8:00 AM', '8:05 AM', 178 , 'Porto', 'Rua Dr. Roberto Frias, s/n', true, 01);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Encontro dos motards da Areosa', 'vroom vroom', 'img/event/7.jpg', '2018-06-05', '2018-06-10', '6:10 AM', '11:30 AM', 178 , 'Porto', 'Estrada da Circunvalação', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Concerto do Toy na Foz ft. Netta', 'IM NOT YOUR TOY (not yooooooour tooooooy),  YOU STUPID BOY (stuuuupiiiid booooooooy)', 'img/event/8.jpg', '2018-09-29', '2018-09-29', '6:10 AM', '11:30 PM', 178 , 'Porto', 'Avenida da Boavista', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Rock In Rio', 'O Rock In Rio voltou a Portugal, no sítio do costume!', 'img/event/9.jpg', '2018-05-29', '2018-05-30', '6:10 AM', '11:30 AM', 178 , 'Lisbon', 'Passeio Marítimo de Algés', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Mundialito de Futebol de Praia', 'ninguém vê isto', 'img/event/10.jpg', '2018-05-29', '2018-05-30', '6:10 AM', '11:30 AM', 178 , 'Espinho', 'Rua 6, 278', false, 04);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Comic Con Portugal 2018', 'O evento que por alguma razão saiu de um centro de convenções e foi para um sítio cheio de pessoal suado!', 'img/event/11.jpg', '2018-09-20', '2018-09-27', '10:10 AM', '11:30 PM', 178 , 'Lisbon', 'Passeio Marítimo de Algés', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Comic Con Portugal 2018 I mean Comic Sans', 'O evento que parodia o Passeio Marítimo de Algés, sem sair do Porto!', null, '2018-12-08', '2018-12-10', '10:10 AM', '09:30 PM', 178 , 'Porto', 'Exponor', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Super Bock Super Rock', 'O evento que por alguma razão fica em Lisboa mas é patrocinado pela Super Bock volta este ano com muita música!', 'img/event/13.jpg', '2018-06-23', '2018-06-30', '12:30 PM', '11:30 PM', 178 , 'Lisbon', 'Praia do Meco', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Ressuscitação da Josefina', ':O', 'img/event/14.jpg', '2018-10-31', '2018-11-01', '6:30 PM', '11:30 AM', 178 , 'Porto', 'Cemitério de Paranhos', true, 05);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('NOS Alive 2018', 'A melhor música chegou ao Passeio Marítimo de Algés para ti, em 2018!', 'img/event/15.jpg', '2018-07-09', '2018-07-12', '6:10 AM', '11:30 AM', 178 , 'Lisbon', 'Passeio Marítimo de Algés', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('NOS Alive 2019', 'A melhor música chegou ao Passeio Marítimo de Algés para ti, em 2019!', 'img/event/16.jpg', '2019-07-09', '2019-07-12', '6:10 AM', '11:30 AM', 178 , 'Lisbon', 'Passeio Marítimo de Algés', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('NOS Dead 2020', 'O melhor Além chegou ao Passeio Marítimo de Algés para ti, em 2020!', 'img/event/17.jpg', '2020-07-09', '2020-07-12', '6:10 AM', '11:30 AM', 178 , 'Lisbon', 'Passeio Marítimo de Algés', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Afundamento da Madeira', 'omg afundámos uma ilha, como', 'img/event/18.jpg', '2018-05-29', '2018-05-30', '6:10 AM', '11:30 AM', 178 , 'Funchal', 'Rua do Quebra Costas, 5', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Festa de Aniversário do Kim Jong-Un', 'Parabéns ao Líder Supremo!', 'img/event/19.jpg', '2018-01-01', '2019-12-31', '0:01 AM', '11:59 PM', 118 , 'Pyongyang', 'Mansudae Street', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Almoço anual de família', 'A avó Alzira arranjou uma anca nova. Ela quer festejar.', 'img/event/20.jpg', '2018-06-03', '2018-06-03', '01:30 PM', '11:30 PM', 178 , 'São João da Madeira', 'Rua dos Sapateiros', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Torneio de Mario Kart 8', 'AAAAAAHHHHH TOMEM LÁ COM A MINHA CARAPAÇA AZUL AAAAAAAAAAAHHHH', 'img/event/21.jpg', '2018-05-29', '2018-05-30', '6:10 AM', '11:30 AM', 178 , 'Porto', 'Rua Dr. Roberto Frias, s/n', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('FEUP CAFFÉ RADICAL', 'A AEFEUP conseguiu meter uma parede de escalada dentro do edifício da AE. Sabe-se lá como.', 'img/event/22.jpg', '2018-05-31', '2018-05-01', '09:30 PM', '05:30 AM', 178 , 'Porto', 'Rua Dr. Roberto Frias, s/n', true, 01);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Festa de visualização do Han Solo', 'O filme precisa de mais audiências.', 'img/event/23.jpg', '2018-06-01', '2018-06-01', '02:30 PM', '07:30 PM', 178 , 'Porto', 'NorteShopping', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Memes', 'memes normies proibidos, apenas queremos memes picantes', null, '2018-04-20', '2018-04-20', '4:20 AM', '04:20 PM', 178 , 'Porto', 'Rua Dr. Roberto Frias, s/n', false, 01);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, ispublic, community) values ('Rally de Portugal', 'O Rally de Portugal voltou e está nos Aliados este ano!', 'img/event/25.jpg', '2018-05-15', '2018-05-20', '01:45 PM', '08:30 PM', 178 , 'Porto', 'Avenida dos Aliados', true, null);


insert into event_eventcategory (idevent, ideventcategory) values (22, 7);
insert into event_eventcategory (idevent, ideventcategory) values (25, 8);
insert into event_eventcategory (idevent, ideventcategory) values (19, 10);
insert into event_eventcategory (idevent, ideventcategory) values (13, 8);
insert into event_eventcategory (idevent, ideventcategory) values (17, 9);
insert into event_eventcategory (idevent, ideventcategory) values (20, 6);
insert into event_eventcategory (idevent, ideventcategory) values (3, 6);
insert into event_eventcategory (idevent, ideventcategory) values (3, 10);
insert into event_eventcategory (idevent, ideventcategory) values (21, 4);
insert into event_eventcategory (idevent, ideventcategory) values (18, 8);
insert into event_eventcategory (idevent, ideventcategory) values (21, 10);
insert into event_eventcategory (idevent, ideventcategory) values (3, 8);
insert into event_eventcategory (idevent, ideventcategory) values (16, 10);
insert into event_eventcategory (idevent, ideventcategory) values (5, 4);
insert into event_eventcategory (idevent, ideventcategory) values (8, 10);
insert into event_eventcategory (idevent, ideventcategory) values (22, 9);
insert into event_eventcategory (idevent, ideventcategory) values (13, 10);
insert into event_eventcategory (idevent, ideventcategory) values (6, 9);
insert into event_eventcategory (idevent, ideventcategory) values (2, 1);
insert into event_eventcategory (idevent, ideventcategory) values (10, 1);
insert into event_eventcategory (idevent, ideventcategory) values (19, 9);
insert into event_eventcategory (idevent, ideventcategory) values (6, 8);
insert into event_eventcategory (idevent, ideventcategory) values (1, 3);
insert into event_eventcategory (idevent, ideventcategory) values (16, 3);
insert into event_eventcategory (idevent, ideventcategory) values (3, 7);
insert into event_eventcategory (idevent, ideventcategory) values (22, 4);
insert into event_eventcategory (idevent, ideventcategory) values (16, 3);
insert into event_eventcategory (idevent, ideventcategory) values (16, 1);
insert into event_eventcategory (idevent, ideventcategory) values (12, 9);
insert into event_eventcategory (idevent, ideventcategory) values (18, 4);
insert into event_eventcategory (idevent, ideventcategory) values (2, 5);
insert into event_eventcategory (idevent, ideventcategory) values (4, 3);
insert into event_eventcategory (idevent, ideventcategory) values (15, 4);
insert into event_eventcategory (idevent, ideventcategory) values (7, 7);
insert into event_eventcategory (idevent, ideventcategory) values (20, 1);
insert into event_eventcategory (idevent, ideventcategory) values (20, 10);
insert into event_eventcategory (idevent, ideventcategory) values (20, 4);
insert into event_eventcategory (idevent, ideventcategory) values (4, 3);
insert into event_eventcategory (idevent, ideventcategory) values (24, 4);
insert into event_eventcategory (idevent, ideventcategory) values (14, 10);



--
-- Data for Name: event_member; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--
insert into event_member (idevent, idmember, isadmin) values (6, 84, false);
insert into event_member (idevent, idmember, isadmin) values (2, 13, true);
insert into event_member (idevent, idmember, isadmin) values (7, 51, true);
insert into event_member (idevent, idmember, isadmin) values (7, 36, false);
insert into event_member (idevent, idmember, isadmin) values (19, 20, true);
insert into event_member (idevent, idmember, isadmin) values (1, 41, true);
insert into event_member (idevent, idmember, isadmin) values (4, 92, false);
insert into event_member (idevent, idmember, isadmin) values (21, 22, true);
insert into event_member (idevent, idmember, isadmin) values (25, 68, true);
insert into event_member (idevent, idmember, isadmin) values (11, 102, true);
insert into event_member (idevent, idmember, isadmin) values (9, 16, false);
insert into event_member (idevent, idmember, isadmin) values (22, 85, false);
insert into event_member (idevent, idmember, isadmin) values (22, 61, true);
insert into event_member (idevent, idmember, isadmin) values (12, 52, true);
insert into event_member (idevent, idmember, isadmin) values (2, 45, true);
insert into event_member (idevent, idmember, isadmin) values (16, 22, false);
insert into event_member (idevent, idmember, isadmin) values (6, 92, false);
insert into event_member (idevent, idmember, isadmin) values (2, 76, false);
insert into event_member (idevent, idmember, isadmin) values (13, 36, true);
insert into event_member (idevent, idmember, isadmin) values (4, 12, true);
insert into event_member (idevent, idmember, isadmin) values (19, 64, false);
insert into event_member (idevent, idmember, isadmin) values (25, 88, true);
insert into event_member (idevent, idmember, isadmin) values (25, 92, false);
insert into event_member (idevent, idmember, isadmin) values (15, 12, false);
insert into event_member (idevent, idmember, isadmin) values (24, 65, false);
insert into event_member (idevent, idmember, isadmin) values (8, 57, false);
insert into event_member (idevent, idmember, isadmin) values (24, 36, false);
insert into event_member (idevent, idmember, isadmin) values (16, 56, true);
insert into event_member (idevent, idmember, isadmin) values (21, 49, true);
insert into event_member (idevent, idmember, isadmin) values (21, 64, true);
insert into event_member (idevent, idmember, isadmin) values (15, 89, true);
insert into event_member (idevent, idmember, isadmin) values (23, 72, false);
insert into event_member (idevent, idmember, isadmin) values (7, 14, false);
insert into event_member (idevent, idmember, isadmin) values (9, 46, true);
insert into event_member (idevent, idmember, isadmin) values (8, 1, false);
insert into event_member (idevent, idmember, isadmin) values (2, 20, false);
insert into event_member (idevent, idmember, isadmin) values (23, 40, true);
insert into event_member (idevent, idmember, isadmin) values (21, 94, true);
insert into event_member (idevent, idmember, isadmin) values (3, 72, true);
insert into event_member (idevent, idmember, isadmin) values (24, 99, false);
insert into event_member (idevent, idmember, isadmin) values (3, 44, false);
insert into event_member (idevent, idmember, isadmin) values (2, 93, false);
insert into event_member (idevent, idmember, isadmin) values (12, 67, true);
insert into event_member (idevent, idmember, isadmin) values (2, 73, false);
insert into event_member (idevent, idmember, isadmin) values (14, 94, false);
insert into event_member (idevent, idmember, isadmin) values (25, 51, true);
insert into event_member (idevent, idmember, isadmin) values (9, 7, true);
insert into event_member (idevent, idmember, isadmin) values (22, 89, false);
insert into event_member (idevent, idmember, isadmin) values (2, 45, true);
insert into event_member (idevent, idmember, isadmin) values (1, 63, true);
insert into event_member (idevent, idmember, isadmin) values (15, 70, true);
insert into event_member (idevent, idmember, isadmin) values (16, 68, true);
insert into event_member (idevent, idmember, isadmin) values (6, 10, true);
insert into event_member (idevent, idmember, isadmin) values (5, 70, false);
insert into event_member (idevent, idmember, isadmin) values (7, 48, true);
insert into event_member (idevent, idmember, isadmin) values (19, 17, true);
insert into event_member (idevent, idmember, isadmin) values (16, 68, false);
insert into event_member (idevent, idmember, isadmin) values (6, 67, true);
insert into event_member (idevent, idmember, isadmin) values (7, 54, true);
insert into event_member (idevent, idmember, isadmin) values (20, 5, false);
insert into event_member (idevent, idmember, isadmin) values (24, 93, true);
insert into event_member (idevent, idmember, isadmin) values (10, 11, true);
insert into event_member (idevent, idmember, isadmin) values (3, 86, true);
insert into event_member (idevent, idmember, isadmin) values (22, 60, true);
insert into event_member (idevent, idmember, isadmin) values (13, 93, true);
insert into event_member (idevent, idmember, isadmin) values (12, 87, false);
insert into event_member (idevent, idmember, isadmin) values (24, 64, true);
insert into event_member (idevent, idmember, isadmin) values (16, 62, true);
insert into event_member (idevent, idmember, isadmin) values (10, 34, true);
insert into event_member (idevent, idmember, isadmin) values (25, 27, false);
insert into event_member (idevent, idmember, isadmin) values (21, 57, false);
insert into event_member (idevent, idmember, isadmin) values (2, 49, true);
insert into event_member (idevent, idmember, isadmin) values (14, 53, true);
insert into event_member (idevent, idmember, isadmin) values (7, 51, true);
insert into event_member (idevent, idmember, isadmin) values (21, 68, false);
insert into event_member (idevent, idmember, isadmin) values (10, 97, false);
insert into event_member (idevent, idmember, isadmin) values (5, 49, false);
insert into event_member (idevent, idmember, isadmin) values (17, 81, false);
insert into event_member (idevent, idmember, isadmin) values (4, 87, true);
insert into event_member (idevent, idmember, isadmin) values (22, 2, true);
insert into event_member (idevent, idmember, isadmin) values (16, 82, false);
insert into event_member (idevent, idmember, isadmin) values (3, 78, false);
insert into event_member (idevent, idmember, isadmin) values (20, 2, true);
insert into event_member (idevent, idmember, isadmin) values (17, 19, true);
insert into event_member (idevent, idmember, isadmin) values (11, 47, true);
insert into event_member (idevent, idmember, isadmin) values (3, 42, true);
insert into event_member (idevent, idmember, isadmin) values (21, 8, false);
insert into event_member (idevent, idmember, isadmin) values (18, 96, true);
insert into event_member (idevent, idmember, isadmin) values (21, 31, false);
insert into event_member (idevent, idmember, isadmin) values (13, 47, true);
insert into event_member (idevent, idmember, isadmin) values (3, 38, true);
insert into event_member (idevent, idmember, isadmin) values (17, 47, false);
insert into event_member (idevent, idmember, isadmin) values (23, 13, false);
insert into event_member (idevent, idmember, isadmin) values (17, 16, false);
insert into event_member (idevent, idmember, isadmin) values (8, 86, true);
insert into event_member (idevent, idmember, isadmin) values (17, 67, true);
insert into event_member (idevent, idmember, isadmin) values (18, 24, false);
insert into event_member (idevent, idmember, isadmin) values (13, 66, true);
insert into event_member (idevent, idmember, isadmin) values (2, 61, false);
insert into event_member (idevent, idmember, isadmin) values (21, 14, true);
insert into event_member (idevent, idmember, isadmin) values (1, 34, false);
insert into event_member (idevent, idmember, isadmin) values (2, 74, true);
insert into event_member (idevent, idmember, isadmin) values (8, 90, false);
insert into event_member (idevent, idmember, isadmin) values (9, 34, true);
insert into event_member (idevent, idmember, isadmin) values (24, 60, false);
insert into event_member (idevent, idmember, isadmin) values (16, 12, false);
insert into event_member (idevent, idmember, isadmin) values (24, 94, false);
insert into event_member (idevent, idmember, isadmin) values (16, 51, false);
insert into event_member (idevent, idmember, isadmin) values (12, 32, false);
insert into event_member (idevent, idmember, isadmin) values (19, 64, false);
insert into event_member (idevent, idmember, isadmin) values (25, 16, true);
insert into event_member (idevent, idmember, isadmin) values (9, 62, true);
insert into event_member (idevent, idmember, isadmin) values (22, 9, true);
insert into event_member (idevent, idmember, isadmin) values (4, 47, false);
insert into event_member (idevent, idmember, isadmin) values (6, 11, false);
insert into event_member (idevent, idmember, isadmin) values (1, 40, false);
insert into event_member (idevent, idmember, isadmin) values (20, 89, true);
insert into event_member (idevent, idmember, isadmin) values (5, 35, true);
insert into event_member (idevent, idmember, isadmin) values (15, 46, false);
insert into event_member (idevent, idmember, isadmin) values (1, 97, false);
insert into event_member (idevent, idmember, isadmin) values (3, 91, true);
insert into event_member (idevent, idmember, isadmin) values (19, 37, false);
insert into event_member (idevent, idmember, isadmin) values (12, 62, true);
insert into event_member (idevent, idmember, isadmin) values (12, 50, true);
insert into event_member (idevent, idmember, isadmin) values (9, 30, true);
insert into event_member (idevent, idmember, isadmin) values (6, 89, true);
insert into event_member (idevent, idmember, isadmin) values (2, 79, true);
insert into event_member (idevent, idmember, isadmin) values (4, 90, false);
insert into event_member (idevent, idmember, isadmin) values (5, 96, false);
insert into event_member (idevent, idmember, isadmin) values (15, 16, false);
insert into event_member (idevent, idmember, isadmin) values (3, 74, true);
insert into event_member (idevent, idmember, isadmin) values (9, 81, false);
insert into event_member (idevent, idmember, isadmin) values (15, 54, true);
insert into event_member (idevent, idmember, isadmin) values (23, 29, true);
insert into event_member (idevent, idmember, isadmin) values (10, 21, false);
insert into event_member (idevent, idmember, isadmin) values (8, 44, true);
insert into event_member (idevent, idmember, isadmin) values (20, 41, true);
insert into event_member (idevent, idmember, isadmin) values (15, 88, false);
insert into event_member (idevent, idmember, isadmin) values (1, 2, false);
insert into event_member (idevent, idmember, isadmin) values (6, 11, false);
insert into event_member (idevent, idmember, isadmin) values (21, 63, true);
insert into event_member (idevent, idmember, isadmin) values (14, 85, false);
insert into event_member (idevent, idmember, isadmin) values (9, 58, true);
insert into event_member (idevent, idmember, isadmin) values (11, 13, true);
insert into event_member (idevent, idmember, isadmin) values (6, 3, true);
insert into event_member (idevent, idmember, isadmin) values (3, 56, true);
insert into event_member (idevent, idmember, isadmin) values (20, 77, true);
insert into event_member (idevent, idmember, isadmin) values (21, 53, true);
insert into event_member (idevent, idmember, isadmin) values (1, 54, false);
insert into event_member (idevent, idmember, isadmin) values (22, 66, false);
insert into event_member (idevent, idmember, isadmin) values (11, 77, false);
insert into event_member (idevent, idmember, isadmin) values (9, 98, true);
insert into event_member (idevent, idmember, isadmin) values (5, 57, true);
insert into event_member (idevent, idmember, isadmin) values (5, 46, false);
insert into event_member (idevent, idmember, isadmin) values (6, 2, true);
insert into event_member (idevent, idmember, isadmin) values (23, 8, false);
insert into event_member (idevent, idmember, isadmin) values (7, 77, false);
insert into event_member (idevent, idmember, isadmin) values (1, 86, false);
insert into event_member (idevent, idmember, isadmin) values (13, 71, true);
insert into event_member (idevent, idmember, isadmin) values (7, 54, true);
insert into event_member (idevent, idmember, isadmin) values (19, 32, true);
insert into event_member (idevent, idmember, isadmin) values (20, 89, false);
insert into event_member (idevent, idmember, isadmin) values (11, 12, false);
insert into event_member (idevent, idmember, isadmin) values (6, 92, true);
insert into event_member (idevent, idmember, isadmin) values (11, 33, false);
insert into event_member (idevent, idmember, isadmin) values (4, 41, true);
insert into event_member (idevent, idmember, isadmin) values (7, 44, false);
insert into event_member (idevent, idmember, isadmin) values (12, 67, true);
insert into event_member (idevent, idmember, isadmin) values (13, 45, false);
insert into event_member (idevent, idmember, isadmin) values (11, 70, false);
insert into event_member (idevent, idmember, isadmin) values (10, 29, true);
insert into event_member (idevent, idmember, isadmin) values (13, 7, false);
insert into event_member (idevent, idmember, isadmin) values (14, 1, true);
insert into event_member (idevent, idmember, isadmin) values (8, 99, true);
insert into event_member (idevent, idmember, isadmin) values (6, 34, true);
insert into event_member (idevent, idmember, isadmin) values (12, 64, false);
insert into event_member (idevent, idmember, isadmin) values (18, 9, false);
insert into event_member (idevent, idmember, isadmin) values (6, 58, false);
insert into event_member (idevent, idmember, isadmin) values (25, 102, false);
insert into event_member (idevent, idmember, isadmin) values (7, 1, false);
insert into event_member (idevent, idmember, isadmin) values (20, 59, false);
insert into event_member (idevent, idmember, isadmin) values (24, 7, true);
insert into event_member (idevent, idmember, isadmin) values (17, 22, true);
insert into event_member (idevent, idmember, isadmin) values (12, 93, false);
insert into event_member (idevent, idmember, isadmin) values (18, 54, true);
insert into event_member (idevent, idmember, isadmin) values (25, 89, false);
insert into event_member (idevent, idmember, isadmin) values (7, 75, true);
insert into event_member (idevent, idmember, isadmin) values (23, 101, true);
insert into event_member (idevent, idmember, isadmin) values (6, 50, true);
insert into event_member (idevent, idmember, isadmin) values (20, 46, true);
insert into event_member (idevent, idmember, isadmin) values (20, 65, false);
insert into event_member (idevent, idmember, isadmin) values (15, 38, true);
insert into event_member (idevent, idmember, isadmin) values (12, 65, true);
insert into event_member (idevent, idmember, isadmin) values (23, 30, true);
insert into event_member (idevent, idmember, isadmin) values (14, 83, false);
insert into event_member (idevent, idmember, isadmin) values (12, 23, true);
insert into event_member (idevent, idmember, isadmin) values (3, 53, false);
insert into event_member (idevent, idmember, isadmin) values (24, 11, false);
insert into event_member (idevent, idmember, isadmin) values (8, 7, true);
insert into event_member (idevent, idmember, isadmin) values (2, 89, false);
insert into event_member (idevent, idmember, isadmin) values (11, 96, false);
insert into event_member (idevent, idmember, isadmin) values (2, 62, true);
insert into event_member (idevent, idmember, isadmin) values (21, 9, false);
insert into event_member (idevent, idmember, isadmin) values (6, 99, true);
insert into event_member (idevent, idmember, isadmin) values (19, 19, true);
insert into event_member (idevent, idmember, isadmin) values (4, 25, true);
insert into event_member (idevent, idmember, isadmin) values (21, 29, true);
insert into event_member (idevent, idmember, isadmin) values (9, 1, true);
insert into event_member (idevent, idmember, isadmin) values (21, 46, true);
insert into event_member (idevent, idmember, isadmin) values (13, 4, false);
insert into event_member (idevent, idmember, isadmin) values (21, 19, false);
insert into event_member (idevent, idmember, isadmin) values (8, 60, false);
insert into event_member (idevent, idmember, isadmin) values (23, 19, false);
insert into event_member (idevent, idmember, isadmin) values (1, 41, false);
insert into event_member (idevent, idmember, isadmin) values (1, 66, true);
insert into event_member (idevent, idmember, isadmin) values (9, 49, false);
insert into event_member (idevent, idmember, isadmin) values (13, 73, false);
insert into event_member (idevent, idmember, isadmin) values (19, 94, false);
insert into event_member (idevent, idmember, isadmin) values (7, 79, false);
insert into event_member (idevent, idmember, isadmin) values (21, 29, true);
insert into event_member (idevent, idmember, isadmin) values (25, 61, false);
insert into event_member (idevent, idmember, isadmin) values (19, 36, true);
insert into event_member (idevent, idmember, isadmin) values (17, 34, true);
insert into event_member (idevent, idmember, isadmin) values (22, 21, false);
insert into event_member (idevent, idmember, isadmin) values (17, 65, false);
insert into event_member (idevent, idmember, isadmin) values (7, 77, false);
insert into event_member (idevent, idmember, isadmin) values (9, 93, false);
insert into event_member (idevent, idmember, isadmin) values (21, 26, true);
insert into event_member (idevent, idmember, isadmin) values (12, 24, false);
insert into event_member (idevent, idmember, isadmin) values (10, 65, false);
insert into event_member (idevent, idmember, isadmin) values (1, 10, true);
insert into event_member (idevent, idmember, isadmin) values (10, 39, true);
insert into event_member (idevent, idmember, isadmin) values (2, 8, false);
insert into event_member (idevent, idmember, isadmin) values (9, 25, true);
insert into event_member (idevent, idmember, isadmin) values (22, 46, false);
insert into event_member (idevent, idmember, isadmin) values (5, 90, true);
insert into event_member (idevent, idmember, isadmin) values (23, 2, true);
insert into event_member (idevent, idmember, isadmin) values (3, 18, false);
insert into event_member (idevent, idmember, isadmin) values (21, 67, false);
insert into event_member (idevent, idmember, isadmin) values (19, 9, false);
insert into event_member (idevent, idmember, isadmin) values (8, 62, false);
insert into event_member (idevent, idmember, isadmin) values (8, 52, false);
insert into event_member (idevent, idmember, isadmin) values (18, 84, false);
insert into event_member (idevent, idmember, isadmin) values (11, 98, true);
insert into event_member (idevent, idmember, isadmin) values (25, 52, false);
insert into event_member (idevent, idmember, isadmin) values (12, 79, false);
insert into event_member (idevent, idmember, isadmin) values (13, 84, false);
insert into event_member (idevent, idmember, isadmin) values (2, 85, false);
insert into event_member (idevent, idmember, isadmin) values (6, 87, false);
insert into event_member (idevent, idmember, isadmin) values (25, 19, true);
insert into event_member (idevent, idmember, isadmin) values (5, 96, true);
insert into event_member (idevent, idmember, isadmin) values (17, 29, true);
insert into event_member (idevent, idmember, isadmin) values (8, 3, false);
insert into event_member (idevent, idmember, isadmin) values (17, 63, true);
insert into event_member (idevent, idmember, isadmin) values (8, 4, true);
insert into event_member (idevent, idmember, isadmin) values (2, 19, false);
insert into event_member (idevent, idmember, isadmin) values (2, 45, true);
insert into event_member (idevent, idmember, isadmin) values (12, 77, true);
insert into event_member (idevent, idmember, isadmin) values (17, 86, true);
insert into event_member (idevent, idmember, isadmin) values (10, 59, false);
insert into event_member (idevent, idmember, isadmin) values (2, 20, false);
insert into event_member (idevent, idmember, isadmin) values (4, 59, true);
insert into event_member (idevent, idmember, isadmin) values (22, 29, true);
insert into event_member (idevent, idmember, isadmin) values (5, 44, true);
insert into event_member (idevent, idmember, isadmin) values (24, 2, false);
insert into event_member (idevent, idmember, isadmin) values (21, 54, false);
insert into event_member (idevent, idmember, isadmin) values (7, 38, false);
insert into event_member (idevent, idmember, isadmin) values (25, 68, false);
insert into event_member (idevent, idmember, isadmin) values (12, 50, true);
insert into event_member (idevent, idmember, isadmin) values (22, 89, false);
insert into event_member (idevent, idmember, isadmin) values (1, 56, true);
insert into event_member (idevent, idmember, isadmin) values (14, 22, true);
insert into event_member (idevent, idmember, isadmin) values (22, 99, false);
insert into event_member (idevent, idmember, isadmin) values (17, 1, false);
insert into event_member (idevent, idmember, isadmin) values (13, 101, true);
insert into event_member (idevent, idmember, isadmin) values (25, 10, true);
insert into event_member (idevent, idmember, isadmin) values (20, 31, false);
insert into event_member (idevent, idmember, isadmin) values (4, 95, true);
insert into event_member (idevent, idmember, isadmin) values (8, 79, true);
insert into event_member (idevent, idmember, isadmin) values (10, 45, false);
insert into event_member (idevent, idmember, isadmin) values (11, 28, false);
insert into event_member (idevent, idmember, isadmin) values (3, 78, false);
insert into event_member (idevent, idmember, isadmin) values (22, 8, true);
insert into event_member (idevent, idmember, isadmin) values (2, 96, true);
insert into event_member (idevent, idmember, isadmin) values (24, 94, false);
insert into event_member (idevent, idmember, isadmin) values (6, 5, false);
insert into event_member (idevent, idmember, isadmin) values (22, 8, false);
insert into event_member (idevent, idmember, isadmin) values (14, 50, true);
insert into event_member (idevent, idmember, isadmin) values (11, 29, false);
insert into event_member (idevent, idmember, isadmin) values (23, 73, true);
insert into event_member (idevent, idmember, isadmin) values (5, 54, false);
insert into event_member (idevent, idmember, isadmin) values (7, 50, false);
insert into event_member (idevent, idmember, isadmin) values (6, 12, true);
insert into event_member (idevent, idmember, isadmin) values (20, 84, false);
insert into event_member (idevent, idmember, isadmin) values (6, 60, false);
insert into event_member (idevent, idmember, isadmin) values (10, 29, true);
insert into event_member (idevent, idmember, isadmin) values (14, 75, false);
insert into event_member (idevent, idmember, isadmin) values (12, 48, false);
insert into event_member (idevent, idmember, isadmin) values (4, 47, true);
insert into event_member (idevent, idmember, isadmin) values (11, 13, true);
insert into event_member (idevent, idmember, isadmin) values (19, 22, true);
insert into event_member (idevent, idmember, isadmin) values (3, 33, true);
insert into event_member (idevent, idmember, isadmin) values (2, 32, true);
insert into event_member (idevent, idmember, isadmin) values (7, 36, false);
insert into event_member (idevent, idmember, isadmin) values (6, 16, true);
insert into event_member (idevent, idmember, isadmin) values (7, 24, false);
insert into event_member (idevent, idmember, isadmin) values (14, 97, true);
insert into event_member (idevent, idmember, isadmin) values (25, 46, true);
insert into event_member (idevent, idmember, isadmin) values (12, 47, true);
insert into event_member (idevent, idmember, isadmin) values (1, 56, true);
insert into event_member (idevent, idmember, isadmin) values (13, 70, false);
insert into event_member (idevent, idmember, isadmin) values (18, 10, true);
insert into event_member (idevent, idmember, isadmin) values (14, 17, true);
insert into event_member (idevent, idmember, isadmin) values (16, 79, false);
insert into event_member (idevent, idmember, isadmin) values (11, 99, false);
insert into event_member (idevent, idmember, isadmin) values (22, 84, true);
insert into event_member (idevent, idmember, isadmin) values (10, 11, true);
insert into event_member (idevent, idmember, isadmin) values (18, 37, true);
insert into event_member (idevent, idmember, isadmin) values (17, 82, true);
insert into event_member (idevent, idmember, isadmin) values (16, 50, false);
insert into event_member (idevent, idmember, isadmin) values (3, 95, false);
insert into event_member (idevent, idmember, isadmin) values (1, 53, false);
insert into event_member (idevent, idmember, isadmin) values (14, 87, false);
insert into event_member (idevent, idmember, isadmin) values (8, 45, true);
insert into event_member (idevent, idmember, isadmin) values (5, 61, true);
insert into event_member (idevent, idmember, isadmin) values (2, 67, false);
insert into event_member (idevent, idmember, isadmin) values (16, 80, true);
insert into event_member (idevent, idmember, isadmin) values (2, 4, true);
insert into event_member (idevent, idmember, isadmin) values (21, 61, false);
insert into event_member (idevent, idmember, isadmin) values (17, 23, false);
insert into event_member (idevent, idmember, isadmin) values (19, 10, true);
insert into event_member (idevent, idmember, isadmin) values (15, 103, false);
insert into event_member (idevent, idmember, isadmin) values (19, 71, false);
insert into event_member (idevent, idmember, isadmin) values (8, 22, false);
insert into event_member (idevent, idmember, isadmin) values (18, 67, false);
insert into event_member (idevent, idmember, isadmin) values (6, 2, true);
insert into event_member (idevent, idmember, isadmin) values (24, 23, false);
insert into event_member (idevent, idmember, isadmin) values (16, 56, true);
insert into event_member (idevent, idmember, isadmin) values (4, 47, true);
insert into event_member (idevent, idmember, isadmin) values (13, 76, false);
insert into event_member (idevent, idmember, isadmin) values (5, 74, true);
insert into event_member (idevent, idmember, isadmin) values (25, 15, true);
insert into event_member (idevent, idmember, isadmin) values (15, 29, true);
insert into event_member (idevent, idmember, isadmin) values (2, 78, true);
insert into event_member (idevent, idmember, isadmin) values (10, 22, false);
insert into event_member (idevent, idmember, isadmin) values (21, 36, false);
insert into event_member (idevent, idmember, isadmin) values (15, 66, false);
insert into event_member (idevent, idmember, isadmin) values (5, 71, true);
insert into event_member (idevent, idmember, isadmin) values (13, 46, true);
insert into event_member (idevent, idmember, isadmin) values (5, 60, true);
insert into event_member (idevent, idmember, isadmin) values (12, 27, true);
insert into event_member (idevent, idmember, isadmin) values (15, 34, true);
insert into event_member (idevent, idmember, isadmin) values (19, 47, false);
insert into event_member (idevent, idmember, isadmin) values (10, 59, true);
insert into event_member (idevent, idmember, isadmin) values (8, 60, false);
insert into event_member (idevent, idmember, isadmin) values (25, 53, true);
insert into event_member (idevent, idmember, isadmin) values (25, 79, false);
insert into event_member (idevent, idmember, isadmin) values (7, 16, true);
insert into event_member (idevent, idmember, isadmin) values (21, 11, false);
insert into event_member (idevent, idmember, isadmin) values (8, 59, false);
insert into event_member (idevent, idmember, isadmin) values (14, 61, true);
insert into event_member (idevent, idmember, isadmin) values (7, 80, false);
insert into event_member (idevent, idmember, isadmin) values (8, 8, true);
insert into event_member (idevent, idmember, isadmin) values (10, 3, false);
insert into event_member (idevent, idmember, isadmin) values (1, 61, true);
insert into event_member (idevent, idmember, isadmin) values (16, 4, false);
insert into event_member (idevent, idmember, isadmin) values (1, 80, true);
insert into event_member (idevent, idmember, isadmin) values (24, 1, false);
insert into event_member (idevent, idmember, isadmin) values (19, 34, true);
insert into event_member (idevent, idmember, isadmin) values (8, 55, false);
insert into event_member (idevent, idmember, isadmin) values (25, 8, true);
insert into event_member (idevent, idmember, isadmin) values (15, 88, false);
insert into event_member (idevent, idmember, isadmin) values (1, 48, false);
insert into event_member (idevent, idmember, isadmin) values (7, 41, true);
insert into event_member (idevent, idmember, isadmin) values (7, 6, false);
insert into event_member (idevent, idmember, isadmin) values (17, 52, false);
insert into event_member (idevent, idmember, isadmin) values (5, 48, true);
insert into event_member (idevent, idmember, isadmin) values (9, 30, false);
insert into event_member (idevent, idmember, isadmin) values (7, 54, true);
insert into event_member (idevent, idmember, isadmin) values (3, 16, true);
insert into event_member (idevent, idmember, isadmin) values (14, 54, true);
insert into event_member (idevent, idmember, isadmin) values (13, 77, true);
insert into event_member (idevent, idmember, isadmin) values (8, 64, false);
insert into event_member (idevent, idmember, isadmin) values (10, 101, false);
insert into event_member (idevent, idmember, isadmin) values (8, 8, false);
insert into event_member (idevent, idmember, isadmin) values (23, 15, false);
insert into event_member (idevent, idmember, isadmin) values (17, 30, true);
insert into event_member (idevent, idmember, isadmin) values (9, 83, true);
insert into event_member (idevent, idmember, isadmin) values (12, 4, true);
insert into event_member (idevent, idmember, isadmin) values (1, 21, false);
insert into event_member (idevent, idmember, isadmin) values (23, 66, false);
insert into event_member (idevent, idmember, isadmin) values (23, 86, false);
insert into event_member (idevent, idmember, isadmin) values (21, 1, true);
insert into event_member (idevent, idmember, isadmin) values (10, 61, true);
insert into event_member (idevent, idmember, isadmin) values (19, 52, false);
insert into event_member (idevent, idmember, isadmin) values (5, 95, true);
insert into event_member (idevent, idmember, isadmin) values (6, 90, true);
insert into event_member (idevent, idmember, isadmin) values (4, 57, false);
insert into event_member (idevent, idmember, isadmin) values (25, 98, false);
insert into event_member (idevent, idmember, isadmin) values (19, 79, true);
insert into event_member (idevent, idmember, isadmin) values (7, 43, false);
insert into event_member (idevent, idmember, isadmin) values (24, 17, false);
insert into event_member (idevent, idmember, isadmin) values (25, 23, false);
insert into event_member (idevent, idmember, isadmin) values (18, 10, true);
insert into event_member (idevent, idmember, isadmin) values (20, 75, true);
insert into event_member (idevent, idmember, isadmin) values (9, 24, false);
insert into event_member (idevent, idmember, isadmin) values (24, 50, true);
insert into event_member (idevent, idmember, isadmin) values (17, 77, false);
insert into event_member (idevent, idmember, isadmin) values (9, 83, false);
insert into event_member (idevent, idmember, isadmin) values (9, 57, false);
insert into event_member (idevent, idmember, isadmin) values (12, 35, true);
insert into event_member (idevent, idmember, isadmin) values (24, 37, false);
insert into event_member (idevent, idmember, isadmin) values (2, 52, true);
insert into event_member (idevent, idmember, isadmin) values (18, 67, false);
insert into event_member (idevent, idmember, isadmin) values (22, 19, true);
insert into event_member (idevent, idmember, isadmin) values (9, 39, true);
insert into event_member (idevent, idmember, isadmin) values (16, 20, false);
insert into event_member (idevent, idmember, isadmin) values (17, 19, false);
insert into event_member (idevent, idmember, isadmin) values (25, 35, true);
insert into event_member (idevent, idmember, isadmin) values (6, 84, true);
insert into event_member (idevent, idmember, isadmin) values (7, 92, false);
insert into event_member (idevent, idmember, isadmin) values (18, 16, false);
insert into event_member (idevent, idmember, isadmin) values (8, 33, true);
insert into event_member (idevent, idmember, isadmin) values (23, 54, true);
insert into event_member (idevent, idmember, isadmin) values (19, 72, true);
insert into event_member (idevent, idmember, isadmin) values (25, 63, true);
insert into event_member (idevent, idmember, isadmin) values (2, 13, false);
insert into event_member (idevent, idmember, isadmin) values (1, 83, true);
insert into event_member (idevent, idmember, isadmin) values (23, 75, false);
insert into event_member (idevent, idmember, isadmin) values (11, 37, false);
insert into event_member (idevent, idmember, isadmin) values (18, 17, false);
insert into event_member (idevent, idmember, isadmin) values (5, 9, false);
insert into event_member (idevent, idmember, isadmin) values (6, 94, false);
insert into event_member (idevent, idmember, isadmin) values (9, 89, false);
insert into event_member (idevent, idmember, isadmin) values (15, 5, true);
insert into event_member (idevent, idmember, isadmin) values (8, 98, true);
insert into event_member (idevent, idmember, isadmin) values (3, 14, true);
insert into event_member (idevent, idmember, isadmin) values (13, 87, false);
insert into event_member (idevent, idmember, isadmin) values (23, 49, true);
insert into event_member (idevent, idmember, isadmin) values (7, 94, false);
insert into event_member (idevent, idmember, isadmin) values (8, 28, false);
insert into event_member (idevent, idmember, isadmin) values (6, 44, false);
insert into event_member (idevent, idmember, isadmin) values (11, 101, true);
insert into event_member (idevent, idmember, isadmin) values (15, 65, true);
insert into event_member (idevent, idmember, isadmin) values (24, 57, true);
insert into event_member (idevent, idmember, isadmin) values (15, 53, true);
insert into event_member (idevent, idmember, isadmin) values (16, 9, false);
insert into event_member (idevent, idmember, isadmin) values (19, 29, true);
insert into event_member (idevent, idmember, isadmin) values (9, 65, true);
insert into event_member (idevent, idmember, isadmin) values (23, 43, false);
insert into event_member (idevent, idmember, isadmin) values (24, 53, true);
insert into event_member (idevent, idmember, isadmin) values (9, 7, false);
insert into event_member (idevent, idmember, isadmin) values (14, 12, true);
insert into event_member (idevent, idmember, isadmin) values (9, 1, false);
insert into event_member (idevent, idmember, isadmin) values (16, 30, false);
insert into event_member (idevent, idmember, isadmin) values (21, 84, false);
insert into event_member (idevent, idmember, isadmin) values (11, 6, true);
insert into event_member (idevent, idmember, isadmin) values (18, 103, true);
insert into event_member (idevent, idmember, isadmin) values (4, 79, true);
insert into event_member (idevent, idmember, isadmin) values (3, 33, false);
insert into event_member (idevent, idmember, isadmin) values (10, 102, true);
insert into event_member (idevent, idmember, isadmin) values (15, 82, true);
insert into event_member (idevent, idmember, isadmin) values (3, 1, false);
insert into event_member (idevent, idmember, isadmin) values (19, 86, false);
insert into event_member (idevent, idmember, isadmin) values (12, 26, false);
insert into event_member (idevent, idmember, isadmin) values (16, 3, false);
insert into event_member (idevent, idmember, isadmin) values (7, 83, true);
insert into event_member (idevent, idmember, isadmin) values (4, 80, false);
insert into event_member (idevent, idmember, isadmin) values (9, 88, true);
insert into event_member (idevent, idmember, isadmin) values (15, 2, false);
insert into event_member (idevent, idmember, isadmin) values (12, 50, false);
insert into event_member (idevent, idmember, isadmin) values (15, 82, true);
insert into event_member (idevent, idmember, isadmin) values (9, 70, true);
insert into event_member (idevent, idmember, isadmin) values (5, 94, true);
insert into event_member (idevent, idmember, isadmin) values (24, 97, true);
insert into event_member (idevent, idmember, isadmin) values (9, 18, false);
insert into event_member (idevent, idmember, isadmin) values (7, 23, false);
insert into event_member (idevent, idmember, isadmin) values (19, 55, true);
insert into event_member (idevent, idmember, isadmin) values (16, 7, true);
insert into event_member (idevent, idmember, isadmin) values (15, 72, true);
insert into event_member (idevent, idmember, isadmin) values (25, 20, true);
insert into event_member (idevent, idmember, isadmin) values (5, 6, true);
insert into event_member (idevent, idmember, isadmin) values (2, 7, false);
insert into event_member (idevent, idmember, isadmin) values (12, 44, false);
insert into event_member (idevent, idmember, isadmin) values (23, 52, true);
insert into event_member (idevent, idmember, isadmin) values (25, 91, false);
insert into event_member (idevent, idmember, isadmin) values (3, 63, true);
insert into event_member (idevent, idmember, isadmin) values (24, 27, true);
insert into event_member (idevent, idmember, isadmin) values (15, 63, true);
insert into event_member (idevent, idmember, isadmin) values (21, 12, false);
insert into event_member (idevent, idmember, isadmin) values (8, 3, true);
insert into event_member (idevent, idmember, isadmin) values (17, 99, true);
insert into event_member (idevent, idmember, isadmin) values (2, 95, false);
insert into event_member (idevent, idmember, isadmin) values (16, 47, true);
insert into event_member (idevent, idmember, isadmin) values (11, 82, true);
insert into event_member (idevent, idmember, isadmin) values (23, 27, false);
insert into event_member (idevent, idmember, isadmin) values (2, 4, true);
insert into event_member (idevent, idmember, isadmin) values (20, 101, true);
insert into event_member (idevent, idmember, isadmin) values (19, 67, false);


--
-- Data for Name: eventcategory; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO eventcategory (name) VALUES ('discoteca');
INSERT INTO eventcategory (name) VALUES ('musica');
INSERT INTO eventcategory (name) VALUES ('cozinha');
INSERT INTO eventcategory (name) VALUES ('politica');
INSERT INTO eventcategory (name) VALUES ('vinhos');
INSERT INTO eventcategory (name) VALUES ('palestra');
INSERT INTO eventcategory (name) VALUES ('empresarial');
INSERT INTO eventcategory (name) VALUES ('apenas pela diversão');
INSERT INTO eventcategory (name) VALUES ('social');
INSERT INTO eventcategory (name) VALUES ('familiar');
INSERT INTO eventcategory (name) VALUES ('festa');
INSERT INTO eventcategory (name) VALUES ('cultura');


--
-- Data for Name: friend; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO friend VALUES (44, 95, false);
INSERT INTO friend VALUES (22, 51, true);
INSERT INTO friend VALUES (18, 88, true);
INSERT INTO friend VALUES (99, 79, false);
INSERT INTO friend VALUES (67, 70, true);
INSERT INTO friend VALUES (13, 30, true);
INSERT INTO friend VALUES (40, 5, false);
INSERT INTO friend VALUES (29, 21, true);
INSERT INTO friend VALUES (44, 60, true);
INSERT INTO friend VALUES (40, 12, true);
INSERT INTO friend VALUES (70, 25, false);
INSERT INTO friend VALUES (88, 51, false);
INSERT INTO friend VALUES (30, 98, true);
INSERT INTO friend VALUES (13, 83, false);
INSERT INTO friend VALUES (95, 51, true);
INSERT INTO friend VALUES (77, 83, false);
INSERT INTO friend VALUES (24, 98, false);
INSERT INTO friend VALUES (29, 90, false);
INSERT INTO friend VALUES (72, 68, false);
INSERT INTO friend VALUES (69, 89, false);
INSERT INTO friend VALUES (16, 92, false);
INSERT INTO friend VALUES (13, 7, true);
INSERT INTO friend VALUES (9, 39, true);
INSERT INTO friend VALUES (8, 51, true);
INSERT INTO friend VALUES (24, 42, false);
INSERT INTO friend VALUES (1, 26, false);
INSERT INTO friend VALUES (7, 12, false);
INSERT INTO friend VALUES (46, 98, false);
INSERT INTO friend VALUES (12, 56, true);
INSERT INTO friend VALUES (29, 48, false);
INSERT INTO friend VALUES (29, 24, false);
INSERT INTO friend VALUES (14, 60, true);
INSERT INTO friend VALUES (66, 97, true);
INSERT INTO friend VALUES (25, 84, false);
INSERT INTO friend VALUES (59, 76, true);
INSERT INTO friend VALUES (35, 38, true);
INSERT INTO friend VALUES (37, 81, false);
INSERT INTO friend VALUES (83, 58, true);
INSERT INTO friend VALUES (49, 93, false);
INSERT INTO friend VALUES (26, 60, false);
INSERT INTO friend VALUES (30, 91, false);
INSERT INTO friend VALUES (37, 71, false);
INSERT INTO friend VALUES (26, 83, true);
INSERT INTO friend VALUES (5, 42, true);
INSERT INTO friend VALUES (3, 72, true);
INSERT INTO friend VALUES (99, 61, true);
INSERT INTO friend VALUES (26, 75, true);
INSERT INTO friend VALUES (25, 75, true);
INSERT INTO friend VALUES (42, 51, true);
INSERT INTO friend VALUES (44, 70, true);
INSERT INTO friend VALUES (73, 7, false);
INSERT INTO friend VALUES (88, 51, false);
INSERT INTO friend VALUES (68, 11, false);
INSERT INTO friend VALUES (49, 97, false);
INSERT INTO friend VALUES (56, 75, true);
INSERT INTO friend VALUES (58, 65, true);
INSERT INTO friend VALUES (86, 74, true);
INSERT INTO friend VALUES (46, 29, false);
INSERT INTO friend VALUES (68, 75, true);
INSERT INTO friend VALUES (67, 2, true);
INSERT INTO friend VALUES (3, 37, true);
INSERT INTO friend VALUES (51, 18, false);
INSERT INTO friend VALUES (6, 11, false);
INSERT INTO friend VALUES (2, 18, false);
INSERT INTO friend VALUES (61, 17, false);
INSERT INTO friend VALUES (45, 77, false);
INSERT INTO friend VALUES (20, 68, false);
INSERT INTO friend VALUES (53, 42, true);
INSERT INTO friend VALUES (30, 36, false);
INSERT INTO friend VALUES (15, 46, false);
INSERT INTO friend VALUES (92, 8, false);
INSERT INTO friend VALUES (24, 47, true);
INSERT INTO friend VALUES (51, 18, true);
INSERT INTO friend VALUES (13, 25, false);
INSERT INTO friend VALUES (18, 67, false);
INSERT INTO friend VALUES (75, 19, false);
INSERT INTO friend VALUES (87, 14, false);
INSERT INTO friend VALUES (44, 99, true);
INSERT INTO friend VALUES (27, 54, true);
INSERT INTO friend VALUES (99, 87, false);
INSERT INTO friend VALUES (50, 20, false);
INSERT INTO friend VALUES (79, 59, false);
INSERT INTO friend VALUES (52, 70, true);
INSERT INTO friend VALUES (12, 37, false);
INSERT INTO friend VALUES (48, 41, false);
INSERT INTO friend VALUES (64, 78, false);
INSERT INTO friend VALUES (94, 14, true);
INSERT INTO friend VALUES (24, 62, false);
INSERT INTO friend VALUES (44, 55, true);
INSERT INTO friend VALUES (2, 77, false);
INSERT INTO friend VALUES (85, 19, true);
INSERT INTO friend VALUES (70, 9, true);
INSERT INTO friend VALUES (69, 15, false);
INSERT INTO friend VALUES (79, 93, true);
INSERT INTO friend VALUES (5, 99, false);
INSERT INTO friend VALUES (100, 41, true);
INSERT INTO friend VALUES (9, 64, false);
INSERT INTO friend VALUES (54, 73, false);
INSERT INTO friend VALUES (14, 61, true);

INSERT INTO friend VALUES (101, 41, true);
INSERT INTO friend VALUES (101, 64, true);
INSERT INTO friend VALUES (101, 73, true);
INSERT INTO friend VALUES (62, 101, false);


--
-- Data for Name: invoice; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date, idmember) VALUES (390993165, 'Pepillo Poulgreen', '8114 Corscot Way', 22, 50, '2017-12-10', 101);


--
-- Data for Name: member; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Liliane Vonderdell', 'lvonderdell0', 'nJSL69', '2017-10-14 10:18:37', 'lvonderdell0@zdnet.com', 196, 'Champagnole', '77 Northport Crossing', 365799637, 'Corros unsp deg mult left fngr (nail), not inc thumb, subs', 'img/member/1.jpg', '2017-08-30 23:51:11', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Nolly Iapico', 'niapico1', 'EJZZbrcLV', '2017-12-10 22:43:32', 'niapico1@jugem.jp', 121, 'Bolengpulau', '18603 Sloan Avenue', 261070092, 'Poisoning by glucocort/synth analog, assault, init', 'img/member/6.jpg', '2017-12-25 18:01:03', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Nariko Jacob', 'njacob2', 'KOWNuA', '2017-04-03 03:54:07', 'njacob2@dropbox.com', 128, 'Bodø', '8766 Farwell Place', 110139540, 'Staphyloma posticum, unspecified eye', 'img/member/6.jpg', '2017-10-01 19:34:38', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Rafaellle Yerlett', 'ryerlett3', 'mokmoW3', '2017-12-03 12:53:22', 'ryerlett3@ft.com', 211, 'Orhei', '2 Prentice Terrace', 599555559, 'Tinea barbae and tinea capitis', 'img/member/3.jpg', '2017-04-16 19:39:09', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Murray Ramelet', 'mramelet4', 'vKNhz99', '2017-06-07 16:09:22', 'mramelet4@canalblog.com', 153, 'Plyussa', '793 Jenifer Parkway', 151281785, 'Toxic effect of dichloromethane, intentional self-harm, subs', 'img/member/4.jpg', '2017-10-17 10:15:37', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Gerhardt Wincer', 'gwincer5', 'CXcCxjg', '2018-01-01 18:30:27', 'gwincer5@unesco.org', 234, 'Chuqui Chuqui', '322 Menomonie Park', 829515188, 'Conjunctival pigmentations, unspecified eye', 'img/member/2.jpg', '2018-01-26 12:48:21', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Winthrop Dimitriou', 'wdimitriou6', 'AS1hKsTj', '2017-04-24 17:29:05', 'wdimitriou6@xrea.com', 167, 'Sindangheula', '64643 Stephen Lane', 642213404, 'Displ oblique fx shaft of unsp ulna, 7thE', 'img/member/6.jpg', '2017-05-04 21:47:31', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Beau Trew', 'btrew7', 'EgQQwnFWK', '2018-03-03 14:54:34', 'btrew7@youtube.com', 205, 'Houndé', '67590 Di Loreto Plaza', 290024476, 'Blister (nonthermal), left knee, subsequent encounter', 'img/member/2.jpg', '2017-04-14 17:37:55', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Anthea Antram', 'aantram8', 'CcOBbHsC', '2017-06-14 04:49:25', 'aantram8@networkadvertising.org', 16, 'Kumlinge', '9913 Westport Hill', 127241873, 'Neurotrophic keratoconjunctivitis, bilateral', 'img/member/6.jpg', '2017-09-22 01:26:25', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Douglas MacLoughlin', 'dmacloughlin9', 'ngxfcz2NNz', '2017-06-13 05:45:55', 'dmacloughlin9@digg.com', 14, 'Alangilanan', '81240 Fairfield Crossing', 412386996, 'Pasngr on bus injured in nonclsn trnsp acc in traf, init', 'img/member/4.jpg', '2017-12-31 19:17:46', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ferdinande Keysall', 'fkeysalla', '9sUZy4u2tvim', '2018-01-10 10:29:01', 'fkeysalla@people.com.cn', 2, 'Gunungkendeng', '44634 Blaine Place', 765227799, 'Toxic effect of gases, fumes and vapors, accidental', 'img/member/4.jpg', '2017-05-06 13:07:45', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Carver MacPake', 'cmacpakeb', 'VYBL4Xdi04', '2017-09-16 21:11:55', 'cmacpakeb@icq.com', 180, 'Ongi', '0227 Doe Crossing Point', 657772019, 'Sltr-haris Type IV physeal fx unspecified calcaneus, sequela', 'img/member/1.jpg', '2017-09-30 21:04:55', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Alwin Alvy', 'aalvyc', 'lmAwyL', '2017-08-19 08:11:19', 'aalvyc@friendfeed.com', 134, 'Baliuag Nuevo', '91914 Dunning Place', 827218348, 'Acquired absence of right great toe', 'img/member/3.jpg', '2017-04-19 12:04:54', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Woody Searight', 'wsearightd', 'pLqgcx9gbr', '2017-05-15 12:37:56', 'wsearightd@chronoengine.com', 105, 'Asykata', '1211 Barby Place', 708123973, 'Corrosion of unsp degree of back of unsp hand, sequela', 'img/member/6.jpg', '2017-11-23 05:08:53', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ulrikaumeko Howselee', 'uhowseleee', 'JAdGManRAQ', '2017-08-06 04:50:49', 'uhowseleee@usda.gov', 220, 'Hagonoy', '04 Vernon Alley', 559524659, 'Unspecified disorder of synovium and tendon, left forearm', 'img/member/4.jpg', '2018-03-08 04:02:38', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Vinnie Debrick', 'vdebrickf', 'ZR694QrcjzBV', '2018-03-19 22:04:20', 'vdebrickf@hhs.gov', 52, 'Pingqiao', '70 Daystar Drive', 244687852, 'Pnctr w fb of unsp great toe w/o damage to nail, subs', 'img/member/6.jpg', '2017-04-10 22:34:27', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Carey Escott', 'cescottg', 'BOC4RdOcE', '2017-12-16 10:53:56', 'cescottg@bloomberg.com', 102, 'Shiqiaotou', '2 Shopko Park', 327595858, 'Oth hemorrhagic disord d/t intrns circ anticoag,antib,inhib', 'img/member/6.jpg', '2018-01-14 02:37:39', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Kinsley Weadick', 'kweadickh', 'xgryr9nY', '2017-08-04 02:25:38', 'kweadickh@addtoany.com', 51, 'Las Lomas', '54722 Transport Park', 583364062, 'Encounter for exam of ears and hearing w abnormal findings', 'img/member/4.jpg', '2017-11-21 15:40:51', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Dave Mannering', 'dmanneringi', '343pi9q', '2017-04-20 17:31:29', 'dmanneringi@unc.edu', 108, 'Korobitsyno', '96700 Rutledge Hill', 230657531, 'Pnctr of abd wall w/o fb, left lower q w/o penet perit cav', 'img/member/5.jpg', '2017-07-23 19:45:57', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Keefer Schenkel', 'kschenkelj', 'h5GauPtW', '2017-10-04 14:43:50', 'kschenkelj@tinyurl.com', 83, 'Gorzów Wielkopolski', '559 Golden Leaf Plaza', 149356560, 'Gestational diabetes in pregnancy, insulin controlled', 'img/member/4.jpg', '2018-01-26 16:37:20', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Diandra O''Reilly', 'doreillyk', '3qmadnpVB', '2017-04-06 09:09:31', 'doreillyk@cmu.edu', 46, 'Franca', '3 Carey Avenue', 953273041, 'Asphyx due to mech threat to breathing due to oth causes', 'img/member/5.jpg', '2017-10-30 20:01:08', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Zelig Stanyard', 'zstanyardl', '7kac6iL1', '2017-05-01 19:22:27', 'zstanyardl@vkontakte.ru', 191, 'Timpas', '7921 Bayside Street', 199726208, 'Disp fx of unsp tibial spine, subs for clos fx w routn heal', 'img/member/2.jpg', '2017-12-08 08:31:49', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Nessi Gornall', 'ngornallm', 'fFjKXsT', '2018-02-04 04:19:14', 'ngornallm@cargocollective.com', 10, 'Kuala Lumpur', '215 Haas Avenue', 420039463, 'Toxic effect of dichloromethane, undetermined, sequela', 'img/member/5.jpg', '2017-06-30 20:30:44', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ninetta Forten', 'nfortenn', 'g7o8o7juvP', '2017-04-17 06:28:02', 'nfortenn@i2i.jp', 14, 'Xinhuang', '71 Green Ridge Hill', 577651191, 'Hemangioma of intracranial structures', 'img/member/6.jpg', '2017-07-01 11:49:18', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Sissie Lesmonde', 'slesmondeo', 'tkgz7SyA', '2017-12-27 11:50:36', 'slesmondeo@springer.com', 25, 'Ayapel', '470 Waxwing Court', 458589897, 'Toxic effect of trichloroethylene, self-harm, sequela', 'img/member/2.jpg', '2018-03-25 19:04:29', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Audre Tebbet', 'atebbetp', '3DhxgJD', '2017-07-31 04:37:59', 'atebbetp@examiner.com', 121, 'Mount Ayliff', '81 Rieder Place', 870067799, 'Nocardiosis, unspecified', 'img/member/1.jpg', '2017-06-22 15:38:48', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Conney Rogers', 'crogersq', 'IEurmmpdC8', '2017-09-21 21:48:14', 'crogersq@trellian.com', 186, 'Viengxay', '432 Steensland Point', 126886432, 'Poisoning by other laxatives, assault, subsequent encounter', 'img/member/4.jpg', '2017-07-18 18:07:12', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Purcell Simion', 'psimionr', 'Vu6qF0', '2018-02-04 04:49:38', 'psimionr@telegraph.co.uk', 70, 'Detupia', '81172 Dryden Place', 629717816, 'Prph tear of lat mensc, current injury, unsp knee, sequela', 'img/member/2.jpg', '2017-05-12 21:28:34', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Chadwick Menichelli', 'cmenichellis', 'jNZyrF', '2017-07-13 16:59:40', 'cmenichellis@biblegateway.com', 158, 'Daqiao', '42 Chinook Parkway', 556830498, 'Puncture wound with foreign body of scalp', 'img/member/5.jpg', '2017-05-15 23:14:05', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Chrysler Kopecka', 'ckopeckat', 'VoxuRnKBk', '2017-07-07 18:17:40', 'ckopeckat@freewebs.com', 50, 'Fontainebleau', '3831 Shopko Trail', 958647861, 'Intestinal angiostrongyliasis', 'img/member/6.jpg', '2018-01-12 07:22:33', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Devlen Elsbury', 'delsburyu', '3MMNMF', '2017-12-24 13:47:03', 'delsburyu@yahoo.com', 41, 'Santarém', '0074 Spohn Circle', 951171884, 'Jump/div into natrl body of wtr strk botm cause drown, init', 'img/member/4.jpg', '2017-10-28 14:12:18', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Zechariah Keepence', 'zkeepencev', 'qP4n63A', '2017-05-05 17:23:33', 'zkeepencev@google.pl', 31, 'Yangzi', '661 Granby Plaza', 450646707, 'Open bite of other specified part of neck, sequela', 'img/member/2.jpg', '2017-04-05 12:05:53', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Shayna Hurst', 'shurstw', 'S3fIv07f6', '2017-04-06 07:25:41', 'shurstw@canalblog.com', 194, 'Gorbatovka', '5 Dorton Place', 441954997, 'Open bite, right knee, subsequent encounter', 'img/member/2.jpg', '2018-01-17 16:17:08', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Emilia Deabill', 'edeabillx', 'h7aCgeQoC3', '2017-06-16 15:49:33', 'edeabillx@slate.com', 244, 'San Javier', '8775 Main Alley', 184369372, 'Encntr for obs for susp exposure to biolg agents ruled out', 'img/member/6.jpg', '2017-10-30 05:15:13', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Brinna Kopta', 'bkoptay', '6Otk9lTN', '2018-01-14 12:00:31', 'bkoptay@bing.com', 14, 'Ainaži', '6427 Westport Crossing', 951057426, 'Legal intervnt w unsp blunt objects, suspect injured, subs', 'img/member/5.jpg', '2017-08-24 12:06:44', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Leland Street', 'lstreetz', 'dJd2r0GJ', '2018-01-31 22:24:01', 'lstreetz@edublogs.org', 135, 'Tulcán', '65 Becker Plaza', 476218317, 'Kaschin-Beck disease, hand', 'img/member/2.jpg', '2017-07-08 01:59:26', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Raquela Harrema', 'rharrema10', 'bTShA3OeL', '2018-02-25 01:02:24', 'rharrema10@newyorker.com', 113, 'Biny Selo', '538 Bonner Street', 292711057, 'Insect bite (nonvenomous) of left ear, sequela', 'img/member/3.jpg', '2018-03-27 20:53:50', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Berk Fairhurst', 'bfairhurst11', 'QC4lmRwv9bNk', '2017-11-05 22:28:45', 'bfairhurst11@si.edu', 105, 'Delod Pangkung', '38 Kenwood Avenue', 752529128, 'Nondisplaced transcondylar fracture of unsp humerus, sequela', 'img/member/6.jpg', '2018-02-28 16:52:28', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Elnore Danels', 'edanels12', 'i2DwjKlY2h', '2018-02-10 20:25:50', 'edanels12@rediff.com', 61, 'Pepe', '657 Gerald Trail', 411651218, 'Other snow-ski accident', 'img/member/3.jpg', '2017-04-02 19:46:43', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Marci Zimmer', 'mzimmer13', '5TEFuee', '2018-02-10 11:14:17', 'mzimmer13@pcworld.com', 51, 'São Martinho do Campo', '5582 Mitchell Drive', 309884714, 'Drug/chem diab with mild nonp rtnop with macular edema, bi', 'img/member/2.jpg', '2017-11-23 03:08:49', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Cinda Bubbear', 'cbubbear14', 'V6R86Nh8X9', '2017-10-05 05:20:58', 'cbubbear14@washingtonpost.com', 106, 'Kortowo', '7 Morningstar Road', 253094782, 'Other idiopathic scoliosis, cervicothoracic region', 'img/member/6.jpg', '2017-09-05 02:58:35', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Flemming Leaves', 'fleaves15', 'odhrCS8', '2017-04-26 19:03:10', 'fleaves15@newyorker.com', 20, 'Afanas’yeva', '1 Sauthoff Junction', 690386683, 'Person injured in unsp motor-vehicle acc, traffic, sequela', 'img/member/2.jpg', '2017-12-03 11:45:17', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Blaine Gudgeon', 'bgudgeon16', 'Mva1dfwDw2', '2017-08-20 04:55:16', 'bgudgeon16@unblog.fr', 234, 'Bokong Timur', '8000 Hoffman Park', 160743191, 'Puncture wound without foreign body of unsp ear, init encntr', 'img/member/4.jpg', '2018-02-10 02:44:57', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Aurilia Rosenblum', 'arosenblum17', 'TtRcFj8', '2017-10-17 11:24:02', 'arosenblum17@usa.gov', 55, 'Nagasari', '0 8th Trail', 326266111, 'Oth multiple gest, unsp num plcnta & amnio sacs, first tri', 'img/member/4.jpg', '2017-06-26 15:15:16', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Brand MacNockater', 'bmacnockater18', '9qAizL1x6SzR', '2018-03-05 16:56:12', 'bmacnockater18@bloglines.com', 61, 'South Bend', '08148 Jenifer Alley', 871938476, 'Transverse fracture of shaft of ulna', 'img/member/1.jpg', '2018-01-25 15:46:36', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Maible Battyll', 'mbattyll19', 'PdWPfpC9L', '2017-10-23 06:47:40', 'mbattyll19@foxnews.com', 12, 'Bell Ville', '6168 Dakota Parkway', 538939522, 'Other contact with other fish, subsequent encounter', 'img/member/5.jpg', '2017-07-22 09:14:53', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ora Dabernott', 'odabernott1a', 'VIWYYL', '2017-08-06 02:13:48', 'odabernott1a@youku.com', 103, 'Clermont-Ferrand', '68 Elka Hill', 454044782, 'Cyst of tunica albuginea testis', 'img/member/1.jpg', '2017-11-17 13:03:37', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Shelton Batteson', 'sbatteson1b', 'K6HH4IxWBwU', '2017-11-10 06:00:48', 'sbatteson1b@constantcontact.com', 52, 'Balinad', '7714 Gerald Court', 218602542, 'Poisoning by salicylates, intentional self-harm, init encntr', 'img/member/3.jpg', '2017-09-22 08:08:55', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Faith Wainman', 'fwainman1c', 'hIADJU2', '2017-09-26 13:00:43', 'fwainman1c@odnoklassniki.ru', 74, 'Qamdo', '820 Manley Center', 155944417, 'Sltr-haris Type IV physeal fx phalanx of left toe, 7thD', 'img/member/3.jpg', '2017-07-01 02:21:02', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Curtis Mollin', 'cmollin1d', 'J1d48rFuVji', '2017-05-03 03:38:38', 'cmollin1d@guardian.co.uk', 8, 'Lanot', '9 Dorton Drive', 675916198, 'Lead-induced chronic gout, left knee, without tophus (tophi)', 'img/member/5.jpg', '2018-02-17 09:26:24', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Claudell Owthwaite', 'cowthwaite1e', 'eaND75', '2018-02-26 08:58:17', 'cowthwaite1e@nydailynews.com', 40, 'Runting', '5 New Castle Court', 153776355, 'Underdosing of antiviral drugs, subsequent encounter', 'img/member/4.jpg', '2017-10-16 05:03:33', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Bordy Brassill', 'bbrassill1f', 'NBkebKNxo', '2017-10-27 19:44:48', 'bbrassill1f@csmonitor.com', 162, 'Sơn Tây', '87 Michigan Junction', 362542572, 'Activity, ice hockey', 'img/member/5.jpg', '2017-11-26 21:00:51', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Malvina Brooksbank', 'mbrooksbank1g', 'HNc3cm9Dp', '2017-10-31 08:54:26', 'mbrooksbank1g@angelfire.com', 213, 'Muhos', '35 Columbus Trail', 122886490, 'Other injury of ovary, bilateral, initial encounter', 'img/member/5.jpg', '2017-06-14 20:14:38', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Brittne Heyburn', 'bheyburn1h', 'xAW6tP', '2018-02-05 14:02:23', 'bheyburn1h@pbs.org', 210, 'Sancti Spíritus', '48486 Coolidge Point', 161299488, 'Osteonecrosis due to previous trauma of right ulna', 'img/member/3.jpg', '2017-07-29 20:30:48', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Panchito Oris', 'poris1i', 'sUici5p4t9', '2018-02-02 14:56:32', 'poris1i@patch.com', 48, 'Nghĩa Hành', '551 Jay Way', 652279864, 'Unspecified injury of body of pancreas, subsequent encounter', 'img/member/6.jpg', '2017-10-24 00:39:27', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Sybila Coonihan', 'scoonihan1j', 'Kqtq3fsHMCJP', '2017-04-13 12:53:25', 'scoonihan1j@howstuffworks.com', 112, 'Okhansk', '39980 Dakota Drive', 301924754, 'Antiphospholipid antibody with hemorrhagic disorder', 'img/member/5.jpg', '2017-11-29 13:52:33', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Parry Slator', 'pslator1k', 'sStZ29LKWYXF', '2018-01-10 10:42:11', 'pslator1k@boston.com', 103, 'Pápa', '217 Fremont Way', 458822398, 'Other spondylosis', 'img/member/2.jpg', '2017-09-22 12:05:08', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Jesse Perche', 'jperche1l', 'LcI0sIrd', '2018-02-15 07:34:41', 'jperche1l@123-reg.co.uk', 12, 'Tōgane', '72 Superior Court', 756253588, 'Disp fx of base of nk of r femr, 7thG', 'img/member/2.jpg', '2017-09-12 05:05:53', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Misti Sillis', 'msillis1m', '6lv6CAP', '2018-03-24 20:38:42', 'msillis1m@smh.com.au', 8, 'Jaworze', '0769 Hansons Place', 837344331, 'Underdosing of agents primarily acting on the resp sys, subs', 'img/member/6.jpg', '2017-06-10 13:36:33', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Lu Kelwaybamber', 'lkelwaybamber1n', 'a8BbpHw', '2017-07-16 06:41:28', 'lkelwaybamber1n@etsy.com', 12, 'Ustyuzhna', '9468 Hollow Ridge Crossing', 403360828, 'Burn of third degree of lip(s), initial encounter', 'img/member/3.jpg', '2017-12-13 09:52:20', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Nara Snartt', 'nsnartt1o', 'csQmor', '2017-06-27 00:14:12', 'nsnartt1o@storify.com', 56, 'Bełk', '5987 Reindahl Street', 701285250, 'Open bite of wrist', 'img/member/3.jpg', '2018-03-09 06:04:01', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Harmonia Minchindon', 'hminchindon1p', 'uvmMMu5', '2017-12-22 06:27:53', 'hminchindon1p@rakuten.co.jp', 173, 'Changzheng', '6 Golden Leaf Alley', 469888654, 'Other specified crystal arthropathies, right ankle and foot', 'img/member/5.jpg', '2017-10-15 09:24:29', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Leah Piccard', 'lpiccard1q', 'guCRFhKbkX1', '2018-01-13 03:45:18', 'lpiccard1q@narod.ru', 28, 'Sirari', '9438 Thierer Park', 702176971, 'Disp fx of body of unsp talus, init for clos fx', 'img/member/6.jpg', '2017-06-07 14:08:47', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Osborn Atger', 'oatger1r', '6znJ3joHBi', '2017-08-02 20:51:08', 'oatger1r@indiegogo.com', 238, 'Nangang', '6462 Havey Parkway', 931325545, 'Military operations involving oth fire/hot subst, civilian', 'img/member/5.jpg', '2017-07-24 17:07:30', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Prudence Carlisi', 'pcarlisi1s', 'mPLM9GXOhJK', '2017-07-16 19:38:25', 'pcarlisi1s@histats.com', 185, 'Babushkin', '88207 Miller Park', 173232869, 'Abscess of bursa, left hand', 'img/member/4.jpg', '2018-01-22 14:25:30', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Andros Tweedlie', 'atweedlie1t', 'TbNxP0w', '2017-09-18 08:21:47', 'atweedlie1t@patch.com', 134, 'Xukou', '34416 Anniversary Court', 435527732, 'Nondisp apophyseal fx unsp femr, 7thR', 'img/member/4.jpg', '2017-12-08 21:04:13', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Elwyn O''Cahill', 'eocahill1u', 'dA0HwtXd', '2018-03-04 07:27:06', 'eocahill1u@i2i.jp', 53, 'General Guido', '6 Dwight Hill', 317512423, 'Minor laceration of thoracic aorta, sequela', 'img/member/3.jpg', '2017-08-06 15:58:19', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Pierre Ride', 'pride1v', 'xlncqtnDtg', '2017-09-16 02:33:48', 'pride1v@domainmarket.com', 30, 'Strasbourg', '68658 Orin Place', 175536798, 'Other injury of uterus, sequela', 'img/member/5.jpg', '2017-10-06 21:30:07', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Baxy Eye', 'beye1w', 'vpgLDfL', '2017-09-11 07:30:29', 'beye1w@mozilla.com', 202, 'Boulogne-Billancourt', '50898 Ilene Alley', 108133571, 'Flexion deformity, unspecified knee', 'img/member/2.jpg', '2017-08-05 05:33:00', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Tybi Gresswood', 'tgresswood1x', 's1mlxBrjS', '2018-01-14 04:24:04', 'tgresswood1x@last.fm', 229, 'Zaliznychne', '48071 Bluejay Drive', 187846779, 'Laceration w/o foreign body of unsp part of head, init', 'img/member/6.jpg', '2017-08-16 08:54:18', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Fiann Klimkov', 'fklimkov1y', 'L00PCKHRb', '2018-01-15 04:46:51', 'fklimkov1y@hatena.ne.jp', 242, 'Curug', '3 Ohio Parkway', 609034159, 'Mild persistent asthma with status asthmaticus', 'img/member/2.jpg', '2017-12-21 17:52:54', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Aloise Buzin', 'abuzin1z', 'z1EQZ1gIB8', '2018-03-22 13:56:17', 'abuzin1z@w3.org', 169, 'Basel', '63020 Thackeray Lane', 624764603, 'Anterior dislocation of right ulnohumeral joint, subs encntr', 'img/member/6.jpg', '2017-11-05 01:59:08', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Rolf Dunning', 'rdunning20', 'c4fl9j', '2017-10-06 08:09:54', 'rdunning20@ehow.com', 145, 'Jeruk', '21742 Ridge Oak Road', 369368958, 'Disp fx of l radial styloid pro, 7thN', 'img/member/6.jpg', '2017-12-09 17:34:35', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Nara Brodley', 'nbrodley21', 'zipWQ1', '2017-12-01 19:12:38', 'nbrodley21@pen.io', 14, 'Sinjhoro', '28 Buena Vista Park', 151760038, 'Exostosis of external canal, unspecified ear', 'img/member/4.jpg', '2017-08-15 06:42:59', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Sheffie Lathleiff', 'slathleiff22', 'tK07ePhc5uQ', '2017-03-31 06:58:20', 'slathleiff22@hud.gov', 211, 'P’yŏngsŏng', '4032 Main Place', 686839601, 'Driver of 3-whl mv inj in clsn w rail trn/veh in traf, subs', 'img/member/5.jpg', '2017-06-08 17:35:24', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Farly Shoebrook', 'fshoebrook23', '7tdfaxaYvyHX', '2018-03-07 05:41:56', 'fshoebrook23@wordpress.com', 224, 'Cincinnati', '52 Chinook Plaza', 928691966, 'Osteophyte, hip', 'img/member/2.jpg', '2017-06-14 16:48:46', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Dinny Duffie', 'dduffie24', 'q7NGDEL', '2017-09-16 19:22:52', 'dduffie24@i2i.jp', 76, 'Xiaoling', '55071 American Ash Hill', 612404320, 'Pnctr w foreign body of r little finger w/o damage to nail', 'img/member/5.jpg', '2017-07-23 11:46:16', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Bil Fredy', 'bfredy25', 'fBmpsVBcs', '2017-06-18 19:47:25', 'bfredy25@example.com', 96, 'Molodizhne', '5949 Rowland Plaza', 503502330, 'Unsp injury of other muscles and tendons at lower leg level', 'img/member/1.jpg', '2017-05-22 01:29:15', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Adelind Willans', 'awillans26', '2qxWbztBt', '2017-07-10 09:53:35', 'awillans26@people.com.cn', 86, 'Garhi Yāsīn', '6671 Union Parkway', 928219547, 'Disp fx of unsp ulna styloid pro, 7thQ', 'img/member/3.jpg', '2017-07-26 19:19:32', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Arnold Prinne', 'aprinne27', 'ZyoSRJzaCq', '2018-02-10 16:19:09', 'aprinne27@forbes.com', 152, 'Jesús Menéndez', '28029 Sunfield Avenue', 961371748, 'Displaced fracture of posterior process of left talus', 'img/member/6.jpg', '2017-04-17 11:26:21', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Miller O''Hogertie', 'mohogertie28', '1bpCBYPX', '2017-06-17 08:42:44', 'mohogertie28@bing.com', 73, 'Gadžin Han', '1 Kensington Trail', 923342845, 'Unsp pedl cyclst injured in clsn w 2/3-whl mv nontraf, init', 'img/member/6.jpg', '2017-08-18 07:51:04', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Trueman Drew', 'tdrew29', 'glFdIMOB0y', '2017-09-09 18:22:27', 'tdrew29@google.es', 218, 'Lianshi', '825 Division Junction', 157810863, 'Laceration of blood vessel of right thumb, subs encntr', 'img/member/2.jpg', '2017-04-08 18:27:56', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Sukey Peckett', 'speckett2a', 'BZ96o0HkQGe', '2017-05-10 00:31:44', 'speckett2a@geocities.com', 161, 'Orlovskiy', '6648 Johnson Avenue', 582941086, 'Partial traumatic amputation of midfoot', 'img/member/1.jpg', '2017-06-22 10:14:30', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Brandtr Peile', 'bpeile2b', 'HTdqnt', '2018-03-23 21:25:26', 'bpeile2b@netvibes.com', 178, 'Las Parejas', '04 Mariners Cove Parkway', 727144790, 'Sector or arcuate defects, bilateral', 'img/member/2.jpg', '2018-03-09 11:18:51', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Vina Pavlov', 'vpavlov2c', '1kLgdd2', '2017-12-19 10:33:02', 'vpavlov2c@disqus.com', 96, 'Chaiwan', '9 Lien Parkway', 897624873, 'Unsp injury of popliteal artery, left leg, init encntr', 'img/member/3.jpg', '2017-06-07 23:41:04', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Jimmy Vakhlov', 'jvakhlov2d', 'aa6vrTgieA7', '2017-06-25 09:40:57', 'jvakhlov2d@creativecommons.org', 42, 'Camilo Aldao', '92 Leroy Road', 909200232, 'Dislocation of unspecified thoracic vertebra, init encntr', 'img/member/2.jpg', '2017-06-16 23:27:46', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Kerstin Craigmile', 'kcraigmile2e', 'UHC5ZRUbv2V', '2017-04-01 02:45:39', 'kcraigmile2e@howstuffworks.com', 86, 'Partesh', '80 Anthes Crossing', 372086586, 'Occupant of hv veh injured in collision w statnry object', 'img/member/2.jpg', '2017-05-29 19:46:31', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ted Ormonde', 'tormonde2f', 'FB2rTJ4TPdu', '2017-06-03 12:38:56', 'tormonde2f@shop-pro.jp', 120, 'Dongtundu', '69198 Troy Street', 185755166, 'Inj blood vessel of right index finger, subs encntr', 'img/member/4.jpg', '2017-07-11 03:35:33', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ansel Aymerich', 'aaymerich2g', 'kYKd45', '2017-04-16 16:01:45', 'aaymerich2g@51.la', 169, 'Sanshengyuan', '01 Alpine Road', 992667200, 'Pedl cyc driver injured in clsn w rail trn/veh nontraf, subs', 'img/member/2.jpg', '2018-01-27 19:09:07', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Jan Stiddard', 'jstiddard2h', 'nNQ5es', '2017-11-12 23:42:33', 'jstiddard2h@sakura.ne.jp', 231, 'Bandeirantes', '0060 Vernon Parkway', 373681044, 'Other myositis, right shoulder', 'img/member/5.jpg', '2017-11-04 21:30:06', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Jodi Morfell', 'jmorfell2i', 'gxTIJ5RW', '2017-03-28 06:07:36', 'jmorfell2i@is.gd', 96, 'Tiandeng', '45 Elgar Court', 840485629, 'Pnctr w fb of l frnt wl of thorax w/o penet thor cav, init', 'img/member/1.jpg', '2017-06-22 02:09:10', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Miriam Fingleton', 'mfingleton2j', 'qcEb7A', '2017-11-26 03:52:53', 'mfingleton2j@google.de', 217, 'Kamenica', '657 Logan Lane', 669875698, 'Puncture wound w foreign body of abd wall w penet perit cav', 'img/member/6.jpg', '2017-10-16 10:57:14', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Teodor O''Hickee', 'tohickee2k', 'SkuEo1UF', '2017-05-10 10:50:57', 'tohickee2k@marriott.com', 61, 'Vidzy', '65 Haas Point', 382644018, 'Labor and delivery complicated by prolapse of cord, unsp', 'img/member/4.jpg', '2017-05-26 10:23:56', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Evin Kohnert', 'ekohnert2l', 'oMdsxPTP', '2017-11-05 00:44:24', 'ekohnert2l@nsw.gov.au', 4, 'Bystřice nad Pernštejnem', '6527 Kingsford Place', 383946784, 'Nondisp fx of nk of r rad, 7thF', 'img/member/6.jpg', '2017-04-27 14:21:35', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Lorens Chitson', 'lchitson2m', '2fUUIow3', '2017-10-03 08:33:35', 'lchitson2m@blinklist.com', 60, 'Poitiers', '10 Cody Avenue', 580938514, 'Displ spiral fx shaft of ulna, l arm, 7thG', 'img/member/1.jpg', '2017-04-27 01:26:57', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Bert Grigorey', 'bgrigorey2n', 'RPM4YK', '2018-01-31 17:26:19', 'bgrigorey2n@whitehouse.gov', 30, 'Chaloem Phra Kiat', '33 Reinke Crossing', 759585943, 'Other sprain of right thumb, subsequent encounter', 'img/member/2.jpg', '2017-08-10 00:08:15', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Marna Keaveny', 'mkeaveny2o', 'AkYR8kTd8G2M', '2017-11-18 15:16:34', 'mkeaveny2o@cdc.gov', 249, 'Sungi Liput', '91 Goodland Court', 923251392, 'Nondisp spiral fx shaft of humer, r arm, 7thP', 'img/member/4.jpg', '2017-09-16 21:54:49', true, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Hewe Rivett', 'hrivett2p', 'TLD5CIyZwq', '2017-11-05 20:15:59', 'hrivett2p@reference.com', 53, 'Moramanga', '76 Main Circle', 268189256, 'Unspecified open wound of right elbow, subsequent encounter', 'img/member/3.jpg', '2018-02-24 06:39:11', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Rustin de Pinna', 'rde2q', 'LSYE8Uy0IBK', '2017-08-15 23:51:39', 'rde2q@newyorker.com', 247, 'Malasugui', '916 Granby Avenue', 574102717, 'Blindness, one eye, low vision other eye, unspecified eyes', 'img/member/5.jpg', '2017-08-04 01:46:44', false, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Travers Brewett', 'tbrewett2r', 'D7JUCbfMcJ', '2017-04-12 14:46:00', 'tbrewett2r@cornell.edu', 240, 'Gangmei', '37213 Dennis Plaza', 907331618, 'Displ transverse fx shaft of unsp fibula, 7thB', 'img/member/6.jpg', '2017-11-21 14:36:27', true, true);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('João Desconhecido', 'user', '$2b$10$n5c6HguQwQgevyJiyqzJJuf9TKC3M2AMBe4mzBIxAeAj2qjtbmG1q', null, 'user@email.com', 178, 'Porto', 'Rua Dr Roberto Frias, s/n', 111222333, 'I like long walks on the bach and my dog', 'img/member/3.jpg',  '2018-04-20', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Joana Silva', 'user2', '$2b$10$n5c6HguQwQgevyJiyqzJJuf9TKC3M2AMBe4mzBIxAeAj2qjtbmG1q', null, 'user2@email.com', 178, 'Lisbon', 'Altice Arena', 222333444, 'I love woodworking, as well as minigolf, insects and Fortnite.', 'img/member/4.jpg',  '2018-05-25', false, false);
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Mr. Admin', 'admin',	'$2b$10$n5c6HguQwQgevyJiyqzJJuf9TKC3M2AMBe4mzBIxAeAj2qjtbmG1q', null, 'admin@example.com', 178, 'Porto', 'Avenida dos Aliados', 123456789, 'haha yes I am the admin', 'img/member/5.jpg',  '1997-03-31', false, true);


--
-- Data for Name: notification; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

insert into notification (timestamp, type, community, recipient, comment, event, buddy) values ('2017-08-15 08:15:27', 'buddy', null, 101, null, null, 62);
insert into notification (timestamp, type, community, recipient, comment, event, buddy) values ('2017-08-15 08:15:27', 'community', 4, 101, null, null, null);
insert into notification (timestamp, type, community, recipient, comment, event, buddy) values ('2017-08-15 08:15:27', 'event', null, 101, null, 20, null);
--insert into notification (timestamp, type, community, recipient, comment, event, buddy) values ('2017-08-15 08:15:27', 'comment', null, 101, 10, null, null);



--
-- Data for Name: report; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-09-25 07:04:10', 'Arthritis due to other bacteria, unspecified hip', 1, 88, 20, 20, false, 34);

--
-- Data for Name: ticket; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO ticket (idtickettype, idinvoice) VALUES (1, 1);


--
-- Data for Name: tickettype; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

insert into tickettype (price, initialquantity, availablequantity, description, event) values (9.73, 200, 200, 'Regular Ticket', 1);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (35.39, 200, 200, 'Regular Ticket', 2);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (48.31, 200, 200, 'Regular Ticket', 4);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (32.66, 200, 200, 'Regular Ticket', 5);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (37.01, 200, 200, 'Regular Ticket', 6);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (27.44, 200, 200, 'Regular Ticket', 7);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (12.52, 200, 200, 'Regular Ticket', 8);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (20.6, 200, 200, 'Regular Ticket', 9);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (7.95, 200, 200, 'Regular Ticket', 10);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (5.56, 200, 200, 'Regular Ticket', 12);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (28.52, 200, 200, 'Regular Ticket', 13);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (48.05, 200, 200, 'Regular Ticket', 14);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (49.36, 200, 200, 'Regular Ticket', 16);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (20.05, 200, 200, 'Regular Ticket', 17);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (45.5, 200, 200, 'Regular Ticket', 18);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (6.34, 200, 200, 'Regular Ticket', 19);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (45.7, 200, 200, 'Regular Ticket', 21);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (36.6, 200, 200, 'Regular Ticket', 22);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (24.81, 200, 200, 'Regular Ticket', 23);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (36.66, 200, 200, 'Regular Ticket', 24);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (30.03, 200, 200, 'Regular Ticket', 25);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (5.74, 200, 200, 'VIP Ticket', 1);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (41.11, 200, 200, 'General Pass', 2);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (44.86, 200, 200, 'VIP Ticket', 4);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (48.97, 200, 200, 'General Pass', 5);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (33.36, 200, 200, 'General Pass', 6);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (40.76, 200, 200, 'General Pass', 7);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (3.03, 200, 200, 'General Pass', 8);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (18.62, 200, 200, 'General Pass', 9);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (2.86, 200, 200, 'General Pass', 10);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (15.02, 200, 200, 'VIP Ticket', 12);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (22.6, 200, 200, 'General Pass', 13);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (20.76, 200, 200, 'General Pass', 14);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (36.64, 200, 200, 'VIP Ticket', 16);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (32.0, 200, 200, 'General Pass', 17);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (44.27, 200, 200, 'General Pass', 18);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (9.43, 200, 200, 'VIP Ticket', 19);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (21.83, 200, 200, 'General Pass', 21);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (28.42, 200, 200, 'General Pass', 22);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (2.09, 200, 200, 'General Pass', 23);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (15.39, 200, 200, 'VIP Ticket', 24);
insert into tickettype (price, initialquantity, availablequantity, description, event) values (27.13, 200, 200, 'General Pass', 25);


INSERT INTO country(name) VALUES('Afghanistan');
INSERT INTO country(name) VALUES('Åland Islands');
INSERT INTO country(name) VALUES('Albania');
INSERT INTO country(name) VALUES('Algeria');
INSERT INTO country(name) VALUES('American Samoa');
INSERT INTO country(name) VALUES('Andorra');
INSERT INTO country(name) VALUES('Angola');
INSERT INTO country(name) VALUES('Anguilla');
INSERT INTO country(name) VALUES('Antarctica');
INSERT INTO country(name) VALUES('Antigua and Barbuda');
INSERT INTO country(name) VALUES('Argentina');
INSERT INTO country(name) VALUES('Armenia');
INSERT INTO country(name) VALUES('Aruba');
INSERT INTO country(name) VALUES('Australia');
INSERT INTO country(name) VALUES('Austria');
INSERT INTO country(name) VALUES('Azerbaijan');
INSERT INTO country(name) VALUES('Bahamas');
INSERT INTO country(name) VALUES('Bahrain');
INSERT INTO country(name) VALUES('Bangladesh');
INSERT INTO country(name) VALUES('Barbados');
INSERT INTO country(name) VALUES('Belarus');
INSERT INTO country(name) VALUES('Belgium');
INSERT INTO country(name) VALUES('Belize');
INSERT INTO country(name) VALUES('Benin');
INSERT INTO country(name) VALUES('Bermuda');
INSERT INTO country(name) VALUES('Bhutan');
INSERT INTO country(name) VALUES('Plurinational State of Bolivia');
INSERT INTO country(name) VALUES('Sint Eustatius and Saba Bonaire');
INSERT INTO country(name) VALUES('Bosnia and Herzegovina');
INSERT INTO country(name) VALUES('Botswana');
INSERT INTO country(name) VALUES('Bouvet Island');
INSERT INTO country(name) VALUES('Brazil');
INSERT INTO country(name) VALUES('British Indian Ocean Territory');
INSERT INTO country(name) VALUES('Brunei Darussalam');
INSERT INTO country(name) VALUES('Bulgaria');
INSERT INTO country(name) VALUES('Burkina Faso');
INSERT INTO country(name) VALUES('Burundi');
INSERT INTO country(name) VALUES('Cambodia');
INSERT INTO country(name) VALUES('Cameroon');
INSERT INTO country(name) VALUES('Canada');
INSERT INTO country(name) VALUES('Cape Verde');
INSERT INTO country(name) VALUES('Cayman Islands');
INSERT INTO country(name) VALUES('Central African Republic');
INSERT INTO country(name) VALUES('Chad');
INSERT INTO country(name) VALUES('Chile');
INSERT INTO country(name) VALUES('China');
INSERT INTO country(name) VALUES('Christmas Island');
INSERT INTO country(name) VALUES('Cocos (Keeling) Islands');
INSERT INTO country(name) VALUES('Colombia');
INSERT INTO country(name) VALUES('Comoros');
INSERT INTO country(name) VALUES('Congo');
INSERT INTO country(name) VALUES('the Democratic Republic of the Congo');
INSERT INTO country(name) VALUES('Cook Islands');
INSERT INTO country(name) VALUES('Costa Rica');
INSERT INTO country(name) VALUES('Côte d`Ivoire');
INSERT INTO country(name) VALUES('Croatia');
INSERT INTO country(name) VALUES('Cuba');
INSERT INTO country(name) VALUES('Curaçao');
INSERT INTO country(name) VALUES('Cyprus');
INSERT INTO country(name) VALUES('Czech Republic');
INSERT INTO country(name) VALUES('Denmark');
INSERT INTO country(name) VALUES('Djibouti');
INSERT INTO country(name) VALUES('Dominica');
INSERT INTO country(name) VALUES('Dominican Republic');
INSERT INTO country(name) VALUES('Ecuador');
INSERT INTO country(name) VALUES('Egypt');
INSERT INTO country(name) VALUES('El Salvador');
INSERT INTO country(name) VALUES('Equatorial Guinea');
INSERT INTO country(name) VALUES('Eritrea');
INSERT INTO country(name) VALUES('Estonia');
INSERT INTO country(name) VALUES('Ethiopia');
INSERT INTO country(name) VALUES('Falkland Islands (Malvinas)');
INSERT INTO country(name) VALUES('Faroe Islands');
INSERT INTO country(name) VALUES('Fiji');
INSERT INTO country(name) VALUES('Finland');
INSERT INTO country(name) VALUES('France');
INSERT INTO country(name) VALUES('French Guiana');
INSERT INTO country(name) VALUES('French Polynesia');
INSERT INTO country(name) VALUES('French Southern Territories');
INSERT INTO country(name) VALUES('Gabon');
INSERT INTO country(name) VALUES('Gambia');
INSERT INTO country(name) VALUES('Georgia');
INSERT INTO country(name) VALUES('Germany');
INSERT INTO country(name) VALUES('Ghana');
INSERT INTO country(name) VALUES('Gibraltar');
INSERT INTO country(name) VALUES('Greece');
INSERT INTO country(name) VALUES('Greenland');
INSERT INTO country(name) VALUES('Grenada');
INSERT INTO country(name) VALUES('Guadeloupe');
INSERT INTO country(name) VALUES('Guam');
INSERT INTO country(name) VALUES('Guatemala');
INSERT INTO country(name) VALUES('Guernsey');
INSERT INTO country(name) VALUES('Guinea');
INSERT INTO country(name) VALUES('Guinea-Bissau');
INSERT INTO country(name) VALUES('Guyana');
INSERT INTO country(name) VALUES('Haiti');
INSERT INTO country(name) VALUES('Heard Island and McDonald Islands');
INSERT INTO country(name) VALUES('Holy See (Vatican City State)');
INSERT INTO country(name) VALUES('Honduras');
INSERT INTO country(name) VALUES('Hong Kong');
INSERT INTO country(name) VALUES('Hungary');
INSERT INTO country(name) VALUES('Iceland');
INSERT INTO country(name) VALUES('India');
INSERT INTO country(name) VALUES('Indonesia');
INSERT INTO country(name) VALUES('Islamic Republic of Iran');
INSERT INTO country(name) VALUES('Iraq');
INSERT INTO country(name) VALUES('Ireland');
INSERT INTO country(name) VALUES('Isle of Man');
INSERT INTO country(name) VALUES('Israel');
INSERT INTO country(name) VALUES('Italy');
INSERT INTO country(name) VALUES('Jamaica');
INSERT INTO country(name) VALUES('Japan');
INSERT INTO country(name) VALUES('Jersey');
INSERT INTO country(name) VALUES('Jordan');
INSERT INTO country(name) VALUES('Kazakhstan');
INSERT INTO country(name) VALUES('Kenya');
INSERT INTO country(name) VALUES('Kiribati');
INSERT INTO country(name) VALUES('Korea');
INSERT INTO country(name) VALUES('Republic of Korea');
INSERT INTO country(name) VALUES('Kuwait');
INSERT INTO country(name) VALUES('Kyrgyzstan');
INSERT INTO country(name) VALUES('Lao People`s Democratic Republic');
INSERT INTO country(name) VALUES('Latvia');
INSERT INTO country(name) VALUES('Lebanon');
INSERT INTO country(name) VALUES('Lesotho');
INSERT INTO country(name) VALUES('Liberia');
INSERT INTO country(name) VALUES('Libya');
INSERT INTO country(name) VALUES('Liechtenstein');
INSERT INTO country(name) VALUES('Lithuania');
INSERT INTO country(name) VALUES('Luxembourg');
INSERT INTO country(name) VALUES('Macao');
INSERT INTO country(name) VALUES('the Former Yugoslav Republic of Macedonia');
INSERT INTO country(name) VALUES('Madagascar');
INSERT INTO country(name) VALUES('Malawi');
INSERT INTO country(name) VALUES('Malaysia');
INSERT INTO country(name) VALUES('Maldives');
INSERT INTO country(name) VALUES('Mali');
INSERT INTO country(name) VALUES('Malta');
INSERT INTO country(name) VALUES('Marshall Islands');
INSERT INTO country(name) VALUES('Martinique');
INSERT INTO country(name) VALUES('Mauritania');
INSERT INTO country(name) VALUES('Mauritius');
INSERT INTO country(name) VALUES('Mayotte');
INSERT INTO country(name) VALUES('Mexico');
INSERT INTO country(name) VALUES('Federated States of Micronesia');
INSERT INTO country(name) VALUES('Republic of Moldova');
INSERT INTO country(name) VALUES('Monaco');
INSERT INTO country(name) VALUES('Mongolia');
INSERT INTO country(name) VALUES('Montenegro');
INSERT INTO country(name) VALUES('Montserrat');
INSERT INTO country(name) VALUES('Morocco');
INSERT INTO country(name) VALUES('Mozambique');
INSERT INTO country(name) VALUES('Myanmar');
INSERT INTO country(name) VALUES('Namibia');
INSERT INTO country(name) VALUES('Nauru');
INSERT INTO country(name) VALUES('Nepal');
INSERT INTO country(name) VALUES('Netherlands');
INSERT INTO country(name) VALUES('New Caledonia');
INSERT INTO country(name) VALUES('New Zealand');
INSERT INTO country(name) VALUES('Nicaragua');
INSERT INTO country(name) VALUES('Niger');
INSERT INTO country(name) VALUES('Nigeria');
INSERT INTO country(name) VALUES('Niue');
INSERT INTO country(name) VALUES('Norfolk Island');
INSERT INTO country(name) VALUES('Northern Mariana Islands');
INSERT INTO country(name) VALUES('Norway');
INSERT INTO country(name) VALUES('Oman');
INSERT INTO country(name) VALUES('Pakistan');
INSERT INTO country(name) VALUES('Palau');
INSERT INTO country(name) VALUES('State of Palestine');
INSERT INTO country(name) VALUES('Panama');
INSERT INTO country(name) VALUES('Papua New Guinea');
INSERT INTO country(name) VALUES('Paraguay');
INSERT INTO country(name) VALUES('Peru');
INSERT INTO country(name) VALUES('Philippines');
INSERT INTO country(name) VALUES('Pitcairn');
INSERT INTO country(name) VALUES('Poland');
INSERT INTO country(name) VALUES('Portugal');
INSERT INTO country(name) VALUES('Puerto Rico');
INSERT INTO country(name) VALUES('Qatar');
INSERT INTO country(name) VALUES('Réunion');
INSERT INTO country(name) VALUES('Romania');
INSERT INTO country(name) VALUES('Russian Federation');
INSERT INTO country(name) VALUES('Rwanda');
INSERT INTO country(name) VALUES('Saint Barthélemy');
INSERT INTO country(name) VALUES('Ascension and Tristan da Cunha Saint Helena');
INSERT INTO country(name) VALUES('Saint Kitts and Nevis');
INSERT INTO country(name) VALUES('Saint Lucia');
INSERT INTO country(name) VALUES('Saint Martin (French part)');
INSERT INTO country(name) VALUES('Saint Pierre and Miquelon');
INSERT INTO country(name) VALUES('Saint Vincent and the Grenadines');
INSERT INTO country(name) VALUES('Samoa');
INSERT INTO country(name) VALUES('San Marino');
INSERT INTO country(name) VALUES('Sao Tome and Principe');
INSERT INTO country(name) VALUES('Saudi Arabia');
INSERT INTO country(name) VALUES('Senegal');
INSERT INTO country(name) VALUES('Serbia');
INSERT INTO country(name) VALUES('Seychelles');
INSERT INTO country(name) VALUES('Sierra Leone');
INSERT INTO country(name) VALUES('Singapore');
INSERT INTO country(name) VALUES('Sint Maarten (Dutch part)');
INSERT INTO country(name) VALUES('Slovakia');
INSERT INTO country(name) VALUES('Slovenia');
INSERT INTO country(name) VALUES('Solomon Islands');
INSERT INTO country(name) VALUES('Somalia');
INSERT INTO country(name) VALUES('South Africa');
INSERT INTO country(name) VALUES('South Georgia and the South Sandwich Islands');
INSERT INTO country(name) VALUES('South Sudan');
INSERT INTO country(name) VALUES('Spain');
INSERT INTO country(name) VALUES('Sri Lanka');
INSERT INTO country(name) VALUES('Sudan');
INSERT INTO country(name) VALUES('Suriname');
INSERT INTO country(name) VALUES('Svalbard and Jan Mayen');
INSERT INTO country(name) VALUES('Swaziland');
INSERT INTO country(name) VALUES('Sweden');
INSERT INTO country(name) VALUES('Switzerland');
INSERT INTO country(name) VALUES('Syrian Arab Republic');
INSERT INTO country(name) VALUES('Province of China Taiwan');
INSERT INTO country(name) VALUES('Tajikistan');
INSERT INTO country(name) VALUES('United Republic of Tanzania');
INSERT INTO country(name) VALUES('Thailand');
INSERT INTO country(name) VALUES('Timor-Leste');
INSERT INTO country(name) VALUES('Togo');
INSERT INTO country(name) VALUES('Tokelau');
INSERT INTO country(name) VALUES('Tonga');
INSERT INTO country(name) VALUES('Trinidad and Tobago');
INSERT INTO country(name) VALUES('Tunisia');
INSERT INTO country(name) VALUES('Turkey');
INSERT INTO country(name) VALUES('Turkmenistan');
INSERT INTO country(name) VALUES('Turks and Caicos Islands');
INSERT INTO country(name) VALUES('Tuvalu');
INSERT INTO country(name) VALUES('Uganda');
INSERT INTO country(name) VALUES('Ukraine');
INSERT INTO country(name) VALUES('United Arab Emirates');
INSERT INTO country(name) VALUES('United Kingdom');
INSERT INTO country(name) VALUES('United States');
INSERT INTO country(name) VALUES('United States Minor Outlying Islands');
INSERT INTO country(name) VALUES('Uruguay');
INSERT INTO country(name) VALUES('Uzbekistan');
INSERT INTO country(name) VALUES('Vanuatu');
INSERT INTO country(name) VALUES('Bolivarian Republic of Venezuela');
INSERT INTO country(name) VALUES('Viet Nam');
INSERT INTO country(name) VALUES('British Virgin Islands');
INSERT INTO country(name) VALUES('Virgin Islands US');
INSERT INTO country(name) VALUES('Wallis and Futuna');
INSERT INTO country(name) VALUES('Western Sahara');
INSERT INTO country(name) VALUES('Yemen');
INSERT INTO country(name) VALUES('Zambia');
INSERT INTO country(name) VALUES('Zimbabwe');


--
-- Name: comment_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (idcomment);


--
-- Name: community_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY community
    ADD CONSTRAINT community_pkey PRIMARY KEY (idcommunity);


--
-- Name: community_publiclink_key; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY community
    ADD CONSTRAINT community_publiclink_key UNIQUE (publiclink);


--
-- Name: communitycategory_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY communitycategory
    ADD CONSTRAINT communitycategory_pkey PRIMARY KEY (idcommunitycategory);


--
-- Name: event_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (idevent);



ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (idcountry);
--
-- Name: eventcategory_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY eventcategory
    ADD CONSTRAINT eventcategory_pkey PRIMARY KEY (ideventcategory);


--
-- Name: invoice_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (idinvoice);


--
-- Name: member_email_key; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_email_key UNIQUE (email);


--
-- Name: member_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (idmember);


--
-- Name: member_taxpayernumber_key; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--


ALTER TABLE ONLY member
    ADD CONSTRAINT fk_country FOREIGN KEY (idcountry) REFERENCES country(idcountry) ON DELETE CASCADE;


ALTER TABLE ONLY member
    ADD CONSTRAINT member_taxpayernumber_key UNIQUE (taxpayernumber);


--
-- Name: member_username_key; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_username_key UNIQUE (username);


--
-- Name: notification_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (idnotification);


--
-- Name: report_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_pkey PRIMARY KEY (idreport);


--
-- Name: ticket_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (idticket);


--
-- Name: tickettype_pkey; Type: CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

ALTER TABLE ONLY tickettype
    ADD CONSTRAINT tickettype_pkey PRIMARY KEY (idtickettype);


--
-- Name: fk_category; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_communitycategory
    ADD CONSTRAINT fk_category FOREIGN KEY (idcommunitycategory) REFERENCES communitycategory(idcommunitycategory);


--
-- Name: fk_comment; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY report
    ADD CONSTRAINT fk_comment FOREIGN KEY (comment) REFERENCES comment(idcomment) ON DELETE CASCADE;


--
-- Name: fk_comment; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_comment FOREIGN KEY (comment) REFERENCES comment(idcomment) ON DELETE CASCADE;


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity) ON DELETE CASCADE;


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_communitycategory
    ADD CONSTRAINT fk_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity) ON DELETE CASCADE;


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY report
    ADD CONSTRAINT fk_community FOREIGN KEY (community) REFERENCES community(idcommunity) ON DELETE CASCADE;


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_community FOREIGN KEY (community) REFERENCES community(idcommunity) ON DELETE CASCADE;


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event
    ADD CONSTRAINT fk_community FOREIGN KEY (community) REFERENCES community(idcommunity) ON DELETE CASCADE;


ALTER TABLE ONLY event
    ADD CONSTRAINT fk_country FOREIGN KEY (idcountry) REFERENCES country(idcountry) ON DELETE CASCADE;


--
-- Name: fk_community_communitycategory_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_communitycategory
    ADD CONSTRAINT fk_community_communitycategory_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity);


--
-- Name: fk_community_communitycategory_communitycategory; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_communitycategory
    ADD CONSTRAINT fk_community_communitycategory_communitycategory FOREIGN KEY (idcommunitycategory) REFERENCES communitycategory(idcommunitycategory);


--
-- Name: fk_community_member_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_community_member_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity) ON DELETE CASCADE;


--
-- Name: fk_community_member_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_community_member_member FOREIGN KEY (idmember) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: fk_communitymember; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_communitymember FOREIGN KEY (idmember) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event_eventcategory
    ADD CONSTRAINT fk_event FOREIGN KEY (idevent) REFERENCES event(idevent);


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event_member
    ADD CONSTRAINT fk_event FOREIGN KEY (idevent) REFERENCES event(idevent) ON DELETE CASCADE;


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_event FOREIGN KEY (event) REFERENCES event(idevent) ON DELETE CASCADE;


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY report
    ADD CONSTRAINT fk_event FOREIGN KEY (event) REFERENCES event(idevent) ON DELETE CASCADE;


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_event FOREIGN KEY (event) REFERENCES event(idevent) ON DELETE CASCADE;


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY friend
    ADD CONSTRAINT fk_event FOREIGN KEY (idf1) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: fk_eventcategory; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event_eventcategory
    ADD CONSTRAINT fk_eventcategory FOREIGN KEY (ideventcategory) REFERENCES eventcategory(ideventcategory);


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event_member
    ADD CONSTRAINT fk_member FOREIGN KEY (idmember) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_member FOREIGN KEY (author) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT fk_member FOREIGN KEY (idmember) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY report
    ADD CONSTRAINT fk_member FOREIGN KEY (reporter) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_member FOREIGN KEY (recipient) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY friend
    ADD CONSTRAINT fk_member FOREIGN KEY (idf2) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: fk_tickettype; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT fk_tickettype FOREIGN KEY (idtickettype) REFERENCES tickettype(idtickettype) ON DELETE CASCADE;


--
-- Name: report_member_fkey; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_member_fkey FOREIGN KEY (member) REFERENCES member(idmember) ON DELETE CASCADE;


--
-- Name: ticket_idinvoice_fkey; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT ticket_idinvoice_fkey FOREIGN KEY (idinvoice) REFERENCES invoice(idinvoice) ON DELETE CASCADE;


--Updates Full text search column
UPDATE event SET fts_vector =
     to_tsvector('portuguese', name || ' ' || description);



--Triggers
DROP TRIGGER IF EXISTS inviteFriend ON friend;
DROP FUNCTION IF EXISTS checkDuplicateFriend();

CREATE OR REPLACE FUNCTION checkDuplicateFriend() RETURNS TRIGGER AS $BODY$
BEGIN
	IF EXISTS
		(SELECT *
			FROM "friend"
			WHERE 	("friend".idf1 = NEW.idf1 AND "friend".idf2 = NEW.idf2) OR
					("friend".idf1 = NEW.idf2 AND "friend".idf2 = NEW.idf1))
		THEN RAISE EXCEPTION 'Duplicate Friendship Tuple';
	END IF;
	RETURN NEW;
END
$BODY$ LANGUAGE plpgsql;

CREATE TRIGGER inviteFriend
  BEFORE INSERT ON "friend"
    FOR EACH ROW EXECUTE PROCEDURE checkDuplicateFriend();

---------------------------------------------------------------------



CREATE OR REPLACE FUNCTION invite_community_to_event()
RETURNS trigger AS $BODY$
DECLARE
_idmember record;
BEGIN
FOR _idmember IN (SELECT idmember FROM community_member where community_member.idcommunity = new.community)
LOOP
	INSERT INTO notification(timestamp, type, community, recipient, comment, event, buddy) VALUES (CURRENT_TIMESTAMP, 'event', new.community, _idmember.idmember, null, new.idevent, null);
END LOOP;
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXists after_community_event on event;
CREATE  TRIGGER after_community_event AFTER INSERT
ON "event"
FOR EACH ROW
WHEN (new.community IS NOT null)
EXECUTE PROCEDURE invite_community_to_event();



