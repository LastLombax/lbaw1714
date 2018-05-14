
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
    amount integer NOT NULL,
    date date NOT NULL,
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
    event integer
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
    type integer,
    buyer integer NOT NULL,
    idinvoice integer NOT NULL,
    used boolean DEFAULT false NOT NULL
);



--
-- Name: tickettype; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE tickettype (
    idtickettype SERIAL NOT NULL,
    type integer NOT NULL,
    price double precision NOT NULL,
    initialquantity integer NOT NULL,
    availablequantity integer,
    description text,
    event integer NOT NULL,
    CONSTRAINT tickettype_initialquantity_check CHECK ((initialquantity > 0)),
    CONSTRAINT tickettype_price_check CHECK ((price > (0)::double precision))
);


CREATE INDEX event_search ON event USING gist(fts_vector);


--
-- Data for Name: comment; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO comment (text, timestamp, event, author) VALUES ('Unsp comp of fb acc left in body fol unsp procedure, subs', '2017-11-07 00:53:39', 12, 52);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Occup of pk-up/van inj in clsn w rail trn/veh in traf, subs', '2017-06-25 07:16:01', 23, 82);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Convergence insufficiency', '2017-10-21 06:16:06', 36, 9);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Unsp inj intrns musc/fasc/tend l lit fngr at wrs/hnd lv,subs', '2017-03-29 17:40:24', 38, 33);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Disp fx of body of scapula, r shldr, 7thG', '2017-07-11 10:32:04', 29, 22);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Unspecified fracture of shaft of right fibula, sequela', '2017-12-02 19:28:10', 17, 88);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Displ commnt fx shaft of ulna, l arm, 7thE', '2018-03-14 02:18:22', 16, 41);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Poisoning by macrolides, intentional self-harm, init encntr', '2017-04-13 19:34:50', 26, 6);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Sprain of unspecified parts of lumbar spine and pelvis', '2018-01-16 06:37:48', 47, 27);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Chronic gingivitis, non-plaque induced', '2017-11-05 15:25:38', 25, 25);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Barton''s fx unsp rad, subs for opn fx type 3A/B/C w nonunion', '2017-09-28 10:20:34', 33, 38);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Matern care for damag to fetus from viral dis in mother, oth', '2017-07-22 00:51:12', 48, 60);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Congenital mitral stenosis', '2017-09-19 03:45:10', 29, 45);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Theater (live) as place', '2018-03-03 23:54:24', 35, 83);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Varus deformity, not elsewhere classified, elbow', '2018-03-05 19:43:38', 20, 96);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Unsp fx right femur, subs for opn fx type 3A/B/C w nonunion', '2018-01-24 21:22:04', 50, 74);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Osseous and sublux stenos of intvrt foramin of thor region', '2017-12-05 02:16:57', 25, 97);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Disp fx of proximal phalanx of left lesser toe(s), init', '2017-12-01 04:37:20', 50, 72);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Other dislocation of right wrist and hand, sequela', '2017-11-16 21:53:12', 34, 70);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Other complications of esophagostomy', '2018-01-04 07:20:47', 29, 49);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Acute nasopharyngitis [common cold]', '2017-04-22 22:57:48', 15, 16);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Corrosion of unspecified degree of right wrist, subs encntr', '2018-01-16 03:28:13', 17, 70);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Disp fx of capitate bone, unspecified wrist, sequela', '2017-06-09 02:21:42', 48, 67);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Contact with nonvenomous toads', '2018-01-08 02:30:39', 43, 2);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Unsp fracture of unsp thoracic vertebra, init for opn fx', '2017-07-19 09:59:04', 38, 13);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Displ commnt fx shaft of unsp tibia, 7thD', '2017-07-22 04:10:51', 50, 56);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Nondisp fx of neck of r rad, subs for clos fx w routn heal', '2017-04-13 11:18:04', 20, 86);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Injury of optic tract and pathways, unspecified eye, sequela', '2017-04-15 22:53:12', 29, 94);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Corros first deg mult right fingers (nail), inc thumb, subs', '2017-03-31 05:31:37', 6, 34);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Injury of tibial nerve at lower leg level, left leg, init', '2017-12-27 06:11:33', 24, 69);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Maternal care for damage to fetus by radiation, oth', '2018-02-04 05:14:13', 20, 22);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Injury of conjunctiva and corneal abrasion w/o fb, left eye', '2017-08-25 03:08:17', 15, 77);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Mucosal cyst of postmastoidectomy cavity, left ear', '2018-01-03 16:25:43', 44, 96);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Nondisplaced apophyseal fracture of unspecified femur', '2017-08-22 11:16:18', 36, 56);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Subacute osteomyelitis, unspecified humerus', '2017-08-22 04:08:39', 28, 94);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Gammaherpesviral mononucleosis with other complications', '2017-04-24 00:38:54', 22, 87);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Poisoning by oth antihypertensive drugs, undetermined, init', '2018-03-01 08:08:04', 45, 14);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Toxic effect of unspecified seafood, assault, subs encntr', '2018-03-11 12:40:46', 39, 85);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Unspecified sprain of other finger, initial encounter', '2017-07-20 00:36:49', 46, 7);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Sltr-haris Type I physl fx lower end humer, right arm, sqla', '2017-07-01 11:56:16', 27, 87);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Infect/inflm react due to int fix of unsp bone of arm, subs', '2018-01-26 11:09:48', 19, 1);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Poisoning by histamine H2-receptor blockers, acc, init', '2017-06-07 03:12:33', 35, 16);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Nondisp fx of distal phalanx of r rng fngr, init for opn fx', '2018-03-20 01:42:45', 14, 42);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Superficial foreign body, left hip, subsequent encounter', '2018-01-24 03:24:31', 30, 8);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Unspecified dacryocystitis of right lacrimal passage', '2017-07-23 06:53:00', 41, 47);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Laceration w/o fb of right cheek and TMJ area, init', '2017-10-03 22:17:06', 47, 47);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Helicopter collision injuring occupant, initial encounter', '2017-11-20 08:12:08', 24, 49);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Insect bite (nonvenomous) of scrotum and testes', '2018-01-21 19:27:11', 5, 97);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Prsn brd/alit a 3-whl mv injured in collision w pedal cycle', '2017-05-12 08:19:59', 46, 67);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Sprain of left acromioclavicular joint, initial encounter', '2018-03-06 04:30:47', 48, 25);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Acute tonsillitis, unspecified', '2017-05-23 14:07:18', 23, 57);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Cyst of unspecified orbit', '2017-07-21 10:53:17', 15, 83);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Adverse effect of otorhino drugs and preparations, init', '2017-05-18 12:30:57', 27, 92);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Displaced fracture of navicular of left foot, sequela', '2017-07-01 21:55:11', 39, 78);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Diabetes mellitus due to underlying condition w ketoacidosis', '2017-08-20 01:36:10', 5, 16);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Minor laceration of right vertebral artery', '2018-03-08 02:36:04', 42, 36);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Direct infct of shldr jt in infec/parastc dis classd elswhr', '2018-02-26 14:00:09', 24, 45);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Fx unsp metatarsal bone(s), unsp ft, 7thG', '2017-10-10 09:17:33', 32, 6);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Pnctr w fb of unsp lesser toe(s) w damage to nail, init', '2017-09-30 11:03:47', 28, 95);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Acne excoriee', '2018-02-10 11:24:10', 10, 15);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Superficial foreign body of breast, unsp breast, init encntr', '2017-07-06 06:01:19', 1, 89);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Sltr-haris Type IV physeal fx phalanx of unsp toe, init', '2017-06-06 08:35:37', 17, 29);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Corrosion of third degree of unspecified wrist', '2017-10-11 16:15:19', 30, 33);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Nondisp oblique fx shaft of l femr, 7thD', '2017-07-20 18:41:38', 21, 34);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Injury of trochlear nerve, unspecified side, sequela', '2018-01-13 01:34:22', 37, 36);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Complete transverse atyp femoral fracture, left leg, init', '2018-03-27 09:01:02', 48, 53);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Occup of hv veh inj in clsn w rail trn/veh in traf, sequela', '2017-04-29 20:39:37', 20, 64);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Brown-Sequard syndrome at C6, subs', '2017-08-22 13:52:35', 38, 92);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Myositis ossificans traumatica, left ankle and foot', '2018-03-11 01:04:01', 3, 40);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Traumatic cerebral edema w LOC of 30 minutes or less, subs', '2018-03-04 08:17:49', 42, 22);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Puncture wound with foreign body of lip, sequela', '2017-04-11 05:00:42', 43, 80);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Non-prs chr ulc unsp prt of r low leg limited to brkdwn skin', '2017-09-01 17:12:26', 11, 88);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Triplet pregnancy, unable to dtrm num plcnta & amnio sacs', '2018-02-16 05:08:45', 26, 34);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Struck by nonvenomous lizards', '2017-07-20 01:52:41', 43, 58);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Anterior dislocation of unsp ulnohumeral joint, init encntr', '2017-08-31 01:18:13', 31, 9);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Laceration w/o foreign body of unsp finger w damage to nail', '2018-01-14 09:05:04', 9, 85);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Underdosing of other bacterial vaccines, initial encounter', '2017-10-17 14:58:19', 23, 62);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Superficial frostbite of left knee and lower leg', '2017-07-03 19:15:29', 37, 70);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Institutional upbringing', '2018-03-08 14:33:48', 24, 16);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Laceration of ulnar artery at forarm lv, left arm, sequela', '2017-06-03 14:12:10', 35, 22);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Minor laceration of left vertebral artery, sequela', '2018-01-29 23:00:26', 8, 18);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Blister (nonthermal), right hip, subsequent encounter', '2018-01-23 00:47:48', 35, 24);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Presence of other orthopedic joint implants', '2018-02-25 17:19:55', 24, 97);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Disp fx of nk of 5th MC bone, l hand, subs for fx w nonunion', '2017-10-26 09:52:46', 47, 65);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Adverse effect of antiallergic and antiemetic drugs, init', '2017-11-22 15:13:02', 43, 39);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Exceptionally large newborn baby', '2017-07-28 16:02:20', 41, 81);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Milt op w explosn of sea-based artlry shell, civilian', '2017-03-30 10:53:15', 28, 12);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Other retained radioactive fragments', '2017-09-11 16:34:31', 20, 28);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Bunionette of unspecified foot', '2017-08-15 01:51:45', 22, 86);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Chronic pain syndrome', '2017-05-27 07:52:27', 40, 98);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Unsp injury of ulnar artery at forearm level, unsp arm, subs', '2017-11-06 17:14:30', 1, 46);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Displ seg fx shaft of rad, l arm, 7thH', '2017-05-29 18:45:29', 50, 24);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Oth injury of peroneal artery, left leg, subs encntr', '2018-03-15 17:42:16', 1, 67);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Disp fx of proximal phalanx of unsp thumb, init for clos fx', '2017-05-03 11:02:13', 45, 18);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Drown d/t being thrown ovrbrd by motion of merch ship, init', '2017-05-23 16:52:56', 50, 63);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Pnctr of abd wall w fb, l upr q w/o penet perit cav, subs', '2018-03-07 23:53:57', 13, 40);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Sedative, hypnotic or anxiolytic use, unsp with withdrawal', '2018-01-02 10:55:33', 36, 26);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Oth physeal fx lower end of r tibia, subs for fx w nonunion', '2017-04-09 14:15:49', 43, 33);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Other injury of fallopian tube, bilateral, sequela', '2017-09-03 15:47:28', 32, 30);
INSERT INTO comment (text, timestamp, event, author) VALUES ('Wedge comprsn fx third lum vertebra, subs for fx w nonunion', '2017-09-03 11:00:14', 35, 49);


