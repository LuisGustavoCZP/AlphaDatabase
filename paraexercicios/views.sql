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