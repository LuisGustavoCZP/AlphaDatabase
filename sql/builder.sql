CREATE TABLE public.user (
	"id" serial NOT NULL,
	"username" varchar(30) NOT NULL UNIQUE,
	"password" varchar(20) NOT NULL,
	"email" varchar(120) NOT NULL UNIQUE,
	"name" varchar(120) NOT NULL,
	"privilege" integer NOT NULL,
	"created_at" TIMESTAMP NOT NULL,
	"created_by" integer NOT NULL,
	"updated_at" TIMESTAMP,
	"updated_by" integer,
	"deleted_at" TIMESTAMP,
	"deleted_by" integer,
	CONSTRAINT "user_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE public.privilege (
	"id" serial NOT NULL,
	"name" varchar(70) NOT NULL,
	"level" integer NOT NULL,
	"created_at" TIMESTAMP NOT NULL,
	"created_by" integer NOT NULL,
	"updated_at" TIMESTAMP,
	"updated_by" integer,
	"deleted_at" TIMESTAMP,
	"deleted_by" integer,
	CONSTRAINT "privilege_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

ALTER TABLE "user" ADD CONSTRAINT "user_fk0" FOREIGN KEY ("privilege") REFERENCES "privilege"("id");

CREATE TABLE public.deleted_user AS TABLE public.user WITH NO DATA;
CREATE FUNCTION moveDeleted() RETURNS trigger AS $$
  BEGIN
    INSERT INTO public.deleted_user VALUES((OLD).*);
	UPDATE
    RETURN OLD;
  END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER moveDeleted
BEFORE DELETE ON public.user
FOR EACH ROW
EXECUTE PROCEDURE moveDeleted();