--
-- Data for Name: community; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Armstrong-Goldner', 'Extrarenal uremia', '2018-03-08', 'http://dummyimage.com/154x237.bmp/5fa2dd/ffffff', '/dis/parturient/montes/nascetur.jsp', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Feil Group', 'Other specified injuries of cervical trachea, subs encntr', '2018-02-11', 'http://dummyimage.com/142x137.jpg/5fa2dd/ffffff', '/turpis/elementum.xml', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Kihn LLC', 'Enophthalmos due to atrophy of orbital tissue, right eye', '2017-10-07', 'http://dummyimage.com/142x137.jpg/5fa2dd/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Hartmann, Powlowski and Koelpin', 'Osteonecrosis due to drugs, other site', '2017-08-19', 'http://dummyimage.com/231x224.jpg/dddddd/000000', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Nolan and Sons', 'Oth fx shaft of r femr, 7thE', '2017-05-09', 'http://dummyimage.com/101x186.png/cc0000/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Becker, Weissnat and McClure', 'Accidental malfunction of gas, air or spring-operated gun', '2017-08-10', 'http://dummyimage.com/152x136.bmp/dddddd/000000', '/a/ipsum/integer.aspx', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Hackett Group', 'Addisonian crisis', '2018-02-04', 'http://dummyimage.com/250x155.jpg/ff4444/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('McClure, Stehr and Ullrich', 'Toxic effect of venom of caterpillars, self-harm, sequela', '2018-02-23', 'http://dummyimage.com/226x133.png/cc0000/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Sporer LLC', 'Motorcycle rider injured pick-up truck, pick-up truck or van', '2017-09-08', 'http://dummyimage.com/107x203.jpg/5fa2dd/ffffff', '/congue/elementum/in/hac/habitasse/platea.json', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Klein, Rowe and Armstrong', 'Chronic postrheumatic arthropathy [Jaccoud], right knee', '2017-04-11', 'http://dummyimage.com/147x204.jpg/5fa2dd/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Sporer Group', 'Mech compl of aortic (bifurcation) graft (replacement), subs', '2017-04-01', 'http://dummyimage.com/188x197.png/cc0000/ffffff', '/volutpat/convallis.jsp', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Johnston, Considine and Thompson', 'Unsp nephritic syndrome w diffuse crescentic glomrlneph', '2017-11-03', 'http://dummyimage.com/155x239.png/cc0000/ffffff', '/consequat/varius.aspx', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Huels-Runolfsson', 'Cellulitis of left orbit', '2017-06-27', 'http://dummyimage.com/221x106.png/cc0000/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Rohan Inc', 'Oth diab with diab macular edema, resolved fol trtmt, l eye', '2017-06-10', 'http://dummyimage.com/131x117.png/ff4444/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Hegmann-Treutel', 'Gastrointestinal anthrax', '2017-12-17', 'http://dummyimage.com/239x188.jpg/dddddd/000000', '/pede/morbi/porttitor/lorem.aspx', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Littel, Ruecker and Stroman', 'Infect/inflm react due to int fix of unsp bone of arm, init', '2017-09-05', 'http://dummyimage.com/221x135.bmp/ff4444/ffffff', '/amet.jsp', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Walsh-Homenick', 'Acute gastric ulcer with perforation', '2017-05-23', 'http://dummyimage.com/199x237.png/dddddd/000000', '/elementum/ligula.jpg', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Ward Group', 'Underdosing of stimulant laxatives, subsequent encounter', '2018-01-24', 'http://dummyimage.com/166x125.bmp/ff4444/ffffff', '/cursus/urna.js', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Erdman Group', 'Drown due to fall/jump fr crushed fishing boat, subs', '2017-07-10', 'http://dummyimage.com/165x231.jpg/5fa2dd/ffffff', '/eget/elit/sodales/scelerisque.png', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Hermann, Ferry and Wilkinson', 'Nondisp commnt fx r patella, subs for clos fx w routn heal', '2018-03-10', 'http://dummyimage.com/150x175.png/5fa2dd/ffffff', '/morbi.png', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Treutel, Bergstrom and Shanahan', 'Pelvic and perineal pain', '2017-06-28', 'http://dummyimage.com/222x242.jpg/5fa2dd/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Watsica, Block and Torp', 'Displacement of int fix of right humerus, init', '2017-08-29', 'http://dummyimage.com/233x235.jpg/dddddd/000000', '/leo.png', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Schultz Group', 'Oth diabetes mellitus w proliferative diabetic retinopathy', '2017-07-02', 'http://dummyimage.com/119x229.jpg/cc0000/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Mitchell, Reilly and Hand', 'Malar fracture, unspecified side, 7thB', '2018-02-18', 'http://dummyimage.com/245x148.png/cc0000/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Marvin-Lockman', 'Salpingitis and oophoritis', '2017-09-28', 'http://dummyimage.com/194x190.png/ff4444/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Rolfson, Hills and Goyette', 'Major lacerat branches of celiac and mesent art, sequela', '2018-02-22', 'http://dummyimage.com/247x107.bmp/5fa2dd/ffffff', '/ligula/sit/amet.png', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Koch and Sons', 'Driver injured in collision w unsp mv in traf, init', '2017-07-06', 'http://dummyimage.com/161x177.png/dddddd/000000', '/pulvinar/nulla/pede/ullamcorper.png', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Steuber Group', 'GaleazziNULLs fx r rad, subs for opn fx type I/2 w delay heal', '2017-09-06', 'http://dummyimage.com/163x108.png/dddddd/000000', '/at/ipsum/ac/tellus/semper.jsp', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Ernser-Baumbach', 'Displ seg fx shaft of l tibia, 7thN', '2017-04-11', 'http://dummyimage.com/106x183.bmp/dddddd/000000', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Tremblay, Zieme and Bauch', 'Other myositis, forearm', '2017-11-03', 'http://dummyimage.com/112x147.bmp/cc0000/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Lesch-Orn', 'Other contact with other fish, initial encounter', '2018-02-08', 'http://dummyimage.com/160x240.bmp/dddddd/000000', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Beatty, Ledner and Metz', 'Subluxation of distal interphaln joint of left thumb, subs', '2017-12-29', 'http://dummyimage.com/157x231.bmp/cc0000/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Gorczany, Hegmann and Herman', 'Sprain of ligaments of thoracic spine, sequela', '2017-07-26', 'http://dummyimage.com/177x103.jpg/dddddd/000000', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Harris, Lindgren and Auer', 'Passenger on bus injured in collision w oth mv nontraf, subs', '2017-05-14', 'http://dummyimage.com/175x120.jpg/5fa2dd/ffffff', '/ligula/sit.jsp', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Smith LLC', 'Corrosion of right eye and adnexa, part unsp, subs encntr', '2018-01-02', 'http://dummyimage.com/230x168.png/5fa2dd/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Rippin, Beatty and Berge', 'Unsp infection of urinary tract in pregnancy, unsp trimester', '2017-05-19', 'http://dummyimage.com/151x177.png/cc0000/ffffff', '/orci/luctus/et/ultrices.jsp', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Hane Inc', 'Laceration of lesser saphenous vein at lower leg level', '2017-10-26', 'http://dummyimage.com/164x129.bmp/dddddd/000000', '/eu/est/congue/elementum/in.json', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Spinka LLC', 'Contusion of left front wall of thorax, initial encounter', '2017-12-11', 'http://dummyimage.com/190x121.bmp/ff4444/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Haley-Halvorson', 'Paracoccidioidomycosis, unspecified', '2017-12-17', 'http://dummyimage.com/100x106.jpg/5fa2dd/ffffff', '/dui/nec/nisi.jpg', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Lynch-Wilderman', 'Other secondary chronic gout, unspecified knee', '2017-05-23', 'http://dummyimage.com/215x168.png/dddddd/000000', '/eu/nibh/quisque/id.xml', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('ONULLConner Inc', 'Rosacea, unspecified', '2017-11-27', 'http://dummyimage.com/109x124.jpg/ff4444/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('MacGyver-Christiansen', 'Incomplete lesion of L4 level of lumbar spinal cord, sequela', '2017-08-03', 'http://dummyimage.com/111x196.png/dddddd/000000', '/nam/congue/risus/semper/porta.html', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('ONULLReilly-King', 'Mech compl of unspecified internal joint prosthesis', '2017-10-19', 'http://dummyimage.com/207x157.png/5fa2dd/ffffff', '/ante/nulla.html', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Dickinson-Botsford', 'Cutaneous anthrax', '2017-08-07', 'http://dummyimage.com/144x184.png/ff4444/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Buckridge, Kohler and Feest', 'Milt op w explosn of sea-based artlry shell, milt, sequela', '2018-03-22', 'http://dummyimage.com/191x147.png/5fa2dd/ffffff', '/semper/rutrum.png', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Denesik, Hintz and Powlowski', 'Corrosions of oth parts of unsp eye and adnexa, subs encntr', '2017-12-21', 'http://dummyimage.com/207x187.png/cc0000/ffffff', '/vestibulum/ante.json', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Hudson, Bartoletti and Bogan', 'Bitten by pig, initial encounter', '2017-10-20', 'http://dummyimage.com/107x142.jpg/dddddd/000000', '/quis.jpg', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Christiansen, Douglas and Aufderhar', 'Disord of visual cortex in inflam disord, left side of brain', '2018-01-17', 'http://dummyimage.com/179x156.bmp/5fa2dd/ffffff', NULL, false);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Kuhlman Group', 'Disp fx of med condyle of l femr, 7thN', '2017-08-24', 'http://dummyimage.com/113x233.bmp/dddddd/000000', '/sapien/cursus/vestibulum/proin.jpg', true);
INSERT INTO community (name, description, creationdate, imagepath, publiclink, ispublic) VALUES ('Smith, Labadie and Morissette', 'Juvenile rheumatoid arthritis w systemic onset, ank/ft', '2017-06-03', 'http://dummyimage.com/182x197.jpg/ff4444/ffffff', '/ligula.html', true);


--
-- Data for Name: community_communitycategory; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO community_communitycategory VALUES (29, 8);
INSERT INTO community_communitycategory VALUES (16, 6);
INSERT INTO community_communitycategory VALUES (42, 3);
INSERT INTO community_communitycategory VALUES (48, 11);
INSERT INTO community_communitycategory VALUES (27, 12);
INSERT INTO community_communitycategory VALUES (8, 3);
INSERT INTO community_communitycategory VALUES (32, 4);
INSERT INTO community_communitycategory VALUES (16, 12);
INSERT INTO community_communitycategory VALUES (2, 7);
INSERT INTO community_communitycategory VALUES (31, 9);
INSERT INTO community_communitycategory VALUES (19, 5);
INSERT INTO community_communitycategory VALUES (37, 5);
INSERT INTO community_communitycategory VALUES (49, 5);
INSERT INTO community_communitycategory VALUES (13, 3);
INSERT INTO community_communitycategory VALUES (3, 4);
INSERT INTO community_communitycategory VALUES (3, 7);
INSERT INTO community_communitycategory VALUES (48, 6);
INSERT INTO community_communitycategory VALUES (24, 9);
INSERT INTO community_communitycategory VALUES (3, 6);
INSERT INTO community_communitycategory VALUES (23, 3);
INSERT INTO community_communitycategory VALUES (33, 8);
INSERT INTO community_communitycategory VALUES (35, 7);
INSERT INTO community_communitycategory VALUES (24, 3);
INSERT INTO community_communitycategory VALUES (6, 10);
INSERT INTO community_communitycategory VALUES (5, 9);
INSERT INTO community_communitycategory VALUES (4, 11);
INSERT INTO community_communitycategory VALUES (30, 6);
INSERT INTO community_communitycategory VALUES (26, 9);
INSERT INTO community_communitycategory VALUES (39, 5);
INSERT INTO community_communitycategory VALUES (15, 11);
INSERT INTO community_communitycategory VALUES (29, 2);
INSERT INTO community_communitycategory VALUES (40, 1);
INSERT INTO community_communitycategory VALUES (7, 8);
INSERT INTO community_communitycategory VALUES (24, 7);
INSERT INTO community_communitycategory VALUES (8, 12);
INSERT INTO community_communitycategory VALUES (12, 12);
INSERT INTO community_communitycategory VALUES (19, 2);
INSERT INTO community_communitycategory VALUES (44, 6);
INSERT INTO community_communitycategory VALUES (45, 7);
INSERT INTO community_communitycategory VALUES (7, 10);
INSERT INTO community_communitycategory VALUES (29, 9);
INSERT INTO community_communitycategory VALUES (16, 1);
INSERT INTO community_communitycategory VALUES (7, 1);
INSERT INTO community_communitycategory VALUES (45, 1);
INSERT INTO community_communitycategory VALUES (41, 1);
INSERT INTO community_communitycategory VALUES (48, 1);
INSERT INTO community_communitycategory VALUES (8, 9);
INSERT INTO community_communitycategory VALUES (5, 11);
INSERT INTO community_communitycategory VALUES (10, 5);
INSERT INTO community_communitycategory VALUES (49, 2);
INSERT INTO community_communitycategory VALUES (23, 5);
INSERT INTO community_communitycategory VALUES (3, 8);
INSERT INTO community_communitycategory VALUES (13, 12);
INSERT INTO community_communitycategory VALUES (47, 10);
INSERT INTO community_communitycategory VALUES (37, 3);
INSERT INTO community_communitycategory VALUES (42, 2);
INSERT INTO community_communitycategory VALUES (45, 3);
INSERT INTO community_communitycategory VALUES (48, 12);
INSERT INTO community_communitycategory VALUES (4, 9);
INSERT INTO community_communitycategory VALUES (44, 3);
INSERT INTO community_communitycategory VALUES (23, 1);
INSERT INTO community_communitycategory VALUES (12, 1);
INSERT INTO community_communitycategory VALUES (5, 7);
INSERT INTO community_communitycategory VALUES (9, 11);
INSERT INTO community_communitycategory VALUES (1, 9);
INSERT INTO community_communitycategory VALUES (49, 6);
INSERT INTO community_communitycategory VALUES (34, 9);
INSERT INTO community_communitycategory VALUES (6, 6);
INSERT INTO community_communitycategory VALUES (20, 4);
INSERT INTO community_communitycategory VALUES (5, 1);
INSERT INTO community_communitycategory VALUES (42, 12);
INSERT INTO community_communitycategory VALUES (46, 4);
INSERT INTO community_communitycategory VALUES (39, 7);
INSERT INTO community_communitycategory VALUES (21, 11);
INSERT INTO community_communitycategory VALUES (9, 12);
INSERT INTO community_communitycategory VALUES (39, 3);
INSERT INTO community_communitycategory VALUES (9, 4);
INSERT INTO community_communitycategory VALUES (2, 5);
INSERT INTO community_communitycategory VALUES (6, 1);
INSERT INTO community_communitycategory VALUES (2, 10);
INSERT INTO community_communitycategory VALUES (32, 12);
INSERT INTO community_communitycategory VALUES (44, 12);
INSERT INTO community_communitycategory VALUES (43, 7);
INSERT INTO community_communitycategory VALUES (11, 2);
INSERT INTO community_communitycategory VALUES (18, 1);
INSERT INTO community_communitycategory VALUES (46, 8);
INSERT INTO community_communitycategory VALUES (3, 1);
INSERT INTO community_communitycategory VALUES (25, 2);
INSERT INTO community_communitycategory VALUES (31, 3);
INSERT INTO community_communitycategory VALUES (38, 3);
INSERT INTO community_communitycategory VALUES (22, 12);


