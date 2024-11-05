CREATE TABLE IF NOT EXISTS "Book" (
	"id_book" serial NOT NULL UNIQUE,
	"Last_name" varchar(50) NOT NULL,
	"First_name" varchar(50) NOT NULL,
	"Part_name" varchar(50) NOT NULL,
	"Name_book" varchar(50) NOT NULL,
	"UDC" varchar(100) NOT NULL,
	PRIMARY KEY ("id_book")
);

CREATE TABLE IF NOT EXISTS "Edition" (
	"ISBN" bigint NOT NULL UNIQUE,
	"genre" varchar(20) NOT NULL,
	"id_book" bigint NOT NULL,
	"format" varchar(2) NOT NULL,
	"cover_book" varchar(7) NOT NULL,
	"year" bigint NOT NULL,
	"publisher_name" varchar(30) NOT NULL,
	"exampler_num" bigint NOT NULL,
	"id_publisher" bigint NOT NULL,
	"rarity_book" boolean NOT NULL,
	PRIMARY KEY ("ISBN")
);

CREATE TABLE IF NOT EXISTS "Publisher" (
	"id_publisher" serial NOT NULL UNIQUE,
	"publisher_name" varchar(30) NOT NULL UNIQUE,
	"id_city" bigint NOT NULL,
	"address" varchar(100) NOT NULL,
	"last_name" varchar(50) NOT NULL,
	"first_name" varchar(50) NOT NULL,
	"part_name" bigint NOT NULL,
	PRIMARY KEY ("id_publisher")
);

CREATE TABLE IF NOT EXISTS "City" (
	"id_city" serial NOT NULL UNIQUE,
	"city_name" varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY ("id_city")
);

CREATE TABLE IF NOT EXISTS "Publisher_phone" (
	"id_phone" varchar(19) NOT NULL UNIQUE,
	"id_publisher" bigint NOT NULL,
	PRIMARY KEY ("id_phone")
);

CREATE TABLE IF NOT EXISTS "Exampler" (
	"id_exampler" serial NOT NULL UNIQUE,
	"ISBN" bigint NOT NULL,
	"Id_publisher" bigint NOT NULL,
	PRIMARY KEY ("id_exampler")
);

CREATE TABLE IF NOT EXISTS "Issue/refund_log" (
	"id_note" serial NOT NULL UNIQUE,
	"id_library_card" bigint NOT NULL,
	"id_exampler" bigint NOT NULL,
	"payment" numeric(10,0) DEFAULT '0',
	"date_issue" date NOT NULL,
	"date_refund_expected" date NOT NULL,
	"date_refund_real" date NOT NULL,
	PRIMARY KEY ("id_note")
);

CREATE TABLE IF NOT EXISTS "Library_card" (
	"id_library_card" serial NOT NULL UNIQUE,
	"last_name" varchar(50) NOT NULL,
	"first_name" varchar(50) NOT NULL,
	"part_name" varchar(50) NOT NULL,
	PRIMARY KEY ("id_library_card")
);

CREATE TABLE IF NOT EXISTS "Reader_under_14" (
	"id_reader_under_14" serial NOT NULL UNIQUE,
	"last_name" varchar(50) NOT NULL,
	"first_name" varchar(50) NOT NULL,
	"part_name" varchar(50) NOT NULL,
	"date_of_birth" date NOT NULL,
	"birth_cert_num" varchar(11) NOT NULL UNIQUE,
	"birth_cert_date" date NOT NULL,
	"id_adult_reader" bigint NOT NULL,
	"id_library_card" bigint NOT NULL UNIQUE,
	PRIMARY KEY ("id_reader_under_14")
);

CREATE TABLE IF NOT EXISTS "Adult_reader" (
	"id_adult_reader" serial NOT NULL UNIQUE,
	"last_name" varchar(50) NOT NULL,
	"first_name" varchar(50) NOT NULL,
	"part_name" varchar(50) NOT NULL,
	"phone" varchar(19) NOT NULL UNIQUE,
	"email" varchar(254) NOT NULL UNIQUE,
	"id_city" bigint NOT NULL,
	"address" varchar(500) NOT NULL,
	"date_of_birth" date,
	"passp_num" varchar(6) NOT NULL,
	"passp_seria" varchar(4) NOT NULL,
	"id_library_card" bigint NOT NULL UNIQUE,
	PRIMARY KEY ("id_adult_reader")
);


ALTER TABLE "Edition" ADD CONSTRAINT "Edition_fk2" FOREIGN KEY ("id_book") REFERENCES "Book"("id_book");

ALTER TABLE "Edition" ADD CONSTRAINT "Edition_fk8" FOREIGN KEY ("id_publisher") REFERENCES "Publisher"("id_publisher");
ALTER TABLE "Publisher" ADD CONSTRAINT "Publisher_fk2" FOREIGN KEY ("id_city") REFERENCES "City"("id_city");

ALTER TABLE "Publisher_phone" ADD CONSTRAINT "Publisher_phone_fk1" FOREIGN KEY ("id_publisher") REFERENCES "Publisher"("id_publisher");
ALTER TABLE "Exampler" ADD CONSTRAINT "Exampler_fk1" FOREIGN KEY ("ISBN") REFERENCES "Edition"("ISBN");

ALTER TABLE "Exampler" ADD CONSTRAINT "Exampler_fk2" FOREIGN KEY ("Id_publisher") REFERENCES "Publisher"("id_publisher");
ALTER TABLE "Issue/refund_log" ADD CONSTRAINT "Issue/refund_log_fk1" FOREIGN KEY ("id_library_card") REFERENCES "Library_card"("id_library_card");

ALTER TABLE "Issue/refund_log" ADD CONSTRAINT "Issue/refund_log_fk2" FOREIGN KEY ("id_exampler") REFERENCES "Exampler"("id_exampler");

ALTER TABLE "Reader_under_14" ADD CONSTRAINT "Reader_under_14_fk7" FOREIGN KEY ("id_adult_reader") REFERENCES "Adult_reader"("id_adult_reader");

ALTER TABLE "Reader_under_14" ADD CONSTRAINT "Reader_under_14_fk8" FOREIGN KEY ("id_library_card") REFERENCES "Library_card"("id_library_card");
ALTER TABLE "Adult_reader" ADD CONSTRAINT "Adult_reader_fk6" FOREIGN KEY ("id_city") REFERENCES "City"("id_city");

ALTER TABLE "Adult_reader" ADD CONSTRAINT "Adult_reader_fk11" FOREIGN KEY ("id_library_card") REFERENCES "Library_card"("id_library_card");