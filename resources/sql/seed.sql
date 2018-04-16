
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
    isadmin boolean NOT NULL
);



--
-- Name: communitycategory; Type: TABLE; Schema: lbaw1714; Owner: lbaw1714; Tablespace:
--

CREATE TABLE communitycategory (
    idcommunitycategory integer NOT NULL,
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
    country character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    address character varying(100) NOT NULL,
    publiclink text,
    ispublic boolean NOT NULL,
    community integer
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
    accepted boolean
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
    country character varying(50),
    city character varying(50),
    address text,
    taxpayernumber character varying(20),
    about character varying(256),
    profilepicture text,
    registrationdate date NOT NULL,
    --sentemailverification boolean NOT NULL,
    verifiedemail boolean NOT NULL,
    iswebsiteadmin boolean NOT NULL
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
    idinvoice integer NOT NULL
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



--
-- Data for Name: comment; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO comment VALUES ('Unsp comp of fb acc left in body fol unsp procedure, subs', '2017-11-07 00:53:39', 12, 52);
INSERT INTO comment VALUES ('Occup of pk-up/van inj in clsn w rail trn/veh in traf, subs', '2017-06-25 07:16:01', 23, 82);
INSERT INTO comment VALUES ('Convergence insufficiency', '2017-10-21 06:16:06', 36, 9);
INSERT INTO comment VALUES ('Unsp inj intrns musc/fasc/tend l lit fngr at wrs/hnd lv,subs', '2017-03-29 17:40:24', 38, 33);
INSERT INTO comment VALUES ('Disp fx of body of scapula, r shldr, 7thG', '2017-07-11 10:32:04', 29, 22);
INSERT INTO comment VALUES ('Unspecified fracture of shaft of right fibula, sequela', '2017-12-02 19:28:10', 17, 88);
INSERT INTO comment VALUES ('Displ commnt fx shaft of ulna, l arm, 7thE', '2018-03-14 02:18:22', 16, 41);
INSERT INTO comment VALUES ('Poisoning by macrolides, intentional self-harm, init encntr', '2017-04-13 19:34:50', 26, 6);
INSERT INTO comment VALUES ('Sprain of unspecified parts of lumbar spine and pelvis', '2018-01-16 06:37:48', 47, 27);
INSERT INTO comment VALUES ('Chronic gingivitis, non-plaque induced', '2017-11-05 15:25:38', 25, 25);
INSERT INTO comment VALUES ('Barton''s fx unsp rad, subs for opn fx type 3A/B/C w nonunion', '2017-09-28 10:20:34', 33, 38);
INSERT INTO comment VALUES ('Matern care for damag to fetus from viral dis in mother, oth', '2017-07-22 00:51:12', 48, 60);
INSERT INTO comment VALUES ('Congenital mitral stenosis', '2017-09-19 03:45:10', 29, 45);
INSERT INTO comment VALUES ('Theater (live) as place', '2018-03-03 23:54:24', 35, 83);
INSERT INTO comment VALUES ('Varus deformity, not elsewhere classified, elbow', '2018-03-05 19:43:38', 20, 96);
INSERT INTO comment VALUES ('Unsp fx right femur, subs for opn fx type 3A/B/C w nonunion', '2018-01-24 21:22:04', 50, 74);
INSERT INTO comment VALUES ('Osseous and sublux stenos of intvrt foramin of thor region', '2017-12-05 02:16:57', 25, 97);
INSERT INTO comment VALUES ('Disp fx of proximal phalanx of left lesser toe(s), init', '2017-12-01 04:37:20', 50, 72);
INSERT INTO comment VALUES ('Other dislocation of right wrist and hand, sequela', '2017-11-16 21:53:12', 34, 70);
INSERT INTO comment VALUES ('Other complications of esophagostomy', '2018-01-04 07:20:47', 29, 49);
INSERT INTO comment VALUES ('Acute nasopharyngitis [common cold]', '2017-04-22 22:57:48', 15, 16);
INSERT INTO comment VALUES ('Corrosion of unspecified degree of right wrist, subs encntr', '2018-01-16 03:28:13', 17, 70);
INSERT INTO comment VALUES ('Disp fx of capitate bone, unspecified wrist, sequela', '2017-06-09 02:21:42', 48, 67);
INSERT INTO comment VALUES ('Contact with nonvenomous toads', '2018-01-08 02:30:39', 43, 2);
INSERT INTO comment VALUES ('Unsp fracture of unsp thoracic vertebra, init for opn fx', '2017-07-19 09:59:04', 38, 13);
INSERT INTO comment VALUES ('Displ commnt fx shaft of unsp tibia, 7thD', '2017-07-22 04:10:51', 50, 56);
INSERT INTO comment VALUES ('Nondisp fx of neck of r rad, subs for clos fx w routn heal', '2017-04-13 11:18:04', 20, 86);
INSERT INTO comment VALUES ('Injury of optic tract and pathways, unspecified eye, sequela', '2017-04-15 22:53:12', 29, 94);
INSERT INTO comment VALUES ('Corros first deg mult right fingers (nail), inc thumb, subs', '2017-03-31 05:31:37', 6, 34);
INSERT INTO comment VALUES ('Injury of tibial nerve at lower leg level, left leg, init', '2017-12-27 06:11:33', 24, 69);
INSERT INTO comment VALUES ('Maternal care for damage to fetus by radiation, oth', '2018-02-04 05:14:13', 20, 22);
INSERT INTO comment VALUES ('Injury of conjunctiva and corneal abrasion w/o fb, left eye', '2017-08-25 03:08:17', 15, 77);
INSERT INTO comment VALUES ('Mucosal cyst of postmastoidectomy cavity, left ear', '2018-01-03 16:25:43', 44, 96);
INSERT INTO comment VALUES ('Nondisplaced apophyseal fracture of unspecified femur', '2017-08-22 11:16:18', 36, 56);
INSERT INTO comment VALUES ('Subacute osteomyelitis, unspecified humerus', '2017-08-22 04:08:39', 28, 94);
INSERT INTO comment VALUES ('Gammaherpesviral mononucleosis with other complications', '2017-04-24 00:38:54', 22, 87);
INSERT INTO comment VALUES ('Poisoning by oth antihypertensive drugs, undetermined, init', '2018-03-01 08:08:04', 45, 14);
INSERT INTO comment VALUES ('Toxic effect of unspecified seafood, assault, subs encntr', '2018-03-11 12:40:46', 39, 85);
INSERT INTO comment VALUES ('Unspecified sprain of other finger, initial encounter', '2017-07-20 00:36:49', 46, 7);
INSERT INTO comment VALUES ('Sltr-haris Type I physl fx lower end humer, right arm, sqla', '2017-07-01 11:56:16', 27, 87);
INSERT INTO comment VALUES ('Infect/inflm react due to int fix of unsp bone of arm, subs', '2018-01-26 11:09:48', 19, 1);
INSERT INTO comment VALUES ('Poisoning by histamine H2-receptor blockers, acc, init', '2017-06-07 03:12:33', 35, 16);
INSERT INTO comment VALUES ('Nondisp fx of distal phalanx of r rng fngr, init for opn fx', '2018-03-20 01:42:45', 14, 42);
INSERT INTO comment VALUES ('Superficial foreign body, left hip, subsequent encounter', '2018-01-24 03:24:31', 30, 8);
INSERT INTO comment VALUES ('Unspecified dacryocystitis of right lacrimal passage', '2017-07-23 06:53:00', 41, 47);
INSERT INTO comment VALUES ('Laceration w/o fb of right cheek and TMJ area, init', '2017-10-03 22:17:06', 47, 47);
INSERT INTO comment VALUES ('Helicopter collision injuring occupant, initial encounter', '2017-11-20 08:12:08', 24, 49);
INSERT INTO comment VALUES ('Insect bite (nonvenomous) of scrotum and testes', '2018-01-21 19:27:11', 5, 97);
INSERT INTO comment VALUES ('Prsn brd/alit a 3-whl mv injured in collision w pedal cycle', '2017-05-12 08:19:59', 46, 67);
INSERT INTO comment VALUES ('Sprain of left acromioclavicular joint, initial encounter', '2018-03-06 04:30:47', 48, 25);
INSERT INTO comment VALUES ('Acute tonsillitis, unspecified', '2017-05-23 14:07:18', 23, 57);
INSERT INTO comment VALUES ('Cyst of unspecified orbit', '2017-07-21 10:53:17', 15, 83);
INSERT INTO comment VALUES ('Adverse effect of otorhino drugs and preparations, init', '2017-05-18 12:30:57', 27, 92);
INSERT INTO comment VALUES ('Displaced fracture of navicular of left foot, sequela', '2017-07-01 21:55:11', 39, 78);
INSERT INTO comment VALUES ('Diabetes mellitus due to underlying condition w ketoacidosis', '2017-08-20 01:36:10', 5, 16);
INSERT INTO comment VALUES ('Minor laceration of right vertebral artery', '2018-03-08 02:36:04', 42, 36);
INSERT INTO comment VALUES ('Direct infct of shldr jt in infec/parastc dis classd elswhr', '2018-02-26 14:00:09', 24, 45);
INSERT INTO comment VALUES ('Fx unsp metatarsal bone(s), unsp ft, 7thG', '2017-10-10 09:17:33', 32, 6);
INSERT INTO comment VALUES ('Pnctr w fb of unsp lesser toe(s) w damage to nail, init', '2017-09-30 11:03:47', 28, 95);
INSERT INTO comment VALUES ('Acne excoriee', '2018-02-10 11:24:10', 10, 15);
INSERT INTO comment VALUES ('Superficial foreign body of breast, unsp breast, init encntr', '2017-07-06 06:01:19', 1, 89);
INSERT INTO comment VALUES ('Sltr-haris Type IV physeal fx phalanx of unsp toe, init', '2017-06-06 08:35:37', 17, 29);
INSERT INTO comment VALUES ('Corrosion of third degree of unspecified wrist', '2017-10-11 16:15:19', 30, 33);
INSERT INTO comment VALUES ('Nondisp oblique fx shaft of l femr, 7thD', '2017-07-20 18:41:38', 21, 34);
INSERT INTO comment VALUES ('Injury of trochlear nerve, unspecified side, sequela', '2018-01-13 01:34:22', 37, 36);
INSERT INTO comment VALUES ('Complete transverse atyp femoral fracture, left leg, init', '2018-03-27 09:01:02', 48, 53);
INSERT INTO comment VALUES ('Occup of hv veh inj in clsn w rail trn/veh in traf, sequela', '2017-04-29 20:39:37', 20, 64);
INSERT INTO comment VALUES ('Brown-Sequard syndrome at C6, subs', '2017-08-22 13:52:35', 38, 92);
INSERT INTO comment VALUES ('Myositis ossificans traumatica, left ankle and foot', '2018-03-11 01:04:01', 3, 40);
INSERT INTO comment VALUES ('Traumatic cerebral edema w LOC of 30 minutes or less, subs', '2018-03-04 08:17:49', 42, 22);
INSERT INTO comment VALUES ('Puncture wound with foreign body of lip, sequela', '2017-04-11 05:00:42', 43, 80);
INSERT INTO comment VALUES ('Non-prs chr ulc unsp prt of r low leg limited to brkdwn skin', '2017-09-01 17:12:26', 11, 88);
INSERT INTO comment VALUES ('Triplet pregnancy, unable to dtrm num plcnta & amnio sacs', '2018-02-16 05:08:45', 26, 34);
INSERT INTO comment VALUES ('Struck by nonvenomous lizards', '2017-07-20 01:52:41', 43, 58);
INSERT INTO comment VALUES ('Anterior dislocation of unsp ulnohumeral joint, init encntr', '2017-08-31 01:18:13', 31, 9);
INSERT INTO comment VALUES ('Laceration w/o foreign body of unsp finger w damage to nail', '2018-01-14 09:05:04', 9, 85);
INSERT INTO comment VALUES ('Underdosing of other bacterial vaccines, initial encounter', '2017-10-17 14:58:19', 23, 62);
INSERT INTO comment VALUES ('Superficial frostbite of left knee and lower leg', '2017-07-03 19:15:29', 37, 70);
INSERT INTO comment VALUES ('Institutional upbringing', '2018-03-08 14:33:48', 24, 16);
INSERT INTO comment VALUES ('Laceration of ulnar artery at forarm lv, left arm, sequela', '2017-06-03 14:12:10', 35, 22);
INSERT INTO comment VALUES ('Minor laceration of left vertebral artery, sequela', '2018-01-29 23:00:26', 8, 18);
INSERT INTO comment VALUES ('Blister (nonthermal), right hip, subsequent encounter', '2018-01-23 00:47:48', 35, 24);
INSERT INTO comment VALUES ('Presence of other orthopedic joint implants', '2018-02-25 17:19:55', 24, 97);
INSERT INTO comment VALUES ('Disp fx of nk of 5th MC bone, l hand, subs for fx w nonunion', '2017-10-26 09:52:46', 47, 65);
INSERT INTO comment VALUES ('Adverse effect of antiallergic and antiemetic drugs, init', '2017-11-22 15:13:02', 43, 39);
INSERT INTO comment VALUES ('Exceptionally large newborn baby', '2017-07-28 16:02:20', 41, 81);
INSERT INTO comment VALUES ('Milt op w explosn of sea-based artlry shell, civilian', '2017-03-30 10:53:15', 28, 12);
INSERT INTO comment VALUES ('Other retained radioactive fragments', '2017-09-11 16:34:31', 20, 28);
INSERT INTO comment VALUES ('Bunionette of unspecified foot', '2017-08-15 01:51:45', 22, 86);
INSERT INTO comment VALUES ('Chronic pain syndrome', '2017-05-27 07:52:27', 40, 98);
INSERT INTO comment VALUES ('Unsp injury of ulnar artery at forearm level, unsp arm, subs', '2017-11-06 17:14:30', 1, 46);
INSERT INTO comment VALUES ('Displ seg fx shaft of rad, l arm, 7thH', '2017-05-29 18:45:29', 50, 24);
INSERT INTO comment VALUES ('Oth injury of peroneal artery, left leg, subs encntr', '2018-03-15 17:42:16', 1, 67);
INSERT INTO comment VALUES ('Disp fx of proximal phalanx of unsp thumb, init for clos fx', '2017-05-03 11:02:13', 45, 18);
INSERT INTO comment VALUES ('Drown d/t being thrown ovrbrd by motion of merch ship, init', '2017-05-23 16:52:56', 50, 63);
INSERT INTO comment VALUES ('Pnctr of abd wall w fb, l upr q w/o penet perit cav, subs', '2018-03-07 23:53:57', 13, 40);
INSERT INTO comment VALUES ('Sedative, hypnotic or anxiolytic use, unsp with withdrawal', '2018-01-02 10:55:33', 36, 26);
INSERT INTO comment VALUES ('Oth physeal fx lower end of r tibia, subs for fx w nonunion', '2017-04-09 14:15:49', 43, 33);
INSERT INTO comment VALUES ('Other injury of fallopian tube, bilateral, sequela', '2017-09-03 15:47:28', 32, 30);
INSERT INTO comment VALUES ('Wedge comprsn fx third lum vertebra, subs for fx w nonunion', '2017-09-03 11:00:14', 35, 49);


--
-- Data for Name: community; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO community VALUES ('Armstrong-Goldner', 'Extrarenal uremia', '2018-03-08', 'http://dummyimage.com/154x237.bmp/5fa2dd/ffffff', '/dis/parturient/montes/nascetur.jsp', true);
INSERT INTO community VALUES ('Feil Group', 'Other specified injuries of cervical trachea, subs encntr', '2018-02-11', 'http://dummyimage.com/142x137.jpg/5fa2dd/ffffff', '/turpis/elementum.xml', true);
INSERT INTO community VALUES ('Kihn LLC', 'Enophthalmos due to atrophy of orbital tissue, right eye', '2017-10-07', 'http://dummyimage.com/142x137.jpg/5fa2dd/ffffff', NULL, false);
INSERT INTO community VALUES ('Hartmann, Powlowski and Koelpin', 'Osteonecrosis due to drugs, other site', '2017-08-19', 'http://dummyimage.com/231x224.jpg/dddddd/000000', NULL, false);
INSERT INTO community VALUES ('Nolan and Sons', 'Oth fx shaft of r femr, 7thE', '2017-05-09', 'http://dummyimage.com/101x186.png/cc0000/ffffff', NULL, false);
INSERT INTO community VALUES ('Becker, Weissnat and McClure', 'Accidental malfunction of gas, air or spring-operated gun', '2017-08-10', 'http://dummyimage.com/152x136.bmp/dddddd/000000', '/a/ipsum/integer.aspx', true);
INSERT INTO community VALUES ('Hackett Group', 'Addisonian crisis', '2018-02-04', 'http://dummyimage.com/250x155.jpg/ff4444/ffffff', NULL, false);
INSERT INTO community VALUES ('McClure, Stehr and Ullrich', 'Toxic effect of venom of caterpillars, self-harm, sequela', '2018-02-23', 'http://dummyimage.com/226x133.png/cc0000/ffffff', NULL, false);
INSERT INTO community VALUES ('Sporer LLC', 'Motorcycle rider injured pick-up truck, pick-up truck or van', '2017-09-08', 'http://dummyimage.com/107x203.jpg/5fa2dd/ffffff', '/congue/elementum/in/hac/habitasse/platea.json', true);
INSERT INTO community VALUES ('Klein, Rowe and Armstrong', 'Chronic postrheumatic arthropathy [Jaccoud], right knee', '2017-04-11', 'http://dummyimage.com/147x204.jpg/5fa2dd/ffffff', NULL, false);
INSERT INTO community VALUES ('Sporer Group', 'Mech compl of aortic (bifurcation) graft (replacement), subs', '2017-04-01', 'http://dummyimage.com/188x197.png/cc0000/ffffff', '/volutpat/convallis.jsp', true);
INSERT INTO community VALUES ('Johnston, Considine and Thompson', 'Unsp nephritic syndrome w diffuse crescentic glomrlneph', '2017-11-03', 'http://dummyimage.com/155x239.png/cc0000/ffffff', '/consequat/varius.aspx', true);
INSERT INTO community VALUES ('Huels-Runolfsson', 'Cellulitis of left orbit', '2017-06-27', 'http://dummyimage.com/221x106.png/cc0000/ffffff', NULL, false);
INSERT INTO community VALUES ('Rohan Inc', 'Oth diab with diab macular edema, resolved fol trtmt, l eye', '2017-06-10', 'http://dummyimage.com/131x117.png/ff4444/ffffff', NULL, false);
INSERT INTO community VALUES ('Hegmann-Treutel', 'Gastrointestinal anthrax', '2017-12-17', 'http://dummyimage.com/239x188.jpg/dddddd/000000', '/pede/morbi/porttitor/lorem.aspx', true);
INSERT INTO community VALUES ('Littel, Ruecker and Stroman', 'Infect/inflm react due to int fix of unsp bone of arm, init', '2017-09-05', 'http://dummyimage.com/221x135.bmp/ff4444/ffffff', '/amet.jsp', true);
INSERT INTO community VALUES ('Walsh-Homenick', 'Acute gastric ulcer with perforation', '2017-05-23', 'http://dummyimage.com/199x237.png/dddddd/000000', '/elementum/ligula.jpg', true);
INSERT INTO community VALUES ('Ward Group', 'Underdosing of stimulant laxatives, subsequent encounter', '2018-01-24', 'http://dummyimage.com/166x125.bmp/ff4444/ffffff', '/cursus/urna.js', true);
INSERT INTO community VALUES ('Erdman Group', 'Drown due to fall/jump fr crushed fishing boat, subs', '2017-07-10', 'http://dummyimage.com/165x231.jpg/5fa2dd/ffffff', '/eget/elit/sodales/scelerisque.png', true);
INSERT INTO community VALUES ('Hermann, Ferry and Wilkinson', 'Nondisp commnt fx r patella, subs for clos fx w routn heal', '2018-03-10', 'http://dummyimage.com/150x175.png/5fa2dd/ffffff', '/morbi.png', true);
INSERT INTO community VALUES ('Treutel, Bergstrom and Shanahan', 'Pelvic and perineal pain', '2017-06-28', 'http://dummyimage.com/222x242.jpg/5fa2dd/ffffff', NULL, false);
INSERT INTO community VALUES ('Watsica, Block and Torp', 'Displacement of int fix of right humerus, init', '2017-08-29', 'http://dummyimage.com/233x235.jpg/dddddd/000000', '/leo.png', true);
INSERT INTO community VALUES ('Schultz Group', 'Oth diabetes mellitus w proliferative diabetic retinopathy', '2017-07-02', 'http://dummyimage.com/119x229.jpg/cc0000/ffffff', NULL, false);
INSERT INTO community VALUES ('Mitchell, Reilly and Hand', 'Malar fracture, unspecified side, 7thB', '2018-02-18', 'http://dummyimage.com/245x148.png/cc0000/ffffff', NULL, false);
INSERT INTO community VALUES ('Marvin-Lockman', 'Salpingitis and oophoritis', '2017-09-28', 'http://dummyimage.com/194x190.png/ff4444/ffffff', NULL, false);
INSERT INTO community VALUES ('Rolfson, Hills and Goyette', 'Major lacerat branches of celiac and mesent art, sequela', '2018-02-22', 'http://dummyimage.com/247x107.bmp/5fa2dd/ffffff', '/ligula/sit/amet.png', true);
INSERT INTO community VALUES ('Koch and Sons', 'Driver injured in collision w unsp mv in traf, init', '2017-07-06', 'http://dummyimage.com/161x177.png/dddddd/000000', '/pulvinar/nulla/pede/ullamcorper.png', true);
INSERT INTO community VALUES ('Steuber Group', 'GaleazziNULLs fx r rad, subs for opn fx type I/2 w delay heal', '2017-09-06', 'http://dummyimage.com/163x108.png/dddddd/000000', '/at/ipsum/ac/tellus/semper.jsp', true);
INSERT INTO community VALUES ('Ernser-Baumbach', 'Displ seg fx shaft of l tibia, 7thN', '2017-04-11', 'http://dummyimage.com/106x183.bmp/dddddd/000000', NULL, false);
INSERT INTO community VALUES ('Tremblay, Zieme and Bauch', 'Other myositis, forearm', '2017-11-03', 'http://dummyimage.com/112x147.bmp/cc0000/ffffff', NULL, false);
INSERT INTO community VALUES ('Lesch-Orn', 'Other contact with other fish, initial encounter', '2018-02-08', 'http://dummyimage.com/160x240.bmp/dddddd/000000', NULL, false);
INSERT INTO community VALUES ('Beatty, Ledner and Metz', 'Subluxation of distal interphaln joint of left thumb, subs', '2017-12-29', 'http://dummyimage.com/157x231.bmp/cc0000/ffffff', NULL, false);
INSERT INTO community VALUES ('Gorczany, Hegmann and Herman', 'Sprain of ligaments of thoracic spine, sequela', '2017-07-26', 'http://dummyimage.com/177x103.jpg/dddddd/000000', NULL, false);
INSERT INTO community VALUES ('Harris, Lindgren and Auer', 'Passenger on bus injured in collision w oth mv nontraf, subs', '2017-05-14', 'http://dummyimage.com/175x120.jpg/5fa2dd/ffffff', '/ligula/sit.jsp', true);
INSERT INTO community VALUES ('Smith LLC', 'Corrosion of right eye and adnexa, part unsp, subs encntr', '2018-01-02', 'http://dummyimage.com/230x168.png/5fa2dd/ffffff', NULL, false);
INSERT INTO community VALUES ('Rippin, Beatty and Berge', 'Unsp infection of urinary tract in pregnancy, unsp trimester', '2017-05-19', 'http://dummyimage.com/151x177.png/cc0000/ffffff', '/orci/luctus/et/ultrices.jsp', true);
INSERT INTO community VALUES ('Hane Inc', 'Laceration of lesser saphenous vein at lower leg level', '2017-10-26', 'http://dummyimage.com/164x129.bmp/dddddd/000000', '/eu/est/congue/elementum/in.json', true);
INSERT INTO community VALUES ('Spinka LLC', 'Contusion of left front wall of thorax, initial encounter', '2017-12-11', 'http://dummyimage.com/190x121.bmp/ff4444/ffffff', NULL, false);
INSERT INTO community VALUES ('Haley-Halvorson', 'Paracoccidioidomycosis, unspecified', '2017-12-17', 'http://dummyimage.com/100x106.jpg/5fa2dd/ffffff', '/dui/nec/nisi.jpg', true);
INSERT INTO community VALUES ('Lynch-Wilderman', 'Other secondary chronic gout, unspecified knee', '2017-05-23', 'http://dummyimage.com/215x168.png/dddddd/000000', '/eu/nibh/quisque/id.xml', true);
INSERT INTO community VALUES ('ONULLConner Inc', 'Rosacea, unspecified', '2017-11-27', 'http://dummyimage.com/109x124.jpg/ff4444/ffffff', NULL, false);
INSERT INTO community VALUES ('MacGyver-Christiansen', 'Incomplete lesion of L4 level of lumbar spinal cord, sequela', '2017-08-03', 'http://dummyimage.com/111x196.png/dddddd/000000', '/nam/congue/risus/semper/porta.html', true);
INSERT INTO community VALUES ('ONULLReilly-King', 'Mech compl of unspecified internal joint prosthesis', '2017-10-19', 'http://dummyimage.com/207x157.png/5fa2dd/ffffff', '/ante/nulla.html', true);
INSERT INTO community VALUES ('Dickinson-Botsford', 'Cutaneous anthrax', '2017-08-07', 'http://dummyimage.com/144x184.png/ff4444/ffffff', NULL, false);
INSERT INTO community VALUES ('Buckridge, Kohler and Feest', 'Milt op w explosn of sea-based artlry shell, milt, sequela', '2018-03-22', 'http://dummyimage.com/191x147.png/5fa2dd/ffffff', '/semper/rutrum.png', true);
INSERT INTO community VALUES ('Denesik, Hintz and Powlowski', 'Corrosions of oth parts of unsp eye and adnexa, subs encntr', '2017-12-21', 'http://dummyimage.com/207x187.png/cc0000/ffffff', '/vestibulum/ante.json', true);
INSERT INTO community VALUES ('Hudson, Bartoletti and Bogan', 'Bitten by pig, initial encounter', '2017-10-20', 'http://dummyimage.com/107x142.jpg/dddddd/000000', '/quis.jpg', true);
INSERT INTO community VALUES ('Christiansen, Douglas and Aufderhar', 'Disord of visual cortex in inflam disord, left side of brain', '2018-01-17', 'http://dummyimage.com/179x156.bmp/5fa2dd/ffffff', NULL, false);
INSERT INTO community VALUES ('Kuhlman Group', 'Disp fx of med condyle of l femr, 7thN', '2017-08-24', 'http://dummyimage.com/113x233.bmp/dddddd/000000', '/sapien/cursus/vestibulum/proin.jpg', true);
INSERT INTO community VALUES ('Smith, Labadie and Morissette', 'Juvenile rheumatoid arthritis w systemic onset, ank/ft', '2017-06-03', 'http://dummyimage.com/182x197.jpg/ff4444/ffffff', '/ligula.html', true);


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

INSERT INTO communitycategory VALUES ('cozinha');
INSERT INTO communitycategory VALUES ('musica');
INSERT INTO communitycategory VALUES ('vendas');
INSERT INTO communitycategory VALUES ('exercito');
INSERT INTO communitycategory VALUES ('trabalho');
INSERT INTO communitycategory VALUES ('vinhos');
INSERT INTO communitycategory VALUES ('jardim');
INSERT INTO communitycategory VALUES ('restauração');
INSERT INTO communitycategory VALUES ('animais');
INSERT INTO communitycategory VALUES ('feminitas');
INSERT INTO communitycategory VALUES ('masculos');
INSERT INTO communitycategory VALUES ('desporto');


--
-- Data for Name: event; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO event VALUES ('TestingUpdate', 'this is a test', 'newImage', '2018-04-13', '2017-05-29', '06:46:00', '16:26:00', 'dogeland', 'dogecity', '0 Luster Junction', '/odio/consequat/varius/integer/ac.json', true, NULL);
INSERT INTO event VALUES ('Distributed secondary forecast', 'Unspecified superficial injury of right hand, sequela', 'http://dummyimage.com/246x193.png/5fa2dd/ffffff', '2018-04-27', '2018-05-02', '11:14:00', '22:23:00', 'Thailand', 'Khon Kaen', '26 Monument Place', '/porttitor/id/consequat/in/consequat.jsp', false, NULL);
INSERT INTO event VALUES ('Multi-tiered directional contingency', 'Nondisp fx of greater tuberosity of right humerus, sequela', 'http://dummyimage.com/165x211.jpg/ff4444/ffffff', '2018-04-08', '2017-12-23', '06:46:00', '14:24:00', 'Panama', 'Santa Marta', '77240 Continental Crossing', '/ac/nibh/fusce/lacus/purus.json', false, NULL);
INSERT INTO event VALUES ('Decentralized 3rd generation data-warehouse', 'Toxic effect of phosphorus and its compounds, assault, subs', 'http://dummyimage.com/125x191.bmp/dddddd/000000', '2018-04-08', '2017-10-05', '06:31:00', '19:26:00', 'China', 'Haiyang', '0169 Hanson Place', '/tortor/quis.jsp', false, 37);
INSERT INTO event VALUES ('Exclusive non-volatile parallelism', 'Other deformity of finger(s)', 'http://dummyimage.com/122x193.png/ff4444/ffffff', '2018-04-23', '2018-02-08', '09:43:00', '19:26:00', 'Moldova', 'Donduşeni', '1 Cottonwood Plaza', '/morbi/a/ipsum/integer/a.jsp', false, NULL);
INSERT INTO event VALUES ('Grass-roots eco-centric projection', 'Sprain of MTP joint of unsp lesser toe(s), subs', 'http://dummyimage.com/235x184.jpg/5fa2dd/ffffff', '2018-04-25', '2017-09-13', '09:30:00', '16:44:00', 'China', 'Zhaiwu', '77675 Upham Lane', '/massa/volutpat.aspx', false, 4);
INSERT INTO event VALUES ('Assimilated user-facing structure', 'Driver of snowmobile injured in traffic accident, subs', 'http://dummyimage.com/119x193.png/ff4444/ffffff', '2018-04-17', '2017-07-21', '10:31:00', '22:42:00', 'Venezuela', 'San Casimiro', '750 High Crossing Parkway', '/porttitor/id/consequat/in.js', false, NULL);
INSERT INTO event VALUES ('User-friendly eco-centric matrix', 'Other physeal fracture of left calcaneus, 7thK', 'http://dummyimage.com/209x106.png/dddddd/000000', '2018-04-26', '2017-11-10', '09:29:00', '17:54:00', 'Portugal', 'Vide', '625 Goodland Alley', '/diam/vitae.jsp', true, NULL);
INSERT INTO event VALUES ('Vision-oriented bottom-line archive', 'Other specified disorders of bone, multiple sites', 'http://dummyimage.com/237x151.png/cc0000/ffffff', '2018-04-10', '2018-04-25', '10:42:00', '17:59:00', 'Philippines', 'Pang', '200 Melvin Pass', '/donec/diam.aspx', true, NULL);
INSERT INTO event VALUES ('Centralized multi-state definition', 'Sprain of interphalangeal joint of left lesser toe(s), subs', 'http://dummyimage.com/184x110.bmp/ff4444/ffffff', '2018-04-24', '2018-01-04', '06:33:00', '17:10:00', 'Czech Republic', 'Drásov', '9896 Nancy Alley', '/dui/nec/nisi/volutpat/eleifend.xml', true, NULL);
INSERT INTO event VALUES ('Configurable radical encoding', 'Primary blast injury of bronchus, unilateral, init encntr', 'http://dummyimage.com/185x153.jpg/cc0000/ffffff', '2018-04-02', '2017-05-23', '08:24:00', '16:27:00', 'United Kingdom', 'Marston', '03139 Karstens Terrace', '/sit/amet/sem/fusce/consequat/nulla.json', true, NULL);
INSERT INTO event VALUES ('Visionary high-level alliance', 'Neoplasm of unspecified behavior of brain', 'http://dummyimage.com/219x200.bmp/5fa2dd/ffffff', '2018-04-27', '2017-10-12', '10:29:00', '15:41:00', 'Yemen', 'Al Qaţn', '085 Eagan Road', '/duis/mattis/egestas.aspx', false, NULL);
INSERT INTO event VALUES ('Managed grid-enabled function', 'Burn of first degree of upper back, subsequent encounter', 'http://dummyimage.com/220x168.jpg/cc0000/ffffff', '2018-04-01', '2017-09-06', '09:45:00', '17:09:00', 'South Korea', 'Wanju', '2769 Lerdahl Circle', '/etiam.png', false, NULL);
INSERT INTO event VALUES ('Re-engineered non-volatile product', 'Muscle wasting and atrophy, NEC, unsp shoulder', 'http://dummyimage.com/180x206.png/5fa2dd/ffffff', '2018-04-29', '2017-10-31', '08:02:00', '14:45:00', 'Japan', 'Fukushima-shi', '048 Tennyson Drive', '/tristique/tortor.jpg', true, NULL);
INSERT INTO event VALUES ('Integrated contextually-based strategy', 'Unspecified physeal fracture of right calcaneus, 7thD', 'http://dummyimage.com/181x119.png/5fa2dd/ffffff', '2018-04-27', '2017-09-08', '10:56:00', '22:39:00', 'Palestinian Territory', '‘Ibwayn', '7 Crownhardt Center', '/a/odio/in/hac/habitasse/platea/dictumst.html', true, NULL);
INSERT INTO event VALUES ('Compatible hybrid system engine', 'Other specified injuries right forearm', 'http://dummyimage.com/243x115.png/cc0000/ffffff', '2018-04-15', '2017-08-19', '11:28:00', '19:53:00', 'Philippines', 'Battung', '629 Donald Hill', '/vehicula/consequat.js', true, NULL);
INSERT INTO event VALUES ('Open-architected disintermediate migration', 'Nondisp seg fx shaft of r tibia, subs for clos fx w malunion', 'http://dummyimage.com/140x118.png/dddddd/000000', '2018-04-25', '2017-09-08', '11:07:00', '17:00:00', 'Guatemala', 'Yepocapa', '508 Annamark Park', '/ut/massa/quis/augue.js', true, NULL);
INSERT INTO event VALUES ('Customizable stable implementation', 'Sltr-haris Type I physeal fx unspecified calcaneus, 7thP', 'http://dummyimage.com/109x247.png/dddddd/000000', '2018-04-14', '2018-02-10', '06:13:00', '15:09:00', 'Czech Republic', 'Jindřichův Hradec', '472 Lillian Crossing', '/libero/ut/massa/volutpat/convallis/morbi/odio.js', false, NULL);
INSERT INTO event VALUES ('Polarised next generation neural-net', 'Monoarthritis, not elsewhere classified, left hip', 'http://dummyimage.com/216x121.bmp/cc0000/ffffff', '2018-04-04', '2017-09-10', '07:09:00', '22:21:00', 'France', 'Obernai', '41 Arapahoe Place', '/sed.js', true, NULL);
INSERT INTO event VALUES ('Self-enabling 3rd generation database', 'Unsp slipped upper femoral epiphysis, right hip', 'http://dummyimage.com/156x124.jpg/5fa2dd/ffffff', '2018-04-03', '2017-05-31', '09:59:00', '18:12:00', 'China', 'Zhuanshui', '97 Talisman Lane', '/orci/eget/orci/vehicula/condimentum/curabitur.jsp', true, NULL);
INSERT INTO event VALUES ('Programmable content-based local area network', 'Minor laceration of left kidney, subsequent encounter', 'http://dummyimage.com/145x144.jpg/cc0000/ffffff', '2018-04-11', '2018-03-18', '11:48:00', '23:47:00', 'France', 'Saint-Chamond', '607 Ramsey Place', '/dapibus/dolor/vel/est.jsp', false, NULL);
INSERT INTO event VALUES ('Vision-oriented 24 hour workforce', 'Animal-rider injured in collision w ped/anml, init', 'http://dummyimage.com/224x126.bmp/ff4444/ffffff', '2018-04-04', '2017-10-03', '08:38:00', '20:06:00', 'Indonesia', 'Praingkareha', '4276 Boyd Circle', '/risus/praesent/lectus.aspx', true, 36);
INSERT INTO event VALUES ('Programmable actuating frame', 'Abnormal innervation syndrome left upper eyelid', 'http://dummyimage.com/202x113.bmp/ff4444/ffffff', '2018-04-12', '2018-04-24', '10:48:00', '19:04:00', 'United States', 'Billings', '229 Glacier Hill Trail', '/viverra/eget/congue.html', true, NULL);
INSERT INTO event VALUES ('Robust uniform conglomeration', 'Burn of first degree of left axilla, sequela', 'http://dummyimage.com/160x199.jpg/dddddd/000000', '2018-04-21', '2017-10-14', '11:54:00', '12:03:00', 'Indonesia', 'Gugut', '3659 Clemons Place', '/sed/ante/vivamus/tortor/duis/mattis/egestas.png', false, NULL);
INSERT INTO event VALUES ('Operative composite frame', 'Disp fx of lateral condyle of r tibia, 7thG', 'http://dummyimage.com/111x238.jpg/ff4444/ffffff', '2018-04-23', '2018-02-16', '06:18:00', '20:40:00', 'Finland', 'Länsi-Turunmaa', '2672 Dryden Circle', '/volutpat/in/congue/etiam/justo/etiam/pretium.js', true, NULL);
INSERT INTO event VALUES ('Profound dynamic portal', 'Laceration of musc/fasc/tend at thigh level, left thigh', 'http://dummyimage.com/134x226.jpg/ff4444/ffffff', '2018-04-22', '2018-04-04', '09:23:00', '15:28:00', 'China', 'Wanjiazhuang', '02 Heffernan Hill', '/aliquam/sit.json', true, 16);
INSERT INTO event VALUES ('Cross-platform mission-critical instruction set', 'Corrosion of unsp degree of unspecified knee, init encntr', 'http://dummyimage.com/148x219.png/5fa2dd/ffffff', '2018-04-13', '2017-09-26', '10:58:00', '14:35:00', 'China', 'Pingya', '84 Corscot Center', '/vestibulum/eget/vulputate.jpg', true, NULL);
INSERT INTO event VALUES ('Innovative bifurcated application', 'Laceration w foreign body of l rng fngr w damage to nail', 'http://dummyimage.com/249x234.jpg/ff4444/ffffff', '2018-04-17', '2017-11-28', '11:25:00', '18:32:00', 'Chile', 'La Ensenada', '82629 Golf Junction', '/cras/mi/pede/malesuada/in/imperdiet/et.aspx', false, NULL);
INSERT INTO event VALUES ('Networked mission-critical paradigm', 'Displaced bicondylar fracture of left tibia, sequela', 'http://dummyimage.com/116x179.bmp/cc0000/ffffff', '2018-04-17', '2017-12-10', '08:14:00', '22:32:00', 'Thailand', 'Khlong Khuean', '4 Granby Junction', '/elementum/in/hac/habitasse/platea/dictumst/morbi.xml', false, NULL);
INSERT INTO event VALUES ('Devolved responsive system engine', 'Strabismic amblyopia, bilateral', 'http://dummyimage.com/100x243.png/5fa2dd/ffffff', '2018-04-11', '2018-04-16', '07:16:00', '12:08:00', 'Brazil', 'Joinville', '79 Fordem Lane', '/in/consequat/ut.png', false, NULL);
INSERT INTO event VALUES ('Stand-alone neutral project', 'Oth demyelinating diseases of central nervous system', 'http://dummyimage.com/237x179.bmp/ff4444/ffffff', '2018-04-05', '2017-08-30', '06:19:00', '23:42:00', 'France', 'Bordeaux', '7 Bunting Place', '/libero/ut/massa/volutpat/convallis/morbi/odio.json', false, NULL);
INSERT INTO event VALUES ('Secured discrete adapter', 'Oth traumatic displ spondylolysis of fifth cervcal vertebra', 'http://dummyimage.com/145x140.png/cc0000/ffffff', '2018-04-08', '2017-12-24', '09:52:00', '15:17:00', 'Syria', '‘Ayn al ‘Arab', '9 Rowland Alley', '/nullam/molestie/nibh/in/lectus.aspx', true, NULL);
INSERT INTO event VALUES ('Seamless zero administration contingency', 'Diabetes due to underlying condition w oth complications', 'http://dummyimage.com/243x188.bmp/5fa2dd/ffffff', '2018-04-05', '2017-05-26', '10:16:00', '23:19:00', 'Ukraine', 'Partenit', '141 Crowley Plaza', '/accumsan/tortor/quis/turpis.xml', true, 48);
INSERT INTO event VALUES ('Multi-channelled exuding function', 'Toxic effect of hydrogen cyanide, assault, sequela', 'http://dummyimage.com/226x238.png/cc0000/ffffff', '2018-04-23', '2018-03-24', '09:44:00', '13:54:00', 'Indonesia', 'Sukamaju', '01384 Green Crossing', '/dui.xml', true, 34);
INSERT INTO event VALUES ('Innovative needs-based protocol', 'Overweight and obesity', 'http://dummyimage.com/166x230.bmp/5fa2dd/ffffff', '2018-04-23', '2017-12-22', '06:18:00', '21:02:00', 'Indonesia', 'Kamubheka', '60 Forster Plaza', '/vel/est/donec/odio.jpg', false, NULL);
INSERT INTO event VALUES ('Team-oriented optimal process improvement', 'Burns of 50-59% of body surface w 40-49% third degree burns', 'http://dummyimage.com/233x239.jpg/cc0000/ffffff', '2018-04-19', '2018-04-21', '09:14:00', '13:27:00', 'China', 'Longquan', '10719 Sloan Plaza', '/semper.aspx', false, 36);
INSERT INTO event VALUES ('Synchronised empowering flexibility', 'Zygomatic fracture, right side, 7thB', 'http://dummyimage.com/175x153.jpg/cc0000/ffffff', '2018-04-21', '2017-09-14', '07:22:00', '21:37:00', 'Brazil', 'Simão Dias', '0 Mayer Street', '/justo/pellentesque/viverra/pede/ac/diam/cras.html', false, NULL);
INSERT INTO event VALUES ('Innovative reciprocal pricing structure', 'Nondisplaced fracture of distal phalanx of left ring finger', 'http://dummyimage.com/209x250.jpg/cc0000/ffffff', '2018-04-03', '2017-08-12', '09:29:00', '13:10:00', 'Armenia', 'Noramarg', '19876 Evergreen Junction', '/in/porttitor/pede/justo/eu/massa/donec.aspx', false, NULL);
INSERT INTO event VALUES ('User-centric upward-trending budgetary management', 'Complete lesion at C4 level of cervical spinal cord, init', 'http://dummyimage.com/168x237.png/cc0000/ffffff', '2018-04-27', '2017-06-16', '10:59:00', '22:37:00', 'China', 'Mahekou', '0277 Monument Alley', '/duis/faucibus/accumsan/odio/curabitur.aspx', false, NULL);
INSERT INTO event VALUES ('Vision-oriented next generation analyzer', 'Lacerat extn musc/fasc/tend finger at wrs/hnd lv, sequela', 'http://dummyimage.com/219x117.png/dddddd/000000', '2018-04-10', '2018-04-27', '10:06:00', '14:35:00', 'France', 'Aubervilliers', '887 Amoth Street', '/pharetra/magna/ac.aspx', false, NULL);
INSERT INTO event VALUES ('Intuitive transitional concept', 'Unspecified sprain of right lesser toe(s)', 'http://dummyimage.com/211x244.bmp/dddddd/000000', '2018-04-15', '2017-07-14', '08:50:00', '22:04:00', 'China', 'Dao’er', '27738 Northfield Park', '/porta.png', false, 48);
INSERT INTO event VALUES ('Future-proofed motivating matrix', 'Occup of pk-up/van injured in clsn w oth and unsp mv in traf', 'http://dummyimage.com/114x212.png/dddddd/000000', '2018-04-16', '2017-11-07', '09:42:00', '15:01:00', 'Brazil', 'Carazinho', '8873 Tennyson Terrace', '/arcu.aspx', false, 35);
INSERT INTO event VALUES ('Cloned didactic project', 'Nondisp associated transv/post fx left acetabulum, sequela', 'http://dummyimage.com/157x245.jpg/cc0000/ffffff', '2018-04-15', '2017-07-17', '06:45:00', '23:19:00', 'Albania', 'Gurra e Vogël', '53 Buell Hill', '/magnis/dis/parturient.js', true, NULL);
INSERT INTO event VALUES ('Networked regional challenge', 'Laceration of stomach, subsequent encounter', 'http://dummyimage.com/121x157.png/dddddd/000000', '2018-04-09', '2017-07-02', '09:08:00', '21:46:00', 'Russia', 'Ust’-Donetskiy', '00588 Service Alley', '/ut/ultrices/vel/augue/vestibulum/ante/ipsum.js', false, NULL);
INSERT INTO event VALUES ('Robust tertiary Graphical User Interface', 'Merkel cell carcinoma, unspecified', 'http://dummyimage.com/153x192.png/dddddd/000000', '2018-04-24', '2017-12-27', '10:42:00', '18:38:00', 'Indonesia', 'Selajambe Satu', '25 Rigney Junction', '/vitae/ipsum/aliquam/non/mauris/morbi.html', true, NULL);
INSERT INTO event VALUES ('Balanced responsive alliance', 'Nondisp unsp fx left great toe, subs for fx w nonunion', 'http://dummyimage.com/223x102.png/ff4444/ffffff', '2018-04-23', '2018-02-23', '11:16:00', '23:08:00', 'China', 'Hohhot', '2020 Thackeray Junction', '/augue/luctus/tincidunt/nulla/mollis/molestie.html', true, NULL);
INSERT INTO event VALUES ('Reverse-engineered dynamic open architecture', 'Other disorders of lacrimal system', 'http://dummyimage.com/222x141.bmp/ff4444/ffffff', '2018-04-04', '2018-04-11', '08:52:00', '14:48:00', 'Brazil', 'Ilhabela', '643 Miller Place', '/dolor/sit/amet/consectetuer/adipiscing/elit/proin.json', false, 10);
INSERT INTO event VALUES ('Universal directional customer loyalty', 'Asphyx due to being trapped in bed linens, acc, sequela', 'http://dummyimage.com/235x218.jpg/ff4444/ffffff', '2018-04-12', '2018-02-21', '09:52:00', '21:43:00', 'Indonesia', 'Tambaksari', '0 Derek Junction', '/at.xml', true, NULL);
INSERT INTO event VALUES ('Ergonomic composite hierarchy', 'Sprain of interphalangeal joint of r rng fngr, sequela', 'http://dummyimage.com/184x145.png/cc0000/ffffff', '2018-04-18', '2017-06-07', '11:58:00', '12:19:00', 'Russia', 'Zheleznogorsk-Ilimskiy', '37 Corben Crossing', '/eros/vestibulum/ac/est.xml', false, NULL);
INSERT INTO event VALUES ('Virtual holistic infrastructure', 'Unspecified open wound of nose, sequela', 'http://dummyimage.com/240x246.png/ff4444/ffffff', '2018-04-22', '2017-07-03', '08:49:00', '17:41:00', 'Serbia', 'Tomaševac', '9 Gale Way', '/eget/tincidunt/eget/tempus/vel/pede/morbi.aspx', true, NULL);
INSERT INTO event VALUES ('Easter Party', 'The brand new party for this Easter', 'blahblah', '2018-04-01', '2018-04-10', '09:00:00', '09:00:00', 'Portugal', 'Amarante', 'Colegio de S Goncalo', NULL, false, NULL);


--
-- Data for Name: event_eventcategory; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

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

INSERT INTO event_member VALUES (21, 43, true);
INSERT INTO event_member VALUES (16, 12, false);
INSERT INTO event_member VALUES (22, 71, false);
INSERT INTO event_member VALUES (17, 2, true);
INSERT INTO event_member VALUES (44, 48, false);
INSERT INTO event_member VALUES (44, 26, false);
INSERT INTO event_member VALUES (10, 34, false);
INSERT INTO event_member VALUES (12, 53, true);
INSERT INTO event_member VALUES (48, 71, false);
INSERT INTO event_member VALUES (45, 65, false);
INSERT INTO event_member VALUES (22, 87, false);
INSERT INTO event_member VALUES (3, 77, true);
INSERT INTO event_member VALUES (17, 43, true);
INSERT INTO event_member VALUES (29, 84, false);
INSERT INTO event_member VALUES (46, 85, false);
INSERT INTO event_member VALUES (32, 14, true);
INSERT INTO event_member VALUES (13, 38, true);
INSERT INTO event_member VALUES (13, 90, true);
INSERT INTO event_member VALUES (35, 72, false);
INSERT INTO event_member VALUES (32, 72, false);
INSERT INTO event_member VALUES (10, 98, false);
INSERT INTO event_member VALUES (35, 1, true);
INSERT INTO event_member VALUES (24, 7, false);
INSERT INTO event_member VALUES (24, 99, true);
INSERT INTO event_member VALUES (17, 22, false);
INSERT INTO event_member VALUES (18, 99, false);
INSERT INTO event_member VALUES (45, 11, false);
INSERT INTO event_member VALUES (48, 36, false);
INSERT INTO event_member VALUES (2, 23, false);
INSERT INTO event_member VALUES (14, 50, false);
INSERT INTO event_member VALUES (7, 78, false);
INSERT INTO event_member VALUES (27, 13, false);
INSERT INTO event_member VALUES (20, 90, false);
INSERT INTO event_member VALUES (47, 62, false);
INSERT INTO event_member VALUES (29, 62, false);
INSERT INTO event_member VALUES (31, 19, true);
INSERT INTO event_member VALUES (8, 11, true);
INSERT INTO event_member VALUES (42, 20, false);
INSERT INTO event_member VALUES (20, 59, true);
INSERT INTO event_member VALUES (36, 60, false);
INSERT INTO event_member VALUES (10, 71, false);
INSERT INTO event_member VALUES (39, 57, true);
INSERT INTO event_member VALUES (9, 74, true);
INSERT INTO event_member VALUES (16, 18, false);
INSERT INTO event_member VALUES (17, 6, true);
INSERT INTO event_member VALUES (35, 70, false);
INSERT INTO event_member VALUES (12, 54, false);
INSERT INTO event_member VALUES (23, 38, true);
INSERT INTO event_member VALUES (45, 83, true);
INSERT INTO event_member VALUES (31, 7, false);
INSERT INTO event_member VALUES (13, 55, true);
INSERT INTO event_member VALUES (36, 8, false);
INSERT INTO event_member VALUES (4, 57, true);
INSERT INTO event_member VALUES (25, 53, true);
INSERT INTO event_member VALUES (32, 56, false);
INSERT INTO event_member VALUES (43, 59, false);
INSERT INTO event_member VALUES (34, 67, false);
INSERT INTO event_member VALUES (9, 10, true);
INSERT INTO event_member VALUES (40, 1, true);
INSERT INTO event_member VALUES (1, 62, false);
INSERT INTO event_member VALUES (38, 50, true);
INSERT INTO event_member VALUES (33, 30, true);
INSERT INTO event_member VALUES (6, 79, false);
INSERT INTO event_member VALUES (21, 78, true);
INSERT INTO event_member VALUES (28, 22, false);
INSERT INTO event_member VALUES (29, 64, false);
INSERT INTO event_member VALUES (13, 36, true);
INSERT INTO event_member VALUES (38, 57, true);
INSERT INTO event_member VALUES (29, 59, false);
INSERT INTO event_member VALUES (44, 47, false);
INSERT INTO event_member VALUES (26, 54, true);
INSERT INTO event_member VALUES (38, 58, false);
INSERT INTO event_member VALUES (20, 6, true);
INSERT INTO event_member VALUES (21, 89, false);
INSERT INTO event_member VALUES (15, 46, false);
INSERT INTO event_member VALUES (1, 90, true);
INSERT INTO event_member VALUES (50, 63, false);
INSERT INTO event_member VALUES (48, 48, true);
INSERT INTO event_member VALUES (39, 8, false);
INSERT INTO event_member VALUES (12, 25, true);
INSERT INTO event_member VALUES (14, 74, false);
INSERT INTO event_member VALUES (46, 38, true);
INSERT INTO event_member VALUES (50, 55, false);
INSERT INTO event_member VALUES (50, 80, true);
INSERT INTO event_member VALUES (29, 83, true);
INSERT INTO event_member VALUES (40, 18, false);
INSERT INTO event_member VALUES (37, 44, false);
INSERT INTO event_member VALUES (20, 50, false);
INSERT INTO event_member VALUES (48, 43, false);
INSERT INTO event_member VALUES (7, 46, false);
INSERT INTO event_member VALUES (10, 18, true);
INSERT INTO event_member VALUES (34, 81, false);
INSERT INTO event_member VALUES (43, 17, true);
INSERT INTO event_member VALUES (10, 79, false);
INSERT INTO event_member VALUES (26, 44, true);
INSERT INTO event_member VALUES (40, 20, true);
INSERT INTO event_member VALUES (8, 80, true);
INSERT INTO event_member VALUES (11, 85, true);
INSERT INTO event_member VALUES (38, 1, false);


--
-- Data for Name: eventcategory; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO eventcategory VALUES ('discoteca');
INSERT INTO eventcategory VALUES ('musica');
INSERT INTO eventcategory VALUES ('cozinha');
INSERT INTO eventcategory VALUES ('politica');
INSERT INTO eventcategory VALUES ('vinhos');
INSERT INTO eventcategory VALUES ('palestra');
INSERT INTO eventcategory VALUES ('empresarial');


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

INSERT INTO invoice VALUES (390993165, 'Pepillo Poulgreen', '8114 Corscot Way', 22, 50, '2017-12-10');
INSERT INTO invoice VALUES (154498197, 'Caesar Lindgren', '44 Stuart Center', 71, 8, '2018-02-16');
INSERT INTO invoice VALUES (838104206, 'Melisenda Chavez', '73 Manley Hill', 86, 76, '2017-09-23');
INSERT INTO invoice VALUES (300871463, 'Elane Pollie', '797 Farwell Circle', 25, 54, '2017-09-11');
INSERT INTO invoice VALUES (106546414, 'Eadmund Gulk', '79096 Kropf Pass', 81, 35, '2018-01-02');
INSERT INTO invoice VALUES (253909640, 'Lorrayne Titchen', '658 Jenifer Place', 65, 38, '2017-09-23');
INSERT INTO invoice VALUES (504546841, 'Augustine Mathevon', '0 Northview Pass', 1, 70, '2017-11-16');
INSERT INTO invoice VALUES (692027672, 'Fleurette Jentges', '6357 Claremont Lane', 44, 97, '2017-06-24');
INSERT INTO invoice VALUES (177207424, 'Sharia Sommers', '4014 Lakeland Lane', 53, 20, '2017-08-28');
INSERT INTO invoice VALUES (107945574, 'Pammi Carmont', '23 Washington Court', 27, 83, '2017-08-31');
INSERT INTO invoice VALUES (140660896, 'Amaleta Petrelli', '4 Thackeray Avenue', 41, 96, '2018-03-13');
INSERT INTO invoice VALUES (776730732, 'Lurleen Swinglehurst', '2682 Prairie Rose Point', 95, 73, '2017-06-14');
INSERT INTO invoice VALUES (415830194, 'Dorisa Bernocchi', '71 Packers Plaza', 93, 39, '2017-10-04');
INSERT INTO invoice VALUES (241800347, 'Vergil Gammet', '7759 Cody Park', 17, 58, '2018-01-15');
INSERT INTO invoice VALUES (385974995, 'Norris Andriolli', '5 Lakewood Gardens Street', 48, 23, '2017-12-31');
INSERT INTO invoice VALUES (580766701, 'Krissy Barthelemy', '96 Nevada Drive', 76, 32, '2017-04-01');
INSERT INTO invoice VALUES (634619738, 'Vinni Mcmanaman', '8 Glendale Hill', 36, 44, '2017-08-15');
INSERT INTO invoice VALUES (703780590, 'Skelly Aylward', '16 Talmadge Center', 46, 37, '2017-12-26');
INSERT INTO invoice VALUES (267207308, 'Eugenie Bidwell', '0 Florence Circle', 27, 12, '2017-03-30');
INSERT INTO invoice VALUES (968705070, 'Atalanta Treece', '90 Starling Hill', 7, 39, '2017-04-08');
INSERT INTO invoice VALUES (619803979, 'Ingelbert Brooksbank', '202 Bunker Hill Court', 14, 64, '2017-12-29');
INSERT INTO invoice VALUES (412129924, 'Modesty Bamblett', '224 Boyd Place', 77, 94, '2018-01-09');
INSERT INTO invoice VALUES (374221892, 'Imogen Okroy', '432 Gina Terrace', 69, 33, '2017-04-13');
INSERT INTO invoice VALUES (110684619, 'Danila Cowie', '3 Ronald Regan Street', 88, 2, '2017-09-17');
INSERT INTO invoice VALUES (712833507, 'Riannon Dutteridge', '41 Larry Hill', 2, 5, '2018-02-25');
INSERT INTO invoice VALUES (418434690, 'Norby Coleyshaw', '7 Red Cloud Center', 20, 1, '2017-09-26');
INSERT INTO invoice VALUES (343101692, 'Terrie Larway', '8 Monument Trail', 18, 32, '2017-05-17');
INSERT INTO invoice VALUES (861344177, 'Florette Kliesl', '30 Alpine Hill', 81, 89, '2017-05-05');
INSERT INTO invoice VALUES (433615381, 'Karyn Beumant', '58132 Waxwing Park', 44, 99, '2017-07-15');
INSERT INTO invoice VALUES (193787519, 'Aharon Grishenkov', '64 Ludington Terrace', 1, 49, '2017-12-21');
INSERT INTO invoice VALUES (951894666, 'Etti Wakes', '79 Ohio Way', 92, 69, '2017-07-19');
INSERT INTO invoice VALUES (372757092, 'Zondra Bretelle', '1963 Haas Junction', 8, 24, '2017-04-17');
INSERT INTO invoice VALUES (646613427, 'Bernhard Mangion', '30 Victoria Center', 61, 93, '2017-05-24');
INSERT INTO invoice VALUES (616697366, 'Bettye Bubbings', '939 Knutson Hill', 35, 66, '2017-10-18');
INSERT INTO invoice VALUES (599792408, 'Sig Bigglestone', '75 Thierer Lane', 39, 68, '2017-10-19');
INSERT INTO invoice VALUES (225593120, 'Zaria Dooney', '97 Iowa Drive', 84, 42, '2017-05-03');
INSERT INTO invoice VALUES (738609737, 'Gilberta Trembath', '29 Porter Park', 24, 54, '2017-08-17');
INSERT INTO invoice VALUES (329434335, 'Magdaia Espinos', '13 Shoshone Point', 93, 98, '2017-07-05');
INSERT INTO invoice VALUES (642374313, 'Abel Tyndall', '334 Truax Street', 19, 26, '2017-12-07');
INSERT INTO invoice VALUES (905443854, 'Benedick Speirs', '1 Kedzie Pass', 9, 90, '2018-03-01');
INSERT INTO invoice VALUES (559898796, 'Bartolemo Cud', '5 Cherokee Street', 36, 53, '2017-08-12');
INSERT INTO invoice VALUES (145505148, 'Morton Boneham', '86770 Monica Pass', 68, 74, '2018-03-04');
INSERT INTO invoice VALUES (113623580, 'Oliver Ciobotaru', '9924 Macpherson Place', 59, 5, '2017-05-20');
INSERT INTO invoice VALUES (896412866, 'Dierdre Stutter', '52 Buena Vista Court', 1, 85, '2017-07-20');
INSERT INTO invoice VALUES (249787576, 'Devlen Coddington', '6 Northview Hill', 68, 6, '2017-10-22');
INSERT INTO invoice VALUES (380025839, 'Demetra Gonet', '4119 Hagan Way', 15, 43, '2018-01-29');
INSERT INTO invoice VALUES (997094639, 'Rory Poltone', '4 Mayfield Pass', 60, 20, '2017-11-22');
INSERT INTO invoice VALUES (786265510, 'Arvin Cobbin', '6 Coleman Street', 88, 64, '2017-10-08');
INSERT INTO invoice VALUES (840210925, 'Pen Letham', '39 Ilene Point', 27, 98, '2017-12-23');
INSERT INTO invoice VALUES (922091712, 'Wash Treffrey', '02476 Vahlen Parkway', 79, 21, '2018-03-26');
INSERT INTO invoice VALUES (650385498, 'Henrietta Aiskrigg', '49 Michigan Street', 10, 82, '2017-06-10');
INSERT INTO invoice VALUES (387721356, 'Saloma Duckham', '77942 Old Shore Road', 95, 85, '2018-01-19');
INSERT INTO invoice VALUES (823235806, 'Veronike Moston', '91688 Burning Wood Drive', 67, 53, '2017-05-22');
INSERT INTO invoice VALUES (867873812, 'Ring Angliss', '50347 Raven Alley', 27, 38, '2017-08-18');
INSERT INTO invoice VALUES (275587345, 'Jerrie Threadgill', '28462 Reindahl Hill', 78, 65, '2017-10-06');
INSERT INTO invoice VALUES (747970913, 'Jemmie Ruthen', '5 Carey Parkway', 50, 1, '2018-01-28');
INSERT INTO invoice VALUES (265201475, 'Fredelia Segrott', '2780 Carpenter Road', 52, 75, '2017-09-08');
INSERT INTO invoice VALUES (958049673, 'Pearl MacElholm', '3732 Southridge Alley', 46, 44, '2017-10-01');
INSERT INTO invoice VALUES (652254506, 'Leonard Fayer', '2680 Dorton Lane', 8, 43, '2017-05-15');
INSERT INTO invoice VALUES (462948103, 'Gardy O''Connel', '50320 Orin Lane', 25, 36, '2017-11-23');
INSERT INTO invoice VALUES (359579286, 'Katha Woodburn', '42720 Sherman Way', 2, 75, '2018-02-10');
INSERT INTO invoice VALUES (159649629, 'Dominik Robshaw', '51 Ryan Hill', 24, 80, '2017-11-09');
INSERT INTO invoice VALUES (301312318, 'Ellyn Wildber', '78786 Basil Court', 63, 62, '2017-10-24');
INSERT INTO invoice VALUES (727289249, 'Lacie Fossey', '89 Tony Avenue', 84, 6, '2017-10-27');
INSERT INTO invoice VALUES (447709009, 'Lyndsie Crampin', '8 Pearson Hill', 3, 19, '2017-09-05');
INSERT INTO invoice VALUES (702999020, 'Ulrika Petrosian', '73884 Corscot Point', 43, 87, '2017-05-24');
INSERT INTO invoice VALUES (643344993, 'Osmond Aguirrezabal', '14611 Jana Lane', 54, 34, '2017-10-07');
INSERT INTO invoice VALUES (186350653, 'Kristyn Sill', '369 Clemons Road', 65, 29, '2017-08-10');
INSERT INTO invoice VALUES (698448318, 'Kalli Noller', '8 Maple Court', 13, 95, '2017-12-04');
INSERT INTO invoice VALUES (718897364, 'Davita Piet', '8885 Roxbury Street', 38, 64, '2017-09-25');
INSERT INTO invoice VALUES (935131861, 'Amitie Collard', '335 Starling Crossing', 58, 47, '2017-05-19');
INSERT INTO invoice VALUES (877297336, 'Ulric McGrudder', '316 Dexter Terrace', 4, 7, '2017-12-01');
INSERT INTO invoice VALUES (176302257, 'Sammie Nield', '54037 Eggendart Place', 75, 91, '2017-05-28');
INSERT INTO invoice VALUES (490807483, 'Elberta Hynam', '6 Grayhawk Drive', 5, 4, '2017-05-30');
INSERT INTO invoice VALUES (515985325, 'Quintina Prosch', '663 Eastwood Terrace', 49, 100, '2017-11-08');
INSERT INTO invoice VALUES (635013318, 'Ardath Esposito', '80488 Mesta Avenue', 7, 59, '2018-01-28');
INSERT INTO invoice VALUES (313631026, 'Petronia O''Suaird', '9 Tomscot Junction', 14, 1, '2017-10-14');
INSERT INTO invoice VALUES (282392246, 'Inge Hodgon', '27 Paget Center', 42, 63, '2017-12-17');
INSERT INTO invoice VALUES (219085399, 'Randell Sirman', '9 Summerview Junction', 24, 60, '2017-08-18');
INSERT INTO invoice VALUES (482390872, 'Ban Santo', '05 Saint Paul Drive', 61, 57, '2018-03-02');
INSERT INTO invoice VALUES (623265805, 'Leonie Harridge', '84 Pierstorff Center', 32, 34, '2017-09-01');
INSERT INTO invoice VALUES (757873444, 'Kent Tallboy', '48 Bultman Crossing', 72, 77, '2017-11-07');
INSERT INTO invoice VALUES (422082912, 'Garold Balaison', '3 Spenser Trail', 99, 65, '2017-12-17');
INSERT INTO invoice VALUES (703647733, 'Jennie Batch', '555 Judy Alley', 9, 87, '2017-05-15');
INSERT INTO invoice VALUES (110004228, 'Renee Twell', '427 Leroy Crossing', 3, 74, '2018-02-02');
INSERT INTO invoice VALUES (652301889, 'Belinda Horry', '6388 Pleasure Hill', 93, 86, '2017-04-15');
INSERT INTO invoice VALUES (302832660, 'Deeann Phayre', '132 Old Shore Crossing', 26, 1, '2017-10-26');
INSERT INTO invoice VALUES (841281831, 'Kala Peasee', '5575 Boyd Drive', 73, 90, '2017-08-12');
INSERT INTO invoice VALUES (922884510, 'Dale Mulcock', '76 Mesta Crossing', 1, 96, '2017-05-20');
INSERT INTO invoice VALUES (333683125, 'Maryellen Gelling', '0 Clove Way', 70, 24, '2017-09-30');
INSERT INTO invoice VALUES (688471128, 'Rancell Cinavas', '30 Lindbergh Crossing', 51, 100, '2017-06-10');
INSERT INTO invoice VALUES (607225970, 'Jereme Tabart', '20 Butterfield Crossing', 36, 100, '2017-04-02');
INSERT INTO invoice VALUES (874473696, 'Deb Wooles', '57840 David Alley', 79, 8, '2017-11-08');
INSERT INTO invoice VALUES (741961195, 'Elbertina Tratton', '1 Oriole Center', 20, 79, '2018-02-16');
INSERT INTO invoice VALUES (915176890, 'Harvey Yannikov', '4167 Muir Alley', 20, 67, '2017-06-09');
INSERT INTO invoice VALUES (672223121, 'Brandise Monson', '46458 Clove Crossing', 21, 72, '2018-01-13');
INSERT INTO invoice VALUES (911871184, 'Cornelius Scamerden', '1 Scott Street', 47, 70, '2017-12-23');
INSERT INTO invoice VALUES (895686372, 'Dulcea Singleton', '14 Jay Avenue', 95, 62, '2017-05-09');
INSERT INTO invoice VALUES (969162988, 'Shelden Jeffcoate', '3730 Vahlen Hill', 26, 89, '2017-06-27');
INSERT INTO invoice VALUES (349542765, 'Stephan Paynes', '43844 Kingsford Lane', 13, 80, '2018-03-18');
INSERT INTO invoice VALUES (978765929, 'Godwin Rijkeseis', '38 Schiller Pass', 49, 24, '2018-01-19');
INSERT INTO invoice VALUES (5, '123456789', 'Rua, n 123', 1, 70, '2018-04-04');


--
-- Data for Name: member; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Kelila Dauby', 'kdauby0', 'QYa0pgL', '2017-11-18 05:38:06', 'kdauby0@narod.ru', 'Thailand', 'Seka', '9978 Jana Crossing', 616482931, 'Infect/inflm reaction due to cardiac valve prosthesis, init', 'http://dummyimage.com/231x105.png/dddddd/000000', '2017-08-25 06:15:51', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Breanne Jelf', 'bjelf1', 'lQOwwvPHaJ0I', '2017-10-31 00:18:00', 'bjelf1@php.net', 'Thailand', 'Khon Kaen', '2444 Valley Edge Plaza', 430305407, 'Other sprain of sternum, sequela', 'http://dummyimage.com/168x159.png/cc0000/ffffff', '2017-07-17 13:55:15', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Catlee Farryn', 'cfarryn2', 'Zq5VORNf', '2017-10-01 04:23:56', 'cfarryn2@flavors.me', 'United States', 'Long Beach', '6978 Hintze Pass', 701639366, 'Unspecified open wound of unspecified elbow, init encntr', 'http://dummyimage.com/149x204.bmp/cc0000/ffffff', '2017-05-23 02:34:03', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Kassandra Savory', 'ksavory3', 'aVOUYQVye', '2017-04-06 13:25:51', 'ksavory3@nba.com', 'Japan', 'Mino', '31479 Lillian Drive', 731198489, 'Complete traumatic MCP amputation of r rng fngr, sequela', 'http://dummyimage.com/162x196.bmp/5fa2dd/ffffff', '2017-12-29 13:30:53', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Cad Areles', 'careles4', 'nIiPRaAZ', '2017-08-19 09:25:41', 'careles4@unesco.org', 'Philippines', 'Silago', '34 Meadow Ridge Trail', 584722553, 'Drug/chem diabetes with stable prolif diabetic retinopathy', 'http://dummyimage.com/216x218.jpg/dddddd/000000', '2017-10-01 09:22:22', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Benn Mussetti', 'bmussetti5', 'PiyTPDRjDaM', '2018-01-24 17:54:57', 'bmussetti5@blogs.com', 'Canada', 'Joliette', '20819 Corben Hill', 903535061, 'Oth fx lower end of unsp tibia, init for opn fx type I/2', 'http://dummyimage.com/160x203.jpg/5fa2dd/ffffff', '2017-11-27 16:24:38', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Allayne Pople', 'apople6', 'u6VB4m', '2017-07-06 11:40:31', 'apople6@diigo.com', 'China', 'Nan’an', '1 Starling Road', 551063896, 'Disp fx of neck of r radius, subs for clos fx w routn heal', 'http://dummyimage.com/149x247.bmp/dddddd/000000', '2017-11-02 21:08:52', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Evangelia Penelli', 'epenelli7', 'neIVbc', '2017-09-27 13:32:01', 'epenelli7@qq.com', 'Brazil', 'Guapimirim', '7266 Lerdahl Circle', 759239638, 'Failure to introduce or to remove other tube or instrument', 'http://dummyimage.com/160x215.jpg/cc0000/ffffff', '2017-04-25 22:44:00', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Sherwood O''Hanley', 'sohanley8', 'YKEPm5WMiZF', '2018-02-17 18:25:48', 'sohanley8@statcounter.com', 'Kazakhstan', 'Semey', '0301 Ramsey Place', 227962385, 'Central cord syndrome at C7, sequela', 'http://dummyimage.com/242x185.bmp/5fa2dd/ffffff', '2017-04-26 16:50:20', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Sinclair Ringham', 'sringham9', 'c6rH3OEgQSox', '2017-07-22 16:22:36', 'sringham9@csmonitor.com', 'Indonesia', 'Krajandadapmulyo', '7 Graedel Place', 694383559, 'Burn of first degree of unspecified forearm, init encntr', 'http://dummyimage.com/123x218.jpg/cc0000/ffffff', '2017-11-28 20:35:51', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Tomas Dennick', 'tdennicka', 'PRydrGz', '2017-11-16 13:43:58', 'tdennicka@google.es', 'Colombia', 'Ciudad Bolívar', '31 Ridge Oak Park', 632326690, 'Person inj in clsn betw rail trn/veh and car, nontraf, sqla', 'http://dummyimage.com/218x172.jpg/ff4444/ffffff', '2018-02-21 04:55:35', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Beatrix Jochanany', 'bjochananyb', 'XVi6gg2z', '2018-01-25 17:52:26', 'bjochananyb@mediafire.com', 'Cape Verde', 'Tarrafal', '47642 Trailsway Point', 756985920, 'Other dislocation of right patella, initial encounter', 'http://dummyimage.com/245x138.bmp/5fa2dd/ffffff', '2017-11-02 11:35:06', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ginni Minghetti', 'gminghettic', 'kLszQ4ni9gX', '2017-12-24 18:01:52', 'gminghettic@huffingtonpost.com', 'Russia', 'Saransk', '4 Gulseth Avenue', 342954188, 'Irritant contact dermatitis due to drugs in contact w skin', 'http://dummyimage.com/214x113.bmp/5fa2dd/ffffff', '2018-01-11 05:43:13', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Yelena Pedwell', 'ypedwelld', 'sXAm1F3nEU3h', '2017-04-17 08:27:00', 'ypedwelld@amazon.co.jp', 'Indonesia', 'Long Layu', '6095 Daystar Way', 426698102, 'Person outside bus injured pick-up truck, pk-up/van nontraf', 'http://dummyimage.com/127x186.bmp/cc0000/ffffff', '2017-05-29 20:55:45', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Sharla Aseef', 'saseefe', 'JhSA80XYChy', '2017-07-28 04:47:32', 'saseefe@macromedia.com', 'Russia', 'Orlovskiy', '806 Derek Junction', 985348397, 'Nondisp fx of prox phalanx of l idx fngr, 7thG', 'http://dummyimage.com/137x242.bmp/ff4444/ffffff', '2017-04-21 20:38:38', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Virgie Clemon', 'vclemonf', 's0vV2F6hW', '2017-05-24 14:47:56', 'vclemonf@ca.gov', 'Barbados', 'Speightstown', '017 Oxford Crossing', 596666848, 'Bucket-hndl tear of lat mensc, crnt injury, unsp knee, sqla', 'http://dummyimage.com/205x130.bmp/dddddd/000000', '2017-07-25 05:58:41', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Leoine Gransden', 'lgransdeng', 'JRbTuLGa', '2018-01-22 17:16:18', 'lgransdeng@ameblo.jp', 'Indonesia', 'Tlogotunggal', '2 Esker Trail', 789216554, 'I/I react d/t ventricular intracranial shunt, init', 'http://dummyimage.com/179x139.png/dddddd/000000', '2018-01-12 04:42:53', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Vivian Bloggett', 'vbloggetth', 'dmiAxD', '2018-02-12 13:46:34', 'vbloggetth@cbc.ca', 'Indonesia', 'Pedamaran', '2405 Reindahl Drive', 581057115, 'Second degree perineal laceration during delivery', 'http://dummyimage.com/246x135.bmp/dddddd/000000', '2018-03-22 14:44:08', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Jamima Brough', 'jbroughi', 'L3lG7AzY', '2017-06-24 21:31:34', 'jbroughi@army.mil', 'United States', 'Alexandria', '52089 Merchant Center', 124197840, 'Corrosion of third degree of unspecified knee, init encntr', 'http://dummyimage.com/211x131.bmp/ff4444/ffffff', '2017-08-28 17:51:52', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Panchito Aronoff', 'paronoffj', 'Ph9Y35X', '2017-06-16 02:41:02', 'paronoffj@surveymonkey.com', 'Russia', 'Dedenëvo', '6711 Russell Street', 241279343, 'Non-in-line roller-skater colliding w statnry obj, init', 'http://dummyimage.com/136x187.jpg/5fa2dd/ffffff', '2017-10-18 14:04:24', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Maurits Gringley', 'mgringleyk', '1V6hdBs', '2017-12-05 09:03:25', 'mgringleyk@ft.com', 'Jamaica', 'Montego Bay', '46268 Vernon Street', 103928692, 'Unsp open wound of unsp great toe w/o damage to nail, init', 'http://dummyimage.com/223x160.jpg/5fa2dd/ffffff', '2017-10-07 13:27:05', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Crissy Titford', 'ctitfordl', 'OhDngcObV', '2017-10-09 10:49:48', 'ctitfordl@usgs.gov', 'Gabon', 'Bitam', '03937 Old Gate Street', 402053402, 'Laceration of anterior tibial artery, unsp leg, sequela', 'http://dummyimage.com/162x249.png/cc0000/ffffff', '2017-06-12 22:37:10', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Joella Frisel', 'jfriselm', '4G0mBz', '2018-02-15 10:55:58', 'jfriselm@bloglines.com', 'China', 'Shuren', '1815 Mcbride Plaza', 472946555, 'Carcinoma in situ of other male genital organs', 'http://dummyimage.com/139x164.jpg/dddddd/000000', '2017-04-10 04:18:05', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Dmitri Bollis', 'dbollisn', 'QqJweKpo', '2018-01-10 13:25:43', 'dbollisn@intel.com', 'Vietnam', 'Kon Dơng', '098 Bunting Crossing', 158867588, 'Fused fingers, left hand', 'http://dummyimage.com/198x164.bmp/dddddd/000000', '2017-09-13 18:45:53', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Abigale Edlestone', 'aedlestoneo', '0v63Cdsza', '2017-11-16 20:49:24', 'aedlestoneo@sbwire.com', 'Zambia', 'Chambishi', '4022 Evergreen Point', 632388261, 'Inj msl/tnd lng extn msl toe at ank/ft level, r foot, subs', 'http://dummyimage.com/196x195.bmp/ff4444/ffffff', '2018-03-15 22:10:36', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Gabbie Perche', 'gperchep', 'OwL1w8rUTa', '2017-04-03 04:39:05', 'gperchep@twitter.com', 'France', 'Fresnes', '26 Sage Court', 150249764, 'Dermatitis due to substances taken internally', 'http://dummyimage.com/222x100.bmp/5fa2dd/ffffff', '2017-09-11 16:48:55', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Helaine Iverson', 'hiversonq', '3zwL9J2', '2018-02-28 12:54:19', 'hiversonq@hc360.com', 'Poland', 'Krzemieniewo', '6 Mitchell Crossing', 585065938, 'Nondisp fx of prox phalanx of l thm, subs for fx w malunion', 'http://dummyimage.com/195x202.jpg/dddddd/000000', '2017-04-27 17:11:28', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Amandy Itzhaki', 'aitzhakir', 'UCsRe3H', '2017-12-10 02:05:55', 'aitzhakir@seesaa.net', 'Norway', 'Isdalstø', '67 Shelley Avenue', 428124754, 'Laceration with foreign body of right shoulder, sequela', 'http://dummyimage.com/110x112.bmp/cc0000/ffffff', '2017-09-24 13:46:15', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Katey Joanaud', 'kjoanauds', 'oIA2QWktmIse', '2017-10-19 13:13:30', 'kjoanauds@cnet.com', 'Senegal', 'Rosso', '145 Center Pass', 370116217, 'Pnctr w/o fb of abd wall, left low q w penet perit cav, subs', 'http://dummyimage.com/186x161.bmp/dddddd/000000', '2018-02-21 01:17:51', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Nolie Avramchik', 'navramchikt', 'L8cOiC', '2017-04-15 00:33:36', 'navramchikt@google.es', 'Kenya', 'Kakamega', '8 Lillian Hill', 518890454, 'Brown-Sequard syndrome at T2-T6, subs', 'http://dummyimage.com/144x196.png/5fa2dd/ffffff', '2017-06-09 20:52:19', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Con Oxer', 'coxeru', 'IdfxzhIf', '2017-08-10 12:01:19', 'coxeru@delicious.com', 'Russia', 'Burlatskoye', '794 Heath Drive', 645364659, 'Other obstetric trauma', 'http://dummyimage.com/197x161.jpg/5fa2dd/ffffff', '2018-02-03 19:41:54', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Valencia Gavrielli', 'vgavrielliv', 'pPWQV2pm', '2017-04-16 15:06:06', 'vgavrielliv@yahoo.com', 'Macedonia', 'Сарај', '02 Ridge Oak Court', 612349608, 'Drown due to fall/jump fr burning fishing boat, sequela', 'http://dummyimage.com/184x188.png/ff4444/ffffff', '2017-05-15 09:14:28', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Artemis Mawtus', 'amawtusw', 'oqqScmJ', '2017-12-02 09:32:57', 'amawtusw@last.fm', 'Colombia', 'Morales', '87485 Hauk Parkway', 837393141, 'Superficial foreign body of unsp part of neck, init encntr', 'http://dummyimage.com/108x121.bmp/ff4444/ffffff', '2017-11-11 00:39:52', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Martin Tierney', 'mtierneyx', 'G3q20Da', '2018-01-25 23:39:35', 'mtierneyx@msn.com', 'Tajikistan', 'Istaravshan', '365 Erie Road', 412266693, 'Guttate psoriasis', 'http://dummyimage.com/126x242.png/ff4444/ffffff', '2017-11-01 20:03:03', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Brenda Hansana', 'bhansanay', 'PejOetUiS7', '2017-10-31 19:03:39', 'bhansanay@nydailynews.com', 'Guatemala', 'El Asintal', '05537 Glacier Hill Court', 951749808, 'Primary blast injury of fallopian tube, bilateral, sequela', 'http://dummyimage.com/139x189.bmp/cc0000/ffffff', '2018-01-01 10:26:58', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Chandra Jimeno', 'cjimenoz', 'lRy6wMQJKCdL', '2017-03-28 00:36:19', 'cjimenoz@about.me', 'China', 'Xifengshan', '60 Packers Street', 646557226, 'Puncture wound w/o foreign body of finger w damage to nail', 'http://dummyimage.com/248x245.jpg/5fa2dd/ffffff', '2017-04-06 16:36:12', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Hercules Staples', 'hstaples10', '24je55ELC2r', '2017-08-22 13:58:59', 'hstaples10@shutterfly.com', 'Mexico', 'La Soledad', '21 Gateway Place', 915328402, 'Injury of deep peroneal nerve at ank/ft level, unsp leg', 'http://dummyimage.com/230x211.jpg/dddddd/000000', '2017-05-11 12:14:08', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Egon Crayk', 'ecrayk11', 'pVXsvj3dKvfr', '2017-04-12 18:23:31', 'ecrayk11@tripod.com', 'Brazil', 'Várzea da Palma', '05 Maryland Crossing', 826845565, 'Poisoning by oral contraceptives, undetermined, sequela', 'http://dummyimage.com/179x211.bmp/dddddd/000000', '2017-10-24 17:39:00', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Kandace Benoy', 'kbenoy12', 'kFCRmj', '2017-09-06 20:25:55', 'kbenoy12@nymag.com', 'Philippines', 'Toledo', '64086 Michigan Street', 192419743, 'Disp fx of base of nk of r femr, 7thM', 'http://dummyimage.com/163x204.png/cc0000/ffffff', '2017-12-01 02:03:12', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Abie Beentjes', 'abeentjes13', 'MIDgLF', '2017-07-11 11:05:17', 'abeentjes13@booking.com', 'United States', 'Wichita', '00724 Scoville Road', 694567940, 'Osteonecrosis in diseases classified elsewhere, upper arm', 'http://dummyimage.com/102x164.png/cc0000/ffffff', '2017-09-23 12:08:25', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ag Simounet', 'asimounet14', '7bLP1wrfVbm', '2018-02-28 15:43:37', 'asimounet14@eventbrite.com', 'Honduras', 'Silca', '0279 Westerfield Way', 898336822, 'Dislocation of L3/L4 lumbar vertebra, sequela', 'http://dummyimage.com/131x232.bmp/cc0000/ffffff', '2017-05-18 19:14:24', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Maynord MacKee', 'mmackee15', 'I2rZp0jje', '2017-12-26 16:56:35', 'mmackee15@flavors.me', 'Philippines', 'Bolboc', '41031 Parkside Road', 691428600, 'Other specified mononeuropathies of right lower limb', 'http://dummyimage.com/234x230.jpg/cc0000/ffffff', '2017-05-20 05:40:30', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Toni McGreal', 'tmcgreal16', '8Hd1TuJ', '2017-10-07 19:12:21', 'tmcgreal16@hhs.gov', 'Czech Republic', 'Veltruby', '1630 Moulton Lane', 877433545, 'Bitten by goose, subsequent encounter', 'http://dummyimage.com/169x187.bmp/cc0000/ffffff', '2017-08-24 13:40:05', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Minna Dutteridge', 'mdutteridge17', 'jCS7ubRA3TQ', '2017-07-30 15:51:20', 'mdutteridge17@printfriendly.com', 'Poland', 'Oborniki Śląskie', '04115 Towne Lane', 803432964, 'Diffuse acute ischemia of intestine, part unspecified', 'http://dummyimage.com/122x220.bmp/dddddd/000000', '2018-03-01 12:11:33', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ibby Halladey', 'ihalladey18', 'yhJ5G3dp', '2017-09-30 08:48:49', 'ihalladey18@moonfruit.com', 'Indonesia', 'Oepuah', '7 Arkansas Parkway', 648004465, 'Burn of first degree of left lower leg, subsequent encounter', 'http://dummyimage.com/198x163.png/5fa2dd/ffffff', '2017-09-04 02:56:59', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Gaspar Emptage', 'gemptage19', 'VsuSe2V', '2017-05-06 14:38:09', 'gemptage19@sfgate.com', 'France', 'Domont', '3 Green Crossing', 463739151, 'Unspecified subluxation of right toe(s)', 'http://dummyimage.com/220x107.png/ff4444/ffffff', '2017-08-20 09:29:40', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Travis Gillebride', 'tgillebride1a', 'tirN3vBp7hx', '2017-09-03 02:52:34', 'tgillebride1a@purevolume.com', 'Russia', 'Borovichi', '5325 Morning Pass', 152047805, 'Osseous and sublux stenosis of intvrt foramina of up extrem', 'http://dummyimage.com/158x197.jpg/ff4444/ffffff', '2018-03-03 17:14:36', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Drucy Sawkins', 'dsawkins1b', 'cfXFIlLEFLr', '2017-05-11 11:16:49', 'dsawkins1b@epa.gov', 'Thailand', 'Udon Thani', '8 Continental Hill', 519957281, 'Laceration without foreign body of unspecified part of neck', 'http://dummyimage.com/141x105.bmp/cc0000/ffffff', '2017-07-25 10:44:41', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Griz Zamorano', 'gzamorano1c', 'rRS692', '2017-12-11 06:02:17', 'gzamorano1c@fema.gov', 'Morocco', 'Tamanar', '855 Artisan Park', 409256032, 'Poisoning by local anesthetics, intentional self-harm, subs', 'http://dummyimage.com/247x211.png/5fa2dd/ffffff', '2017-04-12 19:56:51', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Carney Hazelby', 'chazelby1d', 'GnnlLn6H', '2017-05-28 18:43:05', 'chazelby1d@who.int', 'Brazil', 'Trindade', '54 Nelson Plaza', 202743119, 'Other superficial bite of unspecified parts of thorax', 'http://dummyimage.com/167x247.jpg/5fa2dd/ffffff', '2017-12-12 13:22:19', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Myrle Tythacott', 'mtythacott1e', 'z9gD5I', '2018-01-14 22:47:00', 'mtythacott1e@archive.org', 'Laos', 'Xam Nua', '08310 Stuart Parkway', 686908687, 'Displ transverse fx shaft of l ulna, 7thC', 'http://dummyimage.com/205x142.bmp/ff4444/ffffff', '2017-06-04 00:50:09', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Mandy Vanelli', 'mvanelli1f', '1bSxyrjqY', '2017-10-14 15:11:21', 'mvanelli1f@alibaba.com', 'Japan', 'Bihoro', '43 Macpherson Point', 899375825, 'Unspecified aircraft accident injuring occupant', 'http://dummyimage.com/169x201.bmp/cc0000/ffffff', '2018-01-29 17:13:35', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Stanfield Grunguer', 'sgrunguer1g', 'zBdRTxJ', '2017-09-03 08:51:03', 'sgrunguer1g@addthis.com', 'United States', 'El Paso', '74102 Roth Center', 140864681, 'Unsp fracture of unsp calcaneus, subs for fx w nonunion', 'http://dummyimage.com/202x216.jpg/5fa2dd/ffffff', '2017-12-05 06:25:01', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Anallise Samudio', 'asamudio1h', 'Tz5w8wSf', '2018-02-21 08:51:31', 'asamudio1h@redcross.org', 'Chile', 'Carahue', '682 Fordem Drive', 809282687, 'Other malformation of placenta, first trimester', 'http://dummyimage.com/130x211.bmp/dddddd/000000', '2017-04-06 07:18:25', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Meggie Janaud', 'mjanaud1i', 'rSQ0gMz', '2017-12-25 04:33:38', 'mjanaud1i@statcounter.com', 'Tunisia', 'Menzel Bourguiba', '42666 Hudson Terrace', 385725340, 'Oth incomplete lesion at C2, subs', 'http://dummyimage.com/208x209.bmp/dddddd/000000', '2017-06-19 06:56:59', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Reeva Lauritsen', 'rlauritsen1j', 'yKzmA39', '2017-10-14 15:15:43', 'rlauritsen1j@psu.edu', 'Russia', 'Zakamensk', '1782 Fieldstone Place', 404372977, 'Other erythema multiforme', 'http://dummyimage.com/157x148.png/5fa2dd/ffffff', '2017-04-09 00:55:25', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Lyndy Gaythorpe', 'lgaythorpe1k', 'VEDbKvA', '2018-01-15 14:02:33', 'lgaythorpe1k@ifeng.com', 'China', 'Xike', '9328 Hintze Circle', 723746458, 'Displacement of int fix of right humerus, subs', 'http://dummyimage.com/121x155.bmp/cc0000/ffffff', '2018-03-16 07:35:12', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Anders Latus', 'alatus1l', 'Ssu3ml5dV', '2017-12-25 17:53:39', 'alatus1l@mlb.com', 'Indonesia', 'Kalangsari', '80 Novick Place', 544874560, 'Path fx in neopltc dis, unsp shldr, subs for fx w malunion', 'http://dummyimage.com/100x223.jpg/ff4444/ffffff', '2017-10-18 19:00:34', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Zack Goning', 'zgoning1m', 'qEET25HIw', '2017-04-24 03:14:46', 'zgoning1m@rediff.com', 'Argentina', 'Colonia Elía', '4251 Banding Alley', 101801348, 'Displ commnt fx shaft of l tibia, 7thM', 'http://dummyimage.com/122x235.bmp/5fa2dd/ffffff', '2017-07-12 13:18:02', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Felicio Lindup', 'flindup1n', 'DB72JmCg8', '2017-07-02 20:36:47', 'flindup1n@prweb.com', 'Panama', 'Guararé', '414 Hintze Center', 284784780, 'Other specified crystal arthropathies, unspecified hand', 'http://dummyimage.com/171x155.bmp/5fa2dd/ffffff', '2017-06-26 16:09:08', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Helenka Millin', 'hmillin1o', '2kwxglH', '2017-07-15 03:38:42', 'hmillin1o@mediafire.com', 'Chile', 'Osorno', '99080 Kropf Road', 541328992, 'Unsp pedl cyclst injured in collision w oth pedl cyc in traf', 'http://dummyimage.com/207x245.jpg/5fa2dd/ffffff', '2018-03-02 08:44:12', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ivie Hollerin', 'ihollerin1p', '6one0tvVLxp', '2017-07-27 21:38:02', 'ihollerin1p@facebook.com', 'Morocco', 'Fifi', '8655 Barby Crossing', 238486165, 'Breakdown (mechanical) of permanent sutures, subs encntr', 'http://dummyimage.com/202x175.jpg/ff4444/ffffff', '2018-03-09 18:24:43', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Dagmar Herreros', 'dherreros1q', 'qH8WgZ8ug', '2018-01-04 10:07:02', 'dherreros1q@prnewswire.com', 'China', 'Sishiba', '3 Sunbrook Point', 275923785, 'Strain of intrinsic musc/fasc/tend unsp finger at wrs/hnd lv', 'http://dummyimage.com/240x202.jpg/ff4444/ffffff', '2017-09-30 19:49:28', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Thadeus Wodeland', 'twodeland1r', 'bM6ci1Cv', '2017-08-15 06:23:58', 'twodeland1r@macromedia.com', 'Philippines', 'San Rafael', '3140 Charing Cross Court', 923586174, 'Poisoning by oth bacterial vaccines, self-harm, init', 'http://dummyimage.com/246x219.bmp/dddddd/000000', '2017-12-02 14:14:25', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Galven Brideoke', 'gbrideoke1s', 'T4RbPVNq', '2017-05-07 03:54:51', 'gbrideoke1s@mashable.com', 'Nigeria', 'Dabai', '4 Sullivan Trail', 124630210, 'Adolescent scoliosis', 'http://dummyimage.com/125x228.png/ff4444/ffffff', '2017-09-07 03:05:19', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Therine Jandourek', 'tjandourek1t', 'diT8GPo75Zfs', '2017-05-18 06:47:40', 'tjandourek1t@yellowpages.com', 'Russia', 'Vol’sk', '58412 Pine View Terrace', 341679069, 'Lac w/o fb of r frnt wl of thorax w penet thor cavity, init', 'http://dummyimage.com/205x105.bmp/5fa2dd/ffffff', '2017-12-18 18:52:22', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Randa Cisland', 'rcisland1u', 'bKrydw', '2017-08-10 13:04:51', 'rcisland1u@amazon.de', 'Jordan', 'Aydūn', '31 Eastlawn Park', 103079722, 'Corros 50-59% of body surface w 50-59% third degree corros', 'http://dummyimage.com/209x186.jpg/ff4444/ffffff', '2017-06-20 16:46:53', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Aksel Storm', 'astorm1v', 'UJOAykhncxG', '2017-05-21 01:11:48', 'astorm1v@last.fm', 'Cyprus', 'Pégeia', '50 Manitowish Junction', 956405935, 'Disp fx of lateral epicondyl of r humer, 7thD', 'http://dummyimage.com/159x247.bmp/ff4444/ffffff', '2018-01-22 01:09:03', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Prue Tierny', 'ptierny1w', 'C5OsdsU', '2017-12-04 03:14:37', 'ptierny1w@goo.gl', 'China', 'Furong', '460 Ronald Regan Plaza', 759049227, 'Prsn brd/alit from bus injured in collision w pedal cycle', 'http://dummyimage.com/233x131.bmp/dddddd/000000', '2017-10-26 04:25:42', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Penelope Jenkins', 'pjenkins1x', '54XuIxIno0', '2017-04-27 08:37:34', 'pjenkins1x@squarespace.com', 'Brazil', 'São Gonçalo do Amarante', '44901 Red Cloud Parkway', 314602544, 'Occup of hv veh injured in nonclsn trnsp acc in traf, subs', 'http://dummyimage.com/161x103.png/cc0000/ffffff', '2017-07-16 20:53:44', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Lindon Hinnerk', 'lhinnerk1y', 'SRH4c8fptY4', '2018-02-09 20:57:18', 'lhinnerk1y@cloudflare.com', 'Sweden', 'Uppsala', '63 Dahle Hill', 532892295, 'Malignant neoplasm of right choroid', 'http://dummyimage.com/192x159.jpg/5fa2dd/ffffff', '2017-10-19 08:53:59', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Gerhard Peers', 'gpeers1z', 'WdxtJv8', '2018-01-12 13:40:40', 'gpeers1z@skyrock.com', 'Brazil', 'São Gotardo', '9 2nd Center', 335425120, 'Open bite of back wall of thorax w penet thoracic cavity', 'http://dummyimage.com/179x219.jpg/5fa2dd/ffffff', '2018-03-05 05:56:12', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Dew Dellar', 'ddellar20', 'kr5eGW1AhJ18', '2017-08-22 06:19:24', 'ddellar20@mtv.com', 'Portugal', 'Olhos de Água', '55284 Northport Center', 315580382, 'Dislocation of r acromioclav jt, > 200% displacmnt, subs', 'http://dummyimage.com/164x108.jpg/cc0000/ffffff', '2017-04-11 16:40:35', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Casper Rowler', 'crowler21', 'ygecKhceAB', '2017-04-18 11:16:42', 'crowler21@sfgate.com', 'Nigeria', 'Samamiya', '3257 South Crossing', 516785544, 'Abrasion of fingers', 'http://dummyimage.com/171x219.png/dddddd/000000', '2018-03-24 23:38:03', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Tammi Wilne', 'twilne22', 'aVqaAmj', '2017-06-27 13:50:09', 'twilne22@latimes.com', 'Spain', 'Vigo', '06729 Butterfield Way', 299592775, 'Vitiligo of left upper eyelid and periocular area', 'http://dummyimage.com/142x152.jpg/ff4444/ffffff', '2017-10-10 08:31:03', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Pavel Playle', 'pplayle23', 'xf0dFkaKzi', '2017-09-19 17:45:29', 'pplayle23@economist.com', 'Peru', 'Cotaparaco', '7 Dovetail Point', 262788930, 'Small cell B-cell lymphoma, lymph nodes of multiple sites', 'http://dummyimage.com/194x110.png/5fa2dd/ffffff', '2017-07-30 11:51:54', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Frances Glenister', 'fglenister24', 'K4UpRC', '2017-12-09 13:31:03', 'fglenister24@lycos.com', 'Serbia', 'Joševa', '64993 Transport Center', 943726215, 'Unspecified subluxation of unspecified finger', 'http://dummyimage.com/226x189.bmp/ff4444/ffffff', '2017-07-14 16:52:35', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Rock Youle', 'ryoule25', 'vMkWiwwlVXP', '2017-05-11 12:45:07', 'ryoule25@google.es', 'United States', 'Boynton Beach', '09503 Fairview Center', 335606999, 'Poisoning by antiasthmatics, intentional self-harm, init', 'http://dummyimage.com/136x162.png/cc0000/ffffff', '2017-07-28 13:35:37', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Pavel Emer', 'pemer26', 'IeqnvnktS0nf', '2018-02-01 03:16:27', 'pemer26@yale.edu', 'China', 'Tangzang', '338 Bultman Parkway', 709643183, 'Nondisp seg fx shaft of l tibia, 7thR', 'http://dummyimage.com/122x164.jpg/dddddd/000000', '2017-12-13 01:26:19', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Gonzales Westoff', 'gwestoff27', 'xrX2TzbUmW', '2017-07-28 06:13:51', 'gwestoff27@vimeo.com', 'Vietnam', 'Cái Nhum', '70778 Dawn Street', 365469194, 'Person on outside of car injured in collision w SUV in traf', 'http://dummyimage.com/195x169.png/cc0000/ffffff', '2017-10-03 10:07:45', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Sherm Goeff', 'sgoeff28', 'q3VPztvk4I', '2017-04-20 06:49:16', 'sgoeff28@free.fr', 'France', 'Caen', '3 Dexter Pass', 788267401, 'Osteolysis, right forearm', 'http://dummyimage.com/142x196.bmp/5fa2dd/ffffff', '2018-03-04 07:18:24', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Lyle Simonnin', 'lsimonnin29', 'nOGAw4gs', '2017-03-31 21:20:34', 'lsimonnin29@rakuten.co.jp', 'Russia', 'Igrim', '1378 Farwell Alley', 916105953, 'Activity, other interior property and clothing maintenance', 'http://dummyimage.com/142x129.jpg/5fa2dd/ffffff', '2017-10-13 13:32:49', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Allene Mudie', 'amudie2a', 'ygcRVbNSf', '2017-04-08 05:48:14', 'amudie2a@virginia.edu', 'United States', 'Omaha', '18477 Susan Way', 995001660, 'Laceration with foreign body, left foot', 'http://dummyimage.com/237x227.bmp/cc0000/ffffff', '2017-06-23 12:58:18', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Ernestus Kyffin', 'ekyffin2b', 'bkJq0ybBaeM', '2017-04-08 21:11:21', 'ekyffin2b@privacy.gov.au', 'Indonesia', 'Cibingbin', '9 Maple Wood Center', 337501065, 'Toxic effect of unsp spider venom, accidental, subs', 'http://dummyimage.com/111x127.jpg/dddddd/000000', '2017-10-30 03:54:04', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Jone Stebbings', 'jstebbings2c', 'L6UhR96tU9vm', '2017-06-11 10:48:37', 'jstebbings2c@auda.org.au', 'Peru', 'Estique', '3 East Street', 138803667, 'Transient synovitis, ankle and foot', 'http://dummyimage.com/223x115.jpg/dddddd/000000', '2017-05-03 09:14:20', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Marmaduke Sparwell', 'msparwell2d', 'PZXrnF0Gtc', '2018-02-11 04:23:07', 'msparwell2d@etsy.com', 'Afghanistan', 'Chahār Burj', '74 Bluejay Lane', 708118435, 'Varus deformity, not elsewhere classified, unspecified site', 'http://dummyimage.com/150x208.png/dddddd/000000', '2018-01-21 09:29:54', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Roanne Burdass', 'rburdass2e', 'SvSLjsEzZ4', '2017-10-24 02:55:06', 'rburdass2e@bloomberg.com', 'China', 'Zhoukou', '06 Dayton Center', 292094401, 'Fetal anemia and thrombocytopenia, first trimester, unsp', 'http://dummyimage.com/146x213.png/5fa2dd/ffffff', '2018-03-10 09:28:15', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Randene Grigorian', 'rgrigorian2f', 'tj332X', '2018-01-05 16:32:16', 'rgrigorian2f@cnet.com', 'Portugal', 'Quinta da Courela', '7558 Main Trail', 672441170, 'Abnlt in fetal heart rate and rhythm comp labor and delivery', 'http://dummyimage.com/193x229.jpg/5fa2dd/ffffff', '2017-07-22 01:46:46', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Cristen Brahms', 'cbrahms2g', 'JHue8pKYH', '2017-06-10 03:07:48', 'cbrahms2g@alibaba.com', 'Colombia', 'Acevedo', '25745 Starling Street', 802275453, 'Mild laceration of heart with hemopericardium, sequela', 'http://dummyimage.com/226x135.jpg/dddddd/000000', '2017-12-16 19:10:46', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Kippy Greste', 'kgreste2h', 'lyzZTlPNM', '2018-02-16 18:59:57', 'kgreste2h@ycombinator.com', 'Russia', 'Lysogorskaya', '809 Butterfield Point', 381681114, 'Contusion of unspecified little finger with damage to nail', 'http://dummyimage.com/181x111.png/5fa2dd/ffffff', '2017-11-26 15:43:36', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Seline Horsburgh', 'shorsburgh2i', 'XSI1iciWHspV', '2017-09-16 00:32:52', 'shorsburgh2i@stanford.edu', 'Japan', 'Kamigyō-ku', '2 Dawn Point', 811987213, 'Disloc of proximal interphaln joint of unsp finger, init', 'http://dummyimage.com/112x195.png/cc0000/ffffff', '2017-12-21 02:39:49', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Winfield Rohfsen', 'wrohfsen2j', 'csj9Bceq3yC', '2017-12-05 21:04:07', 'wrohfsen2j@domainmarket.com', 'Croatia', 'Čakovec', '9 Mcbride Park', 616873867, 'Burn of second degree of left toe(s) (nail), init encntr', 'http://dummyimage.com/172x107.bmp/cc0000/ffffff', '2017-11-25 20:05:22', true, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Simmonds Consterdine', 'sconsterdine2k', 'Ip1e56AhM7Cx', '2018-02-26 07:39:06', 'sconsterdine2k@illinois.edu', 'China', 'Beima', '11573 Meadow Ridge Park', 271264735, 'Vesicoureter-reflux w reflux nephropathy w/o hydrourt, unsp', 'http://dummyimage.com/141x111.bmp/5fa2dd/ffffff', '2017-11-17 01:19:37', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Filia Catford', 'fcatford2l', 'PZ2bmxYg', '2018-01-23 11:19:53', 'fcatford2l@disqus.com', 'Philippines', 'Bambang', '7766 Transport Hill', 750157415, 'Milt op involving unintentional restriction of air/airwy', 'http://dummyimage.com/248x119.jpg/ff4444/ffffff', '2017-06-30 12:19:23', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Nevins Dicky', 'ndicky2m', 'vGfIWaGh6g', '2017-09-28 00:02:51', 'ndicky2m@harvard.edu', 'United States', 'Atlanta', '9317 School Park', 580224684, 'Oth injury of intercostal blood vessels, right side', 'http://dummyimage.com/171x148.bmp/ff4444/ffffff', '2018-03-08 15:22:43', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Vince Bohlsen', 'vbohlsen2n', '8zBVSc4', '2017-09-26 16:14:37', 'vbohlsen2n@npr.org', 'Israel', 'Deir Ḥannā', '2255 Golf Course Street', 620313966, 'Listerial endocarditis', 'http://dummyimage.com/135x232.png/cc0000/ffffff', '2017-05-28 15:15:50', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Kermy Jeffress', 'kjeffress2o', 'yeSfgePjeW', '2017-11-12 09:30:55', 'kjeffress2o@sogou.com', 'China', 'Jinshanzui', '3609 Sheridan Crossing', 871570839, 'Strabismic amblyopia, bilateral', 'http://dummyimage.com/235x225.jpg/ff4444/ffffff', '2017-10-02 13:57:25', true, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Marsh Brook', 'mbrook2p', 'FZc5ZWJu8ir', '2017-10-08 13:35:07', 'mbrook2p@bbb.org', 'Indonesia', 'Samanggen', '7 David Court', 983688955, 'Displ commnt fx shaft of l femr, subs for clos fx w malunion', 'http://dummyimage.com/145x243.png/ff4444/ffffff', '2017-12-10 16:13:05', false, false);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Cari Hallut', 'challut2q', '97R4kgez2E', '2017-12-16 07:54:17', 'challut2q@blogspot.com', 'China', 'Yeliguan', '74011 Old Shore Junction', 112135776, 'Other secondary osteonecrosis, left femur', 'http://dummyimage.com/202x119.bmp/cc0000/ffffff', '2017-06-29 05:42:14', false, true);
insert into member (name, username, password, birthdate, email, country, city, address, taxpayernumber, about, profilepicture, registrationdate, verifiedemail, iswebsiteadmin) values ('Dana Olyfat', 'dolyfat2r', 'IKPK5JIGsaa8', '2017-04-26 17:29:42', 'dolyfat2r@homestead.com', 'North Korea', 'Changyŏn', '6536 Spaight Street', 146984129, 'Other superficial bite of unspecified foot, init encntr', 'http://dummyimage.com/239x180.bmp/dddddd/000000', '2017-12-01 06:55:19', false, false);

--
-- Data for Name: notification; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO notification VALUES ('2018-01-05 15:30:19', 'invite', 4, 5, 45, 39);
INSERT INTO notification VALUES ('2017-09-20 15:42:40', 'invite', 17, 6, 30, 50);
INSERT INTO notification VALUES ('2018-03-12 19:04:46', 'invite', 26, 68, 35, 30);
INSERT INTO notification VALUES ('2018-03-21 11:46:44', 'invite', 50, 9, 36, 16);
INSERT INTO notification VALUES ('2018-02-25 14:50:51', 'comment', 19, 60, 4, 12);
INSERT INTO notification VALUES ('2018-03-18 01:24:53', 'invite', 41, 63, 29, 26);
INSERT INTO notification VALUES ('2018-03-06 10:54:17', 'invite', 7, 64, 12, 19);
INSERT INTO notification VALUES ('2017-03-31 09:03:52', 'invite', 15, 89, 35, 23);
INSERT INTO notification VALUES ('2017-11-13 04:06:16', 'comment', 42, 16, 3, 17);
INSERT INTO notification VALUES ('2017-10-13 20:49:22', 'invite', 1, 44, 8, 21);
INSERT INTO notification VALUES ('2017-07-09 20:26:07', 'comment', 45, 51, 33, 26);
INSERT INTO notification VALUES ('2017-08-29 18:06:52', 'invite', 39, 39, 39, 16);
INSERT INTO notification VALUES ('2017-12-15 04:01:58', 'comment', 15, 56, 27, 44);
INSERT INTO notification VALUES ('2017-11-27 04:48:25', 'invite', 36, 89, 38, 43);
INSERT INTO notification VALUES ('2017-06-22 12:56:54', 'comment', 4, 98, 31, 10);
INSERT INTO notification VALUES ('2017-09-14 07:30:26', 'invite', 3, 40, 12, 5);
INSERT INTO notification VALUES ('2018-01-10 10:49:20', 'invite', 10, 4, 27, 41);
INSERT INTO notification VALUES ('2017-07-01 10:20:07', 'invite', 22, 41, 18, 19);
INSERT INTO notification VALUES ('2017-11-16 03:05:13', 'comment', 18, 35, 10, 28);
INSERT INTO notification VALUES ('2017-08-11 03:00:22', 'invite', 40, 69, 44, 2);
INSERT INTO notification VALUES ('2018-01-16 16:29:18', 'comment', 45, 51, 21, 21);
INSERT INTO notification VALUES ('2017-07-15 05:25:15', 'invite', 16, 91, 23, 11);
INSERT INTO notification VALUES ('2017-09-11 16:04:37', 'invite', 15, 26, 31, 36);
INSERT INTO notification VALUES ('2018-02-05 11:10:26', 'comment', 46, 8, 35, 40);
INSERT INTO notification VALUES ('2017-08-30 17:27:45', 'invite', 29, 9, 4, 48);
INSERT INTO notification VALUES ('2017-12-24 02:12:41', 'comment', 4, 41, 18, 45);
INSERT INTO notification VALUES ('2017-07-08 19:56:27', 'invite', 48, 84, 36, 34);
INSERT INTO notification VALUES ('2017-12-07 10:49:48', 'invite', 37, 1, 35, 49);
INSERT INTO notification VALUES ('2017-06-17 22:22:11', 'comment', 14, 87, 29, 8);
INSERT INTO notification VALUES ('2018-02-27 05:33:28', 'comment', 29, 26, 17, 12);
INSERT INTO notification VALUES ('2017-08-11 22:53:44', 'invite', 45, 1, 32, 1);
INSERT INTO notification VALUES ('2018-01-12 01:35:23', 'invite', 50, 17, 47, 1);
INSERT INTO notification VALUES ('2017-05-06 22:30:52', 'comment', 43, 15, 48, 13);
INSERT INTO notification VALUES ('2017-12-17 12:26:03', 'comment', 23, 15, 48, 30);
INSERT INTO notification VALUES ('2017-10-11 17:57:12', 'invite', 21, 19, 48, 42);
INSERT INTO notification VALUES ('2017-07-17 04:50:43', 'invite', 12, 19, 32, 40);
INSERT INTO notification VALUES ('2017-05-10 10:17:13', 'comment', 30, 24, 38, 26);
INSERT INTO notification VALUES ('2017-04-13 01:50:54', 'comment', 24, 20, 46, 2);
INSERT INTO notification VALUES ('2017-04-15 17:18:40', 'invite', 50, 66, 7, 2);
INSERT INTO notification VALUES ('2017-11-19 06:18:05', 'invite', 8, 91, 33, 21);
INSERT INTO notification VALUES ('2017-10-11 18:38:09', 'comment', 31, 8, 45, 19);
INSERT INTO notification VALUES ('2018-02-24 17:52:48', 'comment', 36, 58, 43, 18);
INSERT INTO notification VALUES ('2018-01-13 18:36:14', 'invite', 27, 95, 3, 6);
INSERT INTO notification VALUES ('2017-10-03 14:51:10', 'comment', 40, 7, 10, 42);
INSERT INTO notification VALUES ('2017-04-22 16:45:32', 'comment', 1, 47, 13, 3);
INSERT INTO notification VALUES ('2017-04-18 22:45:12', 'invite', 10, 18, 42, 42);
INSERT INTO notification VALUES ('2017-10-08 22:07:39', 'invite', 33, 2, 32, 8);
INSERT INTO notification VALUES ('2017-07-20 01:27:30', 'comment', 23, 95, 30, 4);
INSERT INTO notification VALUES ('2017-07-07 00:08:55', 'comment', 15, 69, 48, 45);
INSERT INTO notification VALUES ('2017-05-20 15:55:42', 'comment', 13, 93, 34, 27);
INSERT INTO notification VALUES ('2017-06-05 18:33:20', 'invite', 3, 67, 40, 3);
INSERT INTO notification VALUES ('2017-08-15 18:45:54', 'comment', 23, 13, 22, 5);
INSERT INTO notification VALUES ('2018-02-03 01:25:19', 'invite', 10, 81, 23, 31);
INSERT INTO notification VALUES ('2017-10-07 17:59:01', 'invite', 28, 11, 24, 10);
INSERT INTO notification VALUES ('2017-05-19 08:32:57', 'invite', 6, 38, 4, 46);
INSERT INTO notification VALUES ('2018-02-05 15:30:04', 'invite', 33, 85, 32, 33);
INSERT INTO notification VALUES ('2018-02-11 06:27:04', 'invite', 46, 66, 30, 10);
INSERT INTO notification VALUES ('2018-02-14 19:18:02', 'comment', 31, 67, 26, 40);
INSERT INTO notification VALUES ('2017-06-30 12:24:45', 'comment', 39, 31, 7, 20);
INSERT INTO notification VALUES ('2018-02-21 05:01:48', 'comment', 1, 91, 4, 44);
INSERT INTO notification VALUES ('2018-03-20 05:15:23', 'invite', 12, 60, 20, 8);
INSERT INTO notification VALUES ('2017-12-28 18:22:23', 'comment', 23, 95, 27, 13);
INSERT INTO notification VALUES ('2017-09-19 12:46:11', 'comment', 38, 73, 3, 2);
INSERT INTO notification VALUES ('2017-05-17 10:19:35', 'comment', 20, 49, 48, 41);
INSERT INTO notification VALUES ('2017-09-30 06:13:24', 'comment', 12, 29, 43, 15);
INSERT INTO notification VALUES ('2018-03-08 21:39:46', 'comment', 20, 3, 14, 22);
INSERT INTO notification VALUES ('2018-01-06 11:20:39', 'invite', 12, 64, 1, 33);
INSERT INTO notification VALUES ('2017-07-31 01:56:53', 'comment', 32, 67, 50, 36);
INSERT INTO notification VALUES ('2017-09-28 11:44:22', 'comment', 13, 70, 12, 11);
INSERT INTO notification VALUES ('2017-08-07 08:35:02', 'invite', 22, 6, 39, 20);
INSERT INTO notification VALUES ('2018-01-29 11:55:11', 'comment', 3, 71, 24, 14);
INSERT INTO notification VALUES ('2017-12-26 23:33:22', 'invite', 1, 98, 13, 30);
INSERT INTO notification VALUES ('2017-09-19 16:22:38', 'comment', 13, 26, 34, 48);
INSERT INTO notification VALUES ('2017-06-21 16:21:08', 'comment', 27, 48, 36, 13);
INSERT INTO notification VALUES ('2017-04-06 17:46:08', 'invite', 7, 28, 16, 17);
INSERT INTO notification VALUES ('2017-10-19 10:14:30', 'invite', 5, 33, 47, 18);
INSERT INTO notification VALUES ('2017-08-12 22:41:25', 'comment', 11, 90, 26, 40);
INSERT INTO notification VALUES ('2017-09-14 07:43:33', 'comment', 32, 3, 26, 48);
INSERT INTO notification VALUES ('2017-10-29 13:28:23', 'comment', 22, 16, 42, 32);
INSERT INTO notification VALUES ('2017-06-29 12:17:38', 'invite', 25, 6, 49, 5);
INSERT INTO notification VALUES ('2017-07-06 05:46:41', 'comment', 30, 44, 42, 50);
INSERT INTO notification VALUES ('2017-08-31 08:30:06', 'comment', 37, 42, 32, 19);
INSERT INTO notification VALUES ('2017-04-26 11:29:03', 'invite', 20, 85, 49, 7);
INSERT INTO notification VALUES ('2017-10-26 00:47:20', 'comment', 50, 8, 38, 2);
INSERT INTO notification VALUES ('2017-06-03 20:27:31', 'comment', 32, 6, 23, 19);
INSERT INTO notification VALUES ('2018-03-17 03:43:12', 'comment', 44, 30, 30, 21);
INSERT INTO notification VALUES ('2017-07-24 02:56:38', 'comment', 5, 3, 15, 33);
INSERT INTO notification VALUES ('2017-08-08 03:54:59', 'invite', 46, 51, 44, 38);
INSERT INTO notification VALUES ('2017-10-20 18:39:57', 'comment', 31, 49, 15, 36);
INSERT INTO notification VALUES ('2017-10-29 18:09:06', 'invite', 34, 63, 25, 8);
INSERT INTO notification VALUES ('2017-05-30 10:38:39', 'comment', 34, 96, 39, 35);
INSERT INTO notification VALUES ('2018-01-02 13:42:43', 'comment', 18, 54, 31, 15);
INSERT INTO notification VALUES ('2017-12-15 08:34:20', 'comment', 35, 20, 38, 33);
INSERT INTO notification VALUES ('2018-01-22 02:34:11', 'comment', 2, 88, 27, 49);
INSERT INTO notification VALUES ('2017-08-20 15:48:08', 'comment', 12, 43, 23, 15);
INSERT INTO notification VALUES ('2017-07-20 10:06:58', 'comment', 45, 21, 31, 29);
INSERT INTO notification VALUES ('2017-04-15 22:14:13', 'comment', 38, 29, 17, 30);
INSERT INTO notification VALUES ('2017-06-20 05:22:52', 'comment', 31, 54, 34, 35);
INSERT INTO notification VALUES ('2017-09-20 06:56:54', 'comment', 20, 88, 31, 6);
INSERT INTO notification VALUES ('2017-09-14 15:23:33', 'comment', 45, 59, 9, 36);


--
-- Data for Name: report; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO report VALUES ('2017-08-17 13:49:07', 'Malignant neoplasm of lower lip, inner aspect', 24, 77, 22, 45, true, 16);
INSERT INTO report VALUES ('2017-04-20 09:08:21', 'Poisoning by other topical agents, undetermined, subs encntr', 45, 86, 46, 33, false, 19);
INSERT INTO report VALUES ('2017-08-02 02:32:44', 'Disp fx of shaft of third metacarpal bone, right hand', 14, 98, 49, 11, true, 34);
INSERT INTO report VALUES ('2017-07-25 05:00:06', 'Toxic eff of venom of African and Asian snake, slf-hrm, subs', 20, 52, 36, 20, true, 16);
INSERT INTO report VALUES ('2017-12-15 13:47:19', 'Miscellaneous ophthalmic devices assoc w incdt, NEC', 18, 69, 24, 3, false, 36);
INSERT INTO report VALUES ('2018-02-12 05:43:42', 'Displ transverse fx unsp patella, 7thE', 21, 51, 4, 5, true, 33);
INSERT INTO report VALUES ('2017-09-22 21:20:28', 'Juvenile osteochondrosis of head of femur, right leg', 46, 100, 45, 22, false, 47);
INSERT INTO report VALUES ('2017-09-29 12:47:38', 'Other heart disorders in diseases classified elsewhere', 45, 95, 14, 21, false, 35);
INSERT INTO report VALUES ('2017-05-11 12:37:16', 'Preterm labor with preterm delivery, unsp trimester, fetus 4', 9, 64, 11, 18, true, 38);
INSERT INTO report VALUES ('2017-12-12 09:03:52', 'Colles'' fracture of unspecified radius', 9, 78, 42, 23, false, 23);
INSERT INTO report VALUES ('2018-01-26 04:32:50', 'Infections of cervix in pregnancy, second trimester', 43, 74, 33, 13, false, 37);
INSERT INTO report VALUES ('2017-05-19 11:03:11', 'Candidiasis of skin and nail', 14, 58, 40, 6, false, 7);
INSERT INTO report VALUES ('2018-02-08 19:10:50', 'Nontraumatic compartment syndrome of right upper extremity', 5, 73, 46, 32, false, 36);
INSERT INTO report VALUES ('2018-03-26 01:19:40', 'Other specified peripheral vascular diseases', 20, 80, 32, 48, false, 11);
INSERT INTO report VALUES ('2017-06-21 15:57:25', 'Unspecified child maltreatment, suspected, subs encntr', 9, 71, 8, 29, true, 5);
INSERT INTO report VALUES ('2018-01-04 13:25:03', 'Absence epileptic syndrome, intractable, w/o stat epi', 32, 54, 3, 16, false, 19);
INSERT INTO report VALUES ('2017-08-22 23:15:39', 'Drug/chem diab w prolif diab rtnop w trctn dtch macula, bi', 40, 91, 42, 35, true, 7);
INSERT INTO report VALUES ('2018-01-04 05:49:53', 'Nondisp fx of ant wall of l acetab, subs for fx w routn heal', 11, 100, 50, 3, true, 19);
INSERT INTO report VALUES ('2017-05-11 19:20:15', 'Pedl cyc driver inj in clsn w nonmtr vehicle in traf, sqla', 35, 85, 45, 26, true, 14);
INSERT INTO report VALUES ('2017-10-08 03:46:20', 'Torus fracture of lower end of right fibula', 33, 82, 2, 16, false, 5);
INSERT INTO report VALUES ('2017-12-16 15:55:04', 'Nondisp fx of coronoid pro of l ulna, 7thB', 20, 55, 45, 38, false, 38);
INSERT INTO report VALUES ('2017-04-29 22:43:43', 'Unspecified subluxation of right ring finger, subs encntr', 47, 94, 38, 13, false, 33);
INSERT INTO report VALUES ('2017-04-01 06:01:15', 'Breast engorgement of newborn', 31, 63, 9, 28, true, 18);
INSERT INTO report VALUES ('2017-10-15 02:23:59', 'Milt op involving fragments from munitions, milt, sequela', 31, 56, 39, 20, false, 31);
INSERT INTO report VALUES ('2017-06-28 17:55:00', 'Oth fracture of sacrum, subs for fx w delay heal', 13, 54, 7, 12, false, 36);
INSERT INTO report VALUES ('2017-09-27 19:56:12', 'Sltr-haris Type II physeal fx lower end of left tibia', 32, 66, 11, 43, true, 38);
INSERT INTO report VALUES ('2017-07-28 04:29:49', 'Peripheral T-cell lymphoma, not classified, nodes mult site', 19, 94, 28, 48, false, 35);
INSERT INTO report VALUES ('2017-06-14 03:31:12', 'Nondisplaced segmental fracture of shaft of ulna, left arm', 30, 73, 17, 49, true, 46);
INSERT INTO report VALUES ('2018-02-08 03:01:14', 'Person outside bus inj in clsn w 2/3-whl mv nontraf, subs', 48, 86, 13, 44, false, 43);
INSERT INTO report VALUES ('2018-02-17 11:18:50', 'Burn of 2nd deg mul sites of unsp wrist and hand, sequela', 43, 50, 46, 39, true, 23);
INSERT INTO report VALUES ('2018-02-05 14:42:30', 'Other superficial bite of unspecified wrist, sequela', 32, 91, 40, 17, false, 26);
INSERT INTO report VALUES ('2017-08-03 23:03:06', 'Fracture of lateral end of clavicle', 15, 67, 48, 21, false, 42);
INSERT INTO report VALUES ('2018-01-05 01:32:25', 'Open bite, unspecified thigh', 32, 83, 33, 25, true, 21);
INSERT INTO report VALUES ('2017-07-06 22:41:11', 'Fatigue fx vertebra, thor region, subs for fx w routn heal', 35, 88, 17, 8, true, 10);
INSERT INTO report VALUES ('2017-05-31 07:43:04', 'Other specified osteochondropathies, right thigh', 35, 79, 15, 30, false, 28);
INSERT INTO report VALUES ('2017-06-23 01:56:33', 'Infect/inflm reaction due to prosth dev/grft in urinry sys', 16, 75, 35, 22, false, 39);
INSERT INTO report VALUES ('2018-03-20 20:46:34', 'Nondisp bicondylar fx l tibia, 7thM', 38, 85, 37, 13, false, 21);
INSERT INTO report VALUES ('2017-09-26 01:01:33', 'Nondisp Maisonneuve''s fx l leg, 7thN', 30, 89, 1, 20, false, 8);
INSERT INTO report VALUES ('2017-12-13 11:16:06', 'Monoamine-oxidase-inhibitor antidepressants', 50, 77, 34, 19, true, 9);
INSERT INTO report VALUES ('2018-01-23 20:06:24', 'Balanced rearrangements and structural markers, NEC', 1, 58, 43, 39, false, 13);
INSERT INTO report VALUES ('2017-08-10 18:48:37', 'Diagnostic and monitoring orthopedic devices assoc w incdt', 27, 65, 40, 4, true, 50);
INSERT INTO report VALUES ('2017-12-30 14:08:58', 'Villonodular synovitis (pigmented), hand', 15, 51, 46, 22, false, 23);
INSERT INTO report VALUES ('2017-07-20 06:16:54', 'Laceration of rectum, subsequent encounter', 28, 66, 9, 39, false, 8);
INSERT INTO report VALUES ('2017-10-08 10:23:34', 'Unsp inj flexor musc/fasc/tend at forarm lv, right arm, init', 13, 67, 13, 41, true, 21);
INSERT INTO report VALUES ('2017-11-24 14:07:15', 'Oth extrartic fx low end l rad, 7thG', 14, 86, 50, 1, false, 13);
INSERT INTO report VALUES ('2018-01-22 10:46:17', 'Cutaneous and mucocutaneous bartonellosis', 47, 72, 49, 27, false, 28);
INSERT INTO report VALUES ('2018-02-08 16:55:00', 'Other shellfish poisoning, assault, sequela', 33, 95, 14, 42, false, 36);
INSERT INTO report VALUES ('2017-04-20 15:49:28', 'Toxic liver disease with acute hepatitis', 44, 99, 3, 19, true, 50);
INSERT INTO report VALUES ('2017-12-02 22:58:41', 'Nondisp commnt suprcndl fx w/o intrcndl fx l humer, 7thD', 7, 73, 18, 16, true, 28);
INSERT INTO report VALUES ('2018-02-16 12:30:24', 'Suprvsn of preg w poor reprodctv or obstet history, unsp tri', 39, 71, 26, 18, true, 37);
INSERT INTO report VALUES ('2017-05-12 18:24:16', 'Traumatic metacarpophalangeal amputation of thumb', 48, 88, 17, 47, true, 23);
INSERT INTO report VALUES ('2017-04-25 03:48:04', 'Nondisp oblique fx shaft of r rad, 7thG', 13, 68, 41, 18, true, 17);
INSERT INTO report VALUES ('2017-12-12 12:25:11', 'Poisn by oth agents prim act on the resp sys, slf-hrm, subs', 24, 78, 48, 34, false, 2);
INSERT INTO report VALUES ('2017-05-22 19:50:51', 'Oth injury of muscle, fascia and tendon of right hip', 45, 100, 25, 4, true, 26);
INSERT INTO report VALUES ('2018-01-30 18:03:26', 'Other hypertrichosis', 18, 50, 37, 14, true, 15);
INSERT INTO report VALUES ('2017-11-27 17:00:53', 'Parasitic endophthalmitis, unspecified, unspecified eye', 49, 59, 27, 13, false, 12);
INSERT INTO report VALUES ('2018-02-15 05:01:27', 'Superficial frostbite of unspecified hand', 19, 68, 22, 4, true, 23);
INSERT INTO report VALUES ('2017-11-30 09:39:37', 'Lacerat intrinsic musc/fasc/tend r thm at wrs/hnd lv, init', 6, 68, 9, 11, true, 26);
INSERT INTO report VALUES ('2018-01-18 14:02:34', 'Unsp glider (nonpowered) accident injuring occupant, init', 17, 71, 20, 19, false, 18);
INSERT INTO report VALUES ('2017-12-05 18:34:01', 'Intentional self-harm by unsp hot objects, init encntr', 5, 78, 9, 18, true, 2);
INSERT INTO report VALUES ('2018-03-11 03:53:20', 'Burn of third degree of right forearm, initial encounter', 12, 63, 9, 13, false, 43);
INSERT INTO report VALUES ('2018-03-01 21:40:57', 'Traum rupt of volar plate of r idx fngr at MCP/IP jt, sqla', 23, 71, 19, 9, true, 25);
INSERT INTO report VALUES ('2018-03-13 03:46:23', 'Sezary disease', 45, 75, 16, 18, false, 11);
INSERT INTO report VALUES ('2017-04-29 00:46:33', 'Nondisp intertroch fx l femr, 7thJ', 29, 89, 36, 14, false, 46);
INSERT INTO report VALUES ('2017-09-07 15:29:27', 'Acquired stenosis of r ext ear canal secondary to trauma', 38, 78, 22, 45, true, 19);
INSERT INTO report VALUES ('2017-12-24 23:57:02', 'Crushing injury of left index finger, subsequent encounter', 45, 82, 36, 6, false, 26);
INSERT INTO report VALUES ('2017-04-11 06:04:03', 'Inj unsp musc/fasc/tend at thigh level, left thigh, subs', 31, 98, 10, 6, true, 18);
INSERT INTO report VALUES ('2017-07-10 19:40:34', 'Unsp fx low end unsp tibia, 7thQ', 2, 87, 20, 18, true, 28);
INSERT INTO report VALUES ('2017-08-02 06:33:48', 'Exposure to other inanimate mechanical forces, sequela', 30, 74, 15, 1, false, 34);
INSERT INTO report VALUES ('2018-01-11 12:07:49', 'Other acquired abnormalities of left ear ossicles', 34, 99, 32, 25, true, 9);
INSERT INTO report VALUES ('2017-09-27 02:56:19', 'Displ longitud fx right patella, subs for clos fx w nonunion', 15, 83, 24, 1, false, 9);
INSERT INTO report VALUES ('2017-06-05 22:35:29', 'Corrosion of respiratory tract, part unspecified', 10, 74, 42, 2, false, 45);
INSERT INTO report VALUES ('2018-01-26 01:35:43', 'Partial traumatic amputation of unsp great toe, init encntr', 14, 63, 24, 2, false, 47);
INSERT INTO report VALUES ('2018-02-15 10:59:55', 'Alcohol abuse with alcohol-induced anxiety disorder', 14, 63, 17, 7, true, 28);
INSERT INTO report VALUES ('2017-04-07 20:16:53', 'Jumping or diving from boat striking bottom causing drown', 9, 78, 30, 13, false, 32);
INSERT INTO report VALUES ('2017-05-22 21:41:53', 'Maternal care for high head at term, fetus 2', 34, 59, 12, 27, true, 16);
INSERT INTO report VALUES ('2017-04-17 21:41:18', 'Chronic neph syndrome w diffuse endocaplry prolif glomrlneph', 5, 75, 47, 45, true, 9);
INSERT INTO report VALUES ('2017-06-02 00:48:47', 'War op w explosn due to acc disch of own munit, milt, sqla', 45, 90, 30, 24, true, 14);
INSERT INTO report VALUES ('2017-10-20 02:27:49', 'Oth disord of continuity of bone, right pelv rgn and thigh', 8, 92, 7, 12, false, 31);
INSERT INTO report VALUES ('2018-01-27 13:05:14', 'Unsp car occupant injured in collision w ped/anml nontraf', 4, 88, 36, 41, true, 48);
INSERT INTO report VALUES ('2017-09-25 07:04:10', 'Arthritis due to other bacteria, unspecified hip', 1, 88, 20, 34, false, 34);
INSERT INTO report VALUES ('2017-08-20 23:24:42', 'Unspecified focal chorioretinal inflammation, left eye', 36, 85, 16, 29, true, 2);
INSERT INTO report VALUES ('2017-05-16 19:17:42', 'Prsn brd/alit hv veh injured in nonclsn trnsp acc, sequela', 24, 65, 10, 49, true, 18);
INSERT INTO report VALUES ('2017-04-05 12:23:40', 'Pigmentary glaucoma, left eye, moderate stage', 10, 97, 4, 3, false, 4);
INSERT INTO report VALUES ('2017-12-06 18:48:33', 'Unsp symptoms and signs w cognitive functions and awareness', 49, 96, 21, 46, false, 19);
INSERT INTO report VALUES ('2017-03-28 21:43:27', 'Ankylosis, right foot', 31, 82, 10, 39, false, 48);
INSERT INTO report VALUES ('2018-03-13 06:04:50', 'Unspecified open wound of right hand', 36, 96, 3, 25, false, 37);
INSERT INTO report VALUES ('2017-09-09 16:56:52', 'Mtrcy passenger injured in clsn w pedl cyc in traf, sequela', 10, 75, 27, 26, false, 46);
INSERT INTO report VALUES ('2017-05-14 22:51:29', 'Traum hemor left cerebrum w LOC of 1-5 hrs 59 minutes, init', 42, 58, 13, 40, true, 7);
INSERT INTO report VALUES ('2017-11-08 17:28:05', 'Zoster with other nervous system involvement', 17, 72, 3, 28, true, 36);
INSERT INTO report VALUES ('2017-12-23 02:15:31', 'Matern care for oth or susp poor fetl grth, third tri, fts3', 50, 79, 32, 16, false, 21);
INSERT INTO report VALUES ('2018-02-07 09:16:30', 'Anesthesia and hypoesthesia of cornea', 47, 84, 21, 8, false, 5);
INSERT INTO report VALUES ('2017-07-19 03:26:58', 'Anaphylactic shock, unspecified, sequela', 14, 88, 20, 44, false, 28);
INSERT INTO report VALUES ('2017-03-29 21:55:38', 'Derang of ant horn of lat mensc due to old tear/inj, r knee', 45, 71, 38, 25, false, 34);
INSERT INTO report VALUES ('2017-06-01 05:20:57', 'Strain of musc/tend peroneal grp at low leg level, left leg', 7, 85, 34, 38, true, 42);
INSERT INTO report VALUES ('2017-12-02 11:45:17', 'Unsp fx shaft of r tibia, 7thQ', 26, 99, 43, 20, true, 24);
INSERT INTO report VALUES ('2018-01-06 10:45:43', 'Unsp fx second MC bone, right hand, subs for fx w malunion', 38, 93, 28, 2, false, 6);
INSERT INTO report VALUES ('2017-11-07 21:06:56', 'Open bite of left index finger with damage to nail, sequela', 45, 59, 47, 37, false, 2);
INSERT INTO report VALUES ('2017-10-12 13:12:36', 'Parasitic cyst of iris, ciliary body or anterior chamber', 18, 62, 48, 41, true, 22);
INSERT INTO report VALUES ('2017-05-24 06:00:54', 'Unsp inj musc/tend post grp at low leg level, unsp leg, sqla', 45, 85, 46, 37, false, 42);


--
-- Data for Name: ticket; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO ticket VALUES (101, 1, 5, 101);
INSERT INTO ticket VALUES (1, 32, 76, 96);
INSERT INTO ticket VALUES (2, 40, 38, 68);
INSERT INTO ticket VALUES (3, 5, 67, 12);
INSERT INTO ticket VALUES (4, 45, 86, 53);
INSERT INTO ticket VALUES (5, 23, 69, 7);
INSERT INTO ticket VALUES (6, 47, 25, 83);
INSERT INTO ticket VALUES (7, 26, 20, 60);
INSERT INTO ticket VALUES (8, 3, 52, 29);
INSERT INTO ticket VALUES (9, 5, 88, 36);
INSERT INTO ticket VALUES (10, 19, 95, 35);
INSERT INTO ticket VALUES (11, 14, 16, 6);
INSERT INTO ticket VALUES (12, 34, 60, 31);
INSERT INTO ticket VALUES (14, 25, 18, 58);
INSERT INTO ticket VALUES (15, 44, 26, 3);
INSERT INTO ticket VALUES (16, 3, 9, 39);
INSERT INTO ticket VALUES (17, 16, 95, 55);
INSERT INTO ticket VALUES (18, 40, 67, 39);
INSERT INTO ticket VALUES (20, 19, 2, 20);
INSERT INTO ticket VALUES (21, 36, 20, 43);
INSERT INTO ticket VALUES (22, 24, 73, 53);
INSERT INTO ticket VALUES (23, 3, 18, 50);
INSERT INTO ticket VALUES (24, 32, 27, 37);
INSERT INTO ticket VALUES (25, 19, 12, 72);
INSERT INTO ticket VALUES (27, 44, 14, 65);
INSERT INTO ticket VALUES (28, 36, 23, 22);
INSERT INTO ticket VALUES (29, 12, 27, 65);
INSERT INTO ticket VALUES (30, 23, 100, 63);
INSERT INTO ticket VALUES (31, 35, 15, 73);
INSERT INTO ticket VALUES (32, 24, 76, 52);
INSERT INTO ticket VALUES (33, 47, 90, 5);
INSERT INTO ticket VALUES (34, 29, 79, 50);
INSERT INTO ticket VALUES (35, 49, 30, 34);
INSERT INTO ticket VALUES (36, 49, 18, 11);
INSERT INTO ticket VALUES (37, 44, 42, 22);
INSERT INTO ticket VALUES (38, 42, 1, 81);
INSERT INTO ticket VALUES (39, 6, 64, 40);
INSERT INTO ticket VALUES (40, 48, 53, 15);
INSERT INTO ticket VALUES (41, 25, 86, 54);
INSERT INTO ticket VALUES (42, 43, 68, 76);
INSERT INTO ticket VALUES (43, 5, 49, 35);
INSERT INTO ticket VALUES (44, 14, 68, 28);
INSERT INTO ticket VALUES (45, 27, 33, 11);
INSERT INTO ticket VALUES (47, 28, 84, 46);
INSERT INTO ticket VALUES (48, 39, 33, 46);
INSERT INTO ticket VALUES (49, 28, 71, 75);
INSERT INTO ticket VALUES (50, 23, 33, 38);
INSERT INTO ticket VALUES (51, 12, 96, 1);
INSERT INTO ticket VALUES (52, 8, 84, 80);
INSERT INTO ticket VALUES (53, 27, 14, 52);
INSERT INTO ticket VALUES (54, 31, 91, 60);
INSERT INTO ticket VALUES (55, 21, 54, 67);
INSERT INTO ticket VALUES (56, 1, 60, 29);
INSERT INTO ticket VALUES (57, 41, 84, 96);
INSERT INTO ticket VALUES (58, 6, 67, 94);
INSERT INTO ticket VALUES (59, 30, 73, 20);
INSERT INTO ticket VALUES (60, 38, 16, 86);
INSERT INTO ticket VALUES (61, 45, 14, 20);
INSERT INTO ticket VALUES (62, 21, 65, 41);
INSERT INTO ticket VALUES (63, 31, 2, 79);
INSERT INTO ticket VALUES (64, 43, 95, 80);
INSERT INTO ticket VALUES (65, 2, 50, 28);
INSERT INTO ticket VALUES (66, 44, 52, 18);
INSERT INTO ticket VALUES (67, 28, 76, 95);
INSERT INTO ticket VALUES (68, 40, 62, 20);
INSERT INTO ticket VALUES (69, 23, 27, 22);
INSERT INTO ticket VALUES (70, 12, 73, 37);
INSERT INTO ticket VALUES (71, 37, 52, 93);
INSERT INTO ticket VALUES (72, 4, 78, 43);
INSERT INTO ticket VALUES (73, 45, 94, 59);
INSERT INTO ticket VALUES (74, 29, 18, 99);
INSERT INTO ticket VALUES (75, 48, 62, 77);
INSERT INTO ticket VALUES (76, 12, 3, 5);
INSERT INTO ticket VALUES (77, 31, 9, 77);
INSERT INTO ticket VALUES (78, 14, 50, 38);
INSERT INTO ticket VALUES (79, 38, 17, 26);
INSERT INTO ticket VALUES (80, 22, 82, 3);
INSERT INTO ticket VALUES (81, 45, 41, 28);
INSERT INTO ticket VALUES (82, 23, 45, 60);
INSERT INTO ticket VALUES (83, 47, 9, 94);
INSERT INTO ticket VALUES (84, 27, 55, 71);
INSERT INTO ticket VALUES (85, 45, 57, 66);
INSERT INTO ticket VALUES (86, 49, 40, 14);
INSERT INTO ticket VALUES (87, 1, 48, 60);
INSERT INTO ticket VALUES (88, 41, 43, 75);
INSERT INTO ticket VALUES (89, 13, 81, 91);
INSERT INTO ticket VALUES (90, 3, 68, 66);
INSERT INTO ticket VALUES (92, 30, 60, 67);
INSERT INTO ticket VALUES (93, 47, 41, 75);
INSERT INTO ticket VALUES (94, 36, 70, 94);
INSERT INTO ticket VALUES (95, 40, 26, 6);
INSERT INTO ticket VALUES (96, 49, 63, 80);
INSERT INTO ticket VALUES (98, 25, 58, 49);
INSERT INTO ticket VALUES (99, 6, 22, 91);
INSERT INTO ticket VALUES (100, 31, 23, 64);


--
-- Data for Name: tickettype; Type: TABLE DATA; Schema: lbaw1714; Owner: lbaw1714
--

INSERT INTO tickettype VALUES (3, 87.6899999999999977, 5205, 4039, 'Diabetes due to underlying condition w oth diabetic arthrop', 43);
INSERT INTO tickettype VALUES (3, 62.8100000000000023, 3404, 1967, 'Congenital absence of hand and finger', 8);
INSERT INTO tickettype VALUES (2, 90.4699999999999989, 4647, 4606, 'Dvrtclos of intest, part unsp, w/o perf or abscess w bleed', 41);
INSERT INTO tickettype VALUES (3, 76.4099999999999966, 1946, 9640, 'Displ commnt fx shaft of l femr, 7thQ', 40);
INSERT INTO tickettype VALUES (1, 70.6599999999999966, 7136, 8990, 'Nondisp spiral fx shaft of ulna, r arm, 7thJ', 23);
INSERT INTO tickettype VALUES (3, 41.5399999999999991, 6010, 3279, 'Lens-induced iridocyclitis, right eye', 30);
INSERT INTO tickettype VALUES (1, 38.8200000000000003, 2769, 9662, 'Unsp mtrcy rider injured in collision w 2/3-whl mv in traf', 5);
INSERT INTO tickettype VALUES (3, 42.7800000000000011, 581, 110, 'Microscopic polyangiitis', 6);
INSERT INTO tickettype VALUES (3, 28.2899999999999991, 719, 6264, 'Nondisp fx of nk of 4th MC bone, l hand, 7thP', 4);
INSERT INTO tickettype VALUES (1, 48.6799999999999997, 4378, 5045, 'Displ spiral fx shaft of ulna, l arm, 7thM', 19);
INSERT INTO tickettype VALUES (1, 20.9200000000000017, 8605, 965, 'Unsp fx upr end r tibia, subs for opn fx type I/2 w nonunion', 50);
INSERT INTO tickettype VALUES (3, 32.1400000000000006, 4461, 4011, 'Tinnitus, bilateral', 29);
INSERT INTO tickettype VALUES (1, 63.9399999999999977, 925, 9562, 'Legal intervention involving injury by dynamite', 46);
INSERT INTO tickettype VALUES (3, 78.6299999999999955, 605, 5208, 'Benign neoplasm of pituitary gland', 39);
INSERT INTO tickettype VALUES (3, 84.519999999999996, 1552, 7307, 'Atrophic nonflaccid tympanic membrane, unspecified ear', 40);
INSERT INTO tickettype VALUES (2, 1.34000000000000008, 3396, 1872, 'Epidural hemorrhage w LOC of 1-5 hrs 59 min, init', 26);
INSERT INTO tickettype VALUES (3, 10.8800000000000008, 8285, 2471, 'Nondisplaced fracture of greater tuberosity of right humerus', 26);
INSERT INTO tickettype VALUES (2, 52.8500000000000014, 1894, 1356, 'Nondisp fx of r tibial tuberosity, 7thC', 10);
INSERT INTO tickettype VALUES (3, 1.44999999999999996, 7613, 8249, 'Unsp inj blood vessels at ank/ft level, right leg, sequela', 17);
INSERT INTO tickettype VALUES (3, 75.7399999999999949, 9859, 8221, 'Adverse effect of other drugs acting on muscles, init encntr', 46);
INSERT INTO tickettype VALUES (3, 58.7700000000000031, 6476, 2147, 'Displ seg fx shaft of r fibula, 7thR', 12);
INSERT INTO tickettype VALUES (3, 2.16999999999999993, 9201, 1768, 'Posterior subluxation of unsp ulnohumeral joint, sequela', 43);
INSERT INTO tickettype VALUES (3, 79.8900000000000006, 5031, 5475, 'Displaced unsp fracture of left great toe, init for opn fx', 16);
INSERT INTO tickettype VALUES (3, 26.4600000000000009, 3705, 3911, 'Gen skin eruption due to drugs and meds taken internally', 41);
INSERT INTO tickettype VALUES (1, 48.6499999999999986, 2672, 2218, 'Unspecified anomaly of jaw size', 10);
INSERT INTO tickettype VALUES (3, 94.7800000000000011, 1019, 4047, 'Enteropathic arthropathies, unspecified elbow', 7);
INSERT INTO tickettype VALUES (1, 17.8200000000000003, 4313, 9629, 'Oth private fix-wing arcrft explosn inj occupant, sequela', 45);
INSERT INTO tickettype VALUES (2, 91.4599999999999937, 9534, 5792, 'Corrosion of first degree of toe(s) (nail)', 44);
INSERT INTO tickettype VALUES (1, 25.0700000000000003, 6185, 6174, 'Contusion of left upper arm', 36);
INSERT INTO tickettype VALUES (1, 31.3599999999999994, 3525, 3020, 'Laceration with foreign body of unsp upper arm, subs encntr', 9);
INSERT INTO tickettype VALUES (2, 65.0499999999999972, 9410, 2374, 'Unsp pedl cyclst injured in nonclsn trnsp acc in traf, init', 46);
INSERT INTO tickettype VALUES (1, 7.51999999999999957, 6981, 593, 'Pnctr w fb of abd wall, epigst rgn w penet perit cav, init', 30);
INSERT INTO tickettype VALUES (1, 85.9300000000000068, 7760, 1876, 'High risk sexual behavior', 26);
INSERT INTO tickettype VALUES (2, 77.8900000000000006, 5046, 6224, 'Other osteonecrosis, unspecified toe(s)', 49);
INSERT INTO tickettype VALUES (2, 27.9899999999999984, 8360, 4504, 'Blister (nonthermal) of unspecified wrist, initial encounter', 21);
INSERT INTO tickettype VALUES (1, 63.9399999999999977, 9226, 8192, 'Squamous blepharitis left lower eyelid', 49);
INSERT INTO tickettype VALUES (3, 96.5100000000000051, 8626, 4451, 'Nondisp fx of triquetrum bone, right wrist, init for clos fx', 25);
INSERT INTO tickettype VALUES (1, 88.1800000000000068, 6602, 453, 'Poisn by unsp sys anti-infect and antiparastc, undet, sqla', 40);
INSERT INTO tickettype VALUES (3, 67.3400000000000034, 2166, 7285, 'Unspecified subluxation of other finger, initial encounter', 18);
INSERT INTO tickettype VALUES (3, 73.9500000000000028, 8014, 2222, 'Diverticulitis of large intestine w perforation and abscess', 30);
INSERT INTO tickettype VALUES (3, 59.0700000000000003, 4244, 8343, 'Elev erythro sedim and abnormality of plasma viscosity', 3);
INSERT INTO tickettype VALUES (3, 53.2999999999999972, 5805, 980, 'Fall from non-moving nonmotorized scooter, sequela', 30);
INSERT INTO tickettype VALUES (2, 96.1800000000000068, 5785, 5043, 'Other and unspecified nontraumatic intracranial hemorrhage', 20);
INSERT INTO tickettype VALUES (2, 70.2199999999999989, 7527, 148, 'Thrombotic microangiopathy', 13);
INSERT INTO tickettype VALUES (1, 31.3399999999999999, 9455, 5616, 'Inj muscle, fascia and tendon of unsp hip, init encntr', 27);
INSERT INTO tickettype VALUES (3, 57.7700000000000031, 4803, 2854, 'Laceration with foreign body, unspecified ankle, sequela', 5);
INSERT INTO tickettype VALUES (3, 64.2099999999999937, 4778, 219, 'Perf due to fb acc left in body following endo exam, init', 36);
INSERT INTO tickettype VALUES (3, 59.9699999999999989, 2201, 3013, 'Unspecified dacryocystitis of right lacrimal passage', 5);
INSERT INTO tickettype VALUES (1, 76.3499999999999943, 1504, 4349, 'Fat embolism (traumatic), sequela', 14);


INSERT INTO tickettype VALUES (3, 87.6899999999999977, 5205, 4039, 'Diabetes due to underlying condition w oth diabetic arthrop', 43);
INSERT INTO tickettype VALUES (3, 62.8100000000000023, 3404, 1967, 'Congenital absence of hand and finger', 8);
INSERT INTO tickettype VALUES (2, 90.4699999999999989, 4647, 4606, 'Dvrtclos of intest, part unsp, w/o perf or abscess w bleed', 41);
INSERT INTO tickettype VALUES (3, 76.4099999999999966, 1946, 9640, 'Displ commnt fx shaft of l femr, 7thQ', 40);
INSERT INTO tickettype VALUES (1, 70.6599999999999966, 7136, 8990, 'Nondisp spiral fx shaft of ulna, r arm, 7thJ', 23);
INSERT INTO tickettype VALUES (3, 41.5399999999999991, 6010, 3279, 'Lens-induced iridocyclitis, right eye', 30);
INSERT INTO tickettype VALUES (1, 38.8200000000000003, 2769, 9662, 'Unsp mtrcy rider injured in collision w 2/3-whl mv in traf', 5);
INSERT INTO tickettype VALUES (3, 42.7800000000000011, 581, 110, 'Microscopic polyangiitis', 6);
INSERT INTO tickettype VALUES (3, 28.2899999999999991, 719, 6264, 'Nondisp fx of nk of 4th MC bone, l hand, 7thP', 4);
INSERT INTO tickettype VALUES (1, 48.6799999999999997, 4378, 5045, 'Displ spiral fx shaft of ulna, l arm, 7thM', 19);
INSERT INTO tickettype VALUES (1, 20.9200000000000017, 8605, 965, 'Unsp fx upr end r tibia, subs for opn fx type I/2 w nonunion', 50);
INSERT INTO tickettype VALUES (3, 32.1400000000000006, 4461, 4011, 'Tinnitus, bilateral', 29);
INSERT INTO tickettype VALUES (1, 63.9399999999999977, 925, 9562, 'Legal intervention involving injury by dynamite', 46);
INSERT INTO tickettype VALUES (3, 78.6299999999999955, 605, 5208, 'Benign neoplasm of pituitary gland', 39);
INSERT INTO tickettype VALUES (3, 84.519999999999996, 1552, 7307, 'Atrophic nonflaccid tympanic membrane, unspecified ear', 40);
INSERT INTO tickettype VALUES (2, 1.34000000000000008, 3396, 1872, 'Epidural hemorrhage w LOC of 1-5 hrs 59 min, init', 26);
INSERT INTO tickettype VALUES (3, 10.8800000000000008, 8285, 2471, 'Nondisplaced fracture of greater tuberosity of right humerus', 26);
INSERT INTO tickettype VALUES (2, 52.8500000000000014, 1894, 1356, 'Nondisp fx of r tibial tuberosity, 7thC', 10);
INSERT INTO tickettype VALUES (3, 1.44999999999999996, 7613, 8249, 'Unsp inj blood vessels at ank/ft level, right leg, sequela', 17);
INSERT INTO tickettype VALUES (3, 75.7399999999999949, 9859, 8221, 'Adverse effect of other drugs acting on muscles, init encntr', 46);
INSERT INTO tickettype VALUES (3, 58.7700000000000031, 6476, 2147, 'Displ seg fx shaft of r fibula, 7thR', 12);
INSERT INTO tickettype VALUES (3, 2.16999999999999993, 9201, 1768, 'Posterior subluxation of unsp ulnohumeral joint, sequela', 43);
INSERT INTO tickettype VALUES (3, 79.8900000000000006, 5031, 5475, 'Displaced unsp fracture of left great toe, init for opn fx', 16);
INSERT INTO tickettype VALUES (3, 26.4600000000000009, 3705, 3911, 'Gen skin eruption due to drugs and meds taken internally', 41);
INSERT INTO tickettype VALUES (1, 48.6499999999999986, 2672, 2218, 'Unspecified anomaly of jaw size', 10);
INSERT INTO tickettype VALUES (3, 94.7800000000000011, 1019, 4047, 'Enteropathic arthropathies, unspecified elbow', 7);
INSERT INTO tickettype VALUES (1, 17.8200000000000003, 4313, 9629, 'Oth private fix-wing arcrft explosn inj occupant, sequela', 45);
INSERT INTO tickettype VALUES (2, 91.4599999999999937, 9534, 5792, 'Corrosion of first degree of toe(s) (nail)', 44);
INSERT INTO tickettype VALUES (1, 25.0700000000000003, 6185, 6174, 'Contusion of left upper arm', 36);
INSERT INTO tickettype VALUES (1, 31.3599999999999994, 3525, 3020, 'Laceration with foreign body of unsp upper arm, subs encntr', 9);
INSERT INTO tickettype VALUES (2, 65.0499999999999972, 9410, 2374, 'Unsp pedl cyclst injured in nonclsn trnsp acc in traf, init', 46);
INSERT INTO tickettype VALUES (1, 7.51999999999999957, 6981, 593, 'Pnctr w fb of abd wall, epigst rgn w penet perit cav, init', 30);
INSERT INTO tickettype VALUES (1, 85.9300000000000068, 7760, 1876, 'High risk sexual behavior', 26);
INSERT INTO tickettype VALUES (2, 77.8900000000000006, 5046, 6224, 'Other osteonecrosis, unspecified toe(s)', 49);
INSERT INTO tickettype VALUES (2, 27.9899999999999984, 8360, 4504, 'Blister (nonthermal) of unspecified wrist, initial encounter', 21);
INSERT INTO tickettype VALUES (1, 63.9399999999999977, 9226, 8192, 'Squamous blepharitis left lower eyelid', 49);
INSERT INTO tickettype VALUES (3, 96.5100000000000051, 8626, 4451, 'Nondisp fx of triquetrum bone, right wrist, init for clos fx', 25);
INSERT INTO tickettype VALUES (1, 88.1800000000000068, 6602, 453, 'Poisn by unsp sys anti-infect and antiparastc, undet, sqla', 40);
INSERT INTO tickettype VALUES (3, 67.3400000000000034, 2166, 7285, 'Unspecified subluxation of other finger, initial encounter', 18);
INSERT INTO tickettype VALUES (3, 73.9500000000000028, 8014, 2222, 'Diverticulitis of large intestine w perforation and abscess', 30);
INSERT INTO tickettype VALUES (3, 59.0700000000000003, 4244, 8343, 'Elev erythro sedim and abnormality of plasma viscosity', 3);
INSERT INTO tickettype VALUES (3, 53.2999999999999972, 5805, 980, 'Fall from non-moving nonmotorized scooter, sequela', 30);
INSERT INTO tickettype VALUES (2, 96.1800000000000068, 5785, 5043, 'Other and unspecified nontraumatic intracranial hemorrhage', 20);
INSERT INTO tickettype VALUES (2, 70.2199999999999989, 7527, 148, 'Thrombotic microangiopathy', 13);
INSERT INTO tickettype VALUES (1, 31.3399999999999999, 9455, 5616, 'Inj muscle, fascia and tendon of unsp hip, init encntr', 27);
INSERT INTO tickettype VALUES (3, 57.7700000000000031, 4803, 2854, 'Laceration with foreign body, unspecified ankle, sequela', 5);
INSERT INTO tickettype VALUES (3, 64.2099999999999937, 4778, 219, 'Perf due to fb acc left in body following endo exam, init', 36);
INSERT INTO tickettype VALUES (3, 59.9699999999999989, 2201, 3013, 'Unspecified dacryocystitis of right lacrimal passage', 5);
INSERT INTO tickettype VALUES (1, 76.3499999999999943, 1504, 4349, 'Fat embolism (traumatic), sequela', 14);


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
    ADD CONSTRAINT fk_comment FOREIGN KEY (comment) REFERENCES comment(idcomment);


--
-- Name: fk_comment; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_comment FOREIGN KEY (comment) REFERENCES comment(idcomment);


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity);


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_communitycategory
    ADD CONSTRAINT fk_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity);


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY report
    ADD CONSTRAINT fk_community FOREIGN KEY (community) REFERENCES community(idcommunity);


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_community FOREIGN KEY (community) REFERENCES community(idcommunity);