--
-- Data for Name: community_member; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO community_member VALUES (16, 22, true);
INSERT INTO community_member VALUES (15, 61, false);
INSERT INTO community_member VALUES (30, 93, true);
INSERT INTO community_member VALUES (48, 34, false);
INSERT INTO community_member VALUES (14, 41, true);
INSERT INTO community_member VALUES (6, 6, false);
INSERT INTO community_member VALUES (25, 82, false);
INSERT INTO community_member VALUES (28, 37, true);
INSERT INTO community_member VALUES (9, 21, true);
INSERT INTO community_member VALUES (3, 75, true);
INSERT INTO community_member VALUES (29, 86, true);
INSERT INTO community_member VALUES (21, 94, false);
INSERT INTO community_member VALUES (29, 19, false);
INSERT INTO community_member VALUES (21, 4, false);
INSERT INTO community_member VALUES (30, 38, true);
INSERT INTO community_member VALUES (24, 60, true);
INSERT INTO community_member VALUES (23, 20, true);
INSERT INTO community_member VALUES (39, 57, false);
INSERT INTO community_member VALUES (42, 66, true);
INSERT INTO community_member VALUES (5, 97, false);
INSERT INTO community_member VALUES (8, 58, true);
INSERT INTO community_member VALUES (19, 12, false);
INSERT INTO community_member VALUES (3, 5, true);
INSERT INTO community_member VALUES (28, 53, false);
INSERT INTO community_member VALUES (1, 34, true);
INSERT INTO community_member VALUES (21, 53, true);
INSERT INTO community_member VALUES (42, 8, false);
INSERT INTO community_member VALUES (17, 97, true);
INSERT INTO community_member VALUES (23, 79, false);
INSERT INTO community_member VALUES (29, 14, false);
INSERT INTO community_member VALUES (2, 30, false);
INSERT INTO community_member VALUES (37, 4, false);
INSERT INTO community_member VALUES (14, 89, false);
INSERT INTO community_member VALUES (23, 93, false);
INSERT INTO community_member VALUES (4, 28, true);
INSERT INTO community_member VALUES (35, 61, false);
INSERT INTO community_member VALUES (22, 41, false);
INSERT INTO community_member VALUES (12, 88, true);
INSERT INTO community_member VALUES (42, 93, true);
INSERT INTO community_member VALUES (12, 14, false);
INSERT INTO community_member VALUES (9, 86, false);
INSERT INTO community_member VALUES (23, 10, true);
INSERT INTO community_member VALUES (32, 68, false);
INSERT INTO community_member VALUES (5, 24, false);
INSERT INTO community_member VALUES (18, 25, false);
INSERT INTO community_member VALUES (40, 17, false);
INSERT INTO community_member VALUES (39, 3, false);
INSERT INTO community_member VALUES (3, 92, true);
INSERT INTO community_member VALUES (45, 46, false);
INSERT INTO community_member VALUES (49, 52, true);
INSERT INTO community_member VALUES (18, 7, false);
INSERT INTO community_member VALUES (36, 63, true);
INSERT INTO community_member VALUES (18, 40, true);
INSERT INTO community_member VALUES (34, 93, false);
INSERT INTO community_member VALUES (4, 48, true);
INSERT INTO community_member VALUES (48, 65, false);
INSERT INTO community_member VALUES (25, 59, false);
INSERT INTO community_member VALUES (50, 39, true);
INSERT INTO community_member VALUES (33, 55, true);
INSERT INTO community_member VALUES (33, 4, true);
INSERT INTO community_member VALUES (9, 44, false);
INSERT INTO community_member VALUES (34, 42, false);
INSERT INTO community_member VALUES (47, 31, true);
INSERT INTO community_member VALUES (19, 32, false);
INSERT INTO community_member VALUES (6, 9, true);
INSERT INTO community_member VALUES (28, 46, false);
INSERT INTO community_member VALUES (7, 10, true);
INSERT INTO community_member VALUES (24, 91, true);
INSERT INTO community_member VALUES (43, 20, true);
INSERT INTO community_member VALUES (16, 92, true);
INSERT INTO community_member VALUES (3, 50, false);
INSERT INTO community_member VALUES (49, 82, true);
INSERT INTO community_member VALUES (13, 15, true);
INSERT INTO community_member VALUES (13, 26, true);
INSERT INTO community_member VALUES (30, 78, false);
INSERT INTO community_member VALUES (29, 29, false);
INSERT INTO community_member VALUES (16, 14, false);
INSERT INTO community_member VALUES (4, 5, false);
INSERT INTO community_member VALUES (4, 20, true);
INSERT INTO community_member VALUES (4, 57, true);
INSERT INTO community_member VALUES (11, 61, false);
INSERT INTO community_member VALUES (17, 18, true);
INSERT INTO community_member VALUES (48, 2, true);
INSERT INTO community_member VALUES (22, 67, true);
INSERT INTO community_member VALUES (28, 51, true);
INSERT INTO community_member VALUES (12, 63, false);
INSERT INTO community_member VALUES (35, 66, true);
INSERT INTO community_member VALUES (12, 27, true);
INSERT INTO community_member VALUES (45, 82, false);
INSERT INTO community_member VALUES (15, 60, true);
INSERT INTO community_member VALUES (47, 47, true);
INSERT INTO community_member VALUES (9, 17, true);
INSERT INTO community_member VALUES (14, 12, true);
INSERT INTO community_member VALUES (22, 64, true);
INSERT INTO community_member VALUES (42, 46, false);
INSERT INTO community_member VALUES (30, 42, true);
INSERT INTO community_member VALUES (36, 75, false);


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
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Ameliorated non-volatile monitoring', 'Salter-Harris Type II physeal fracture of left metatarsal, subsequent encounter for fracture with malunion', 'img/event/1.jpg', '2018-06-20 07:02:57', '11/5/2017', '7:35 AM', '7:50 PM', 45 , 'Longquan', '25325 Corscot Plaza', '/erat.xml', true, 10);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Multi-tiered fresh-thinking approach', 'Infection and inflammatory reaction due to internal fixation device of right tibia, initial encounter', 'img/event/2.jpg', '2018-08-04 17:45:20', '12/8/2017', '11:07 AM', '9:30 PM', 45 , 'Xiongzhou', '7431 5th Park', '/vestibulum/rutrum.json', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Programmable reciprocal attitude', 'Unspecified displaced fracture of first cervical vertebra, initial encounter for open fracture', 'img/event/3.jpg', '2018-07-03 20:44:07', '1/9/2018', '8:51 AM', '5:03 PM', 60 , 'København', '10288 Union Plaza', '/in/lectus/pellentesque/at/nulla.json', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Diverse holistic access', 'Displaced fracture of cuboid bone of left foot, subsequent encounter for fracture with nonunion', 'img/event/4.jpg', '2018-09-18 14:25:31', '7/20/2017', '10:18 AM', '5:17 PM', 55 , 'Čačinci', '7786 Loeprich Alley', '/pharetra/magna/vestibulum.json', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Intuitive discrete pricing structure', 'Infection and inflammatory reaction due to other internal prosthetic devices, implants and grafts, initial encounter', 'img/event/5.jpg', '2018-08-10 17:23:08', '10/29/2017', '11:32 AM', '10:34 PM', 45 , 'Yinzhu', '2498 Erie Street', '/elit/sodales.html', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Advanced content-based collaboration', 'Intraoperative cerebrovascular infarction', 'img/event/6.jpg', '2018-07-03 00:58:00', '10/14/2017', '7:41 AM', '10:39 PM', 45 , 'Wuli', '170 Vahlen Lane', '/odio/porttitor.json', false, 36);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Upgradable exuding pricing structure', 'Simple chronic conjunctivitis', 'img/event/7.jpg', '2018-05-16 09:44:35', '1/16/2018', '6:42 AM', '2:32 PM', 31 , 'Panambi', '0215 Kinsman Pass', '/nisl/duis.jsp', true, 8);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('User-friendly 6th generation toolset', 'Car driver injured in collision with fixed or stationary object in traffic accident, subsequent encounter', 'img/event/8.jpg', '2018-08-20 20:08:50', '12/8/2017', '9:54 AM', '9:13 PM', 39 , 'Cap-Santé', '3 Lyons Terrace', '/diam/nam/tristique/tortor/eu/pede.jpg', false, 27);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Managed foreground approach', 'Nondisplaced unspecified condyle fracture of lower end of left femur', 'img/event/9.jpg', '2018-06-12 10:34:06', '2/28/2018', '11:03 AM', '3:51 PM', 173 , 'Bretaña', '594 Summerview Junction', '/at/dolor/quis/odio.xml', true, 13);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Face to face next generation superstructure', 'Adverse effect of unspecified topical agent, initial encounter', 'img/event/10.jpg', '2018-09-03 19:07:31', '4/6/2018', '9:21 AM', '12:26 PM', 45 , 'Zuhu', '6 Vermont Road', '/vivamus/vel/nulla/eget.xml', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Multi-channelled object-oriented info-mediaries', 'Acute lymphadenitis of trunk', 'img/event/11.jpg', '2018-06-16 16:23:05', '11/14/2017', '9:25 AM', '8:44 PM', 103 , 'Ngajum', '08218 Jenifer Circle', '/magnis/dis/parturient/montes.html', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Multi-layered interactive open architecture', 'Corrosion of third degree of multiple sites of left wrist and hand', 'img/event/12.jpg', '2018-06-27 04:30:27', '4/10/2018', '6:15 AM', '2:58 PM', 226 , 'Menzel Abderhaman', '590 Cambridge Alley', '/ut/ultrices/vel.js', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Focused intermediate migration', 'Traumatic hemorrhage of cerebrum, unspecified, with loss of consciousness greater than 24 hours without return to pre-existing conscious level with patient surviving, sequela', 'img/event/13.jpg', '2018-06-20 19:55:13', '2/3/2018', '6:34 AM', '7:01 PM', 21 , 'Momignies', '81119 Dakota Pass', '/augue/quam/sollicitudin/vitae.jpg', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Upgradable client-server algorithm', 'Nondisplaced fracture of posterior process of left talus, subsequent encounter for fracture with malunion', 'img/event/14.jpg', '2018-07-15 07:23:24', '3/11/2018', '7:27 AM', '9:23 PM', 103 , 'Banjarejo', '1502 Valley Edge Way', '/ut/erat/curabitur/gravida/nisi.html', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Future-proofed dynamic interface', 'Other fractures of lower end of unspecified radius, sequela', 'img/event/15.jpg', '2018-06-30 08:36:53', '10/30/2017', '8:53 AM', '6:26 PM', 103 , 'Banyulegi', '796 Melrose Road', '/curabitur/at/ipsum/ac/tellus/semper/interdum.js', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Monitored bifurcated moratorium', 'Rubella with other complications', 'img/event/16.jpg', '2018-07-30 12:00:38', '6/23/2017', '7:04 AM', '11:07 PM', 45 , 'Lixin', '923 Atwood Circle', '/nam/nulla/integer/pede/justo/lacinia.xml', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Multi-lateral holistic hierarchy', 'Open bite of left great toe with damage to nail, initial encounter', 'img/event/17.jpg', '2018-09-09 15:09:34', '12/15/2017', '7:42 AM', '5:58 PM', 226 , 'Medenine', '642 Pennsylvania Road', '/dapibus/augue.js', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Innovative dynamic methodology', 'Exposure to industrial wiring, appliances and electrical machinery, subsequent encounter', 'img/event/18.jpg', '2018-09-05 15:45:41', '7/26/2017', '6:40 AM', '3:37 PM', 150 , 'Skoura', '77790 Portage Circle', '/platea.jsp', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Up-sized user-facing toolset', 'Cerebral infarction due to thrombosis of unspecified carotid artery', 'img/event/19.jpg', '2018-09-15 07:39:49', '10/30/2017', '9:56 AM', '11:53 PM', 45 , 'Dongshan', '5632 Fisk Center', '/auctor/sed/tristique/in/tempus/sit/amet.js', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Implemented methodical protocol', 'Vertigo of central origin, right ear', 'img/event/20.jpg', '2018-07-14 23:33:12', '8/8/2017', '7:20 AM', '2:24 PM', 174 , 'Matayumtayum', '568 Daystar Trail', '/turpis/integer/aliquet.json', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Implemented responsive implementation', 'Traumatic vasospastic syndrome, initial encounter', 'img/event/21.jpg', '2018-06-17 00:04:00', '7/26/2017', '10:28 AM', '2:26 PM', 241, 'Puerto Cumarebo', '9185 Declaration Alley', '/natoque/penatibus/et/magnis/dis/parturient/montes.js', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Up-sized zero tolerance forecast', 'Infection of amniotic sac and membranes, unspecified, second trimester, fetus 3', 'img/event/22.jpg', '2018-07-10 19:02:08', '9/7/2017', '6:12 AM', '4:57 PM', 174 , 'Mayo', '4 Marquette Alley', '/accumsan/tellus/nisi/eu/orci/mauris.aspx', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Devolved 5th generation middleware', 'Other injury of muscle, fascia and tendon of triceps, right arm', 'img/event/23.jpg', '2018-05-23 12:21:27', '10/16/2017', '9:27 AM', '8:02 PM', 45 , 'Yongjiang', '62935 Nevada Pass', '/vestibulum/quam/sapien.xml', false, 34);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Optimized directional framework', 'Nondisplaced transcondylar fracture of unspecified humerus, subsequent encounter for fracture with delayed healing', 'img/event/24.jpg', '2018-07-09 10:36:58', '7/21/2017', '11:49 AM', '1:23 PM', 184, 'Isheyevka', '01 Autumn Leaf Parkway', '/nunc.png', false, 27);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Customer-focused methodical toolset', 'Unspecified fracture of upper end of left radius, initial encounter for closed fracture', 'img/event/25.jpg', '2018-07-09 13:39:24', '6/15/2017', '8:32 AM', '11:25 PM', 31 , 'Ibitinga', '45 Fisk Crossing', '/sit/amet.png', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Face to face context-sensitive support', 'Malignant neoplasm without specification of site', 'img/event/26.jpg', '2018-09-29 09:17:28', '12/23/2017', '6:35 AM', '10:17 PM', 106 , 'Monaghan', '63 Boyd Plaza', '/est/lacinia/nisi/venenatis/tristique/fusce/congue.json', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Seamless uniform project', 'Blister (nonthermal) of right upper arm, initial encounter', 'img/event/27.jpg', '2018-07-06 01:43:54', '1/5/2018', '7:54 AM', '4:51 PM', 39 , 'Smithers', '5 Melody Alley', '/viverra/dapibus/nulla.html', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Seamless impactful frame', 'Displaced comminuted fracture of unspecified patella, subsequent encounter for open fracture type IIIA, IIIB, or IIIC with malunion', 'img/event/28.jpg', '2018-06-08 02:37:29', '11/22/2017', '8:32 AM', '6:19 PM', 39 , 'Danville', '25237 Tennyson Drive', '/adipiscing/lorem/vitae/mattis.html', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Phased uniform utilisation', 'Other mechanical complication of unspecified cardiac device', 'img/event/29.jpg', '2018-08-28 03:15:33', '3/5/2018', '10:00 AM', '3:36 PM', 173 , 'Buenos Aires', '65670 Carey Hill', '/posuere/cubilia/curae/mauris/viverra/diam.jpg', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Reactive heuristic success', 'Deformity of finger(s)', 'img/event/30.jpg', '2018-07-01 07:41:19', '11/30/2017', '8:12 AM', '10:12 PM', 174 , 'Nanyo', '4645 Fuller Avenue', '/orci/eget/orci.png', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Streamlined explicit hardware', 'Pathological fracture in other disease, unspecified shoulder, subsequent encounter for fracture with nonunion', 'img/event/31.jpg', '2018-08-27 15:59:43', '2/17/2018', '8:18 AM', '12:17 PM', 143 , 'Reforma', '59 Sachtjen Center', '/ipsum/primis.xml', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('User-centric executive protocol', 'External constriction of unspecified thumb, sequela', 'img/event/32.jpg', '2018-05-12 15:15:07', '5/3/2017', '6:52 AM', '12:43 PM', 122 , 'Viesīte', '5 Loomis Hill', '/ut/rhoncus/aliquet.json', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Quality-focused zero tolerance leverage', 'Other specified injuries of left shoulder and upper arm', 'img/event/33.jpg', '2018-05-02 09:51:50', '7/21/2017', '10:54 AM', '10:25 PM', 174 , 'Kalibo (poblacion)', '0 Monterey Trail', '/elit/sodales/scelerisque.aspx', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Focused content-based initiative', 'Toxic effect of thallium, undetermined, sequela', 'img/event/34.jpg', '2018-05-02 05:46:11', '8/14/2017', '7:09 AM', '8:09 PM', 183 , 'Koltubanovskiy', '4399 Coleman Terrace', '/in/porttitor/pede/justo/eu/massa/donec.aspx', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Compatible demand-driven approach', 'Unspecified injury of unspecified blood vessel at hip and thigh level, right leg, sequela', 'img/event/35.jpg', '2018-06-11 14:27:12', '8/30/2017', '7:54 AM', '1:02 PM', 45 , 'Xinfu', '41423 Summerview Avenue', '/ornare/imperdiet/sapien/urna/pretium.html', true, 41);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('User-centric systematic archive', 'Bilateral primary osteoarthritis of knee', 'img/event/36.jpg', '2018-06-20 16:06:13', '1/20/2018', '10:46 AM', '10:22 PM', 34 , 'Dimovo', '976 Mockingbird Pass', '/hac/habitasse/platea/dictumst/etiam.html', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Profound scalable success', 'Pseudocoxalgia', 'img/event/37.jpg', '2018-07-01 14:28:15', '6/9/2017', '10:41 AM', '11:16 PM', 45 , 'Xiaogang', '038 Homewood Point', '/consequat/varius/integer/ac/leo/pellentesque/ultrices.jsp', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Team-oriented empowering functionalities', 'Isolated proteinuria with diffuse mesangial proliferative glomerulonephritis', 'img/event/38.jpg', '2018-05-10 02:03:53', '1/30/2018', '8:25 AM', '7:53 PM', 161 , 'Abuochiche', '9050 Swallow Avenue', '/ac/leo/pellentesque/ultrices/mattis.png', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Future-proofed homogeneous installation', 'Posterior subluxation of proximal end of tibia, unspecified knee, subsequent encounter', 'img/event/39.jpg', '2018-06-23 22:36:39', '9/1/2017', '8:59 AM', '7:07 PM', 45 , 'Jiangmen', '19820 Fairview Terrace', '/ipsum/primis/in/faucibus/orci.js', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Future-proofed transitional alliance', 'Unspecified fracture of lower end of left femur', 'img/event/40.jpg', '2018-09-05 00:16:49', '7/16/2017', '10:35 AM', '9:57 PM', 45 , 'Sanjiang', '21 Menomonie Hill', '/vel/accumsan/tellus/nisi.js', false, 49);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Exclusive maximized open architecture', 'Stress fracture, left foot, subsequent encounter for fracture with malunion', 'img/event/41.jpg', '2018-09-08 04:48:42', '1/19/2018', '8:13 AM', '7:15 PM', 45 , 'Tangkeng', '2 Buell Plaza', '/fringilla/rhoncus/mauris/enim/leo/rhoncus.xml', true, 40);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Cross-platform context-sensitive emulation', 'Passenger of ambulance or fire engine injured in nontraffic accident, subsequent encounter', 'img/event/42.jpg', '2018-06-29 08:55:10', '3/20/2018', '9:05 AM', '4:52 PM', 64 , 'Pasaje', '3305 Bultman Lane', '/sit/amet.png', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Right-sized multimedia model', 'Unspecified car occupant injured in collision with other type car in traffic accident', 'img/event/43.jpg', '2018-09-24 11:13:28', '1/28/2018', '7:16 AM', '4:20 PM', 173 , 'Conchucos', '413 Monica Junction', '/curabitur/at/ipsum/ac.jpg', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Innovative 4th generation secured line', 'Fall into natural body of water striking side', 'img/event/44.jpg', '2018-09-22 06:29:58', '6/29/2017', '11:11 AM', '8:15 PM', 214 , 'Ystad', '564 Lawn Lane', '/felis/donec/semper/sapien/a/libero.aspx', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Switchable hybrid extranet', 'Other intraarticular fracture of lower end of unspecified radius, subsequent encounter for open fracture type I or II with malunion', 'img/event/45.jpg', '2018-05-23 01:44:39', '12/2/2017', '11:57 AM', '10:45 PM', 75 , 'Mâcon', '0 Old Shore Court', '/cursus/urna/ut/tellus.aspx', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Sharable static hierarchy', 'Person on outside of pick-up truck or van injured in collision with other nonmotor vehicle in traffic accident', 'img/event/46.jpg', '2018-06-29 04:21:20', '8/28/2017', '8:03 AM', '1:51 PM', 45 , 'Dainan', '92 Browning Crossing', '/at.aspx', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Total bi-directional attitude', 'Pathological fracture in other disease, left hand, subsequent encounter for fracture with routine healing', 'img/event/47.jpg', '2018-06-06 00:21:30', '10/14/2017', '10:19 AM', '2:54 PM', 10 , 'La Falda', '3 Scofield Avenue', '/sapien/iaculis/congue/vivamus.js', true, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Networked holistic challenge', 'Subluxation of C2/C3 cervical vertebrae, subsequent encounter', 'img/event/48.jpg', '2018-07-25 16:23:34', '1/28/2018', '10:52 AM', '7:08 PM', 61 , 'Dikhil', '9320 Pleasure Pass', '/arcu/adipiscing.json', true, 24);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Proactive uniform Graphic Interface', 'Displacement of ventricular intracranial (communicating) shunt, subsequent encounter', 'img/event/49.jpg', '2018-08-02 00:01:56', '5/14/2017', '7:09 AM', '6:49 PM', 74 , 'Outokumpu', '8403 Vidon Plaza', '/posuere/cubilia/curae/nulla/dapibus/dolor/vel.json', false, null);
insert into event (name, description, imagepath, startDay, endDay, startTime, endTime, idcountry, city, address, publiclink, ispublic, community) values ('Re-engineered zero defect customer loyalty', 'Infection following a procedure, sequela', 'img/event/50.jpg', '2018-09-17 19:04:17', '12/2/2017', '6:10 AM', '2:46 PM', 111 , 'Fujioka', '4970 Oak Valley Lane', '/dictumst/maecenas/ut/massa/quis/augue/luctus.png', true, null);


