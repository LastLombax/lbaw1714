
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


CREATE TYPE notificationtype AS ENUM (
    'invitation',
    'comment'
);

CREATE TABLE comment (
    idcomment integer NOT NULL,
    text text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    event integer,
    author integer
);


CREATE TABLE community (
    idcommunity integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256) NOT NULL,
    creationdate date NOT NULL,
    imagepath text,
    publiclink text,
    ispublic boolean NOT NULL,
    isactive boolean NOT NULL
);


CREATE TABLE community_communitycategory (
    idcommunity integer,
    idcommunitycategory integer,
    PRIMARY KEY(idcommunity, idcommunitycategory)
);



CREATE TABLE community_member (
    idcommunity integer,
    idmember integer,
    isadmin boolean NOT NULL,
    PRIMARY KEY(idcommunity, idmember)
);

CREATE TABLE communitycategory (
    idcommunitycategory integer NOT NULL,
    name character varying(50)
);



CREATE TABLE event (
    idevent integer NOT NULL,
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
    community integer,
    isactive boolean NOT NULL
);



CREATE TABLE event_eventcategory (
    idevent integer,
    ideventcategory integer.
    PRIMARY KEY(idevent, ideventcategory)
);


CREATE TABLE event_member (
    idevent integer,
    idmember integer,
    isadmin boolean NOT NULL,
    PRIMARY KEY(idevent, idevent)
);


CREATE TABLE eventcategory (
    ideventcategory integer NOT NULL,
    name character varying(50) NOT NULL,
);


CREATE TABLE friend (
    idf1 integer NOT NULL,
    idf2 integer NOT NULL,
    accepted boolean
);


CREATE TABLE invoice (
    idinvoice integer NOT NULL,
    taxpayernumber integer,
    name character varying(50),
    address text,
    quantity integer NOT NULL,
    amount integer NOT NULL,
    date date NOT NULL,
    CONSTRAINT invoice_amount_check CHECK ((amount > 0)),
    CONSTRAINT invoice_quantity_check CHECK ((quantity > 0))
);




CREATE TABLE member (
    idmember integer NOT NULL,
    name character varying(50) NOT NULL,
    username character varying(16) NOT NULL,
    password text NOT NULL,
    birthdate date NOT NULL,
    email character varying(50) NOT NULL,
    country character varying(50),
    city character varying(50),
    address text,
    taxpayernumber character varying(20),
    about character varying(256),
    profilepicture text,
    registrationdate date NOT NULL,
    sentemailverification boolean NOT NULL,
    verifiedemail boolean NOT NULL,
    iswebsiteadmin boolean NOT NULL,
    isactive boolean NOT NULL
);




CREATE TABLE notification (
    idnotification integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    type notificationtype NOT NULL,
    community integer,
    recipient integer,
    comment integer,
    event integer
);




CREATE TABLE report (
    idreport integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    context text NOT NULL,
    community integer,
    reporter integer,
    comment integer,
    event integer,
    solved boolean DEFAULT false NOT NULL,
    member integer
);


CREATE TABLE ticket (
    idticket integer NOT NULL,
    type integer,
    buyer integer NOT NULL,
    idinvoice integer NOT NULL
);




CREATE TABLE tickettype (
    idtickettype integer NOT NULL,
    type integer NOT NULL,
    price double precision NOT NULL,
    initialquantity integer NOT NULL,
    availablequantity integer,
    description text,
    event integer NOT NULL,
    CONSTRAINT tickettype_initialquantity_check CHECK ((initialquantity > 0)),
    CONSTRAINT tickettype_price_check CHECK ((price > (0)::double precision))
);



ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (idcomment);


ALTER TABLE ONLY community
    ADD CONSTRAINT community_pkey PRIMARY KEY (idcommunity);


ALTER TABLE ONLY community
    ADD CONSTRAINT community_publiclink_key UNIQUE (publiclink);


ALTER TABLE ONLY communitycategory
    ADD CONSTRAINT communitycategory_pkey PRIMARY KEY (idcommunitycategory);


ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (idevent);


ALTER TABLE ONLY eventcategory
    ADD CONSTRAINT eventcategory_pkey PRIMARY KEY (ideventcategory);

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (idinvoice);


ALTER TABLE ONLY member
    ADD CONSTRAINT member_email_key UNIQUE (email);


ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (idmember);