--
-- Name: fk_community; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event
    ADD CONSTRAINT fk_community FOREIGN KEY (community) REFERENCES community(idcommunity);


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
    ADD CONSTRAINT fk_community_member_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity);


--
-- Name: fk_community_member_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_community_member_member FOREIGN KEY (idmember) REFERENCES member(idmember);


--
-- Name: fk_communitymember; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_communitymember FOREIGN KEY (idmember) REFERENCES member(idmember);


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event_eventcategory
    ADD CONSTRAINT fk_event FOREIGN KEY (idevent) REFERENCES event(idevent);


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event_member
    ADD CONSTRAINT fk_event FOREIGN KEY (idevent) REFERENCES event(idevent);


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_event FOREIGN KEY (event) REFERENCES event(idevent);


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY report
    ADD CONSTRAINT fk_event FOREIGN KEY (event) REFERENCES event(idevent);


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_event FOREIGN KEY (event) REFERENCES event(idevent);


--
-- Name: fk_event; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY friend
    ADD CONSTRAINT fk_event FOREIGN KEY (idf1) REFERENCES member(idmember);


--
-- Name: fk_eventcategory; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event_eventcategory
    ADD CONSTRAINT fk_eventcategory FOREIGN KEY (ideventcategory) REFERENCES eventcategory(ideventcategory);


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY event_member
    ADD CONSTRAINT fk_member FOREIGN KEY (idmember) REFERENCES member(idmember);


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_member FOREIGN KEY (author) REFERENCES member(idmember);


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT fk_member FOREIGN KEY (buyer) REFERENCES member(idmember);


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY report
    ADD CONSTRAINT fk_member FOREIGN KEY (reporter) REFERENCES member(idmember);


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_member FOREIGN KEY (recipient) REFERENCES member(idmember);


--
-- Name: fk_member; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY friend
    ADD CONSTRAINT fk_member FOREIGN KEY (idf2) REFERENCES member(idmember);


--
-- Name: fk_tickettype; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT fk_tickettype FOREIGN KEY (type) REFERENCES tickettype(idtickettype);


--
-- Name: report_member_fkey; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_member_fkey FOREIGN KEY (member) REFERENCES member(idmember);


--
-- Name: ticket_idinvoice_fkey; Type: FK CONSTRAINT; Schema: lbaw1714; Owner: lbaw1714
--

ALTER TABLE ONLY ticket
    ADD CONSTRAINT ticket_idinvoice_fkey FOREIGN KEY (idinvoice) REFERENCES invoice(idinvoice);