INSERT INTO event_eventcategory VALUES (14, 1);
INSERT INTO event_eventcategory VALUES (24, 2);
INSERT INTO event_eventcategory VALUES (45, 6);
INSERT INTO event_eventcategory VALUES (38, 2);
INSERT INTO event_eventcategory VALUES (30, 2);
INSERT INTO event_eventcategory VALUES (38, 6);
INSERT INTO event_eventcategory VALUES (13, 1);
INSERT INTO event_eventcategory VALUES (40, 2);
INSERT INTO event_eventcategory VALUES (35, 2);
INSERT INTO event_eventcategory VALUES (41, 3);
INSERT INTO event_eventcategory VALUES (25, 6);
INSERT INTO event_eventcategory VALUES (33, 2);
INSERT INTO event_eventcategory VALUES (13, 6);
INSERT INTO event_eventcategory VALUES (29, 5);
INSERT INTO event_eventcategory VALUES (37, 3);
INSERT INTO event_eventcategory VALUES (20, 5);
INSERT INTO event_eventcategory VALUES (48, 7);
INSERT INTO event_eventcategory VALUES (5, 6);
INSERT INTO event_eventcategory VALUES (16, 2);
INSERT INTO event_eventcategory VALUES (47, 1);
INSERT INTO event_eventcategory VALUES (42, 6);
INSERT INTO event_eventcategory VALUES (23, 1);
INSERT INTO event_eventcategory VALUES (31, 4);
INSERT INTO event_eventcategory VALUES (34, 2);
INSERT INTO event_eventcategory VALUES (21, 3);
INSERT INTO event_eventcategory VALUES (20, 7);
INSERT INTO event_eventcategory VALUES (50, 4);
INSERT INTO event_eventcategory VALUES (11, 5);
INSERT INTO event_eventcategory VALUES (24, 6);
INSERT INTO event_eventcategory VALUES (14, 2);
INSERT INTO event_eventcategory VALUES (41, 4);
INSERT INTO event_eventcategory VALUES (22, 6);
INSERT INTO event_eventcategory VALUES (27, 6);
INSERT INTO event_eventcategory VALUES (23, 7);
INSERT INTO event_eventcategory VALUES (43, 5);
INSERT INTO event_eventcategory VALUES (20, 1);
INSERT INTO event_eventcategory VALUES (9, 6);
INSERT INTO event_eventcategory VALUES (35, 3);
INSERT INTO event_eventcategory VALUES (10, 1);
INSERT INTO event_eventcategory VALUES (28, 2);
INSERT INTO event_eventcategory VALUES (36, 6);
INSERT INTO event_eventcategory VALUES (25, 7);
INSERT INTO event_eventcategory VALUES (2, 7);
INSERT INTO event_eventcategory VALUES (26, 5);
INSERT INTO event_eventcategory VALUES (6, 2);
INSERT INTO event_eventcategory VALUES (8, 3);
INSERT INTO event_eventcategory VALUES (8, 2);
INSERT INTO event_eventcategory VALUES (18, 6);
INSERT INTO event_eventcategory VALUES (50, 6);
INSERT INTO event_eventcategory VALUES (40, 4);
INSERT INTO event_eventcategory VALUES (18, 5);
INSERT INTO event_eventcategory VALUES (44, 6);
INSERT INTO event_eventcategory VALUES (18, 7);
INSERT INTO event_eventcategory VALUES (28, 4);
INSERT INTO event_eventcategory VALUES (6, 4);
INSERT INTO event_eventcategory VALUES (28, 5);
INSERT INTO event_eventcategory VALUES (4, 2);
INSERT INTO event_eventcategory VALUES (19, 2);
INSERT INTO event_eventcategory VALUES (9, 2);
INSERT INTO event_eventcategory VALUES (28, 7);
INSERT INTO event_eventcategory VALUES (40, 3);
INSERT INTO event_eventcategory VALUES (33, 5);
INSERT INTO event_eventcategory VALUES (37, 7);
INSERT INTO event_eventcategory VALUES (26, 3);
INSERT INTO event_eventcategory VALUES (32, 7);
INSERT INTO event_eventcategory VALUES (21, 2);
INSERT INTO event_eventcategory VALUES (14, 6);
INSERT INTO event_eventcategory VALUES (22, 5);
INSERT INTO event_eventcategory VALUES (22, 1);
INSERT INTO event_eventcategory VALUES (4, 7);
INSERT INTO event_eventcategory VALUES (39, 6);
INSERT INTO event_eventcategory VALUES (24, 3);
INSERT INTO event_eventcategory VALUES (39, 2);
INSERT INTO event_eventcategory VALUES (10, 3);
INSERT INTO event_eventcategory VALUES (36, 1);
INSERT INTO event_eventcategory VALUES (33, 6);
INSERT INTO event_eventcategory VALUES (3, 5);
INSERT INTO event_eventcategory VALUES (23, 2);
INSERT INTO event_eventcategory VALUES (19, 7);
INSERT INTO event_eventcategory VALUES (32, 5);
INSERT INTO event_eventcategory VALUES (14, 3);
INSERT INTO event_eventcategory VALUES (20, 3);
INSERT INTO event_eventcategory VALUES (47, 4);
INSERT INTO event_eventcategory VALUES (20, 2);
INSERT INTO event_eventcategory VALUES (38, 3);
INSERT INTO event_eventcategory VALUES (31, 7);


