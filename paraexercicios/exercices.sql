--INSERT INTO public.privilege (name, level, created_at, created_by) VALUES ('coordenadoria', '200', '2022-04-05 23:03:00', -1);
--INSERT INTO public.privilege (name, level, created_at, created_by) VALUES ('secretariado', '50', '2022-04-05 23:03:00', -1);
--SELECT * FROM public.privilege;

--INSERT INTO public.request (name, access_privilege, created_at, created_by) VALUES ('matricula', 2, '2022-04-05 23:03:00', -1);
--INSERT INTO public.request (name, access_privilege, created_at, created_by) VALUES ('transferencia', 2, '2022-04-05 23:03:00', -1);
--SELECT * FROM public.request;


--INSERT INTO public.user (username, password, email, name, privilege, created_at, created_by) VALUES ('kenji', 'omestre', 'kenjaoomestre@school.edu', 'Professor Kenji', 1, '2022-04-05 23:03:00', -1);
--INSERT INTO public.user (username, password, email, name, privilege, created_at, created_by) VALUES ('fabio', 'oprofis', 'fabiaooprofis@school.edu', 'Professor Fabio', 2, '2022-04-05 23:03:00', -1);
--SELECT * FROM public.user AS usr WHERE usr.name LIKE 'Professor%';
--SELECT * FROM public.user AS usr WHERE usr.created_at BETWEEN '2022-04-05 23:02:00' AND '2022-04-05 23:04:00';
--SELECT * FROM public.user AS usr WHERE usr.privilege IN (1, 2);
--SELECT * FROM public.user AS usr WHERE usr.privilege NOT IN (3, 2);
--UPDATE public.user AS usr SET (updated_at, updated_by) = ('2022-04-07 03:03:00', '1') WHERE usr.name LIKE 'Professor%';
--SELECT * FROM public.user AS usr WHERE usr.privilege IN (1, 2);


--INSERT INTO public.status (name, created_at, created_by) VALUES ('pendente', '2022-04-05 23:03:00', -1);
--INSERT INTO public.status (name, created_at, created_by) VALUES ('finalizado', '2022-04-05 23:03:00', -1);
--INSERT INTO public.status (name, created_at, created_by) VALUES ('cancelado', '2022-04-05 23:03:00', -1);
--SELECT * FROM public.status;

--INSERT INTO public.requestor_address (cep, street_number, street, district, city, created_at, created_by) VALUES ('87502030', '3614', 'Goiás', 'Zona II', 'Umuarama', '2022-04-05 23:03:00', -1);
--SELECT * FROM public.requestor_address;

--INSERT INTO public.requestor (name, email, address_id, created_at, created_by) VALUES ('Luis Gustavo Zanetti', 'luisgustavoczp@gmail.com', 1, '2022-04-05 23:03:00', -1);
--SELECT * FROM public.requestor;

--INSERT INTO public.requestor_phone (requestor_id, phone_ddd, phone_number, created_at, created_by) VALUES (1, '45', '933002944', '2022-04-05 23:03:00', -1);
--SELECT * FROM public.requestor_phone;

--INSERT INTO public.protocol (request_id, requestor_id, open_date, status, created_at, created_by) VALUES (1, 1, '2022-04-05', 'iniciado', '2022-04-05 23:03:00', -1);
--SELECT * FROM public.protocol;

--INSERT INTO public.process (protocol_id, status_id, started_at, access_privilege, operator_id, created_at, created_by) VALUES (1, 1, '2022-04-05', 2, 1, '2022-04-05 23:03:00', -1);
--SELECT * FROM public.process;

--/*
CREATE OR REPLACE VIEW vw_user AS
SELECT usr.id, usr.name, CONCAT(privilege.name, '(', privilege.level, ')') AS privilege
FROM public.user AS usr
INNER JOIN public.privilege AS privilege ON usr.privilege=privilege.id;
--*/
SELECT * FROM vw_user
--/*
CREATE OR REPLACE VIEW vw_requestor AS
SELECT reque.name, reque.email, CONCAT ('(', phone.phone_ddd, ')', phone.phone_number ) AS phone , CONCAT ('Rua ', address.street, ', ', address.street_number, '. ', address.district, '. ', address.city) AS address, address.cep, reque.id
FROM public.requestor AS reque
INNER JOIN public.requestor_address AS address ON reque.address_id=address.id
INNER JOIN public.requestor_phone AS phone ON reque.id=phone.requestor_id;
--*/
SELECT * FROM vw_requestor
--/*
CREATE OR REPLACE VIEW vw_request AS
SELECT request.name, CONCAT(privilege.name, '(', privilege.level, ')') AS privilege, request.id
FROM public.request AS request
INNER JOIN public.privilege AS privilege ON request.access_privilege=privilege.id;
--*/
SELECT * FROM vw_request;
--/*
CREATE OR REPLACE VIEW vw_protocol AS
SELECT proto.id, requestor.name AS requestor_name, request.name AS request_name, CONCAT (proto.status, ' (', proto.open_date, ')') AS status
FROM public.protocol AS proto
INNER JOIN vw_request AS request ON request.id=proto.request_id
INNER JOIN vw_requestor AS requestor ON requestor.id=proto.requestor_id
--*/
SELECT * FROM vw_protocol;
--/*
CREATE OR REPLACE VIEW vw_process AS
SELECT protocol.id, protocol.requestor_name AS requestor, protocol.request_name AS request, status, usr.name AS operator, started_at 
FROM public.process AS process
INNER JOIN vw_protocol AS protocol ON protocol.id=process.protocol_id
INNER JOIN vw_user AS usr ON usr.id=process.operator_id
INNER JOIN public.status AS status ON status.id=process.status_id;
--*/
SELECT * FROM vw_process;

--UPDATE public.user AS usr SET id=1 WHERE id=2;
--SELECT * FROM vw_process;
--BEGIN TRANSACTION
--SELECT * FROM public.user;
--SELECT * FROM public.deleted_user;
--ROLLBACK
--COMMIT
--DELETE FROM public.user CASCADE;
--DELETE FROM public.deleted_user CASCADE;
--ALTER TABLE public.user ALTER COLUMN password TYPE varchar(60);
/*
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
*/