ALTER TABLE ONLY member
    ADD CONSTRAINT member_taxpayernumber_key UNIQUE (taxpayernumber);


ALTER TABLE ONLY member
    ADD CONSTRAINT member_username_key UNIQUE (username);


ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (idnotification);


ALTER TABLE ONLY report
    ADD CONSTRAINT report_pkey PRIMARY KEY (idreport);


ALTER TABLE ONLY ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (idticket);


ALTER TABLE ONLY tickettype
    ADD CONSTRAINT tickettype_pkey PRIMARY KEY (idtickettype);


ALTER TABLE ONLY community_communitycategory
    ADD CONSTRAINT fk_category FOREIGN KEY (idcommunitycategory) REFERENCES communitycategory(idcommunitycategory);


ALTER TABLE ONLY report
    ADD CONSTRAINT fk_comment FOREIGN KEY (comment) REFERENCES comment(idcomment);


ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_comment FOREIGN KEY (comment) REFERENCES comment(idcomment);


ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity);



ALTER TABLE ONLY community_communitycategory
    ADD CONSTRAINT fk_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity);


ALTER TABLE ONLY report
    ADD CONSTRAINT fk_community FOREIGN KEY (community) REFERENCES community(idcommunity);


ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_community FOREIGN KEY (community) REFERENCES community(idcommunity);


ALTER TABLE ONLY event
    ADD CONSTRAINT fk_community FOREIGN KEY (community) REFERENCES community(idcommunity);


ALTER TABLE ONLY community_communitycategory
    ADD CONSTRAINT fk_community_communitycategory_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity);


ALTER TABLE ONLY community_communitycategory
    ADD CONSTRAINT fk_community_communitycategory_communitycategory FOREIGN KEY (idcommunitycategory) REFERENCES communitycategory(idcommunitycategory);


ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_community_member_community FOREIGN KEY (idcommunity) REFERENCES community(idcommunity);

ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_community_member_member FOREIGN KEY (idmember) REFERENCES member(idmember);


ALTER TABLE ONLY community_member
    ADD CONSTRAINT fk_communitymember FOREIGN KEY (idmember) REFERENCES member(idmember);


ALTER TABLE ONLY event_eventcategory
    ADD CONSTRAINT fk_event FOREIGN KEY (idevent) REFERENCES event(idevent);


ALTER TABLE ONLY event_member
    ADD CONSTRAINT fk_event FOREIGN KEY (idevent) REFERENCES event(idevent);


ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_event FOREIGN KEY (event) REFERENCES event(idevent);


ALTER TABLE ONLY report
    ADD CONSTRAINT fk_event FOREIGN KEY (event) REFERENCES event(idevent);


ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_event FOREIGN KEY (event) REFERENCES event(idevent);



ALTER TABLE ONLY friend
    ADD CONSTRAINT fk_event FOREIGN KEY (idf1) REFERENCES member(idmember);



ALTER TABLE ONLY event_eventcategory
    ADD CONSTRAINT fk_eventcategory FOREIGN KEY (ideventcategory) REFERENCES eventcategory(ideventcategory);


ALTER TABLE ONLY event_member
    ADD CONSTRAINT fk_member FOREIGN KEY (idmember) REFERENCES member(idmember);



ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_member FOREIGN KEY (author) REFERENCES member(idmember);



ALTER TABLE ONLY ticket
    ADD CONSTRAINT fk_member FOREIGN KEY (buyer) REFERENCES member(idmember);



ALTER TABLE ONLY report
    ADD CONSTRAINT fk_member FOREIGN KEY (reporter) REFERENCES member(idmember);



ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_member FOREIGN KEY (recipient) REFERENCES member(idmember);



ALTER TABLE ONLY friend
    ADD CONSTRAINT fk_member FOREIGN KEY (idf2) REFERENCES member(idmember);



ALTER TABLE ONLY ticket
    ADD CONSTRAINT fk_tickettype FOREIGN KEY (type) REFERENCES tickettype(idtickettype);



ALTER TABLE ONLY report
    ADD CONSTRAINT report_member_fkey FOREIGN KEY (member) REFERENCES member(idmember);



ALTER TABLE ONLY ticket
    ADD CONSTRAINT ticket_idinvoice_fkey FOREIGN KEY (idinvoice) REFERENCES invoice(idinvoice);