--
-- Data for Name: event_member; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (1,101,true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (21, 43, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (16, 12, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (22, 71, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (17, 2, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (44, 48, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (44, 26, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (10, 34, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (12, 53, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (48, 71, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (45, 65, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (22, 87, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (3, 77, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (17, 43, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (29, 84, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (46, 85, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (32, 14, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (13, 38, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (13, 90, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (35, 72, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (32, 72, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (10, 98, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (35, 1, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (24, 7, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (24, 99, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (17, 22, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (18, 99, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (45, 11, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (48, 36, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (2, 23, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (14, 50, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (7, 78, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (27, 13, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (20, 90, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (47, 62, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (29, 62, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (31, 19, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (8, 11, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (42, 20, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (20, 59, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (36, 60, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (10, 71, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (39, 57, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (9, 74, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (16, 18, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (17, 6, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (35, 70, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (12, 54, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (23, 38, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (45, 83, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (31, 7, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (13, 55, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (36, 8, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (4, 57, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (25, 53, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (32, 56, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (43, 59, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (34, 67, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (9, 10, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (40, 1, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (1, 62, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (38, 50, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (33, 30, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (6, 79, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (21, 78, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (28, 22, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (29, 64, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (13, 36, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (38, 57, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (29, 59, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (44, 47, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (26, 54, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (38, 58, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (20, 6, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (21, 89, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (15, 46, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (1, 90, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (50, 63, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (48, 48, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (39, 8, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (12, 25, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (14, 74, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (46, 38, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (50, 55, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (50, 80, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (29, 83, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (40, 18, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (37, 44, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (20, 50, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (48, 43, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (7, 46, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (10, 18, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (34, 81, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (43, 17, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (10, 79, false);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (26, 44, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (40, 20, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (8, 80, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (11, 85, true);
INSERT INTO event_member(idevent, idmember, isadmin) VALUES (38, 1, false);


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


--
-- Data for Name: invoice; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (390993165, 'Pepillo Poulgreen', '8114 Corscot Way', 22, 50, '2017-12-10');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (154498197, 'Caesar Lindgren', '44 Stuart Center', 71, 8, '2018-02-16');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (838104206, 'Melisenda Chavez', '73 Manley Hill', 86, 76, '2017-09-23');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (300871463, 'Elane Pollie', '797 Farwell Circle', 25, 54, '2017-09-11');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (106546414, 'Eadmund Gulk', '79096 Kropf Pass', 81, 35, '2018-01-02');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (253909640, 'Lorrayne Titchen', '658 Jenifer Place', 65, 38, '2017-09-23');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (504546841, 'Augustine Mathevon', '0 Northview Pass', 1, 70, '2017-11-16');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (692027672, 'Fleurette Jentges', '6357 Claremont Lane', 44, 97, '2017-06-24');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (177207424, 'Sharia Sommers', '4014 Lakeland Lane', 53, 20, '2017-08-28');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (107945574, 'Pammi Carmont', '23 Washington Court', 27, 83, '2017-08-31');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (140660896, 'Amaleta Petrelli', '4 Thackeray Avenue', 41, 96, '2018-03-13');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (776730732, 'Lurleen Swinglehurst', '2682 Prairie Rose Point', 95, 73, '2017-06-14');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (415830194, 'Dorisa Bernocchi', '71 Packers Plaza', 93, 39, '2017-10-04');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (241800347, 'Vergil Gammet', '7759 Cody Park', 17, 58, '2018-01-15');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (385974995, 'Norris Andriolli', '5 Lakewood Gardens Street', 48, 23, '2017-12-31');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (580766701, 'Krissy Barthelemy', '96 Nevada Drive', 76, 32, '2017-04-01');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (634619738, 'Vinni Mcmanaman', '8 Glendale Hill', 36, 44, '2017-08-15');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (703780590, 'Skelly Aylward', '16 Talmadge Center', 46, 37, '2017-12-26');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (267207308, 'Eugenie Bidwell', '0 Florence Circle', 27, 12, '2017-03-30');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (968705070, 'Atalanta Treece', '90 Starling Hill', 7, 39, '2017-04-08');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (619803979, 'Ingelbert Brooksbank', '202 Bunker Hill Court', 14, 64, '2017-12-29');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (412129924, 'Modesty Bamblett', '224 Boyd Place', 77, 94, '2018-01-09');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (374221892, 'Imogen Okroy', '432 Gina Terrace', 69, 33, '2017-04-13');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (110684619, 'Danila Cowie', '3 Ronald Regan Street', 88, 2, '2017-09-17');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (712833507, 'Riannon Dutteridge', '41 Larry Hill', 2, 5, '2018-02-25');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (418434690, 'Norby Coleyshaw', '7 Red Cloud Center', 20, 1, '2017-09-26');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (343101692, 'Terrie Larway', '8 Monument Trail', 18, 32, '2017-05-17');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (861344177, 'Florette Kliesl', '30 Alpine Hill', 81, 89, '2017-05-05');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (433615381, 'Karyn Beumant', '58132 Waxwing Park', 44, 99, '2017-07-15');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (193787519, 'Aharon Grishenkov', '64 Ludington Terrace', 1, 49, '2017-12-21');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (951894666, 'Etti Wakes', '79 Ohio Way', 92, 69, '2017-07-19');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (372757092, 'Zondra Bretelle', '1963 Haas Junction', 8, 24, '2017-04-17');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (646613427, 'Bernhard Mangion', '30 Victoria Center', 61, 93, '2017-05-24');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (616697366, 'Bettye Bubbings', '939 Knutson Hill', 35, 66, '2017-10-18');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (599792408, 'Sig Bigglestone', '75 Thierer Lane', 39, 68, '2017-10-19');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (225593120, 'Zaria Dooney', '97 Iowa Drive', 84, 42, '2017-05-03');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (738609737, 'Gilberta Trembath', '29 Porter Park', 24, 54, '2017-08-17');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (329434335, 'Magdaia Espinos', '13 Shoshone Point', 93, 98, '2017-07-05');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (642374313, 'Abel Tyndall', '334 Truax Street', 19, 26, '2017-12-07');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (905443854, 'Benedick Speirs', '1 Kedzie Pass', 9, 90, '2018-03-01');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (559898796, 'Bartolemo Cud', '5 Cherokee Street', 36, 53, '2017-08-12');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (145505148, 'Morton Boneham', '86770 Monica Pass', 68, 74, '2018-03-04');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (113623580, 'Oliver Ciobotaru', '9924 Macpherson Place', 59, 5, '2017-05-20');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (896412866, 'Dierdre Stutter', '52 Buena Vista Court', 1, 85, '2017-07-20');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (249787576, 'Devlen Coddington', '6 Northview Hill', 68, 6, '2017-10-22');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (380025839, 'Demetra Gonet', '4119 Hagan Way', 15, 43, '2018-01-29');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (997094639, 'Rory Poltone', '4 Mayfield Pass', 60, 20, '2017-11-22');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (786265510, 'Arvin Cobbin', '6 Coleman Street', 88, 64, '2017-10-08');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (840210925, 'Pen Letham', '39 Ilene Point', 27, 98, '2017-12-23');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (922091712, 'Wash Treffrey', '02476 Vahlen Parkway', 79, 21, '2018-03-26');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (650385498, 'Henrietta Aiskrigg', '49 Michigan Street', 10, 82, '2017-06-10');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (387721356, 'Saloma Duckham', '77942 Old Shore Road', 95, 85, '2018-01-19');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (823235806, 'Veronike Moston', '91688 Burning Wood Drive', 67, 53, '2017-05-22');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (867873812, 'Ring Angliss', '50347 Raven Alley', 27, 38, '2017-08-18');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (275587345, 'Jerrie Threadgill', '28462 Reindahl Hill', 78, 65, '2017-10-06');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (747970913, 'Jemmie Ruthen', '5 Carey Parkway', 50, 1, '2018-01-28');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (265201475, 'Fredelia Segrott', '2780 Carpenter Road', 52, 75, '2017-09-08');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (958049673, 'Pearl MacElholm', '3732 Southridge Alley', 46, 44, '2017-10-01');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (652254506, 'Leonard Fayer', '2680 Dorton Lane', 8, 43, '2017-05-15');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (462948103, 'Gardy O''Connel', '50320 Orin Lane', 25, 36, '2017-11-23');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (359579286, 'Katha Woodburn', '42720 Sherman Way', 2, 75, '2018-02-10');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (159649629, 'Dominik Robshaw', '51 Ryan Hill', 24, 80, '2017-11-09');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (301312318, 'Ellyn Wildber', '78786 Basil Court', 63, 62, '2017-10-24');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (727289249, 'Lacie Fossey', '89 Tony Avenue', 84, 6, '2017-10-27');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (447709009, 'Lyndsie Crampin', '8 Pearson Hill', 3, 19, '2017-09-05');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (702999020, 'Ulrika Petrosian', '73884 Corscot Point', 43, 87, '2017-05-24');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (643344993, 'Osmond Aguirrezabal', '14611 Jana Lane', 54, 34, '2017-10-07');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (186350653, 'Kristyn Sill', '369 Clemons Road', 65, 29, '2017-08-10');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (698448318, 'Kalli Noller', '8 Maple Court', 13, 95, '2017-12-04');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (718897364, 'Davita Piet', '8885 Roxbury Street', 38, 64, '2017-09-25');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (935131861, 'Amitie Collard', '335 Starling Crossing', 58, 47, '2017-05-19');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (877297336, 'Ulric McGrudder', '316 Dexter Terrace', 4, 7, '2017-12-01');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (176302257, 'Sammie Nield', '54037 Eggendart Place', 75, 91, '2017-05-28');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (490807483, 'Elberta Hynam', '6 Grayhawk Drive', 5, 4, '2017-05-30');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (515985325, 'Quintina Prosch', '663 Eastwood Terrace', 49, 100, '2017-11-08');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (635013318, 'Ardath Esposito', '80488 Mesta Avenue', 7, 59, '2018-01-28');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (313631026, 'Petronia O''Suaird', '9 Tomscot Junction', 14, 1, '2017-10-14');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (282392246, 'Inge Hodgon', '27 Paget Center', 42, 63, '2017-12-17');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (219085399, 'Randell Sirman', '9 Summerview Junction', 24, 60, '2017-08-18');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (482390872, 'Ban Santo', '05 Saint Paul Drive', 61, 57, '2018-03-02');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (623265805, 'Leonie Harridge', '84 Pierstorff Center', 32, 34, '2017-09-01');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (757873444, 'Kent Tallboy', '48 Bultman Crossing', 72, 77, '2017-11-07');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (422082912, 'Garold Balaison', '3 Spenser Trail', 99, 65, '2017-12-17');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (703647733, 'Jennie Batch', '555 Judy Alley', 9, 87, '2017-05-15');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (110004228, 'Renee Twell', '427 Leroy Crossing', 3, 74, '2018-02-02');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (652301889, 'Belinda Horry', '6388 Pleasure Hill', 93, 86, '2017-04-15');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (302832660, 'Deeann Phayre', '132 Old Shore Crossing', 26, 1, '2017-10-26');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (841281831, 'Kala Peasee', '5575 Boyd Drive', 73, 90, '2017-08-12');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (922884510, 'Dale Mulcock', '76 Mesta Crossing', 1, 96, '2017-05-20');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (333683125, 'Maryellen Gelling', '0 Clove Way', 70, 24, '2017-09-30');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (688471128, 'Rancell Cinavas', '30 Lindbergh Crossing', 51, 100, '2017-06-10');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (607225970, 'Jereme Tabart', '20 Butterfield Crossing', 36, 100, '2017-04-02');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (874473696, 'Deb Wooles', '57840 David Alley', 79, 8, '2017-11-08');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (741961195, 'Elbertina Tratton', '1 Oriole Center', 20, 79, '2018-02-16');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (915176890, 'Harvey Yannikov', '4167 Muir Alley', 20, 67, '2017-06-09');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (672223121, 'Brandise Monson', '46458 Clove Crossing', 21, 72, '2018-01-13');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (911871184, 'Cornelius Scamerden', '1 Scott Street', 47, 70, '2017-12-23');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (895686372, 'Dulcea Singleton', '14 Jay Avenue', 95, 62, '2017-05-09');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (969162988, 'Shelden Jeffcoate', '3730 Vahlen Hill', 26, 89, '2017-06-27');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (349542765, 'Stephan Paynes', '43844 Kingsford Lane', 13, 80, '2018-03-18');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (978765929, 'Godwin Rijkeseis', '38 Schiller Pass', 49, 24, '2018-01-19');
INSERT INTO invoice (taxpayernumber, name, address, quantity, amount, date) VALUES (5, '123456789', 'Rua, n 123', 1, 70, '2018-04-04');


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
insert into member (name, username, password, birthdate, email, idcountry, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Regular User',	'user',	'$2y$10$ByFGDdFUlrPF4jQ.3MK1tOtA6DK9xxhaW9Gr/azhkkFr.b.FnvbIO', null, 'user@email.com', 4, null, null, null, null, null, '2018-04-20', false, false);

--
-- Data for Name: notification; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-01-05 15:30:19', 'invite', 4, 5, 45, 39);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-20 15:42:40', 'invite', 17, 6, 30, 50);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-03-12 19:04:46', 'invite', 26, 68, 35, 30);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-03-21 11:46:44', 'invite', 50, 9, 36, 16);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-02-25 14:50:51', 'comment', 19, 60, 4, 12);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-03-18 01:24:53', 'invite', 41, 63, 29, 26);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-03-06 10:54:17', 'invite', 7, 64, 12, 19);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-03-31 09:03:52', 'invite', 15, 89, 35, 23);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-11-13 04:06:16', 'comment', 42, 16, 3, 17);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-13 20:49:22', 'invite', 1, 44, 8, 21);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-09 20:26:07', 'comment', 45, 51, 33, 26);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-29 18:06:52', 'invite', 39, 39, 39, 16);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-12-15 04:01:58', 'comment', 15, 56, 27, 44);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-11-27 04:48:25', 'invite', 36, 89, 38, 43);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-06-22 12:56:54', 'comment', 4, 98, 31, 10);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-14 07:30:26', 'invite', 3, 40, 12, 5);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-01-10 10:49:20', 'invite', 10, 4, 27, 41);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-01 10:20:07', 'invite', 22, 41, 18, 19);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-11-16 03:05:13', 'comment', 18, 35, 10, 28);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-11 03:00:22', 'invite', 40, 69, 44, 2);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-01-16 16:29:18', 'comment', 45, 51, 21, 21);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-15 05:25:15', 'invite', 16, 91, 23, 11);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-11 16:04:37', 'invite', 15, 26, 31, 36);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-02-05 11:10:26', 'comment', 46, 8, 35, 40);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-30 17:27:45', 'invite', 29, 9, 4, 48);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-12-24 02:12:41', 'comment', 4, 41, 18, 45);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-08 19:56:27', 'invite', 48, 84, 36, 34);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-12-07 10:49:48', 'invite', 37, 1, 35, 49);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-06-17 22:22:11', 'comment', 14, 87, 29, 8);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-02-27 05:33:28', 'comment', 29, 26, 17, 12);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-11 22:53:44', 'invite', 45, 1, 32, 1);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-01-12 01:35:23', 'invite', 50, 17, 47, 1);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-05-06 22:30:52', 'comment', 43, 15, 48, 13);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-12-17 12:26:03', 'comment', 23, 15, 48, 30);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-11 17:57:12', 'invite', 21, 19, 48, 42);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-17 04:50:43', 'invite', 12, 19, 32, 40);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-05-10 10:17:13', 'comment', 30, 24, 38, 26);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-04-13 01:50:54', 'comment', 24, 20, 46, 2);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-04-15 17:18:40', 'invite', 50, 66, 7, 2);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-11-19 06:18:05', 'invite', 8, 91, 33, 21);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-11 18:38:09', 'comment', 31, 8, 45, 19);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-02-24 17:52:48', 'comment', 36, 58, 43, 18);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-01-13 18:36:14', 'invite', 27, 95, 3, 6);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-03 14:51:10', 'comment', 40, 7, 10, 42);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-04-22 16:45:32', 'comment', 1, 47, 13, 3);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-04-18 22:45:12', 'invite', 10, 18, 42, 42);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-08 22:07:39', 'invite', 33, 2, 32, 8);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-20 01:27:30', 'comment', 23, 95, 30, 4);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-07 00:08:55', 'comment', 15, 69, 48, 45);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-05-20 15:55:42', 'comment', 13, 93, 34, 27);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-06-05 18:33:20', 'invite', 3, 67, 40, 3);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-15 18:45:54', 'comment', 23, 13, 22, 5);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-02-03 01:25:19', 'invite', 10, 81, 23, 31);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-07 17:59:01', 'invite', 28, 11, 24, 10);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-05-19 08:32:57', 'invite', 6, 38, 4, 46);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-02-05 15:30:04', 'invite', 33, 85, 32, 33);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-02-11 06:27:04', 'invite', 46, 66, 30, 10);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-02-14 19:18:02', 'comment', 31, 67, 26, 40);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-06-30 12:24:45', 'comment', 39, 31, 7, 20);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-02-21 05:01:48', 'comment', 1, 91, 4, 44);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-03-20 05:15:23', 'invite', 12, 60, 20, 8);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-12-28 18:22:23', 'comment', 23, 95, 27, 13);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-19 12:46:11', 'comment', 38, 73, 3, 2);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-05-17 10:19:35', 'comment', 20, 49, 48, 41);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-30 06:13:24', 'comment', 12, 29, 43, 15);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-03-08 21:39:46', 'comment', 20, 3, 14, 22);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-01-06 11:20:39', 'invite', 12, 64, 1, 33);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-31 01:56:53', 'comment', 32, 67, 50, 36);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-28 11:44:22', 'comment', 13, 70, 12, 11);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-07 08:35:02', 'invite', 22, 6, 39, 20);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-01-29 11:55:11', 'comment', 3, 71, 24, 14);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-12-26 23:33:22', 'invite', 1, 98, 13, 30);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-19 16:22:38', 'comment', 13, 26, 34, 48);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-06-21 16:21:08', 'comment', 27, 48, 36, 13);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-04-06 17:46:08', 'invite', 7, 28, 16, 17);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-19 10:14:30', 'invite', 5, 33, 47, 18);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-12 22:41:25', 'comment', 11, 90, 26, 40);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-14 07:43:33', 'comment', 32, 3, 26, 48);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-29 13:28:23', 'comment', 22, 16, 42, 32);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-06-29 12:17:38', 'invite', 25, 6, 49, 5);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-06 05:46:41', 'comment', 30, 44, 42, 50);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-31 08:30:06', 'comment', 37, 42, 32, 19);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-04-26 11:29:03', 'invite', 20, 85, 49, 7);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-26 00:47:20', 'comment', 50, 8, 38, 2);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-06-03 20:27:31', 'comment', 32, 6, 23, 19);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-03-17 03:43:12', 'comment', 44, 30, 30, 21);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-24 02:56:38', 'comment', 5, 3, 15, 33);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-08 03:54:59', 'invite', 46, 51, 44, 38);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-20 18:39:57', 'comment', 31, 49, 15, 36);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-10-29 18:09:06', 'invite', 34, 63, 25, 8);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-05-30 10:38:39', 'comment', 34, 96, 39, 35);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-01-02 13:42:43', 'comment', 18, 54, 31, 15);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-12-15 08:34:20', 'comment', 35, 20, 38, 33);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2018-01-22 02:34:11', 'comment', 2, 88, 27, 49);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-08-20 15:48:08', 'comment', 12, 43, 23, 15);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-07-20 10:06:58', 'comment', 45, 21, 31, 29);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-04-15 22:14:13', 'comment', 38, 29, 17, 30);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-06-20 05:22:52', 'comment', 31, 54, 34, 35);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-20 06:56:54', 'comment', 20, 88, 31, 6);
INSERT INTO notification (timestamp, type, community, recipient, comment, event) VALUES ('2017-09-14 15:23:33', 'comment', 45, 59, 9, 36);


--
-- Data for Name: report; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-08-17 13:49:07', 'Malignant neoplasm of lower lip, inner aspect', 24, 77, 22, 45, true, 16);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-20 09:08:21', 'Poisoning by other topical agents, undetermined, subs encntr', 45, 86, 46, 33, false, 19);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-08-02 02:32:44', 'Disp fx of shaft of third metacarpal bone, right hand', 14, 98, 49, 11, true, 34);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-07-25 05:00:06', 'Toxic eff of venom of African and Asian snake, slf-hrm, subs', 20, 52, 36, 20, true, 16);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-15 13:47:19', 'Miscellaneous ophthalmic devices assoc w incdt, NEC', 18, 69, 24, 3, false, 36);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-12 05:43:42', 'Displ transverse fx unsp patella, 7thE', 21, 51, 4, 5, true, 33);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-09-22 21:20:28', 'Juvenile osteochondrosis of head of femur, right leg', 46, 100, 45, 22, false, 47);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-09-29 12:47:38', 'Other heart disorders in diseases classified elsewhere', 45, 95, 14, 21, false, 35);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-11 12:37:16', 'Preterm labor with preterm delivery, unsp trimester, fetus 4', 9, 64, 11, 18, true, 38);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-12 09:03:52', 'Colles'' fracture of unspecified radius', 9, 78, 42, 23, false, 23);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-26 04:32:50', 'Infections of cervix in pregnancy, second trimester', 43, 74, 33, 13, false, 37);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-19 11:03:11', 'Candidiasis of skin and nail', 14, 58, 40, 6, false, 7);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-08 19:10:50', 'Nontraumatic compartment syndrome of right upper extremity', 5, 73, 46, 32, false, 36);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-03-26 01:19:40', 'Other specified peripheral vascular diseases', 20, 80, 32, 48, false, 11);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-06-21 15:57:25', 'Unspecified child maltreatment, suspected, subs encntr', 9, 71, 8, 29, true, 5);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-04 13:25:03', 'Absence epileptic syndrome, intractable, w/o stat epi', 32, 54, 3, 16, false, 19);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-08-22 23:15:39', 'Drug/chem diab w prolif diab rtnop w trctn dtch macula, bi', 40, 91, 42, 35, true, 7);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-04 05:49:53', 'Nondisp fx of ant wall of l acetab, subs for fx w routn heal', 11, 100, 50, 3, true, 19);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-11 19:20:15', 'Pedl cyc driver inj in clsn w nonmtr vehicle in traf, sqla', 35, 85, 45, 26, true, 14);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-10-08 03:46:20', 'Torus fracture of lower end of right fibula', 33, 82, 2, 16, false, 5);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-16 15:55:04', 'Nondisp fx of coronoid pro of l ulna, 7thB', 20, 55, 45, 38, false, 38);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-29 22:43:43', 'Unspecified subluxation of right ring finger, subs encntr', 47, 94, 38, 13, false, 33);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-01 06:01:15', 'Breast engorgement of newborn', 31, 63, 9, 28, true, 18);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-10-15 02:23:59', 'Milt op involving fragments from munitions, milt, sequela', 31, 56, 39, 20, false, 31);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-06-28 17:55:00', 'Oth fracture of sacrum, subs for fx w delay heal', 13, 54, 7, 12, false, 36);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-09-27 19:56:12', 'Sltr-haris Type II physeal fx lower end of left tibia', 32, 66, 11, 43, true, 38);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-07-28 04:29:49', 'Peripheral T-cell lymphoma, not classified, nodes mult site', 19, 94, 28, 48, false, 35);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-06-14 03:31:12', 'Nondisplaced segmental fracture of shaft of ulna, left arm', 30, 73, 17, 49, true, 46);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-08 03:01:14', 'Person outside bus inj in clsn w 2/3-whl mv nontraf, subs', 48, 86, 13, 44, false, 43);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-17 11:18:50', 'Burn of 2nd deg mul sites of unsp wrist and hand, sequela', 43, 50, 46, 39, true, 23);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-05 14:42:30', 'Other superficial bite of unspecified wrist, sequela', 32, 91, 40, 17, false, 26);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-08-03 23:03:06', 'Fracture of lateral end of clavicle', 15, 67, 48, 21, false, 42);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-05 01:32:25', 'Open bite, unspecified thigh', 32, 83, 33, 25, true, 21);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-07-06 22:41:11', 'Fatigue fx vertebra, thor region, subs for fx w routn heal', 35, 88, 17, 8, true, 10);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-31 07:43:04', 'Other specified osteochondropathies, right thigh', 35, 79, 15, 30, false, 28);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-06-23 01:56:33', 'Infect/inflm reaction due to prosth dev/grft in urinry sys', 16, 75, 35, 22, false, 39);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-03-20 20:46:34', 'Nondisp bicondylar fx l tibia, 7thM', 38, 85, 37, 13, false, 21);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-09-26 01:01:33', 'Nondisp Maisonneuve''s fx l leg, 7thN', 30, 89, 1, 20, false, 8);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-13 11:16:06', 'Monoamine-oxidase-inhibitor antidepressants', 50, 77, 34, 19, true, 9);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-23 20:06:24', 'Balanced rearrangements and structural markers, NEC', 1, 58, 43, 39, false, 13);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-08-10 18:48:37', 'Diagnostic and monitoring orthopedic devices assoc w incdt', 27, 65, 40, 4, true, 50);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-30 14:08:58', 'Villonodular synovitis (pigmented), hand', 15, 51, 46, 22, false, 23);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-07-20 06:16:54', 'Laceration of rectum, subsequent encounter', 28, 66, 9, 39, false, 8);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-10-08 10:23:34', 'Unsp inj flexor musc/fasc/tend at forarm lv, right arm, init', 13, 67, 13, 41, true, 21);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-11-24 14:07:15', 'Oth extrartic fx low end l rad, 7thG', 14, 86, 50, 1, false, 13);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-22 10:46:17', 'Cutaneous and mucocutaneous bartonellosis', 47, 72, 49, 27, false, 28);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-08 16:55:00', 'Other shellfish poisoning, assault, sequela', 33, 95, 14, 42, false, 36);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-20 15:49:28', 'Toxic liver disease with acute hepatitis', 44, 99, 3, 19, true, 50);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-02 22:58:41', 'Nondisp commnt suprcndl fx w/o intrcndl fx l humer, 7thD', 7, 73, 18, 16, true, 28);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-16 12:30:24', 'Suprvsn of preg w poor reprodctv or obstet history, unsp tri', 39, 71, 26, 18, true, 37);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-12 18:24:16', 'Traumatic metacarpophalangeal amputation of thumb', 48, 88, 17, 47, true, 23);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-25 03:48:04', 'Nondisp oblique fx shaft of r rad, 7thG', 13, 68, 41, 18, true, 17);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-12 12:25:11', 'Poisn by oth agents prim act on the resp sys, slf-hrm, subs', 24, 78, 48, 34, false, 2);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-22 19:50:51', 'Oth injury of muscle, fascia and tendon of right hip', 45, 100, 25, 4, true, 26);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-30 18:03:26', 'Other hypertrichosis', 18, 50, 37, 14, true, 15);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-11-27 17:00:53', 'Parasitic endophthalmitis, unspecified, unspecified eye', 49, 59, 27, 13, false, 12);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-15 05:01:27', 'Superficial frostbite of unspecified hand', 19, 68, 22, 4, true, 23);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-11-30 09:39:37', 'Lacerat intrinsic musc/fasc/tend r thm at wrs/hnd lv, init', 6, 68, 9, 11, true, 26);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-18 14:02:34', 'Unsp glider (nonpowered) accident injuring occupant, init', 17, 71, 20, 19, false, 18);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-05 18:34:01', 'Intentional self-harm by unsp hot objects, init encntr', 5, 78, 9, 18, true, 2);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-03-11 03:53:20', 'Burn of third degree of right forearm, initial encounter', 12, 63, 9, 13, false, 43);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-03-01 21:40:57', 'Traum rupt of volar plate of r idx fngr at MCP/IP jt, sqla', 23, 71, 19, 9, true, 25);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-03-13 03:46:23', 'Sezary disease', 45, 75, 16, 18, false, 11);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-29 00:46:33', 'Nondisp intertroch fx l femr, 7thJ', 29, 89, 36, 14, false, 46);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-09-07 15:29:27', 'Acquired stenosis of r ext ear canal secondary to trauma', 38, 78, 22, 45, true, 19);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-24 23:57:02', 'Crushing injury of left index finger, subsequent encounter', 45, 82, 36, 6, false, 26);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-11 06:04:03', 'Inj unsp musc/fasc/tend at thigh level, left thigh, subs', 31, 98, 10, 6, true, 18);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-07-10 19:40:34', 'Unsp fx low end unsp tibia, 7thQ', 2, 87, 20, 18, true, 28);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-08-02 06:33:48', 'Exposure to other inanimate mechanical forces, sequela', 30, 74, 15, 1, false, 34);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-11 12:07:49', 'Other acquired abnormalities of left ear ossicles', 34, 99, 32, 25, true, 9);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-09-27 02:56:19', 'Displ longitud fx right patella, subs for clos fx w nonunion', 15, 83, 24, 1, false, 9);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-06-05 22:35:29', 'Corrosion of respiratory tract, part unspecified', 10, 74, 42, 2, false, 45);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-26 01:35:43', 'Partial traumatic amputation of unsp great toe, init encntr', 14, 63, 24, 2, false, 47);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-15 10:59:55', 'Alcohol abuse with alcohol-induced anxiety disorder', 14, 63, 17, 7, true, 28);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-07 20:16:53', 'Jumping or diving from boat striking bottom causing drown', 9, 78, 30, 13, false, 32);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-22 21:41:53', 'Maternal care for high head at term, fetus 2', 34, 59, 12, 27, true, 16);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-17 21:41:18', 'Chronic neph syndrome w diffuse endocaplry prolif glomrlneph', 5, 75, 47, 45, true, 9);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-06-02 00:48:47', 'War op w explosn due to acc disch of own munit, milt, sqla', 45, 90, 30, 24, true, 14);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-10-20 02:27:49', 'Oth disord of continuity of bone, right pelv rgn and thigh', 8, 92, 7, 12, false, 31);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-27 13:05:14', 'Unsp car occupant injured in collision w ped/anml nontraf', 4, 88, 36, 41, true, 48);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-09-25 07:04:10', 'Arthritis due to other bacteria, unspecified hip', 1, 88, 20, 34, false, 34);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-08-20 23:24:42', 'Unspecified focal chorioretinal inflammation, left eye', 36, 85, 16, 29, true, 2);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-16 19:17:42', 'Prsn brd/alit hv veh injured in nonclsn trnsp acc, sequela', 24, 65, 10, 49, true, 18);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-04-05 12:23:40', 'Pigmentary glaucoma, left eye, moderate stage', 10, 97, 4, 3, false, 4);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-06 18:48:33', 'Unsp symptoms and signs w cognitive functions and awareness', 49, 96, 21, 46, false, 19);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-03-28 21:43:27', 'Ankylosis, right foot', 31, 82, 10, 39, false, 48);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-03-13 06:04:50', 'Unspecified open wound of right hand', 36, 96, 3, 25, false, 37);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-09-09 16:56:52', 'Mtrcy passenger injured in clsn w pedl cyc in traf, sequela', 10, 75, 27, 26, false, 46);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-14 22:51:29', 'Traum hemor left cerebrum w LOC of 1-5 hrs 59 minutes, init', 42, 58, 13, 40, true, 7);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-11-08 17:28:05', 'Zoster with other nervous system involvement', 17, 72, 3, 28, true, 36);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-23 02:15:31', 'Matern care for oth or susp poor fetl grth, third tri, fts3', 50, 79, 32, 16, false, 21);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-02-07 09:16:30', 'Anesthesia and hypoesthesia of cornea', 47, 84, 21, 8, false, 5);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-07-19 03:26:58', 'Anaphylactic shock, unspecified, sequela', 14, 88, 20, 44, false, 28);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-03-29 21:55:38', 'Derang of ant horn of lat mensc due to old tear/inj, r knee', 45, 71, 38, 25, false, 34);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-06-01 05:20:57', 'Strain of musc/tend peroneal grp at low leg level, left leg', 7, 85, 34, 38, true, 42);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-12-02 11:45:17', 'Unsp fx shaft of r tibia, 7thQ', 26, 99, 43, 20, true, 24);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2018-01-06 10:45:43', 'Unsp fx second MC bone, right hand, subs for fx w malunion', 38, 93, 28, 2, false, 6);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-11-07 21:06:56', 'Open bite of left index finger with damage to nail, sequela', 45, 59, 47, 37, false, 2);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-10-12 13:12:36', 'Parasitic cyst of iris, ciliary body or anterior chamber', 18, 62, 48, 41, true, 22);
INSERT INTO report (timestamp, context, community, reporter, comment, event, solved, member) VALUES ('2017-05-24 06:00:54', 'Unsp inj musc/tend post grp at low leg level, unsp leg, sqla', 45, 85, 46, 37, false, 42);


