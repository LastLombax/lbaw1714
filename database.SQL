CREATE TABLE PrivateCommunity ( 
	idPrivateCommunity integer NOT NULL
)
;

CREATE TABLE PublicCommunity ( 
	idPublicCommunity integer NOT NULL,
	publicLink path NOT NULL
)
;

CREATE TABLE PrivateEvent ( 
	idPrivateEvent integer NOT NULL
)
;

CREATE TABLE PublicEvent ( 
	idPublicEvent integer NOT NULL,
	publicLink path NOT NULL
)
;

CREATE TABLE TicketPurchase ( 
	idTicketPurchase integer NOT NULL,
	quantity integer
)
;

CREATE TABLE Notification ( 
	idNotification integer NOT NULL
)
;

CREATE TABLE CommunityCategory ( 
	idCommunityCategory integer NOT NULL,
	name varchar(50)
)
;

CREATE TABLE EventCategory ( 
	idEventCategory integer NOT NULL,
	name varchar(50) NOT NULL
)
;

CREATE TABLE Report ( 
	idReport integer NOT NULL,
	timestamp timestamp(0) NOT NULL,
	itemToReport varchar(50) NOT NULL,
	description text NOT NULL
)
;

CREATE TABLE WebsiteAdmin ( 
	idWebsiteAdmin  NOT NULL
)
;

CREATE TABLE CommunityAdmin ( 
	idCommunityAdmin  NOT NULL
)
;

CREATE TABLE EventAdmin ( 
	idEventAdmin  NOT NULL
)
;

CREATE TABLE Comment ( 
	idComment integer NOT NULL,
	text text NOT NULL,
	timestamp timestamp(0) NOT NULL
)
;

CREATE TABLE Community ( 
	idCommunity integer NOT NULL,
	name varchar(64) NOT NULL,
	description varchar(256) NOT NULL,
	creationDate date NOT NULL,
	imagePath path,
	isPublic boolean NOT NULL
)
;

CREATE TABLE Member ( 
	idMember integer NOT NULL,
	username varchar(16) NOT NULL,
	password text NOT NULL,
	name varchar(50) NOT NULL,
	birthdate date NOT NULL,
	email varchar(50) NOT NULL,
	country varchar(50),
	city varchar(50),
	address text,
	taxPayerNumber varchar(20),
	about varchar(256),
	profilePicture path,
	registrationDate date NOT NULL,
	sentEmailVerification boolean NOT NULL,
	verifiedEmail boolean NOT NULL
)
;

CREATE TABLE Ticket ( 
	idTicket integer NOT NULL,
	price double precision NOT NULL,
	type varchar(50) NOT NULL,
	initialQuantity integer NOT NULL,
	availableQuantity integer NOT NULL
)
;

CREATE TABLE Event ( 
	idEvent integer NOT NULL,
	name varchar(64) NOT NULL,
	description varchar(516),
	imagePath path,
	date date NOT NULL,
	country varchar(50) NOT NULL,
	city varchar(50) NOT NULL,
	address varchar(100) NOT NULL,
	publicLink path,
	isPublic boolean NOT NULL
)
;


ALTER TABLE PrivateCommunity ADD CONSTRAINT PK_Community 
	PRIMARY KEY (idPrivateCommunity)
;


ALTER TABLE PublicCommunity ADD CONSTRAINT PK_Community 
	PRIMARY KEY (idPublicCommunity)
;


ALTER TABLE PrivateEvent ADD CONSTRAINT PK_Event 
	PRIMARY KEY (idPrivateEvent)
;


ALTER TABLE PublicEvent ADD CONSTRAINT PK_Event 
	PRIMARY KEY (idPublicEvent)
;


ALTER TABLE TicketPurchase ADD CONSTRAINT PK_TicketPurchase 
	PRIMARY KEY (idTicketPurchase)
;


ALTER TABLE Notification ADD CONSTRAINT PK_Notification 
	PRIMARY KEY (idNotification)
;


ALTER TABLE CommunityCategory ADD CONSTRAINT PK_CommunityCategory 
	PRIMARY KEY (idCommunityCategory)
;


ALTER TABLE EventCategory ADD CONSTRAINT PK_EventCategory 
	PRIMARY KEY (idEventCategory)
;


ALTER TABLE Report ADD CONSTRAINT PK_Report 
	PRIMARY KEY (idReport)
;


ALTER TABLE WebsiteAdmin ADD CONSTRAINT PK_WebsiteAdmin 
	PRIMARY KEY (idWebsiteAdmin)
;


ALTER TABLE CommunityAdmin ADD CONSTRAINT PK_Member 
	PRIMARY KEY (idCommunityAdmin)
;


ALTER TABLE EventAdmin ADD CONSTRAINT PK_Member 
	PRIMARY KEY (idEventAdmin)
;


ALTER TABLE Comment ADD CONSTRAINT PK_Comment 
	PRIMARY KEY (idComment)
;


ALTER TABLE Community ADD CONSTRAINT PK_Community 
	PRIMARY KEY (idCommunity)
;


ALTER TABLE Member ADD CONSTRAINT PK_Member 
	PRIMARY KEY (idMember)
;


ALTER TABLE Ticket ADD CONSTRAINT PK_Ticket 
	PRIMARY KEY (idTicket)
;


ALTER TABLE Event ADD CONSTRAINT PK_Event 
	PRIMARY KEY (idEvent)
;