--
-- Data for Name: ticket; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO ticket (type, buyer, idinvoice) VALUES (1, 5, 101);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (32, 76, 96);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (40, 38, 68);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (5, 67, 12);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (45, 86, 53);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (23, 69, 7);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (47, 25, 83);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (26, 20, 60);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (3, 52, 29);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (5, 88, 36);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (19, 95, 35);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (14, 16, 6);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (34, 60, 31);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (25, 18, 58);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (44, 26, 3);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (3, 9, 39);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (16, 95, 55);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (40, 67, 39);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (19, 2, 20);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (36, 20, 43);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (24, 73, 53);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (3, 18, 50);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (32, 27, 37);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (19, 12, 72);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (44, 14, 65);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (36, 23, 22);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (12, 27, 65);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (23, 100, 63);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (35, 15, 73);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (24, 76, 52);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (47, 90, 5);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (29, 79, 50);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (49, 30, 34);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (49, 18, 11);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (44, 42, 22);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (42, 1, 81);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (6, 64, 40);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (48, 53, 15);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (25, 86, 54);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (43, 68, 76);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (5, 49, 35);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (14, 68, 28);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (27, 33, 11);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (28, 84, 46);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (39, 33, 46);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (28, 71, 75);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (23, 33, 38);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (12, 96, 1);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (8, 84, 80);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (27, 14, 52);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (31, 91, 60);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (21, 54, 67);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (1, 60, 29);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (41, 84, 96);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (6, 67, 94);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (30, 73, 20);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (38, 16, 86);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (45, 14, 20);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (21, 65, 41);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (31, 2, 79);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (43, 95, 80);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (2, 50, 28);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (44, 52, 18);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (28, 76, 95);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (40, 62, 20);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (23, 27, 22);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (12, 73, 37);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (37, 52, 93);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (4, 78, 43);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (45, 94, 59);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (29, 18, 99);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (48, 62, 77);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (12, 3, 5);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (31, 9, 77);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (14, 50, 38);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (38, 17, 26);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (22, 82, 3);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (45, 41, 28);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (23, 45, 60);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (47, 9, 94);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (27, 55, 71);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (45, 57, 66);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (49, 40, 14);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (1, 48, 60);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (41, 43, 75);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (13, 81, 91);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (3, 68, 66);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (30, 60, 67);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (47, 41, 75);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (36, 70, 94);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (40, 26, 6);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (49, 63, 80);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (25, 58, 49);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (6, 22, 91);
INSERT INTO ticket (type, buyer, idinvoice) VALUES (31, 23, 64);


--
-- Data for Name: tickettype; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 87.6899999999999977, 5205, 4039, 'Diabetes due to underlying condition w oth diabetic arthrop', 43);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 62.8100000000000023, 3404, 1967, 'Congenital absence of hand and finger', 8);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 90.4699999999999989, 4647, 4606, 'Dvrtclos of intest, part unsp, w/o perf or abscess w bleed', 41);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 76.4099999999999966, 1946, 9640, 'Displ commnt fx shaft of l femr, 7thQ', 40);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 70.6599999999999966, 7136, 8990, 'Nondisp spiral fx shaft of ulna, r arm, 7thJ', 23);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 41.5399999999999991, 6010, 3279, 'Lens-induced iridocyclitis, right eye', 30);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 38.8200000000000003, 2769, 9662, 'Unsp mtrcy rider injured in collision w 2/3-whl mv in traf', 5);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 42.7800000000000011, 581, 110, 'Microscopic polyangiitis', 6);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 28.2899999999999991, 719, 6264, 'Nondisp fx of nk of 4th MC bone, l hand, 7thP', 4);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 48.6799999999999997, 4378, 5045, 'Displ spiral fx shaft of ulna, l arm, 7thM', 19);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 20.9200000000000017, 8605, 965, 'Unsp fx upr end r tibia, subs for opn fx type I/2 w nonunion', 50);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 32.1400000000000006, 4461, 4011, 'Tinnitus, bilateral', 29);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 63.9399999999999977, 925, 9562, 'Legal intervention involving injury by dynamite', 46);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 78.6299999999999955, 605, 5208, 'Benign neoplasm of pituitary gland', 39);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 84.519999999999996, 1552, 7307, 'Atrophic nonflaccid tympanic membrane, unspecified ear', 40);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 1.34000000000000008, 3396, 1872, 'Epidural hemorrhage w LOC of 1-5 hrs 59 min, init', 26);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 10.8800000000000008, 8285, 2471, 'Nondisplaced fracture of greater tuberosity of right humerus', 26);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 52.8500000000000014, 1894, 1356, 'Nondisp fx of r tibial tuberosity, 7thC', 10);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 1.44999999999999996, 7613, 8249, 'Unsp inj blood vessels at ank/ft level, right leg, sequela', 17);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 75.7399999999999949, 9859, 8221, 'Adverse effect of other drugs acting on muscles, init encntr', 46);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 58.7700000000000031, 6476, 2147, 'Displ seg fx shaft of r fibula, 7thR', 12);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 2.16999999999999993, 9201, 1768, 'Posterior subluxation of unsp ulnohumeral joint, sequela', 43);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 79.8900000000000006, 5031, 5475, 'Displaced unsp fracture of left great toe, init for opn fx', 16);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 26.4600000000000009, 3705, 3911, 'Gen skin eruption due to drugs and meds taken internally', 41);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 48.6499999999999986, 2672, 2218, 'Unspecified anomaly of jaw size', 10);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 94.7800000000000011, 1019, 4047, 'Enteropathic arthropathies, unspecified elbow', 7);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 17.8200000000000003, 4313, 9629, 'Oth private fix-wing arcrft explosn inj occupant, sequela', 45);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 91.4599999999999937, 9534, 5792, 'Corrosion of first degree of toe(s) (nail)', 44);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 25.0700000000000003, 6185, 6174, 'Contusion of left upper arm', 36);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 31.3599999999999994, 3525, 3020, 'Laceration with foreign body of unsp upper arm, subs encntr', 9);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 65.0499999999999972, 9410, 2374, 'Unsp pedl cyclst injured in nonclsn trnsp acc in traf, init', 46);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 7.51999999999999957, 6981, 593, 'Pnctr w fb of abd wall, epigst rgn w penet perit cav, init', 30);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 85.9300000000000068, 7760, 1876, 'High risk sexual behavior', 26);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 77.8900000000000006, 5046, 6224, 'Other osteonecrosis, unspecified toe(s)', 49);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 27.9899999999999984, 8360, 4504, 'Blister (nonthermal) of unspecified wrist, initial encounter', 21);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 63.9399999999999977, 9226, 8192, 'Squamous blepharitis left lower eyelid', 49);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 96.5100000000000051, 8626, 4451, 'Nondisp fx of triquetrum bone, right wrist, init for clos fx', 25);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 88.1800000000000068, 6602, 453, 'Poisn by unsp sys anti-infect and antiparastc, undet, sqla', 40);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 67.3400000000000034, 2166, 7285, 'Unspecified subluxation of other finger, initial encounter', 18);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 73.9500000000000028, 8014, 2222, 'Diverticulitis of large intestine w perforation and abscess', 30);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 59.0700000000000003, 4244, 8343, 'Elev erythro sedim and abnormality of plasma viscosity', 3);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 53.2999999999999972, 5805, 980, 'Fall from non-moving nonmotorized scooter, sequela', 30);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 96.1800000000000068, 5785, 5043, 'Other and unspecified nontraumatic intracranial hemorrhage', 20);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 70.2199999999999989, 7527, 148, 'Thrombotic microangiopathy', 13);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 31.3399999999999999, 9455, 5616, 'Inj muscle, fascia and tendon of unsp hip, init encntr', 27);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 57.7700000000000031, 4803, 2854, 'Laceration with foreign body, unspecified ankle, sequela', 5);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 64.2099999999999937, 4778, 219, 'Perf due to fb acc left in body following endo exam, init', 36);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 59.9699999999999989, 2201, 3013, 'Unspecified dacryocystitis of right lacrimal passage', 5);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 76.3499999999999943, 1504, 4349, 'Fat embolism (traumatic), sequela', 14);


INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 87.6899999999999977, 5205, 4039, 'Diabetes due to underlying condition w oth diabetic arthrop', 43);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 62.8100000000000023, 3404, 1967, 'Congenital absence of hand and finger', 8);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 90.4699999999999989, 4647, 4606, 'Dvrtclos of intest, part unsp, w/o perf or abscess w bleed', 41);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 76.4099999999999966, 1946, 9640, 'Displ commnt fx shaft of l femr, 7thQ', 40);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 70.6599999999999966, 7136, 8990, 'Nondisp spiral fx shaft of ulna, r arm, 7thJ', 23);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 41.5399999999999991, 6010, 3279, 'Lens-induced iridocyclitis, right eye', 30);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 38.8200000000000003, 2769, 9662, 'Unsp mtrcy rider injured in collision w 2/3-whl mv in traf', 5);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 42.7800000000000011, 581, 110, 'Microscopic polyangiitis', 6);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 28.2899999999999991, 719, 6264, 'Nondisp fx of nk of 4th MC bone, l hand, 7thP', 4);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 48.6799999999999997, 4378, 5045, 'Displ spiral fx shaft of ulna, l arm, 7thM', 19);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 20.9200000000000017, 8605, 965, 'Unsp fx upr end r tibia, subs for opn fx type I/2 w nonunion', 50);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 32.1400000000000006, 4461, 4011, 'Tinnitus, bilateral', 29);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 63.9399999999999977, 925, 9562, 'Legal intervention involving injury by dynamite', 46);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 78.6299999999999955, 605, 5208, 'Benign neoplasm of pituitary gland', 39);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 84.519999999999996, 1552, 7307, 'Atrophic nonflaccid tympanic membrane, unspecified ear', 40);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 1.34000000000000008, 3396, 1872, 'Epidural hemorrhage w LOC of 1-5 hrs 59 min, init', 26);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 10.8800000000000008, 8285, 2471, 'Nondisplaced fracture of greater tuberosity of right humerus', 26);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 52.8500000000000014, 1894, 1356, 'Nondisp fx of r tibial tuberosity, 7thC', 10);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 1.44999999999999996, 7613, 8249, 'Unsp inj blood vessels at ank/ft level, right leg, sequela', 17);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 75.7399999999999949, 9859, 8221, 'Adverse effect of other drugs acting on muscles, init encntr', 46);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 58.7700000000000031, 6476, 2147, 'Displ seg fx shaft of r fibula, 7thR', 12);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 2.16999999999999993, 9201, 1768, 'Posterior subluxation of unsp ulnohumeral joint, sequela', 43);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 79.8900000000000006, 5031, 5475, 'Displaced unsp fracture of left great toe, init for opn fx', 16);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 26.4600000000000009, 3705, 3911, 'Gen skin eruption due to drugs and meds taken internally', 41);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 48.6499999999999986, 2672, 2218, 'Unspecified anomaly of jaw size', 10);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 94.7800000000000011, 1019, 4047, 'Enteropathic arthropathies, unspecified elbow', 7);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 17.8200000000000003, 4313, 9629, 'Oth private fix-wing arcrft explosn inj occupant, sequela', 45);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 91.4599999999999937, 9534, 5792, 'Corrosion of first degree of toe(s) (nail)', 44);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 25.0700000000000003, 6185, 6174, 'Contusion of left upper arm', 36);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 31.3599999999999994, 3525, 3020, 'Laceration with foreign body of unsp upper arm, subs encntr', 9);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 65.0499999999999972, 9410, 2374, 'Unsp pedl cyclst injured in nonclsn trnsp acc in traf, init', 46);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 7.51999999999999957, 6981, 593, 'Pnctr w fb of abd wall, epigst rgn w penet perit cav, init', 30);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 85.9300000000000068, 7760, 1876, 'High risk sexual behavior', 26);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 77.8900000000000006, 5046, 6224, 'Other osteonecrosis, unspecified toe(s)', 49);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 27.9899999999999984, 8360, 4504, 'Blister (nonthermal) of unspecified wrist, initial encounter', 21);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 63.9399999999999977, 9226, 8192, 'Squamous blepharitis left lower eyelid', 49);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 96.5100000000000051, 8626, 4451, 'Nondisp fx of triquetrum bone, right wrist, init for clos fx', 25);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 88.1800000000000068, 6602, 453, 'Poisn by unsp sys anti-infect and antiparastc, undet, sqla', 40);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 67.3400000000000034, 2166, 7285, 'Unspecified subluxation of other finger, initial encounter', 18);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 73.9500000000000028, 8014, 2222, 'Diverticulitis of large intestine w perforation and abscess', 30);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 59.0700000000000003, 4244, 8343, 'Elev erythro sedim and abnormality of plasma viscosity', 3);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 53.2999999999999972, 5805, 980, 'Fall from non-moving nonmotorized scooter, sequela', 30);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 96.1800000000000068, 5785, 5043, 'Other and unspecified nontraumatic intracranial hemorrhage', 20);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (2, 70.2199999999999989, 7527, 148, 'Thrombotic microangiopathy', 13);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 31.3399999999999999, 9455, 5616, 'Inj muscle, fascia and tendon of unsp hip, init encntr', 27);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 57.7700000000000031, 4803, 2854, 'Laceration with foreign body, unspecified ankle, sequela', 5);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 64.2099999999999937, 4778, 219, 'Perf due to fb acc left in body following endo exam, init', 36);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (3, 59.9699999999999989, 2201, 3013, 'Unspecified dacryocystitis of right lacrimal passage', 5);
INSERT INTO tickettype (type, price, initialquantity, availableQuantity, description, event) VALUES (1, 76.3499999999999943, 1504, 4349, 'Fat embolism (traumatic), sequela', 14);


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

ALTER TABLE ONLY ticket
    ADD CONSTRAINT fk_member FOREIGN KEY (buyer) REFERENCES member(idmember) ON DELETE CASCADE;


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
    ADD CONSTRAINT fk_tickettype FOREIGN KEY (type) REFERENCES tickettype(idtickettype) ON DELETE CASCADE;


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
     to_tsvector('english', name || ' ' || description);



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

CREATE OR REPLACE FUNCTION inviteCommunityMembers(integer, integer) RETURNS VOID AS $BODY$
DECLARE
	idevent ALIAS FOR $1;
	idcommunity ALIAS FOR $2;
	tuple RECORD;
BEGIN
 FOR tuple IN (SELECT community_member.idmember as idmember, community_member.isadmin  as isadmin
      FROM community_member
      WHERE community_member.idcommunity = idcommunity) LOOP
    INSERT INTO event_member VALUES(idevent, tuple.idmember, tuple.isadmin);
    --TODO Falta gerar as notificacoes
  END LOOP;
END;
$BODY$ LANGUAGE plpgsql;

