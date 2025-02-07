--
-- PostgreSQL database dump
--

-- Dumped from database version 13.16 (Debian 13.16-1.pgdg120+1)
-- Dumped by pg_dump version 15.8 (Debian 15.8-0+deb12u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: update_modified_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_modified_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance (
    attendance_id integer NOT NULL,
    student_id integer,
    class_id integer,
    attendance_date date NOT NULL,
    status character varying(10) NOT NULL,
    semester_id integer,
    staff_id integer
);


ALTER TABLE public.attendance OWNER TO postgres;

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendance_attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attendance_attendance_id_seq OWNER TO postgres;

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendance_attendance_id_seq OWNED BY public.attendance.attendance_id;


--
-- Name: balance_adjustment_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.balance_adjustment_log (
    log_id integer NOT NULL,
    student_id integer,
    amount_adjusted numeric(10,2),
    reason text,
    adjusted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.balance_adjustment_log OWNER TO postgres;

--
-- Name: balance_adjustment_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.balance_adjustment_log_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.balance_adjustment_log_log_id_seq OWNER TO postgres;

--
-- Name: balance_adjustment_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.balance_adjustment_log_log_id_seq OWNED BY public.balance_adjustment_log.log_id;


--
-- Name: bus_pick_up_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus_pick_up_points (
    pick_up_id integer NOT NULL,
    student_id integer,
    pick_up_point_name character varying(100) NOT NULL,
    pick_up_price integer,
    status character varying(10) DEFAULT 'active'::character varying
);


ALTER TABLE public.bus_pick_up_points OWNER TO postgres;

--
-- Name: bus_pick_up_points_pick_up_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bus_pick_up_points_pick_up_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bus_pick_up_points_pick_up_id_seq OWNER TO postgres;

--
-- Name: bus_pick_up_points_pick_up_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bus_pick_up_points_pick_up_id_seq OWNED BY public.bus_pick_up_points.pick_up_id;


--
-- Name: class_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.class_items (
    class_item_id integer NOT NULL,
    class_id integer,
    item_id integer,
    semester_id integer,
    quantity_per_student integer DEFAULT 0,
    supplied_by integer,
    assigned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'active'::character varying
);


ALTER TABLE public.class_items OWNER TO postgres;

--
-- Name: class_items_class_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.class_items_class_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.class_items_class_item_id_seq OWNER TO postgres;

--
-- Name: class_items_class_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.class_items_class_item_id_seq OWNED BY public.class_items.class_item_id;


--
-- Name: classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classes (
    class_id integer NOT NULL,
    class_name character varying(50) NOT NULL,
    class_level character varying(50) NOT NULL,
    capacity integer,
    room_name character varying(50),
    staff_id integer,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT classes_status_check CHECK (((status)::text = ANY (ARRAY[('active'::character varying)::text, ('inactive'::character varying)::text, ('archived'::character varying)::text, ('deleted'::character varying)::text])))
);


ALTER TABLE public.classes OWNER TO postgres;

--
-- Name: classes_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classes_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classes_class_id_seq OWNER TO postgres;

--
-- Name: classes_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classes_class_id_seq OWNED BY public.classes.class_id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    department_id integer NOT NULL,
    department_name character varying(50) NOT NULL,
    head_of_department integer,
    description text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: departments_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_department_id_seq OWNER TO postgres;

--
-- Name: departments_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_department_id_seq OWNED BY public.departments.department_id;


--
-- Name: evaluations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluations (
    evaluation_id integer NOT NULL,
    evaluatee_id integer,
    evaluation_date date NOT NULL,
    teaching_effectiveness numeric(2,1),
    classroom_management numeric(2,1),
    student_engagement numeric(2,1),
    professionalism numeric(2,1),
    overall_rating numeric(2,1) GENERATED ALWAYS AS (((((teaching_effectiveness + classroom_management) + student_engagement) + professionalism) / (4)::numeric)) STORED,
    comments text,
    years_of_experience integer,
    evaluator_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT evaluations_classroom_management_check CHECK (((classroom_management >= (1)::numeric) AND (classroom_management <= (5)::numeric))),
    CONSTRAINT evaluations_professionalism_check CHECK (((professionalism >= (1)::numeric) AND (professionalism <= (5)::numeric))),
    CONSTRAINT evaluations_student_engagement_check CHECK (((student_engagement >= (1)::numeric) AND (student_engagement <= (5)::numeric))),
    CONSTRAINT evaluations_teaching_effectiveness_check CHECK (((teaching_effectiveness >= (1)::numeric) AND (teaching_effectiveness <= (5)::numeric)))
);


ALTER TABLE public.evaluations OWNER TO postgres;

--
-- Name: evaluations_evaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evaluations_evaluation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evaluations_evaluation_id_seq OWNER TO postgres;

--
-- Name: evaluations_evaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evaluations_evaluation_id_seq OWNED BY public.evaluations.evaluation_id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    event_id integer NOT NULL,
    event_title character varying(100) NOT NULL,
    event_date date,
    start_time time without time zone,
    end_time time without time zone,
    location character varying(100),
    description text,
    event_type character varying(50),
    target_audience character varying(50),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'active'::character varying,
    user_id integer,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_event_id_seq OWNER TO postgres;

--
-- Name: events_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_event_id_seq OWNED BY public.events.event_id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expenses (
    expense_id integer NOT NULL,
    recipient_name character varying(100),
    expense_category character varying(50),
    description text,
    amount numeric(10,2),
    expense_date date,
    invoice_number character varying(50),
    supplier_id integer,
    staff_id integer,
    user_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.expenses OWNER TO postgres;

--
-- Name: expenses_expense_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expenses_expense_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expenses_expense_id_seq OWNER TO postgres;

--
-- Name: expenses_expense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expenses_expense_id_seq OWNED BY public.expenses.expense_id;


--
-- Name: fee_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fee_collections (
    collection_id integer NOT NULL,
    student_id integer,
    payment_date date,
    amount_received numeric(10,2),
    old_balance numeric(10,2),
    new_balance numeric(10,2),
    fee_type character varying(50),
    payment_mode character varying(20),
    status character varying(50) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    received_by integer,
    comment text
);


ALTER TABLE public.fee_collections OWNER TO postgres;

--
-- Name: fee_collections_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fee_collections_collection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fee_collections_collection_id_seq OWNER TO postgres;

--
-- Name: fee_collections_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fee_collections_collection_id_seq OWNED BY public.fee_collections.collection_id;


--
-- Name: feeding_fee_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feeding_fee_payments (
    id integer NOT NULL,
    student_id integer NOT NULL,
    class_id integer NOT NULL,
    collected_by integer NOT NULL,
    feeding_fee numeric(10,2) NOT NULL,
    valid_until_feeding date NOT NULL,
    transport_fee numeric(10,2) NOT NULL,
    valid_until_transport date NOT NULL,
    total_fee numeric(10,2) NOT NULL,
    semester_id integer NOT NULL,
    payment_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.feeding_fee_payments OWNER TO postgres;

--
-- Name: feeding_fee_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feeding_fee_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feeding_fee_payments_id_seq OWNER TO postgres;

--
-- Name: feeding_fee_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feeding_fee_payments_id_seq OWNED BY public.feeding_fee_payments.id;


--
-- Name: feeding_transport_fees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feeding_transport_fees (
    student_id integer NOT NULL,
    transportation_method character varying(100),
    feeding_fee numeric(10,2),
    transport_fee numeric(10,2),
    pick_up_point integer
);


ALTER TABLE public.feeding_transport_fees OWNER TO postgres;

--
-- Name: grading_scheme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grading_scheme (
    gradescheme_id integer NOT NULL,
    grade_name character varying(10) NOT NULL,
    minimum_mark numeric(5,2) NOT NULL,
    maximum_mark numeric(5,2) NOT NULL,
    grade_remark character varying(60),
    status character varying(10) DEFAULT 'active'::character varying
);


ALTER TABLE public.grading_scheme OWNER TO postgres;

--
-- Name: grading_scheme_grade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grading_scheme_grade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grading_scheme_grade_id_seq OWNER TO postgres;

--
-- Name: grading_scheme_grade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grading_scheme_grade_id_seq OWNED BY public.grading_scheme.gradescheme_id;


--
-- Name: health_incident; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_incident (
    incident_id integer NOT NULL,
    incident_date date,
    incident_description text,
    treatmentprovided text,
    user_id integer
);


ALTER TABLE public.health_incident OWNER TO postgres;

--
-- Name: health_incident_incident_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.health_incident_incident_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.health_incident_incident_id_seq OWNER TO postgres;

--
-- Name: health_incident_incident_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.health_incident_incident_id_seq OWNED BY public.health_incident.incident_id;


--
-- Name: inventory_class_semester; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_class_semester (
    inventory_id integer NOT NULL,
    class_id integer NOT NULL,
    semester_id integer NOT NULL
);


ALTER TABLE public.inventory_class_semester OWNER TO postgres;

--
-- Name: inventory_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_items (
    inventory_id integer NOT NULL,
    inventory_name character varying(150) NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    quantity_per_student integer,
    total_price numeric(12,2) NOT NULL,
    restock_level integer,
    status character varying(20) DEFAULT 'active'::character varying
);


ALTER TABLE public.inventory_items OWNER TO postgres;

--
-- Name: inventory_items_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventory_items_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_items_inventory_id_seq OWNER TO postgres;

--
-- Name: inventory_items_inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventory_items_inventory_id_seq OWNED BY public.inventory_items.inventory_id;


--
-- Name: invoice_class_semester; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_class_semester (
    invoice_id integer NOT NULL,
    class_id integer NOT NULL,
    semester_id integer NOT NULL
);


ALTER TABLE public.invoice_class_semester OWNER TO postgres;

--
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoices (
    invoice_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    description character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(30) DEFAULT 'active'::character varying
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- Name: invoices_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoices_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoices_invoice_id_seq OWNER TO postgres;

--
-- Name: invoices_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoices_invoice_id_seq OWNED BY public.invoices.invoice_id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    item_id integer NOT NULL,
    item_name character varying(250) NOT NULL,
    category character varying(150),
    description text,
    unit_price numeric(10,2) NOT NULL,
    quantity_desired integer,
    quantity_available integer DEFAULT 0,
    restock_level integer,
    status character varying(20) DEFAULT 'active'::character varying
);


ALTER TABLE public.items OWNER TO postgres;

--
-- Name: items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_item_id_seq OWNER TO postgres;

--
-- Name: items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.items_item_id_seq OWNED BY public.items.item_id;


--
-- Name: items_movement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items_movement (
    supply_id integer NOT NULL,
    staff_id integer,
    recipient_name character varying(100),
    recipient_phone character varying(30),
    comments text,
    item_id integer,
    quantity integer NOT NULL,
    supplied_by integer,
    supplied_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'out'::character varying,
    movement_type character varying(20),
    returned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.items_movement OWNER TO postgres;

--
-- Name: items_movement_supply_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.items_movement_supply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_movement_supply_id_seq OWNER TO postgres;

--
-- Name: items_movement_supply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.items_movement_supply_id_seq OWNED BY public.items_movement.supply_id;


--
-- Name: items_supply; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items_supply (
    supply_id integer NOT NULL,
    student_id integer,
    item_id integer,
    quantity integer NOT NULL,
    supplied_by integer,
    supplied_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    semester_id integer,
    class_id integer,
    status character varying(20) DEFAULT 'active'::character varying
);


ALTER TABLE public.items_supply OWNER TO postgres;

--
-- Name: items_supply_supply_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.items_supply_supply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_supply_supply_id_seq OWNER TO postgres;

--
-- Name: items_supply_supply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.items_supply_supply_id_seq OWNED BY public.items_supply.supply_id;


--
-- Name: notification_recipients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_recipients (
    id integer NOT NULL,
    notification_id integer,
    recipient_id integer NOT NULL,
    recipient_type character varying(20) NOT NULL,
    is_read boolean DEFAULT false,
    read_at timestamp without time zone
);


ALTER TABLE public.notification_recipients OWNER TO postgres;

--
-- Name: notification_recipients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_recipients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_recipients_id_seq OWNER TO postgres;

--
-- Name: notification_recipients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_recipients_id_seq OWNED BY public.notification_recipients.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    notification_title character varying(255) NOT NULL,
    notification_message text NOT NULL,
    notification_type character varying(50) DEFAULT 'general'::character varying,
    priority character varying(20) DEFAULT 'normal'::character varying,
    sender_id integer,
    sent_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_read boolean DEFAULT false,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_notification_id_seq OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- Name: parents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parents (
    parent_id integer NOT NULL,
    other_names character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    phone character varying(20),
    email character varying(100),
    address text,
    status character varying DEFAULT 'active'::character varying,
    user_id integer
);


ALTER TABLE public.parents OWNER TO postgres;

--
-- Name: parents_parent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parents_parent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parents_parent_id_seq OWNER TO postgres;

--
-- Name: parents_parent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parents_parent_id_seq OWNED BY public.parents.parent_id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    permission_id integer NOT NULL,
    permission_name character varying(100) NOT NULL
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_permission_id_seq OWNER TO postgres;

--
-- Name: permissions_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_permission_id_seq OWNED BY public.permissions.permission_id;


--
-- Name: procurements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.procurements (
    procurement_id integer NOT NULL,
    item_id integer,
    supplier_id integer,
    unit_cost numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    total_cost numeric(12,2) NOT NULL,
    procurement_date date DEFAULT CURRENT_DATE,
    brought_by character varying(100),
    received_by integer,
    received_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(50) DEFAULT 'active'::character varying
);


ALTER TABLE public.procurements OWNER TO postgres;

--
-- Name: procurements_procurement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.procurements_procurement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.procurements_procurement_id_seq OWNER TO postgres;

--
-- Name: procurements_procurement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.procurements_procurement_id_seq OWNED BY public.procurements.procurement_id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    room_id integer NOT NULL,
    room_name character varying(50) NOT NULL
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- Name: rooms_room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooms_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_room_id_seq OWNER TO postgres;

--
-- Name: rooms_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooms_room_id_seq OWNED BY public.rooms.room_id;


--
-- Name: semesters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.semesters (
    semester_id integer NOT NULL,
    semester_name character varying(50) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    status character varying(30) DEFAULT 'inactive'::character varying
);


ALTER TABLE public.semesters OWNER TO postgres;

--
-- Name: semesters_semester_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.semesters_semester_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.semesters_semester_id_seq OWNER TO postgres;

--
-- Name: semesters_semester_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.semesters_semester_id_seq OWNED BY public.semesters.semester_id;


--
-- Name: sms_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sms_logs (
    id integer NOT NULL,
    recipient_type character varying(50),
    message_type character varying(50),
    sender_id integer,
    recipients_id integer[],
    message_content text,
    total_attempeted integer,
    total_invalid_numbers integer,
    total_successful integer,
    total_failed integer,
    successful_recipients_ids integer[],
    failed_receipients_ids integer[],
    invalid_recipients_ids integer[],
    invalid_recippients_phone text[],
    api_response jsonb,
    send_timestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_sms_used integer
);


ALTER TABLE public.sms_logs OWNER TO postgres;

--
-- Name: sms_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sms_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sms_logs_id_seq OWNER TO postgres;

--
-- Name: sms_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sms_logs_id_seq OWNED BY public.sms_logs.id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    staff_id integer NOT NULL,
    user_id integer,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    middle_name character varying(50),
    date_of_birth date,
    gender character(1),
    marital_status character varying(20),
    address text,
    phone_number character varying(20),
    email character varying(100),
    emergency_contact character varying(100),
    date_of_joining date,
    designation character varying(50),
    department character varying(50),
    salary numeric(10,2),
    account_number character varying(30),
    contract_type character varying(50),
    employment_status character varying(50),
    qualification text,
    experience text,
    blood_group character varying(5),
    national_id character varying(50),
    passport_number character varying(20),
    photo text,
    teaching_subject character varying(50),
    class_teacher boolean,
    subject_in_charge boolean,
    house_in_charge boolean,
    bus_in_charge boolean,
    library_in_charge boolean,
    status character varying DEFAULT 'active'::character varying,
    role character varying(50) DEFAULT 'teaching staff'::character varying
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_staff_id_seq OWNER TO postgres;

--
-- Name: staff_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_staff_id_seq OWNED BY public.staff.staff_id;


--
-- Name: student_grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_grades (
    grade_id integer NOT NULL,
    student_id integer,
    subject_id integer,
    class_id integer,
    user_id integer,
    gradescheme_id integer,
    semester_id integer,
    class_score numeric(5,2),
    exams_score numeric(5,2),
    total_score numeric(5,2),
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.student_grades OWNER TO postgres;

--
-- Name: student_grades_grade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_grades_grade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_grades_grade_id_seq OWNER TO postgres;

--
-- Name: student_grades_grade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_grades_grade_id_seq OWNED BY public.student_grades.grade_id;


--
-- Name: student_parent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_parent (
    student_id integer NOT NULL,
    parent_id integer NOT NULL,
    relationship character varying(50),
    status character varying(20) DEFAULT 'active'::character varying
);


ALTER TABLE public.student_parent OWNER TO postgres;

--
-- Name: student_remarks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_remarks (
    remark_id integer NOT NULL,
    student_id integer,
    class_id integer,
    semester_id integer,
    user_id integer,
    class_teachers_remark text,
    headteachers_remark text,
    remark_date date DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.student_remarks OWNER TO postgres;

--
-- Name: student_remarks_remark_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_remarks_remark_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_remarks_remark_id_seq OWNER TO postgres;

--
-- Name: student_remarks_remark_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_remarks_remark_id_seq OWNED BY public.student_remarks.remark_id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    photo text,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    other_names character varying(50),
    date_of_birth date NOT NULL,
    gender character varying(10),
    class_id integer,
    amountowed numeric(10,2),
    residential_address text,
    phone character varying(20),
    email character varying(100),
    enrollment_date date NOT NULL,
    national_id character varying(15),
    birth_cert_id character varying(20),
    role character varying(20) DEFAULT 'student'::character varying,
    user_id integer,
    status character varying DEFAULT 'active'::character varying,
    class_promoted_to integer
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_student_id_seq OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_student_id_seq OWNED BY public.students.student_id;


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjects (
    subject_id integer NOT NULL,
    subject_name character varying(100) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- Name: subjects_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subjects_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subjects_subject_id_seq OWNER TO postgres;

--
-- Name: subjects_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subjects_subject_id_seq OWNED BY public.subjects.subject_id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    supplier_id integer NOT NULL,
    supplier_name character varying(100) NOT NULL,
    contact_name character varying(100),
    contact_phone character varying(30),
    contact_email character varying(100),
    address text,
    details text,
    status character varying DEFAULT 'active'::character varying
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_supplier_id_seq OWNER TO postgres;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_supplier_id_seq OWNED BY public.suppliers.supplier_id;


--
-- Name: timetable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timetable (
    timetable_id integer NOT NULL,
    class_id integer,
    subject_id integer,
    teacher_id integer,
    room_id integer,
    day_of_week character varying(10),
    period_number integer,
    start_time time without time zone,
    end_time time without time zone,
    semester_id integer
);


ALTER TABLE public.timetable OWNER TO postgres;

--
-- Name: timetable_timetable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.timetable_timetable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.timetable_timetable_id_seq OWNER TO postgres;

--
-- Name: timetable_timetable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.timetable_timetable_id_seq OWNED BY public.timetable.timetable_id;


--
-- Name: user_health_record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_health_record (
    user_id integer NOT NULL,
    medical_conditions text,
    allergies text,
    blood_group character varying(8),
    vaccination_status text,
    last_physical_exam_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    health_insurance_id character varying(20),
    status character varying(20) DEFAULT 'active'::character varying
);


ALTER TABLE public.user_health_record OWNER TO postgres;

--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(100) NOT NULL,
    user_email character varying(50),
    role character varying(20) DEFAULT 'user'::character varying,
    status character varying(20) DEFAULT 'active'::character varying,
    password character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: attendance attendance_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance ALTER COLUMN attendance_id SET DEFAULT nextval('public.attendance_attendance_id_seq'::regclass);


--
-- Name: balance_adjustment_log log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance_adjustment_log ALTER COLUMN log_id SET DEFAULT nextval('public.balance_adjustment_log_log_id_seq'::regclass);


--
-- Name: bus_pick_up_points pick_up_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_pick_up_points ALTER COLUMN pick_up_id SET DEFAULT nextval('public.bus_pick_up_points_pick_up_id_seq'::regclass);


--
-- Name: class_items class_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_items ALTER COLUMN class_item_id SET DEFAULT nextval('public.class_items_class_item_id_seq'::regclass);


--
-- Name: classes class_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes ALTER COLUMN class_id SET DEFAULT nextval('public.classes_class_id_seq'::regclass);


--
-- Name: departments department_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN department_id SET DEFAULT nextval('public.departments_department_id_seq'::regclass);


--
-- Name: evaluations evaluation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations ALTER COLUMN evaluation_id SET DEFAULT nextval('public.evaluations_evaluation_id_seq'::regclass);


--
-- Name: events event_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN event_id SET DEFAULT nextval('public.events_event_id_seq'::regclass);


--
-- Name: expenses expense_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses ALTER COLUMN expense_id SET DEFAULT nextval('public.expenses_expense_id_seq'::regclass);


--
-- Name: fee_collections collection_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_collections ALTER COLUMN collection_id SET DEFAULT nextval('public.fee_collections_collection_id_seq'::regclass);


--
-- Name: feeding_fee_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feeding_fee_payments ALTER COLUMN id SET DEFAULT nextval('public.feeding_fee_payments_id_seq'::regclass);


--
-- Name: grading_scheme gradescheme_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grading_scheme ALTER COLUMN gradescheme_id SET DEFAULT nextval('public.grading_scheme_grade_id_seq'::regclass);


--
-- Name: health_incident incident_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_incident ALTER COLUMN incident_id SET DEFAULT nextval('public.health_incident_incident_id_seq'::regclass);


--
-- Name: inventory_items inventory_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_items ALTER COLUMN inventory_id SET DEFAULT nextval('public.inventory_items_inventory_id_seq'::regclass);


--
-- Name: invoices invoice_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices ALTER COLUMN invoice_id SET DEFAULT nextval('public.invoices_invoice_id_seq'::regclass);


--
-- Name: items item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items ALTER COLUMN item_id SET DEFAULT nextval('public.items_item_id_seq'::regclass);


--
-- Name: items_movement supply_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_movement ALTER COLUMN supply_id SET DEFAULT nextval('public.items_movement_supply_id_seq'::regclass);


--
-- Name: items_supply supply_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_supply ALTER COLUMN supply_id SET DEFAULT nextval('public.items_supply_supply_id_seq'::regclass);


--
-- Name: notification_recipients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_recipients ALTER COLUMN id SET DEFAULT nextval('public.notification_recipients_id_seq'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);


--
-- Name: parents parent_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parents ALTER COLUMN parent_id SET DEFAULT nextval('public.parents_parent_id_seq'::regclass);


--
-- Name: permissions permission_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN permission_id SET DEFAULT nextval('public.permissions_permission_id_seq'::regclass);


--
-- Name: procurements procurement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procurements ALTER COLUMN procurement_id SET DEFAULT nextval('public.procurements_procurement_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: rooms room_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms ALTER COLUMN room_id SET DEFAULT nextval('public.rooms_room_id_seq'::regclass);


--
-- Name: semesters semester_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semesters ALTER COLUMN semester_id SET DEFAULT nextval('public.semesters_semester_id_seq'::regclass);


--
-- Name: sms_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sms_logs ALTER COLUMN id SET DEFAULT nextval('public.sms_logs_id_seq'::regclass);


--
-- Name: staff staff_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN staff_id SET DEFAULT nextval('public.staff_staff_id_seq'::regclass);


--
-- Name: student_grades grade_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_grades ALTER COLUMN grade_id SET DEFAULT nextval('public.student_grades_grade_id_seq'::regclass);


--
-- Name: student_remarks remark_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remarks ALTER COLUMN remark_id SET DEFAULT nextval('public.student_remarks_remark_id_seq'::regclass);


--
-- Name: students student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN student_id SET DEFAULT nextval('public.students_student_id_seq'::regclass);


--
-- Name: subjects subject_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects ALTER COLUMN subject_id SET DEFAULT nextval('public.subjects_subject_id_seq'::regclass);


--
-- Name: suppliers supplier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('public.suppliers_supplier_id_seq'::regclass);


--
-- Name: timetable timetable_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable ALTER COLUMN timetable_id SET DEFAULT nextval('public.timetable_timetable_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance (attendance_id, student_id, class_id, attendance_date, status, semester_id, staff_id) FROM stdin;
3	1	1	2024-09-08	present	1	\N
4	2	1	2024-09-08	present	1	\N
5	3	4	2024-09-08	present	1	\N
6	1	1	2024-09-10	late	1	\N
7	2	1	2024-09-10	present	1	\N
10	1	1	2024-09-11	present	1	\N
11	2	1	2024-09-11	absent	1	\N
12	1	1	2024-09-13	present	1	\N
13	2	1	2024-09-13	present	1	\N
14	3	4	2024-09-13	present	1	\N
1	1	1	2024-08-26	present	1	\N
21	3	4	2024-09-14	present	1	26
15	1	1	2024-09-14	absent	1	\N
16	2	1	2024-09-14	present	1	\N
25	1	1	2024-09-20	present	1	26
26	2	1	2024-09-20	present	1	26
27	3	4	2024-09-20	absent	1	26
28	1	1	2024-10-10	absent	1	26
29	2	1	2024-10-10	present	1	26
30	3	4	2024-11-06	present	1	26
\.


--
-- Data for Name: balance_adjustment_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.balance_adjustment_log (log_id, student_id, amount_adjusted, reason, adjusted_at) FROM stdin;
1	1	450.00	Invoice update for class 1 and semester 1	2024-10-10 20:17:53.267556
2	2	450.00	Invoice update for class 1 and semester 1	2024-10-10 20:17:53.267556
3	2	250.00	Invoice update for class 2 and semester 8	2025-01-14 07:28:07.607023
4	1	250.00	Invoice update for class 2 and semester 8	2025-01-14 07:28:07.607023
\.


--
-- Data for Name: bus_pick_up_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bus_pick_up_points (pick_up_id, student_id, pick_up_point_name, pick_up_price, status) FROM stdin;
1	\N	Kasoa 2	3	active
2	\N	Kasoa	30	deleted
5	\N	Kasoa 5	4	\N
6	\N	Accra 	3	\N
\.


--
-- Data for Name: class_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.class_items (class_item_id, class_id, item_id, semester_id, quantity_per_student, supplied_by, assigned_at, status) FROM stdin;
4	4	3	2	2	26	2024-10-03 00:34:27.176337	active
5	4	2	2	1	26	2024-10-03 00:34:27.176337	active
6	4	1	2	5	26	2024-10-03 00:34:27.176337	active
7	1	3	1	2	26	2024-10-04 21:46:04.024035	active
8	1	1	1	1	26	2024-10-04 21:46:04.024035	active
9	1	2	1	5	26	2024-10-04 21:46:04.024035	active
10	1	3	2	1	26	2024-10-04 22:32:05.458882	active
11	1	5	2	4	26	2024-10-04 22:32:05.458882	active
12	1	4	2	16	26	2024-10-04 22:32:05.458882	active
13	1	2	2	10	26	2024-10-04 23:36:15.396256	active
14	6	3	1	2	26	2024-10-20 08:16:04.658309	active
15	6	5	1	4	26	2024-10-20 08:16:04.658309	active
16	4	2	1	1	26	2025-01-13 14:22:29.647046	active
17	4	1	1	1	26	2025-01-13 14:22:29.647046	active
18	4	3	1	1	26	2025-01-13 14:22:29.647046	active
19	4	4	1	10	26	2025-01-13 14:22:29.647046	active
20	7	3	1	1	26	2025-01-13 14:23:52.816752	active
21	7	4	1	8	26	2025-01-13 14:23:52.816752	active
22	7	5	1	6	26	2025-01-13 14:23:52.816752	active
\.


--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classes (class_id, class_name, class_level, capacity, room_name, staff_id, status, created_at, updated_at) FROM stdin;
2	class 2b	Pre School	60	room 5	2	active	2024-08-13 19:50:34.26825+00	2024-08-13 19:50:34.26825+00
3	class 1	Pre School	60	room 5	2	active	2024-08-13 19:51:30.390517+00	2024-08-13 19:51:30.390517+00
6	Nursery 1A	Pre School	33	New Block Room 2	3	active	2024-09-08 12:20:00.486043+00	2024-09-08 12:20:00.486043+00
5	Jhs 2c	JHS	45	50	3	deleted	2024-08-14 10:40:27.110367+00	2024-08-14 10:40:27.110367+00
7	Class 3	Pre School	40	Room 20	3	active	2024-10-17 20:01:14.465045+00	2024-10-17 20:01:14.465045+00
9	Class 4	Primary	30	room 404	11	deleted	2024-10-19 10:37:35.866819+00	2024-10-19 10:37:35.866819+00
10	class 5	Primary	35	room 5	2	deleted	2024-10-19 11:28:29.224766+00	2024-10-19 11:28:29.224766+00
1	Completed	Pre School	50	room 5	2	active	2024-08-13 19:47:47.312142+00	2024-08-13 19:47:47.312142+00
11	class 6	Pre School	50		2	active	2025-01-09 21:33:00.730429+00	2025-01-09 21:33:00.730429+00
12	BS 4A	Primary	30		2	active	2025-01-10 18:23:58.330529+00	2025-01-10 18:23:58.330529+00
4	JHS 2	JHS	60	Room 20	17	active	2024-08-13 19:56:41.411305+00	2024-08-13 19:56:41.411305+00
13	class 3b	Primary	30		2	deleted	2025-01-13 12:11:35.31935+00	2025-01-13 12:11:35.31935+00
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (department_id, department_name, head_of_department, description, created_at, updated_at) FROM stdin;
1	Music Department	2	We Teach students music. \nmusic is life	2024-08-12 22:23:04.309118+00	2024-08-12 22:23:04.309118+00
\.


--
-- Data for Name: evaluations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evaluations (evaluation_id, evaluatee_id, evaluation_date, teaching_effectiveness, classroom_management, student_engagement, professionalism, comments, years_of_experience, evaluator_id, created_at, status) FROM stdin;
1	6	2024-09-19	5.0	3.0	4.0	2.0	This is the best comment ever	8	\N	2024-09-06 09:38:22.848046	active
2	12	2024-09-06	5.0	5.0	4.0	3.0	this is my second comment	10	\N	2024-09-06 14:30:46.262454	active
3	12	2024-09-10	3.0	4.0	4.0	5.0		11	\N	2024-09-25 17:34:02.25116	active
4	3	2024-09-25	1.0	1.0	1.0	1.0		1	\N	2024-09-25 17:37:51.391703	active
5	16	2024-10-07	5.0	5.0	4.0	3.0		1	\N	2024-10-07 18:48:51.356142	active
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (event_id, event_title, event_date, start_time, end_time, location, description, event_type, target_audience, created_at, status, user_id, updated_at) FROM stdin;
3	Sermon 	2024-07-28	03:13:00	03:13:00	office	discuss what is going on	Meeting	Students	2024-08-16 15:14:13.379533+00	active	6	2024-09-15 11:32:51.33743+00
2	End of first term exams 	2024-07-30	05:34:00	21:39:00	accra	gggjjgc	Sports	Parents	2024-08-14 03:38:07.836015+00	active	\N	2024-09-15 11:39:18.855637+00
1	End of term exams 	2024-08-14	08:35:00	05:33:00	accra	organising a meeting for all staff	Meeting	Staff	2024-08-14 03:32:38.085418+00	deleted	6	2024-09-15 11:32:51.33743+00
5	Founders Day	2024-09-23	19:44:00	17:47:00	office	second founders day celebration edited 	Meeting	Parents	2024-09-20 17:48:54.109365+00	active	\N	2024-09-20 17:52:32.738468+00
4	Founders Day 2	2024-09-18	14:12:00	16:12:00	classroom	description 	Holiday	Staff	2024-09-15 13:13:27.802007+00	deleted	\N	2024-10-19 20:35:32.252716+00
6	Sermon 3	2025-01-11	01:47:00	00:50:00			Holiday	Staff	2025-01-11 00:48:17.455075+00	active	\N	2025-01-11 00:50:30.31285+00
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expenses (expense_id, recipient_name, expense_category, description, amount, expense_date, invoice_number, supplier_id, staff_id, user_id, created_at) FROM stdin;
3		Supplies	supplies made	40.00	2024-09-16	401523	1	\N	26	2024-09-16 17:01:03.817017
2	Ernest  Wilson	Salaries	bawuliar updated	60.00	2024-08-28	40	\N	12	26	2024-08-29 07:45:29.013477
4	Amam Cobina	Utilities	this is the second item updated	700.00	2024-09-16	5jjhff	\N	\N	26	2024-09-16 21:40:14.099986
1	Ernest  Wilson	Salaries	this is the first description\ni am adding the user id	60.00	2024-08-28	50	1	12	26	2024-08-28 22:23:15.59297
5	Master Ebo	Maintenance	this is the latest item added	420.00	2024-09-20	invoice	\N	\N	26	2024-09-20 19:43:40.824753
6	Master Ebo	Maintenance		20.00	2024-10-08		\N	\N	26	2024-10-08 23:07:25.467438
7	mama esther	Utilities	i dont have any comments	200.00	2024-10-26		\N	\N	26	2024-10-26 18:09:12.819918
8	Addo d	Maintenance	this is the description from fees page	40.00	2024-10-26		\N	\N	26	2024-10-26 18:11:09.066957
9	Master Ebo	Utilities	no description	50.00	2024-11-07		\N	\N	26	2024-11-07 21:35:46.646725
10		Supplies		200.00	2025-01-04		3	\N	26	2025-01-04 06:27:05.258069
11	joo	Utilities		150.00	2025-01-11		\N	\N	26	2025-01-11 01:06:18.604016
\.


--
-- Data for Name: fee_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fee_collections (collection_id, student_id, payment_date, amount_received, old_balance, new_balance, fee_type, payment_mode, status, created_at, received_by, comment) FROM stdin;
1	1	2024-08-23	50.00	80.00	30.00	\N	\N	active	2024-08-23 22:52:06.443503	26	\N
2	1	2024-08-23	50.00	30.00	0.00	\N	\N	active	2024-08-23 23:48:53.982245	26	\N
3	1	2024-08-23	-32.00	0.00	32.00	\N	\N	active	2024-08-23 23:56:33.864432	26	\N
4	1	2024-08-23	40.00	32.00	0.00	\N	\N	active	2024-08-23 23:59:51.816007	26	\N
5	1	2024-08-24	-50.00	0.00	-50.00	\N	\N	active	2024-08-24 00:02:45.215038	26	\N
6	3	2024-09-16	900.00	700.00	200.00	\N	\N	active	2024-09-16 21:37:42.335603	26	not a sensible comment
7	2	2024-09-17	850.00	800.00	50.00	\N	\N	active	2024-09-17 05:46:15.338171	26	not needed
8	2	2024-10-08	50.00	50.00	0.00	\N	\N	active	2024-10-08 22:29:03.668483	26	\N
9	3	2024-10-09	300.00	2165.00	-1865.00	\N	\N	active	2024-10-09 00:32:16.91302	26	\N
10	3	2024-10-09	100.00	1865.00	-1765.00	\N	\N	active	2024-10-09 08:28:31.16789	26	\N
11	3	2024-10-09	125.00	1765.00	-1640.00	\N	\N	active	2024-10-09 17:26:26.859451	26	\N
12	3	2024-10-09	150.00	1640.00	-1490.00	\N	\N	active	2024-10-09 19:05:52.823945	26	\N
14	3	2024-10-09	36.50	1490.00	\N	\N	\N	active	2024-10-09 19:24:16.790488	26	\N
15	3	2024-10-09	60.00	1480.00	1420.00	\N	\N	active	2024-10-09 19:36:41.679802	26	\N
16	3	2024-10-09	420.00	1420.00	1000.00	\N	\N	active	2024-10-09 20:06:12.977772	26	\N
17	3	2024-10-09	40.00	1000.00	960.00	\N	\N	active	2024-10-09 20:53:45.94281	26	this is the best comment yet
18	3	2024-10-09	32.50	960.00	927.00	\N	\N	active	2024-10-09 21:06:16.128975	26	\N
19	3	2024-10-09	19.00	927.00	908.00	\N	\N	active	2024-10-09 21:08:53.451345	26	\N
20	3	2024-10-09	1.00	908.00	907.00	\N	\N	active	2024-10-09 21:11:55.74334	26	\N
21	3	2024-10-09	2.00	907.00	905.00	\N	\N	active	2024-10-09 21:21:34.792926	26	\N
22	3	2024-10-09	1.00	905.00	904.00	\N	\N	active	2024-10-09 21:25:12.925555	26	\N
23	3	2024-10-09	2.00	904.00	902.00	\N	\N	active	2024-10-09 23:13:31.926853	26	\N
24	3	2024-10-09	1.00	902.00	901.00	\N	\N	active	2024-10-09 23:15:29.191477	26	\N
25	3	2024-10-09	1.50	901.00	899.00	\N	\N	active	2024-10-09 23:25:14.01074	26	\N
27	3	2024-10-09	1.50	899.00	897.50	\N	\N	active	2024-10-09 23:55:56.647848	26	\N
28	3	2024-10-10	10.50	897.50	887.00	\N	\N	active	2024-10-10 00:14:37.43673	26	\N
29	3	2024-10-10	7.00	887.00	880.00	\N	Cash	active	2024-10-10 02:49:04.670226	26	\N
30	3	2024-10-10	8.50	880.00	871.50	\N	Cash	active	2024-10-10 02:50:52.786001	26	\N
31	4	2024-11-06	100.00	0.00	-100.00	\N	Momo	active	2024-11-06 15:14:58.426835	26	\N
32	5	2024-11-18	250.00	600.00	350.00	\N	Cash	active	2024-11-18 20:36:25.911715	26	\N
33	5	2025-01-04	300.00	350.00	50.00	\N	Cash	active	2025-01-04 06:28:40.419489	26	\N
34	3	2025-01-11	71.00	871.50	800.50	\N	Momo	active	2025-01-11 01:04:42.493594	26	\N
35	9	2025-01-12	100.00	200.00	100.00	\N	Cash	active	2025-01-12 18:37:04.040784	26	\N
36	9	2025-01-12	10.00	100.00	90.00	\N	Cash	active	2025-01-12 18:38:55.082806	26	\N
37	9	2025-01-12	10.00	90.00	80.00	\N	Cash	active	2025-01-12 18:39:56.707773	26	\N
38	9	2025-01-12	15.00	80.00	65.00	\N	Cash	active	2025-01-12 18:40:38.653221	26	\N
39	9	2025-01-12	7.00	65.00	58.00	\N	Cash	active	2025-01-12 18:45:19.556608	26	\N
40	9	2025-01-12	3.00	58.00	55.00	\N	Cash	active	2025-01-12 18:47:17.317242	26	\N
41	9	2025-01-12	4.00	55.00	51.00	\N	Cash	active	2025-01-12 19:27:50.086468	26	\N
42	9	2025-01-12	2.00	51.00	49.00	\N	Cash	active	2025-01-12 20:03:25.305049	26	\N
43	9	2025-01-12	40.00	49.00	9.00	\N	Cash	active	2025-01-12 20:23:51.423256	26	\N
44	9	2025-01-12	5.00	9.00	4.00	\N	Cash	active	2025-01-12 20:31:21.843171	26	\N
45	9	2025-01-13	20.00	4.00	-16.00	\N	Cash	active	2025-01-13 12:47:53.382547	26	\N
46	5	2025-01-13	27.00	50.00	23.00	\N	Cash	active	2025-01-13 12:48:27.331262	26	\N
47	3	2025-01-14	450.00	800.50	350.50	\N	Cash	active	2025-01-14 07:17:10.749477	26	\N
48	3	2025-01-14	40.00	350.50	310.50	\N	Cash	active	2025-01-14 07:19:34.619668	26	\N
49	5	2025-02-01	20.00	23.00	3.00	\N	Cash	active	2025-02-01 17:36:55.156174	1	\N
\.


--
-- Data for Name: feeding_fee_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feeding_fee_payments (id, student_id, class_id, collected_by, feeding_fee, valid_until_feeding, transport_fee, valid_until_transport, total_fee, semester_id, payment_date) FROM stdin;
1	5	7	26	10.00	2024-11-11	5.00	2024-11-10	15.00	1	2024-11-10 00:00:00+00
2	6	7	26	5.00	2024-11-10	3.00	2024-11-10	8.00	1	2024-11-10 00:00:00+00
3	5	7	26	5.00	2024-11-18	3.00	2024-11-18	8.00	1	2024-11-18 00:00:00+00
4	6	7	26	5.00	2024-11-18	0.00	2024-11-18	5.00	1	2024-11-18 00:00:00+00
5	3	4	26	2.00	2025-01-11	2.00	2025-01-11	4.00	1	2025-01-11 00:00:00+00
\.


--
-- Data for Name: feeding_transport_fees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feeding_transport_fees (student_id, transportation_method, feeding_fee, transport_fee, pick_up_point) FROM stdin;
10	School Bus	5.00	5.00	\N
6	By self	5.00	3.00	\N
5	 	2.00	0.00	\N
9	School Bus	150.00	3.00	1
11	School Bus	7.00	3.00	1
14	By self	0.00	\N	\N
\.


--
-- Data for Name: grading_scheme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grading_scheme (gradescheme_id, grade_name, minimum_mark, maximum_mark, grade_remark, status) FROM stdin;
1	A	90.00	100.00	EXCELLENT	active
3	Grade 4	60.00	68.00	High Average	active
2	B	70.00	80.00	GOOD	deleted
\.


--
-- Data for Name: health_incident; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.health_incident (incident_id, incident_date, incident_description, treatmentprovided, user_id) FROM stdin;
1	2024-08-05	he is the latest legend in town 	given Jesus	\N
2	2024-08-05	he is the latest legend in town 	given Jesus	\N
3	2024-08-05	he is the latest legend in town 	given Jesus	\N
4	2024-08-05	he is the latest legend in town 	given Jesus	\N
5	2024-08-05	he is the latest legend in town 2024	given Jesus	\N
6	2024-08-05	he is the latest legend in town 2024	given Jesus	\N
7	2024-08-05	he is the latest legend in town 2024	given Jesush	\N
8	2024-08-05	he is the latest legend in town 2024	given Jesush	\N
9	2024-08-06	this is a serious emergency	sent to the hospital	\N
10	2024-08-06	this is a serious emergency	sent to the hospital	\N
11	2024-08-13	hhgfghj	ythjjuu	\N
12	2024-10-19	Fell from a tall tree and broke the head on a stone	First aid administered and rushed to the hospital	\N
\.


--
-- Data for Name: inventory_class_semester; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_class_semester (inventory_id, class_id, semester_id) FROM stdin;
1	1	1
2	1	1
3	1	1
\.


--
-- Data for Name: inventory_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_items (inventory_id, inventory_name, unit_price, quantity_per_student, total_price, restock_level, status) FROM stdin;
1	uniform	15.00	3	45.00	50	active
2	Exercise Books 	5.00	10	50.00	10	active
3	My 2nd copy book	15.00	1	15.00	5	active
\.


--
-- Data for Name: invoice_class_semester; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice_class_semester (invoice_id, class_id, semester_id) FROM stdin;
22	2	1
23	2	1
24	2	1
25	2	8
26	2	8
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoices (invoice_id, amount, description, created_at, status) FROM stdin;
22	200.00	Feeding fee	2024-10-10 20:17:53.267556	active
23	200.00	Tuition Fee	2024-10-10 20:17:53.267556	active
24	50.00	Maintenance	2024-10-10 20:17:53.267556	active
25	200.00	Tuition 	2025-01-14 07:28:07.607023	active
26	50.00	Sports 	2025-01-14 07:28:07.607023	active
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (item_id, item_name, category, description, unit_price, quantity_desired, quantity_available, restock_level, status) FROM stdin;
5	Fullscap Books Note 3	supply	\N	10.00	400	187	20	active
3	Aki Ola Social Studies for Jhs 	supply	\N	3.00	30	29	5	active
1	integrated science for class 2	supply	\N	10.00	100	63	10	active
2	integrated science for class 34	supply	\N	30.00	80	13	8	deleted
4	Excercise Books note 1	supply	\N	4.00	1500	842	50	damaged
\.


--
-- Data for Name: items_movement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items_movement (supply_id, staff_id, recipient_name, recipient_phone, comments, item_id, quantity, supplied_by, supplied_at, status, movement_type, returned_at) FROM stdin;
1	\N	Amam Cobina	547323204	this is not compulsory	5	200	26	2024-10-05 19:54:06.319188	out	External	2024-10-05 22:14:10.570356
2	\N	Amam Cobina	547323204	this details is not compulsory	5	10	26	2024-10-05 20:24:00.488341	out	External	2024-10-05 22:14:10.570356
3	13		NaN	\N	5	16	26	2024-10-05 21:03:55.419095	in	Internal	2024-10-06 00:00:00
\.


--
-- Data for Name: items_supply; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items_supply (supply_id, student_id, item_id, quantity, supplied_by, supplied_at, semester_id, class_id, status) FROM stdin;
1	1	3	1	15	2024-10-04 23:28:31.143719	2	\N	active
2	1	5	3	15	2024-10-04 23:28:31.143719	2	\N	active
3	1	4	10	15	2024-10-04 23:28:31.143719	2	\N	active
4	2	3	1	15	2024-10-04 23:28:31.143719	2	\N	active
5	2	5	1	15	2024-10-04 23:28:31.143719	2	\N	active
6	2	4	16	15	2024-10-04 23:28:31.143719	2	\N	active
7	1	3	20	15	2024-10-05 00:36:36.458117	2	1	active
8	1	5	3	15	2024-10-05 00:36:36.458117	2	1	active
9	1	4	10	15	2024-10-05 00:36:36.458117	2	1	active
10	1	2	20	15	2024-10-05 00:36:36.458117	2	1	active
11	2	3	30	15	2024-10-05 00:36:36.458117	2	1	active
12	2	5	1	15	2024-10-05 00:36:36.458117	2	1	active
13	2	4	16	15	2024-10-05 00:36:36.458117	2	1	active
14	2	2	10	15	2024-10-05 00:36:36.458117	2	1	active
15	1	2	1	15	2024-10-05 01:07:03.262546	2	1	active
16	2	2	6	15	2024-10-05 01:07:03.262546	2	1	active
17	3	1	5	15	2024-11-08 02:30:08.219196	1	4	active
18	3	2	1	15	2024-11-08 02:30:08.219196	1	4	active
19	3	3	1	15	2024-11-08 02:30:08.219196	1	4	active
20	3	1	-2	15	2024-11-11 14:38:36.305094	1	4	active
\.


--
-- Data for Name: notification_recipients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_recipients (id, notification_id, recipient_id, recipient_type, is_read, read_at) FROM stdin;
1	3	1	all users	f	\N
2	3	2	all users	f	\N
3	3	3	all users	f	\N
4	3	4	all users	f	\N
5	3	6	all users	f	\N
6	3	8	all users	f	\N
7	3	9	all users	f	\N
8	3	12	all users	f	\N
9	3	13	all users	f	\N
10	3	14	all users	f	\N
11	3	15	all users	f	\N
12	3	20	all users	f	\N
13	3	21	all users	f	\N
14	4	1	all users	f	\N
15	4	2	all users	f	\N
16	4	3	all users	f	\N
17	4	4	all users	f	\N
18	4	6	all users	f	\N
19	4	8	all users	f	\N
20	4	9	all users	f	\N
21	4	12	all users	f	\N
22	4	13	all users	f	\N
23	4	14	all users	f	\N
24	4	15	all users	f	\N
25	4	20	all users	f	\N
26	4	21	all users	f	\N
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (notification_id, notification_title, notification_message, notification_type, priority, sender_id, sent_at, is_read, status, created_at) FROM stdin;
3	meeting	meeting	general	normal	6	2024-08-19 02:15:35.681418	f	active	2024-08-19 02:15:35.681418
4	Cooking 	this is the general message for you	alert	high	6	2024-08-19 03:04:51.148667	f	active	2024-08-19 03:04:51.148667
5	New Staff Added	A new staff(Ernest ) has joined the school.	general	normal	6	2024-08-19 15:32:17.380274	f	active	2024-08-19 15:32:17.380274
7	New Staff Added	A new staff(admin) has joined the school.	general	normal	6	2024-08-20 14:48:09.09222	f	active	2024-08-20 14:48:09.09222
8	New Procurement completed	A new procurement wort(2000) completed.	general	normal	26	2024-08-20 15:34:33.303374	f	active	2024-08-20 15:34:33.303374
9	New Procurement completed	A new procurement wort(3240) completed.	general	normal	26	2024-08-20 15:48:43.722116	f	active	2024-08-20 15:48:43.722116
10	Staff Member Removed	Staff member Ernest  Owusu  has been removed from the system.	general	normal	15	2024-09-06 10:33:19.895194	f	active	2024-09-06 10:33:19.895194
11	Staff Member Removed	Staff member Nelson Kweku  has been removed from the system.	general	normal	20	2024-09-06 10:36:40.468882	f	active	2024-09-06 10:36:40.468882
12	Staff Member Removed	Staff member Nelson Dorkordi has been removed from the system.	general	normal	8	2024-09-06 10:38:45.338737	f	active	2024-09-06 10:38:45.338737
13	subject Removed	subject Mathematics has been removed from the system.	general	normal	1	2024-09-06 23:03:22.458343	f	active	2024-09-06 23:03:22.458343
17	subject Removed	subject Fante has been removed from the system.	general	normal	6	2024-09-07 00:34:46.263186	f	active	2024-09-07 00:34:46.263186
19	subject Removed	subject RME has been removed from the system.	general	normal	4	2024-09-07 00:35:14.995547	f	active	2024-09-07 00:35:14.995547
20	subject Removed	subject Mathematics has been removed from the system.	general	normal	2	2024-09-07 00:35:33.755162	f	active	2024-09-07 00:35:33.755162
21	subject Removed	subject RME has been removed from the system.	general	normal	4	2024-09-07 00:37:57.496133	f	active	2024-09-07 00:37:57.496133
23	subject Removed	subject Fante has been removed from the system.	general	normal	6	2024-09-07 00:38:58.804955	f	active	2024-09-07 00:38:58.804955
25	subject Removed	subject Mathematics has been removed from the system.	general	normal	1	2024-09-07 08:26:07.769764	f	active	2024-09-07 08:26:07.769764
28	subject Removed	subject Biology has been removed from the system.	general	normal	26	2024-09-07 10:59:23.121808	f	active	2024-09-07 10:59:23.121808
29	subject Removed	subject Chemistry has been removed from the system.	general	normal	26	2024-09-07 11:00:23.519517	f	active	2024-09-07 11:00:23.519517
30	semester Removed	semester Third Term has been removed from the system.	general	normal	26	2024-09-08 01:09:00.897031	f	active	2024-09-08 01:09:00.897031
31	New Class Added	A new class "Nursery 1A" has been added to the system.	general	normal	3	2024-09-08 12:20:00.486043	f	active	2024-09-08 12:20:00.486043
32	class Removed	class Jhs 2c has been removed from the system.	general	normal	26	2024-09-08 19:39:56.716721	f	active	2024-09-08 19:39:56.716721
33	Event Added	Event Founders Day has been added to the system.	alert	normal	26	2024-09-15 13:13:27.802007	f	active	2024-09-15 13:13:27.802007
34	Event Removed	Event End of term exams  has been removed from the system.	alert	normal	26	2024-09-15 16:39:37.977906	f	active	2024-09-15 16:39:37.977906
35	subject Removed	subject French has been removed from the system.	general	normal	26	2024-09-15 17:56:05.134523	f	active	2024-09-15 17:56:05.134523
36	Event Added	Event Founders Day has been added to the system.	alert	normal	26	2024-09-20 17:48:54.109365	f	active	2024-09-20 17:48:54.109365
37	Grading scheme removed Removed	Event B has been removed from the system.	alert	normal	26	2024-09-23 01:48:19.376673	f	active	2024-09-23 01:48:19.376673
38	User Deleted	User ernest wilson (ID: 21) has been soft deleted from the system.	alert	high	26	2024-09-29 16:01:30.05622	f	active	2024-09-29 16:01:30.05622
39	item Removed	item integrated science for class 2 has been removed from the system.	general	normal	26	2024-10-01 23:39:22.113175	f	active	2024-10-01 23:39:22.113175
40	supplier Removed	supplier CEPME has been removed from the system.	general	normal	26	2024-10-01 23:46:54.248765	f	active	2024-10-01 23:46:54.248765
41	supplier Removed	supplier CEPME has been removed from the system.	general	normal	26	2024-10-01 23:47:41.54189	f	active	2024-10-01 23:47:41.54189
42	New Procurement completed	A new procurement worth(120) completed.	general	normal	26	2024-10-03 13:49:49.890444	f	active	2024-10-03 13:49:49.890444
43	New Procurement completed	A new procurement worth(750) completed.	general	normal	26	2024-10-03 13:49:49.890444	f	active	2024-10-03 13:49:49.890444
44	New Procurement completed	A new procurement worth(160) completed.	general	normal	26	2024-10-03 13:49:49.890444	f	active	2024-10-03 13:49:49.890444
45	New Procurement completed	A new procurement worth(500) completed.	general	normal	26	2024-10-03 14:26:05.873685	f	active	2024-10-03 14:26:05.873685
46	New Procurement completed	A new procurement worth(120) completed.	general	normal	26	2024-10-03 14:26:05.873685	f	active	2024-10-03 14:26:05.873685
47	New Procurement completed	A new procurement worth(120) completed.	general	normal	26	2024-10-03 14:26:05.873685	f	active	2024-10-03 14:26:05.873685
48	New Procurement completed	A new procurement worth(100) completed.	general	normal	26	2024-10-03 15:19:38.539699	f	active	2024-10-03 15:19:38.539699
49	New Procurement completed	A new procurement worth(2250) completed.	general	normal	26	2024-10-03 15:19:38.539699	f	active	2024-10-03 15:19:38.539699
50	item Removed	item integrated science for class 2 has been removed from the system.	general	normal	26	2024-10-03 20:51:26.374489	f	active	2024-10-03 20:51:26.374489
51	item Removed	item integrated science for class 2 has been removed from the system.	general	normal	26	2024-10-03 20:53:37.897599	f	active	2024-10-03 20:53:37.897599
52	item Removed	item Aki Ola Social Studies for Jhs  has been removed from the system.	general	normal	26	2024-10-03 20:54:05.592268	f	active	2024-10-03 20:54:05.592268
53	Class Supplies Added	Supplies for class 1 in semester 2 have been added.	general	normal	26	2024-10-04 23:28:31.143719	f	active	2024-10-04 23:28:31.143719
54	Class Supplies Added	Supplies for class 1 in semester 2 have been added.	general	normal	26	2024-10-05 00:36:36.458117	f	active	2024-10-05 00:36:36.458117
55	Class Supplies Updated	Supplies for class 1 in semester 2 have been updated.	general	normal	26	2024-10-05 01:07:03.262546	f	active	2024-10-05 01:07:03.262546
56	Item Movement Recorded	2 item(s) have been moved. Movement type: Internal	inventory	normal	26	2024-10-05 18:40:59.318894	f	active	2024-10-05 18:40:59.318894
57	Item Movement Recorded	2 item(s) have been moved. Movement type: Internal	inventory	normal	26	2024-10-05 18:58:47.271487	f	active	2024-10-05 18:58:47.271487
58	Item Movement Recorded	1 item(s) have been moved. Movement type: External	inventory	normal	26	2024-10-05 19:54:06.319188	f	active	2024-10-05 19:54:06.319188
59	Item Movement Recorded	1 item(s) have been moved. Movement type: External	inventory	normal	26	2024-10-05 20:24:00.488341	f	active	2024-10-05 20:24:00.488341
60	Item Movement Recorded	1 item(s) have been moved. Movement type: Internal	inventory	normal	26	2024-10-05 21:03:55.419095	f	active	2024-10-05 21:03:55.419095
61	Item Received	16 Fullscap Books Note 3(s) have been received.	inventory	normal	\N	2024-10-06 02:04:19.456263	f	active	2024-10-06 02:04:19.456263
62	New Staff Added	A new staff(Patience ) has joined the school.	general	normal	26	2024-10-07 13:09:01.706378	f	active	2024-10-07 13:09:01.706378
63	New Class Added	A new class "Class 3" has been added to the system.	general	normal	3	2024-10-17 20:01:14.465045	f	active	2024-10-17 20:01:14.465045
64	Supplier updated	Supplier Aki Ola Publications has been updated the system.	general	normal	26	2024-10-18 19:20:02.3255	f	active	2024-10-18 19:20:02.3255
65	supplier Removed	supplier Aki Ola Publications has been removed from the system.	general	normal	26	2024-10-18 19:22:51.6563	f	active	2024-10-18 19:22:51.6563
67	New Class Added	A new class "Class 4" has been added to the system.	general	normal	26	2024-10-19 10:37:35.866819	f	active	2024-10-19 10:37:35.866819
68	New Class Added	A new class "class 5" has been added to the system.	general	normal	26	2024-10-19 11:28:29.224766	f	active	2024-10-19 11:28:29.224766
69	class Removed	class Class 4 has been removed from the system.	general	normal	26	2024-10-19 11:44:08.897451	f	active	2024-10-19 11:44:08.897451
70	Event Removed	Event Founders Day 2 has been removed from the system.	alert	normal	26	2024-10-19 20:47:27.761997	f	active	2024-10-19 20:47:27.761997
71	item updated	Item Excercise Books note 1 has been updated the system. the current status is damaged	general	normal	26	2024-10-19 23:22:28.054712	f	active	2024-10-19 23:22:28.054712
72	User Deleted	User johnnyarkoh (ID: 30) has been soft deleted from the system.	alert	high	26	2024-10-21 00:16:58.761308	f	active	2024-10-21 00:16:58.761308
73	New Procurement completed	A new procurement worth(200) completed.	general	normal	26	2024-10-27 07:13:05.267938	f	active	2024-10-27 07:13:05.267938
74	New Procurement completed	A new procurement worth(25) completed.	general	normal	26	2024-10-27 07:13:05.267938	f	active	2024-10-27 07:13:05.267938
75	New Procurement completed	A new procurement worth(8) completed.	general	normal	26	2024-10-27 07:13:05.267938	f	active	2024-10-27 07:13:05.267938
76	New Student Registration	A new student Emmanuel  Foli has been registered with ID: 6	student	normal	38	2024-11-08 00:46:24.499533	f	active	2024-11-08 00:46:24.499533
77	Student Information Updated	Student Emmanuel  Foli's information has been updated.	student	normal	38	2024-11-08 01:15:39.428027	f	active	2024-11-08 01:15:39.428027
78	Class Supplies Updated	Supplies for class 4 in semester 1 have been updated.	general	normal	26	2024-11-08 02:30:08.219196	f	active	2024-11-08 02:30:08.219196
79	Class Supplies Updated	Supplies for class 4 in semester 1 have been updated.	general	normal	26	2024-11-11 14:38:36.305094	f	active	2024-11-11 14:38:36.305094
80	class Removed	class class 2a has been removed from the system.	general	normal	26	2024-11-17 21:09:39.587179	f	active	2024-11-17 21:09:39.587179
81	class Removed	class class 5 has been removed from the system.	general	normal	26	2024-11-17 21:27:38.110256	f	active	2024-11-17 21:27:38.110256
82	Student Information Updated	Student Emmanuel  Foli's information has been updated.	student	normal	38	2024-11-18 13:30:03.063696	f	active	2024-11-18 13:30:03.063696
83	Student Information Updated	Student Emmanuel  Foli's information has been updated.	student	normal	38	2024-11-18 13:31:21.966426	f	active	2024-11-18 13:31:21.966426
84	Student Information Updated	Student Emmanuel  Foli's information has been updated.	student	normal	38	2024-11-18 14:03:17.141354	f	active	2024-11-18 14:03:17.141354
85	Parent Removed	Parent Edward 58 Attah 85 has been removed from the system.	general	normal	26	2024-11-18 14:09:54.010619	f	active	2024-11-18 14:09:54.010619
86	Student Information Updated	Student Emmanuel  Foli's information has been updated.	student	normal	38	2024-11-18 14:15:07.62688	f	active	2024-11-18 14:15:07.62688
87	Student Information Updated	Student Emmanuel  Foli's information has been updated.	student	normal	38	2024-11-18 14:16:19.315336	f	active	2024-11-18 14:16:19.315336
88	Student Information Updated	Student Emmanuel  Foli's information has been updated.	student	normal	38	2024-11-18 14:20:04.23192	f	active	2024-11-18 14:20:04.23192
89	New Class Added	A new class "class 6" has been added to the system.	general	normal	26	2025-01-09 21:33:00.730429	f	active	2025-01-09 21:33:00.730429
90	New Class Added	A new class "BS 4A" has been added to the system.	general	normal	26	2025-01-10 18:23:58.330529	f	active	2025-01-10 18:23:58.330529
91	Event Added	Event Sermon  has been added to the system.	alert	normal	26	2025-01-11 00:48:17.455075	f	active	2025-01-11 00:48:17.455075
92	item updated	Item integrated science for class 34 has been updated the system. the current status is active	general	normal	26	2025-01-11 01:16:19.841842	f	active	2025-01-11 01:16:19.841842
93	item Removed	item integrated science for class 34 has been removed from the system.	general	normal	26	2025-01-11 01:16:31.710027	f	active	2025-01-11 01:16:31.710027
94	Supplier updated	Supplier Aki Ola Publications22 has been updated the system.	general	normal	26	2025-01-11 01:16:56.724565	f	active	2025-01-11 01:16:56.724565
95	supplier Removed	supplier Aki Ola Publications22 has been removed from the system.	general	normal	26	2025-01-11 01:17:07.921229	f	active	2025-01-11 01:17:07.921229
96	semester Removed	semester Second Term has been removed from the system.	general	normal	26	2025-01-11 01:47:01.015179	f	active	2025-01-11 01:47:01.015179
97	Grading scheme removed Removed	Event B has been removed from the system.	alert	normal	26	2025-01-11 01:54:24.837988	f	active	2025-01-11 01:54:24.837988
98	New Staff Added	A new staff(Alex ) has joined the school.	general	normal	26	2025-01-11 02:06:42.421319	f	active	2025-01-11 02:06:42.421319
99	Staff Member Removed	Staff member Nelson Kweku  has been removed from the system.	general	normal	20	2025-01-11 02:28:41.670896	f	active	2025-01-11 02:28:41.670896
100	New Student Registration	A new student Grace  Acquah has been registered with ID: 9	student	normal	50	2025-01-11 02:35:43.638219	f	active	2025-01-11 02:35:43.638219
101	Student Information Updated	Student Grace  Acquah's information has been updated.	student	normal	50	2025-01-11 02:54:59.50045	f	active	2025-01-11 02:54:59.50045
102	Student Information Updated	Student Richmond Adasu 's information has been updated.	student	normal	36	2025-01-11 02:57:40.350917	f	active	2025-01-11 02:57:40.350917
103	Student Information Updated	Student Richmond Adasu 's information has been updated.	student	normal	36	2025-01-11 02:59:54.815424	f	active	2025-01-11 02:59:54.815424
104	Student Information Updated	Student Richmond Adasu 's information has been updated.	student	normal	36	2025-01-11 03:03:44.252535	f	active	2025-01-11 03:03:44.252535
105	Student Information Updated	Student Richmond Adasu 's information has been updated.	student	normal	36	2025-01-11 03:07:30.723396	f	active	2025-01-11 03:07:30.723396
106	subject Removed	subject chinese has been removed from the system.	general	normal	26	2025-01-11 03:15:23.113232	f	active	2025-01-11 03:15:23.113232
107	Student Information Updated	Student Grace  Acquah's information has been updated.	student	normal	50	2025-01-11 03:19:57.297541	f	active	2025-01-11 03:19:57.297541
108	Student Information Updated	Student Grace  Acquah's information has been updated.	student	normal	50	2025-01-11 03:32:03.504448	f	active	2025-01-11 03:32:03.504448
109	User Deleted	User alfred acquah (ID: 63) has been soft deleted from the system.	alert	high	26	2025-01-11 03:33:55.033686	f	active	2025-01-11 03:33:55.033686
110	User Deleted	User christiana gyato (ID: 61) has been soft deleted from the system.	alert	high	26	2025-01-11 03:34:40.136697	f	active	2025-01-11 03:34:40.136697
111	User Deleted	User edward 23 attah 3 (ID: 62) has been soft deleted from the system.	alert	high	26	2025-01-11 03:34:47.88111	f	active	2025-01-11 03:34:47.88111
112	User Deleted	User alfred acquah (ID: 63) has been soft deleted from the system.	alert	high	26	2025-01-12 16:41:05.009489	f	active	2025-01-12 16:41:05.009489
113	New Class Added	A new class "class 3b" has been added to the system.	general	normal	26	2025-01-13 12:11:35.31935	f	active	2025-01-13 12:11:35.31935
114	Class Removed	Class class 3b has been removed from the system.	general	normal	26	2025-01-13 12:13:49.553034	f	active	2025-01-13 12:13:49.553034
115	item updated	Item Excercise Books note 1 has been updated the system. the current status is damaged	general	normal	26	2025-01-13 14:21:25.771933	f	active	2025-01-13 14:21:25.771933
116	New Student Registration	A new student Margaret  Attah  has been registered with ID: 10	student	normal	65	2025-01-20 10:39:02.022079	f	active	2025-01-20 10:39:02.022079
117	New Student Registration	A new student Kojo Nelson has been registered with ID: 11	student	normal	67	2025-01-20 10:43:36.828989	f	active	2025-01-20 10:43:36.828989
118	New Staff Added	A new staff(David) has joined the school.	general	normal	26	2025-01-21 06:52:31.455345	f	active	2025-01-21 06:52:31.455345
119	Student Information Updated	Student Grace  Acquah's information has been updated.	student	normal	50	2025-01-22 06:57:15.797923	f	active	2025-01-22 06:57:15.797923
120	Student Information Updated	Student Grace  Acquah's information has been updated.	student	normal	50	2025-01-22 07:00:22.376229	f	active	2025-01-22 07:00:22.376229
121	Student Information Updated	Student Kojo Nelson's information has been updated.	student	normal	67	2025-01-22 07:02:16.340122	f	active	2025-01-22 07:02:16.340122
122	Pick-up point updated	Pick-up point Kasoa 2 has been updated the system.	general	normal	1	2025-01-30 09:52:21.392516	f	active	2025-01-30 09:52:21.392516
123	Pick-up point deleted	Pick-up point "Kasoa" has been soft deleted from the system.	general	normal	\N	2025-01-30 10:37:28.51777	f	active	2025-01-30 10:37:28.51777
124	New Student Registration	A new student Nelson Dorkordi has been registered with ID: 14	student	normal	72	2025-02-01 18:29:00.740949	f	active	2025-02-01 18:29:00.740949
\.


--
-- Data for Name: parents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parents (parent_id, other_names, last_name, phone, email, address, status, user_id) FROM stdin;
7	Yaa	Yaa	054575686	atlfrt@gmail.com	Ghana post gps 25634	active	34
3	Cecilia 	Akwasikumah	0249760060	parent@gmail.com	Apam	active	\N
5	David 	Attah	0571141320	david@attah.nk	Wurupong Rc	inactive	\N
4	Edward 	Nyarkoh	0244024457	edwardnyarkoh2@gmail.com	America	deleted	\N
8	Edward 58	Attah 85	0249760060	parent2@gmail.com	apam church service	deleted	39
6	Yaa	Nooyoo	0551544776	yaanooyoo@gmail.com	Ghana post gps 25634	active	33
9	Kofi	Nimo	0551544776	kofinimo@gmail.com	Ghana post gps 25634	active	45
1	christiana	Gyato	0244024457	parent@gmail.com	apam church servicef	deleted	61
2	Edward 23	Attah 3	0249760060	parent2@gmail.com	apam church service	deleted	62
12	Alfred	Acquah	0547323204			active	66
10	Alfred	Acquah	0244044846		xcs	deleted	63
13	Christiana	Acquah	+233551577446		cvcfccd	active	68
11	Innocentia 	Acquah	0244997473			active	64
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (permission_id, permission_name) FROM stdin;
70	view attendance
71	take attendance
72	view attendance report
73	view attendance analytics
74	view classes
75	add class
76	delete class
77	view events
78	add event
79	add expense
80	view feeding fee and tnt
81	take feeding and tnt
82	take fees
83	view finances
84	add bills
85	view examinations
86	record assessment
87	promote students
88	view masters sheet
89	view report cards
90	add remarks
91	add grading scheme
92	add health incident
93	view health record
94	send sms
95	view sms
96	view notification
97	send notification
98	view parents
99	delete parents
100	view semesters
101	close semester
102	add semester
103	delete semester
104	view staff
105	add staff
106	evaluate staff
107	delete staff
108	view students
109	add student
110	delete student
111	view subjects
112	add subjects
113	add subject
114	delete subject
115	add timetable
116	add role
117	delete user
118	assign roles
119	assign permissions
120	delete event
121	view fees
122	view student's payment history
123	view financial report
124	delete grading scheme
125	view users
126	view items
127	delete item
128	manage supply
129	view stock items
130	delete supply items
\.


--
-- Data for Name: procurements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.procurements (procurement_id, item_id, supplier_id, unit_cost, quantity, total_cost, procurement_date, brought_by, received_by, received_at, status) FROM stdin;
1	3	1	10.00	50	500.00	2024-10-08	\N	15	2024-10-03 14:26:05.873685	active
2	1	1	20.00	6	120.00	2024-10-08	\N	15	2024-10-03 14:26:05.873685	active
3	2	1	6.00	20	120.00	2024-10-08	\N	15	2024-10-03 14:26:05.873685	active
4	3	1	10.00	10	100.00	2024-09-29	\N	15	2024-10-03 15:19:38.539699	active
5	1	1	50.00	45	2250.00	2024-09-29	\N	15	2024-10-03 15:19:38.539699	active
6	3	3	10.00	20	200.00	2024-10-27	\N	15	2024-10-27 07:13:05.267938	active
7	5	3	5.00	5	25.00	2024-10-27	\N	15	2024-10-27 07:13:05.267938	active
8	3	3	4.00	2	8.00	2024-10-27	\N	15	2024-10-27 07:13:05.267938	active
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (role_id, permission_id) FROM stdin;
1	84
1	75
1	78
1	79
1	91
1	90
1	92
1	116
1	102
1	105
1	109
1	113
1	112
1	115
1	119
1	118
1	101
1	76
1	120
1	124
1	127
1	99
1	103
1	107
1	110
1	114
1	130
1	117
1	106
1	128
1	87
1	86
1	97
1	94
1	71
1	81
1	82
1	70
1	73
1	72
1	74
1	77
1	85
1	80
1	121
1	83
1	123
1	93
1	126
1	88
1	96
1	98
1	89
1	100
1	95
1	104
1	129
1	122
1	108
1	111
1	125
4	81
4	80
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (role_id, role_name) FROM stdin;
1	Admin
2	Head Teacher
3	Teaching Staff
4	feeding fee collector
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooms (room_id, room_name) FROM stdin;
\.


--
-- Data for Name: semesters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.semesters (semester_id, semester_name, start_date, end_date, status) FROM stdin;
8	Third Term	2024-10-01	2024-11-07	upcoming
2	Second Term	2024-09-01	2024-09-30	deleted
1	First Term	2024-07-28	2025-02-05	active
\.


--
-- Data for Name: sms_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sms_logs (id, recipient_type, message_type, sender_id, recipients_id, message_content, total_attempeted, total_invalid_numbers, total_successful, total_failed, successful_recipients_ids, failed_receipients_ids, invalid_recipients_ids, invalid_recippients_phone, api_response, send_timestamp, total_sms_used) FROM stdin;
23	students	\N	26	{31,29,30}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	3	0	3	0	{}	{}	{36,38}	{055136961,055465235}	{"data": [{"id": "9fc43184-e04e-4d17-9876-72ad77c49edc", "recipient": "233504238397"}, {"id": "b23b8c75-ea4c-42a0-b4a6-713d4fbb8b2f", "recipient": "233551577446"}, {"id": "72e59890-fade-4e4f-8f54-94db8f9085b7", "recipient": "233551577446"}], "status": "success"}	2024-12-18 09:36:30.72518	\N
24	users	\N	26	{26,39,39,12,45,31,9,29,32,35,33,3,38,22,14,6,1,4,13,36,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	11	10	11	0	{}	{}	{3,38,22,14,6,1,4,13,36,34}	{NULL,055465235,25844245,NULL,NULL,NULL,NULL,NULL,055136961,054575686}	{"data": [{"id": "2fe42ac4-c5be-416f-a073-7d8c86b1f000", "recipient": "233551577446"}, {"id": "c81e572d-4fc1-4be6-934b-a7078939787f", "recipient": "233249760060"}, {"id": "0c0ee17a-910d-4302-ade5-7dd4460cc975", "recipient": "233249760060"}, {"id": "b68581e6-a97c-4876-9fdb-23333c0dceea", "recipient": "233551577446"}, {"id": "f2ba2620-7660-4603-a180-60c0ee6b4b73", "recipient": "233551544776"}, {"id": "ec8a8cbb-5bb8-4e11-9f61-1b63f0d259bb", "recipient": "233504238397"}, {"id": "434b2a5a-0b8c-4a19-b03b-277791067a58", "recipient": "233551577446"}, {"id": "1afe23f0-c0fc-4377-a5a5-bf5e7b9aac3e", "recipient": "233551577446"}, {"id": "62ec6dc1-0ac0-49b0-a2c0-76e9d200f97c", "recipient": "233547323204"}, {"id": "5c2ef3bb-e2c6-4218-b7a0-86130b25513e", "recipient": "233547323204"}, {"id": "a15c40ef-a0de-4083-bd5d-364ce72ef4ed", "recipient": "233551544776"}], "status": "success"}	2024-12-18 09:52:46.369043	\N
25	users	\N	26	{26,39,39,12,45,31,9,29,32,35,33,3,38,22,14,6,1,4,13,36,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	21	10	11	0	{}	{}	{3,38,22,14,6,1,4,13,36,34}	{NULL,055465235,25844245,NULL,NULL,NULL,NULL,NULL,055136961,054575686}	{"data": [{"id": "f088706e-1761-4c2c-abde-cf3cfe2976e4", "recipient": "233551577446"}, {"id": "76d2ecc2-7bec-4a11-a1a0-70f514b9c4b2", "recipient": "233249760060"}, {"id": "4147f579-2b63-4d88-8bcf-88af56c508fb", "recipient": "233249760060"}, {"id": "efac6e64-f207-421e-a92d-25dcb418bad3", "recipient": "233551577446"}, {"id": "5af2776a-3d58-4cf5-990e-6fef24de3764", "recipient": "233551544776"}, {"id": "dd54d280-6a36-4251-b47e-cb2f3ee1def9", "recipient": "233504238397"}, {"id": "a2eeb3a7-28f7-49b1-b056-e39715a0c1a2", "recipient": "233551577446"}, {"id": "437d8c08-8b2a-4ca7-9742-6a14b544cf79", "recipient": "233551577446"}, {"id": "e17d7643-f07e-4c8d-a857-3391186004de", "recipient": "233547323204"}, {"id": "0d2ffb72-8b79-41a0-b10b-cda5c12c688e", "recipient": "233547323204"}, {"id": "b2c6fb99-001a-40ac-a697-0d5ffcdd625c", "recipient": "233551544776"}], "status": "success"}	2024-12-18 09:54:35.433215	\N
26	users	\N	26	{39,39,12,45,31,9,29,32,35,33,3,38,22,14,6,1,4,13,36,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	20	10	10	0	{}	{}	{3,38,22,14,6,1,4,13,36,34}	{NULL,055465235,25844245,NULL,NULL,NULL,NULL,NULL,055136961,054575686}	{"data": [{"id": "8d87d36d-54b8-4a42-9a65-b0e13ca44fc6", "recipient": "233249760060"}, {"id": "222a1921-31f0-43e8-bce9-cffdf33a4c10", "recipient": "233249760060"}, {"id": "6cde76b5-b9b0-425e-9a93-78e2e84b9c56", "recipient": "233551577446"}, {"id": "d09d83c8-fefb-4e39-b4f5-a83bcc5813a6", "recipient": "233551544776"}, {"id": "2e124449-87d7-45c8-a9b9-2422aef8451e", "recipient": "233504238397"}, {"id": "a40dd4b1-9897-47ed-b5ab-d764d08a5080", "recipient": "233551577446"}, {"id": "9c25bf48-3fbc-4b33-8679-bd645dd82788", "recipient": "233551577446"}, {"id": "da711da7-3106-4b6c-93ab-0401b76c2d28", "recipient": "233547323204"}, {"id": "c9d165c0-c6e0-40a6-80a7-4070c84947f7", "recipient": "233547323204"}, {"id": "49eb7b7f-f52f-4291-b598-2c45e4def181", "recipient": "233551544776"}], "status": "success"}	2024-12-18 09:57:54.19286	\N
27	students	\N	26	{31,29,30,36,38}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	5	2	3	0	{}	{}	{36,38}	{055136961,055465235}	{"data": [{"id": "d8a91149-3f14-45b8-a468-d098d030b10e", "recipient": "233504238397"}, {"id": "0d7832d1-0689-4740-af8b-e45aee92f50c", "recipient": "233551577446"}, {"id": "ce656395-c7bc-4784-aa38-b7d85d2bb358", "recipient": "233551577446"}], "status": "success"}	2024-12-18 10:02:58.208128	\N
28	students	\N	26	{31,36,38}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	3	2	1	0	{}	{}	{36,38}	{055136961,055465235}	{"data": [{"id": "40870ade-7c10-4a1a-aa09-87ee97bf62aa", "recipient": "233504238397"}], "status": "success"}	2024-12-18 10:09:16.984176	\N
29	users	\N	26	{26,39,39,12,45,31,9,29,32,35,33,3,38,22,14,6,1,4,13,36,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	11	10	11	0	{NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL}	{26,39,39,12,45,31,9,29,32,35,33}	{3,38,22,14,6,1,4,13,36,34}	{NULL,055465235,25844245,NULL,NULL,NULL,NULL,NULL,055136961,054575686}	{"data": [{"id": "1231d0a8-10d8-4d6e-a4b8-69215f4c9552", "recipient": "233551577446"}, {"id": "b6160042-053c-4b7d-9a9b-b62095800a23", "recipient": "233249760060"}, {"id": "2706dc51-04da-45d3-8ee4-bad9e64a9100", "recipient": "233249760060"}, {"id": "5a81d2e1-d3e8-4473-975f-65b948df702e", "recipient": "233551577446"}, {"id": "7b9a9ccd-01eb-4654-a0a1-d29531673acb", "recipient": "233551544776"}, {"id": "cd3551d2-20bf-4962-97a3-9595542e925e", "recipient": "233504238397"}, {"id": "845cb8f4-f687-4bd4-bece-2fef5ff5df15", "recipient": "233551577446"}, {"id": "40944425-2597-4884-be66-b072e89274a9", "recipient": "233551577446"}, {"id": "3c3cb6a8-b98f-44c1-976c-19e2e46cbacb", "recipient": "233547323204"}, {"id": "285bd29a-3c2c-475b-9a14-a260dd9a4c78", "recipient": "233547323204"}, {"id": "b375797b-097a-4c82-90c1-fabc84c725e4", "recipient": "233551544776"}], "status": "success"}	2024-12-18 10:37:59.015789	\N
41	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	0	5	0	0	{}	{}	{29,30,31,36,38}	{0551577446,0551577446,0504238397,055136961,055465235}	{}	2024-12-18 16:15:58.890117	\N
42	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	0	5	0	0	{}	{}	{29,30,31,36,38}	{0551577446,0551577446,0504238397,055136961,055465235}	{}	2024-12-18 16:17:57.792324	\N
30	users	\N	26	{26,39,39,12,45,31,9,29,32,35,33,3,38,22,14,6,1,4,13,36,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	11	10	11	0	{NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL}	{26,39,39,12,45,31,9,29,32,35,33}	{3,38,22,14,6,1,4,13,36,34}	{NULL,055465235,25844245,NULL,NULL,NULL,NULL,NULL,055136961,054575686}	{"data": [{"id": "30f5b7a2-bc0a-41df-9ff0-85a4fbbdcb96", "recipient": "233551577446"}, {"id": "25c55d61-24aa-46c2-b679-6a29c1853bdd", "recipient": "233249760060"}, {"id": "ec01b626-198e-4e2a-a1b7-e2da2911dbb3", "recipient": "233249760060"}, {"id": "374621f6-5b35-4fb8-a092-c56995ebae12", "recipient": "233551577446"}, {"id": "8cb2bb2e-c52d-4529-97d2-8dab5753e5d8", "recipient": "233551544776"}, {"id": "9be7fa2e-74a4-4981-b6cd-f046ad371f2d", "recipient": "233504238397"}, {"id": "96c27c31-4cf9-4b7d-8115-2980bc4438e3", "recipient": "233551577446"}, {"id": "e3bd6938-541d-4976-9ee9-fb54ad19cbff", "recipient": "233551577446"}, {"id": "ffe7cbd1-12a7-4767-abb9-1d62843c969b", "recipient": "233547323204"}, {"id": "75f59114-ddb3-468c-8a41-ae7a43dbc026", "recipient": "233547323204"}, {"id": "a0da5ed6-b0a2-44c5-9258-75b768808764", "recipient": "233551544776"}], "status": "success"}	2024-12-18 10:40:20.37654	\N
31	students	\N	26	{31,29,30,36,38}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	3	2	3	0	{NULL,NULL,NULL}	{31,29,30}	{36,38}	{055136961,055465235}	{"data": [{"id": "d08d8e3a-93e8-4016-8607-e6665c40a03f", "recipient": "233504238397"}, {"id": "0a82254b-09f8-4995-9694-17d0b6513e26", "recipient": "233551577446"}, {"id": "58c23561-6590-463e-ae16-1e6a7e5d670c", "recipient": "233551577446"}], "status": "success"}	2024-12-18 10:45:12.46097	\N
32	users	\N	26	{26,12,45,31,9,29,32,35,33,3,38,22,1,4,13,36,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	17	8	9	0	{26,26,45,31,26,26,32,32,45}	{}	{3,38,22,1,4,13,36,34}	{NULL,055465235,25844245,NULL,NULL,NULL,055136961,054575686}	{"data": [{"id": "45a4ca01-5e76-4285-825a-6398e1500c52", "recipient": "233551577446"}, {"id": "f4239f61-5d41-470b-9e2e-f6307ab9a63a", "recipient": "233551577446"}, {"id": "afd175f5-3df0-493b-bec9-49ed1fe5089a", "recipient": "233551544776"}, {"id": "df7f9d97-cb6a-48f3-9f59-2bf89ef6db75", "recipient": "233504238397"}, {"id": "dba962ab-67bd-446c-8656-eca41c0863a1", "recipient": "233551577446"}, {"id": "a20a0ee3-9a8f-45e7-9872-56e2ceb10d00", "recipient": "233551577446"}, {"id": "9f887cf0-eea0-4c9b-bf54-f1091d425e6a", "recipient": "233547323204"}, {"id": "c94acb15-34bb-4fa7-b623-0a989edde0aa", "recipient": "233547323204"}, {"id": "5ab9bb10-c569-4c42-a957-cc25edcb2a60", "recipient": "233551544776"}], "status": "success"}	2024-12-18 11:03:12.523581	\N
33	users	general	26	{26,39,39,12,45,31,9,29,32,35,33,3,38,22,14,6,1,4,13,36,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	21	10	11	0	{26,39,39,26,45,31,26,26,32,32,45}	{}	{3,38,22,14,6,1,4,13,36,34}	{NULL,055465235,25844245,NULL,NULL,NULL,NULL,NULL,055136961,054575686}	{"data": [{"id": "0d729c53-5f1c-45d2-8e58-eaedb8eca103", "recipient": "233551577446"}, {"id": "1a7e2166-6976-4471-a571-4b753d5a6f63", "recipient": "233249760060"}, {"id": "1ac4c7e6-11f6-426e-a753-d422f70e7d08", "recipient": "233249760060"}, {"id": "83ffb4cf-69ba-4d22-b7d3-7bfad3c6dbad", "recipient": "233551577446"}, {"id": "99a7677a-a14c-4524-a960-adaba65e2171", "recipient": "233551544776"}, {"id": "095b58c1-fb63-4380-9d2e-29fdd0ffb348", "recipient": "233504238397"}, {"id": "0c02153b-32f7-4b0d-8222-fc12c46d59d4", "recipient": "233551577446"}, {"id": "0f0a31e3-289c-4932-99a6-2417006d7276", "recipient": "233551577446"}, {"id": "a5f335d2-7e31-4f49-ad81-c0810e1186a9", "recipient": "233547323204"}, {"id": "64be5ed4-bab4-4a3f-ba69-27249461e5fd", "recipient": "233547323204"}, {"id": "00767ee6-81cc-445d-8b9d-df41138b4a54", "recipient": "233551544776"}], "status": "success"}	2024-12-18 11:18:25.605817	\N
34	students owing	fee_reminder	26	{29,29,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	0	5	0	0	{}	{}	{29,29,31,36,38}	{233551577446,233551577446,233504238397,55136961,55465235}	{}	2024-12-18 15:41:28.463339	\N
35	students owing	fee_reminder	26	{29,29,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	0	5	0	0	{}	{}	{29,29,31,36,38}	{233551577446,233551577446,233504238397,55136961,55465235}	{}	2024-12-18 15:43:24.931509	\N
36	students owing	fee_reminder	26	{29,29,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	0	5	0	0	{}	{}	{29,29,31,36,38}	{233551577446,233551577446,233504238397,55136961,55465235}	{}	2024-12-18 15:46:25.280931	\N
37	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	0	5	0	0	{}	{}	{29,30,31,36,38}	{0551577446,0551577446,0504238397,055136961,055465235}	{}	2024-12-18 15:56:16.934738	\N
38	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	0	5	0	0	{}	{}	{29,30,31,36,38}	{0551577446,0551577446,0504238397,055136961,055465235}	{}	2024-12-18 15:58:48.964387	\N
39	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	0	5	0	0	{}	{}	{29,30,31,36,38}	{0551577446,0551577446,0504238397,055136961,055465235}	{}	2024-12-18 16:09:36.562444	\N
40	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	0	5	0	0	{}	{}	{29,30,31,36,38}	{0551577446,0551577446,0504238397,055136961,055465235}	{}	2024-12-18 16:13:56.449302	\N
43	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	3	2	3	0	{29,30,31}	{}	{36,38}	{055136961,055465235}	{"data": [{"id": "a5849678-3823-4ab1-a671-24ab5d0084e5", "recipient": "233551577446"}, {"id": "70a9478f-fdf6-4363-82ef-9cf831de5075", "recipient": "233551577446"}, {"id": "a780c22c-ae23-482a-823e-b0b6af0fbb71", "recipient": "233504238397"}], "status": "success"}	2024-12-18 16:28:49.945655	\N
44	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	3	2	3	0	{29,30,31}	{}	{36,38}	{055136961,055465235}	{"data": [{"id": "cd0bbcc3-a223-43d2-a9c4-829e72d057be", "recipient": "233551577446"}, {"id": "37e257e0-2d7d-44e8-84cd-bceccf1dd93b", "recipient": "233551577446"}, {"id": "82fead44-dec0-4154-acaa-c1e55fe6211f", "recipient": "233504238397"}], "status": "success"}	2024-12-18 16:35:58.186386	\N
45	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	3	2	3	0	{29,30,31}	{}	{36,38}	{055136961,055465235}	{"data": [{"id": "b318f86b-bc2e-420e-9fba-beb1c8940b7c", "recipient": "233551577446"}, {"id": "4987772d-36b8-4157-b1e1-1b706b3fdf67", "recipient": "233551577446"}, {"id": "486edf62-0971-4f68-9e7c-603d22c6c510", "recipient": "233504238397"}], "status": "success"}	2024-12-18 16:54:15.6263	\N
46	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	3	2	0	3	{}	{29,29,31}	{36,38}	{055136961,055465235}	{}	2024-12-18 17:05:04.089354	\N
47	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	3	2	0	3	{}	{29,29,31}	{36,38}	{055136961,055465235}	{}	2024-12-18 17:08:49.395516	\N
48	users	general	26	{26,39,39,12,45,31,9,29,32,35,33,3,38,22,14,6,1,4,13,36,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	21	10	11	0	{26,39,39,26,45,31,26,26,32,32,45}	{}	{3,38,22,14,6,1,4,13,36,34}	{NULL,055465235,25844245,NULL,NULL,NULL,NULL,NULL,055136961,054575686}	{"data": [{"id": "df483f02-783c-4fac-ba3e-890202e089f3", "recipient": "233551577446"}, {"id": "b7737698-b021-4e02-bcaf-d900b6293e85", "recipient": "233249760060"}, {"id": "9b99b20a-bd76-4491-897d-50344ee787dc", "recipient": "233249760060"}, {"id": "432f4a37-3dd0-40a6-966d-21e8b03754be", "recipient": "233551577446"}, {"id": "ec9b1daa-7c1e-47c8-bcf6-775207eaba9f", "recipient": "233551544776"}, {"id": "b7049c75-a95f-4b09-a815-aa591f5f5254", "recipient": "233504238397"}, {"id": "24161486-1805-49b9-96a7-807671fbe085", "recipient": "233551577446"}, {"id": "44734f49-e783-49b2-b79b-a30e225a4e58", "recipient": "233551577446"}, {"id": "47975dae-a1f2-4d88-9e38-5abfa5c85701", "recipient": "233547323204"}, {"id": "f763fc35-400a-4551-b8e2-02e11057431d", "recipient": "233547323204"}, {"id": "5fe035b2-e004-4599-840e-eb1a0ca27d5a", "recipient": "233551544776"}], "status": "success"}	2024-12-18 22:05:09.520569	\N
49	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	0	5	0	0	{}	{}	{29,30,31,36,38}	{0551577446,0551577446,0504238397,055136961,055465235}	{}	2024-12-18 22:18:22.399894	\N
50	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	0	5	0	0	{}	{}	{29,30,31,36,38}	{0551577446,0551577446,0504238397,055136961,055465235}	{}	2024-12-18 22:40:46.987951	\N
51	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	3	2	3	0	{29,29,31}	{}	{36,38}	{055136961,055465235}	[{"response": {"data": [{"id": "137569e2-511e-4940-a67f-3df20579c6a6", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "ff14ade1-7126-4f74-aa8a-d7c266c2b783", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "ede6d7b8-0742-4325-838b-4387712e6e55", "recipient": "233504238397"}], "status": "success"}, "recipient": "233504238397"}]	2024-12-19 00:11:31.906192	\N
52	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	3	2	3	0	{29,29,31}	{}	{36,38}	{055136961,055465235}	[{"response": {"data": [{"id": "012c341c-3ea2-42dd-8cc7-1e8eb3cfaa20", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "aa1b9877-daa1-45cd-8f59-37afc81e8d7d", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "f3461dd4-4c0b-4cc8-9d44-3709ad9addfe", "recipient": "233504238397"}], "status": "success"}, "recipient": "233504238397"}]	2024-12-19 03:26:43.243592	\N
53	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	3	2	3	0	{29,29,31}	{}	{36,38}	{055136961,055465235}	[{"response": {"data": [{"id": "2043b7be-a51e-4851-b405-de2b22e303ff", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "46219858-fa2f-4b21-859d-3bbe75b31367", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "7bccf000-8dc6-474b-a2e1-c5e7602aba6d", "recipient": "233504238397"}], "status": "success"}, "recipient": "233504238397"}]	2024-12-19 03:31:41.208968	\N
54	students	general	26	{31,29,30,36,38}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	5	2	3	0	{31,29,29}	{}	{36,38}	{055136961,055465235}	{"data": [{"id": "7c2a38a8-e106-4f7f-902a-646f647f856d", "recipient": "233504238397"}, {"id": "36ff5dff-e1f1-43e8-9496-a9d6e07a4c2f", "recipient": "233551577446"}, {"id": "2a18b1d4-0205-4bc0-a5c7-39aadf783020", "recipient": "233551577446"}], "status": "success"}	2024-12-28 18:25:48.26031	3
55	suppliers	general	26	{3,1}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	2	1	1	0	{3}	{}	{1}	{054732204}	{"data": [{"id": "b9441630-0493-4ffe-868b-0226561fcb23", "recipient": "233545686123"}], "status": "success"}	2024-12-29 12:49:24.707827	1
56	staff	general	26	{15,12,9,8,35,26,22,20}	this is the message to for the staff	8	2	6	0	{15,15,15,15,35,15}	{}	{22,20}	{25844245,25844245}	{"data": [{"id": "1519eb10-7e95-4151-9cb6-a0fdfc35fe4e", "recipient": "233551577446"}, {"id": "e90befe6-b567-4fec-9e59-de451d208c9c", "recipient": "233551577446"}, {"id": "9d6c187b-6c1e-453a-8406-d4f5c43f23a5", "recipient": "233551577446"}, {"id": "9f0f8510-109c-44c4-8501-b53d18436bd9", "recipient": "233551577446"}, {"id": "c92858e2-f6d2-4eb2-90a9-f709dea27a92", "recipient": "233547323204"}, {"id": "675eda92-0229-4450-a250-6737155b644d", "recipient": "233551577446"}], "status": "success"}	2024-12-30 09:58:42.698499	6
57	parents	general	26	{NULL,39,NULL,45,33,34}	Dear {name},\n\nThis is a reminder about the upcoming event: {event_name}...	6	1	5	0	{NULL,NULL,NULL,45,45}	{}	{34}	{054575686}	{"data": [{"id": "1266595f-6080-4296-9328-4dd1a79056e7", "recipient": "233249760060"}, {"id": "64913b27-cb3a-4a6d-8739-6da5019f470f", "recipient": "233249760060"}, {"id": "451ff4f4-33f9-4dc9-b11e-c1b10e66dd42", "recipient": "233244024457"}, {"id": "8c3a482f-2f2e-4ee6-8304-feb02d3bc92d", "recipient": "233551544776"}, {"id": "9bc60a94-df3a-4398-b1e9-6a8f9d4cfda1", "recipient": "233551544776"}], "status": "success"}	2024-12-30 10:13:11.638444	5
58	parents	general	26	{NULL,39,NULL,45,33,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	6	1	5	0	{NULL,NULL,NULL,45,45}	{}	{34}	{054575686}	{"data": [{"id": "c51453d4-c961-47a0-91ec-339baee7d486", "recipient": "233249760060"}, {"id": "4184103d-f92b-4d66-8a06-4e9861f73ca0", "recipient": "233249760060"}, {"id": "7c57191d-f3a9-470b-a632-bc11f2905e34", "recipient": "233244024457"}, {"id": "6ca266f3-fe80-42a6-b55d-1522ca5e1895", "recipient": "233551544776"}, {"id": "9e313da4-46c6-4ef3-b824-b428380fcf32", "recipient": "233551544776"}], "status": "success"}	2024-12-30 10:26:50.447352	5
59	staff	general	26	{15,12,9,8,35,26,22,20}	Dear {name},\n\nThis is a reminder about the upcoming event: {event_name}...	8	2	6	0	{15,15,15,15,35,15}	{}	{22,20}	{25844245,25844245}	{"data": [{"id": "6743c490-5b24-4ffc-9608-73c6bb35abac", "recipient": "233551577446"}, {"id": "281dd70a-94c8-4bc2-abe3-377be315c5a4", "recipient": "233551577446"}, {"id": "8317d341-7b52-495e-bdf9-5ea44c487fad", "recipient": "233551577446"}, {"id": "b6e11656-b442-4e4c-8a0b-d5f75253f4bf", "recipient": "233551577446"}, {"id": "371b3dfb-fed0-46d8-8425-add657df7e4e", "recipient": "233547323204"}, {"id": "063fdb81-f641-4004-8218-a021a17fa30d", "recipient": "233551577446"}], "status": "success"}	2024-12-30 10:29:51.879381	6
60	staff	general	26	{15,12,9,8,35,26,22,20}	Dear {name},\n\nThis is a reminder about the upcoming event: {event_name}...	8	2	6	0	{15,12,9,8,35,26}	{}	{22,20}	{25844245,25844245}	{"data": [{"id": "fe4603f2-ea12-42a3-98f1-3e2c4710f860", "recipient": "233551577446"}, {"id": "20e14d30-b86d-4e17-90e6-7715d74fd9b6", "recipient": "233551577446"}, {"id": "8150ce06-1fdf-42b5-be34-97ed124afdee", "recipient": "233551577446"}, {"id": "59b28fd0-c061-4fe5-984e-2596286eee57", "recipient": "233551577446"}, {"id": "e27b228a-bc5a-4cf1-b8a7-1002a6f473c8", "recipient": "233547323204"}, {"id": "9218ffd5-1574-4ebb-a613-aa372c6d37fa", "recipient": "233551577446"}], "status": "success"}	2024-12-30 10:39:52.149246	6
61	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	3	2	3	0	{29,30,31}	{}	{36,38}	{055136961,055465235}	[{"response": {"data": [{"id": "59d57056-ca96-4a29-a0cc-9478267cc0b2", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "1b5172c6-e8ed-475d-82c9-1d7ab23391ec", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "f9c6eade-9ad8-4b99-a20a-4953cdd64b8d", "recipient": "233504238397"}], "status": "success"}, "recipient": "233504238397"}]	2024-12-30 10:45:42.759171	6
62	users	general	26	{26,39,39,12,45,31,9,29,32,35,33,3,38,22,14,6,1,4,13,36,34}	Dear {name},\n\nThis is a reminder about the upcoming event: {event_name}...	21	10	11	0	{26,39,39,12,45,31,9,29,32,35,33}	{}	{3,38,22,14,6,1,4,13,36,34}	{NULL,055465235,25844245,NULL,NULL,NULL,NULL,NULL,055136961,054575686}	{"data": [{"id": "3a0ed4b8-a869-45eb-8c42-d37a608ba067", "recipient": "233551577446"}, {"id": "a844c630-ac5a-4a82-82a2-c5d03369cade", "recipient": "233249760060"}, {"id": "574addd6-1279-469f-bdab-6ab1374c5cf6", "recipient": "233249760060"}, {"id": "ed104b4b-307d-47af-94c2-e0a3096a288d", "recipient": "233551577446"}, {"id": "1f587642-1dc8-472a-97e3-5397fee3b63a", "recipient": "233551544776"}, {"id": "c5d62995-1d37-4cd6-a0ed-1c39ef84ec73", "recipient": "233504238397"}, {"id": "b0a7a5e8-c1b4-41b7-bd07-7d71466ef031", "recipient": "233551577446"}, {"id": "e79ad821-c5c9-449a-a6cf-1f7cf08b88e5", "recipient": "233551577446"}, {"id": "6f58db03-ec66-44ac-86de-d7b41ce6ddf9", "recipient": "233547323204"}, {"id": "5c5eddd7-e5b5-430b-9f17-29c72c93c441", "recipient": "233547323204"}, {"id": "907e62f5-491a-4004-bc9b-18886c62e003", "recipient": "233551544776"}], "status": "success"}	2024-12-30 10:49:13.304975	11
63	students	general	26	{36,38,31,29,30}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	5	2	3	0	{36,38,38}	{29,30}	{29,30}	{055136961,055465235}	{"data": [{"id": "b812b2fc-7b62-4a61-ad28-129a8beb43a9", "recipient": "233504238397"}, {"id": "f8089d28-ee08-49bc-bd17-e995f482def7", "recipient": "233551577446"}, {"id": "632171b9-e54a-4c1f-9718-62cb3c45602f", "recipient": "233551577446"}], "status": "success"}	2024-12-30 11:27:22.968376	3
64	students	general	26	{31,29,30,36,38}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	5	2	3	0	{31,29,30}	{}	{36,38}	{055136961,055465235}	{"data": [{"id": "abea4eb6-341c-4ff3-acc6-73b0d05094e8", "recipient": "233504238397"}, {"id": "c1369994-5d5c-480f-b242-d1ec9595568d", "recipient": "233551577446"}, {"id": "dc55be58-8441-4371-abf2-4aba9f2c8832", "recipient": "233551577446"}], "status": "success"}	2024-12-30 11:29:05.183995	3
65	students	general	26	{31,29,30}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	5	2	3	0	{31,29,29}	{}	{}	{055136961,055465235}	{"data": [{"id": "971cb739-79f0-481c-b97a-f243cc4b0f05", "recipient": "233504238397"}, {"id": "f734fcc8-efdc-449b-a6a4-0977c53500d4", "recipient": "233551577446"}, {"id": "2580100e-8aab-4b3d-b665-a77875cc91ed", "recipient": "233551577446"}], "status": "success"}	2024-12-30 11:33:04.799844	3
66	students	general	26	{31,29,30,36,38}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	5	2	3	0	{31,29,30}	{}	{36,38}	{055136961,055465235}	{"data": [{"id": "3cd98180-a546-4cf4-822f-6b52b22dd1c1", "recipient": "233504238397"}, {"id": "8c2cc6a7-6cd8-47b8-9a10-c1b87560b522", "recipient": "233551577446"}, {"id": "702a0298-99e6-4483-baa5-3dcff0cbdd1d", "recipient": "233551577446"}], "status": "success"}	2024-12-30 11:35:30.21798	3
67	staff	general	26	{15,12,9,8,35,26,22,20}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	8	2	6	0	{15,12,9,8,35,26}	{}	{22,20}	{25844245,25844245}	{"data": [{"id": "e96c1475-7622-49d1-8c3d-dc4bf7125e4b", "recipient": "233551577446"}, {"id": "94fe58c0-2a65-429b-aa57-f14c630e0ecc", "recipient": "233551577446"}, {"id": "8f86612b-019f-42a3-acd9-108bb3675a52", "recipient": "233551577446"}, {"id": "1926e186-15a7-483a-8310-29647112a9aa", "recipient": "233551577446"}, {"id": "507e9a22-b275-452a-b807-89a53dcc0390", "recipient": "233547323204"}, {"id": "8727ae4e-1717-4e0d-bce4-20042d812f10", "recipient": "233551577446"}], "status": "success"}	2024-12-30 11:37:14.928752	6
68	staff	general	26	{15,12,9,8,35,26,22,20}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	8	2	6	0	{15,12,9,8,35,26}	{}	{22,20}	{25844245,25844245}	{"data": [{"id": "b92d6816-fdb4-4c70-b966-79ed4d0892f9", "recipient": "233551577446"}, {"id": "a68e875a-63d4-4c76-b04b-251623ac7c3c", "recipient": "233551577446"}, {"id": "e26d136a-a94b-438d-9957-26a68092d9eb", "recipient": "233551577446"}, {"id": "18f06f6b-0bbd-4ce2-9b0f-bace0408dd3e", "recipient": "233551577446"}, {"id": "92456aee-aac3-4888-b9b7-3023fe0e2a03", "recipient": "233547323204"}, {"id": "145d5e3f-2208-4631-a117-6a976d036485", "recipient": "233551577446"}], "status": "success"}	2024-12-30 11:42:47.284426	6
69	parents	general	26	{NULL,39,NULL,45,33,34}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	6	1	5	0	{NULL,39,NULL,45,33}	{}	{34}	{054575686}	{"data": [{"id": "6d0262b4-a7d0-4d94-8bd2-4d839a223d5b", "recipient": "233249760060"}, {"id": "ba428ac1-6b28-4d07-8cce-7efeea7038e8", "recipient": "233249760060"}, {"id": "48f17bce-21b0-4a43-ba98-c492c352d2f3", "recipient": "233244024457"}, {"id": "f1617fc6-6a77-4c19-9c96-b5453c5ecc05", "recipient": "233551544776"}, {"id": "9f95d9a1-12df-4b6b-ad4f-6438cdde95a0", "recipient": "233551544776"}], "status": "success"}	2024-12-30 11:44:11.024953	5
70	suppliers	general	26	{3,1}	Dear {name},\n\nWelcome to our school! We're excited to have you join us...	2	1	1	0	{3}	{}	{1}	{054732204}	{"data": [{"id": "e29728ab-85f8-4333-8237-9522fdf9a00c", "recipient": "233545686123"}], "status": "success"}	2024-12-30 11:45:41.739061	1
71	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	3	2	3	0	{29,30,31}	{}	{36,38}	{055136961,055465235}	[{"response": {"data": [{"id": "4e2d03d0-5596-434d-95f4-65a22b3a0ac9", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "c820f1c1-b5ef-4d79-9e89-8ef42dfb7fb3", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "261c7f76-b106-44ac-a3b2-75d8a1e55a17", "recipient": "233504238397"}], "status": "success"}, "recipient": "233504238397"}]	2024-12-30 11:48:26.640736	6
72	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	5	2	3	0	{29,30,31}	{}	{36,38}	{055136961,055465235}	[{"response": {"data": [{"id": "6a3f8b0f-6f2b-4cc7-bdb0-6615efdb5f02", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "b8cc1d25-1fc8-4453-aa12-81667b670333", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "716f25bc-5b2b-4fe3-9edb-111f5252226e", "recipient": "233504238397"}], "status": "success"}, "recipient": "233504238397"}]	2024-12-30 11:51:27.699356	6
73	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	5	2	3	0	{29,29,31}	{}	{36,38}	{055136961,055465235}	[{"response": {"data": [{"id": "24e18be7-43bf-4a70-b478-66d7aeac926d", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "fbef9905-e16f-4d1d-abbf-770897bfc78c", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "b37cee27-410c-4664-944f-f743f8d8ae22", "recipient": "233504238397"}], "status": "success"}, "recipient": "233504238397"}]	2024-12-30 12:40:46.234573	6
74	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	5	2	3	0	{29,29,31}	{}	{36,38}	{055136961,055465235}	[{"response": {"data": [{"id": "7530666a-3c9a-4bc8-96cf-bd6a3bd037eb", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "5bbea07b-a83c-4c49-b2d0-713bce2be61e", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "abf1c9a5-95a8-47b4-8160-0a3973a9b98c", "recipient": "233504238397"}], "status": "success"}, "recipient": "233504238397"}]	2024-12-30 12:42:24.708198	6
75	students owing	fee_reminder	26	{29,30,31,36,38}	Attention Parent: School fees for {name} are past due. Kindly clear the GHS {amount} balance by [Date] to prevent academic service suspension.	5	2	3	0	{29,29,31}	{}	{36,38}	{055136961,055465235}	[{"response": {"data": [{"id": "d6e41e3d-4e62-43ea-8a7b-8e499dc46aca", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "fd8b3a9c-5818-4233-b84d-1d90b3e79eb8", "recipient": "233551577446"}], "status": "success"}, "recipient": "233551577446"}, {"response": {"data": [{"id": "a6f90f5b-313a-4032-9b48-a0d07815712a", "recipient": "233504238397"}], "status": "success"}, "recipient": "233504238397"}]	2024-12-30 12:46:34.450937	3
76	students owing	fee_reminder	26	{29,30,31,36,38}	Dear Parent, this is a reminder that school fees for {name} are overdue. Kindly settle the outstanding balance of GHS {amount} before [Date] to avoid disruption of academic services.	5	2	0	3	{}	{29,29,31}	{36,38}	{055136961,055465235}	[{"error": "getaddrinfo EAI_AGAIN sms.arkesel.com", "recipient": "233551577446"}, {"error": "getaddrinfo EAI_AGAIN sms.arkesel.com", "recipient": "233551577446"}, {"error": "getaddrinfo EAI_AGAIN sms.arkesel.com", "recipient": "233504238397"}]	2024-12-30 13:25:59.160073	6
77	fee_payment	fee_payment	26	{9}	Payment Received: GHS 2 for Grace  Acquah. New balance: GHS 49. Receipt #: 42. Thank you!	1	\N	1	\N	\N	\N	\N	\N	\N	2025-01-12 20:03:25.305049	1
78	fee_payment	fee_payment	26	{9}	Payment Received: GHS 5 for Grace  Acquah. New balance: GHS 4. Receipt #: 44. Thank you!	1	\N	1	\N	\N	\N	\N	\N	\N	2025-01-12 20:31:21.843171	1
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff (staff_id, user_id, first_name, last_name, middle_name, date_of_birth, gender, marital_status, address, phone_number, email, emergency_contact, date_of_joining, designation, department, salary, account_number, contract_type, employment_status, qualification, experience, blood_group, national_id, passport_number, photo, teaching_subject, class_teacher, subject_in_charge, house_in_charge, bus_in_charge, library_in_charge, status, role) FROM stdin;
2	9	Matilda 	Attah 	Emefa	2024-07-29	F	Single	assemblies of god ghana	+233551577446	atlcoccus@gmail2.com	0504238397	2024-08-12		Mathematics	800.00	0702109023	Full-time	Active	degrees	worked with js	AB-	50865769		https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2FIMG-20220401-WA0018.jpg2024-08-12T17%3A26%3A03.675Z?alt=media&token=f97ee86c-f2ef-473b-894f-211235022277	mathematics	\N	\N	\N	\N	\N	active	teaching staff
3	12	John 	Nyarkoh	Akwasikumah	2024-07-28	M	Single	assemblies of god ghana	+233551577446	atlcoccus@gmail123.com	0504238397	2024-08-13		English	500.00	0702109023	Full-time	Active	degree	worked with js	AB+	50865769	20540244	\N	English	\N	\N	\N	\N	\N	active	teaching staff
15	26	admin	admin	admin	2024-08-20	M	Single	admin	0551577446	admin@admin	0551577446	2024-08-20	Admin	admin	50000.00	8040750	Contract	Active	HND 	5 years	O+	54246	584455	https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2Fphoto_2023-11-02_11-14-45.jpg2024-08-20T14%3A48%3A00.576Z?alt=media&token=922165c8-4b73-4878-bd36-338f04242ff2		\N	\N	\N	\N	\N	active	admin
13	22	Ernest 1	Nelson 	Tawiah	1996-02-19	M	Single	jkhgjgg	25844245	atlcoccus123@gmail.com25	0551577446	2024-08-19		Music	20.00	502856	Full-time	Active	HND 	5 years	AB+	54246	584455	https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2Fdownload.jpeg2024-08-19T15%3A32%3A09.961Z?alt=media&token=f9a1c6aa-e655-4460-bd08-cae23bc38c76		\N	\N	\N	\N	\N	active	admin
6	15	Ernest 	Owusu 		2023-07-30	M	Divorced	assemblies of god ghana	+233551577446	atlcoccus@gmail7885.com	0502109023	2024-01-08		English	806.00	0702109023	Part-time	On Leave	degree	worked with jsx	AB-	50865769	20540244	https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2FANGEL%20PROJECT%202-01.png2024-09-06T14%3A15%3A53.326Z?alt=media&token=af21a9b5-6f99-4e1b-b39c-d4c8908df40c	social	\N	\N	\N	\N	\N	active	non teaching
1	8	Nelson	Dorkordi	Tawiah	2024-07-28	M	Single	assemblies of god ghana	+233551577446	atlcoccus@gmail1.com	0504238397	2024-08-12		Mathematics	400.00	0702109023	Contract	Active	degrees	worked with js	A+	50865769		https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2Fphoto_2023-11-02_11-14-45.jpg2024-08-12T17%3A02%3A55.492Z?alt=media&token=0e663bd9-746b-4b01-a98c-665694a8b7bc	mathematics	\N	\N	\N	\N	\N	active	teaching staff
12	21	Ernest 	Wilson	Ernest 	2024-08-20	M	Single	newest staff	25844245	nelsodork@gmail24.com	0551577446	2024-08-12		Music	200.00	8040750	Full-time	On Leave	HND 	5 years	AB-	54246	584455	https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2FIMG-20230627-WA0051.jpg2024-09-06T14%3A33%3A46.907Z?alt=media&token=42b62bb9-db20-476d-a367-594f8ba1e5e5		\N	\N	\N	\N	\N	deleted	head teacher
16	35	Patience 	Enyaah	Maame Araba	2004-10-07	F	Married	Ghana post gps 2546	0547323204	enyaahpat1@gmail.com	0551577446	2024-10-07	Staff	Music	400.00	15468753	Full-time	Active	Diploma	2	A+	23564789		\N		\N	\N	\N	\N	\N	active	teaching staff
17	47	Alex 	Ankah	Junior	1992-06-03	M	Single	zsdsd	0249248800		0249248800	2025-01-11		JHS	400.00		Full-time	Active	degree	8 years of teaching experience	B+	22336		\N	fante	\N	\N	\N	\N	\N	active	teaching staff
11	20	Nelson	Kweku 	Legend	2024-07-29	M	Married	fffjhng\nvcfgfg	25844245	nelsodork@gmail.com	0551577446	2024-07-31		Music	809.00	20	Full-time	On Leave	HND 	5 years	AB+	54246	584455	https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2FdorkordiChannel4.jpeg2024-08-16T14%3A04%3A23.167Z?alt=media&token=bb14602c-940b-445b-86d5-bcea27f7b130	578	\N	\N	\N	\N	\N	deleted	teaching staff
18	69	David	Attah		2009-12-27	M	Single	assemblies of god ghana	+233551577446		0551577446	2025-01-07		Mathematics	500.00		Full-time	Active	degree	1year		5638954	20540244	\N	mathematics	\N	\N	\N	\N	\N	active	teaching staff
\.


--
-- Data for Name: student_grades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_grades (grade_id, student_id, subject_id, class_id, user_id, gradescheme_id, semester_id, class_score, exams_score, total_score, status, created_at) FROM stdin;
1	1	1	1	26	\N	1	40.00	50.00	90.00	active	2024-09-20 20:39:56.947281+00
4	1	3	1	26	2	1	40.00	35.00	75.00	active	2024-09-20 20:39:56.947281+00
6	1	7	1	26	\N	1	47.00	7.00	54.00	active	2024-09-20 20:39:56.947281+00
7	2	7	1	26	\N	1	25.00	35.00	60.00	active	2024-09-20 20:39:56.947281+00
3	1	2	1	26	1	1	45.00	45.00	90.00	active	2024-09-20 20:39:56.947281+00
9	2	2	1	26	1	1	40.00	47.00	87.00	active	2024-09-20 20:39:56.947281+00
10	3	8	4	26	2	1	40.00	30.00	70.00	active	2024-09-20 21:39:48.595818+00
12	2	8	1	26	\N	1	0.00	30.00	30.00	active	2024-09-23 02:25:48.345006+00
15	1	5	1	26	\N	1	0.00	41.00	41.00	active	2024-09-23 02:27:52.432508+00
16	2	5	1	26	\N	1	0.00	50.00	50.00	active	2024-09-23 02:27:52.432508+00
23	3	6	4	26	\N	1	40.00	0.00	40.00	active	2024-09-24 16:28:13.398494+00
19	1	6	1	26	\N	1	40.00	43.00	83.00	active	2024-09-23 02:35:19.136102+00
20	2	6	1	26	1	1	47.00	44.00	91.00	active	2024-09-23 02:35:19.136102+00
11	1	8	1	26	1	1	0.00	20.00	30.00	active	2024-09-23 02:25:48.345006+00
28	4	4	6	26	1	1	45.00	48.00	93.00	active	2024-10-08 19:23:10.217259+00
29	4	3	6	26	2	1	40.00	40.00	80.00	active	2024-10-08 19:24:13.590033+00
\.


--
-- Data for Name: student_parent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_parent (student_id, parent_id, relationship, status) FROM stdin;
1	1	Mother 	active
1	2	Father	active
4	6	Mother 	active
4	7	Father	active
3	3	Guardian	inactive
3	5	Father 	inactive
2	3	Mother 	deleted
2	4	Father	deleted
6	6	Mother	active
6	9	Mother-In-Law	active
6	2	Guardian 	active
5	1	Guardian	inactive
5	2	Father 	inactive
10	12	Father	active
9	11	Mother 	active
9	10	Father	active
11	13	Mother 	active
11	11	Guardian	active
14	13	Mother 	active
14	12	Guardian	active
\.


--
-- Data for Name: student_remarks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_remarks (remark_id, student_id, class_id, semester_id, user_id, class_teachers_remark, headteachers_remark, remark_date) FROM stdin;
1	1	1	1	26	student details  \nclass teachers remark2	head teachers remark	2024-08-28
2	2	1	1	26		this is the headteachers remarks for nyarko	2024-09-25
3	3	4	1	26		This is the remark for this student	2024-10-28
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (student_id, photo, first_name, last_name, other_names, date_of_birth, gender, class_id, amountowed, residential_address, phone, email, enrollment_date, national_id, birth_cert_id, role, user_id, status, class_promoted_to) FROM stdin;
6	\N	Emmanuel 	Foli		1995-01-08	Male	7	680.00	ghana post gps	055465235	atlcoccus@gmail.com53535	2024-11-08	6943158	98745632	student	38	active	7
3	https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2FANGEL%20PROJECT%202-01.png2024-08-31T17%3A35%3A26.002Z?alt=media&token=62a33d0a-2478-4f77-8a45-ca893f273b2a	Matilda 	Attah 	Emefa 	2009-05-16	Female	4	310.50	Nkonya wurupong \nKwanyako	0504238397	emefa@emefa.com	2024-08-31	23564789	98745632	student	31	active	7
2	https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2Fdownload.jpeg2024-08-30T19%3A29%3A16.975Z?alt=media&token=9ef118ff-c2b5-4f65-9a61-5c2b2f0e4a23	John	Nyarkoh	Yaw	2017-09-22	Male	2	700.00	this is the second student	0551577446	atlcoccus@gmail23.com	2024-08-30	54246	5454	student	30	active	2
1	https://firebasestorage.googleapis.com/v0/b/school-management-e22be.appspot.com/o/images%2FdorkordiChannel.jpeg2024-08-21T22%3A50%3A58.566Z?alt=media&token=c4c32613-7f02-4936-84ad-fcb2e4b85767	nelson1	Dorkordi	coccus	1999-02-23	Male	2	650.00	Swedru senior high school	0551577446	atlcoccus@gmail.comme	2024-08-21	54246	5454	student	29	active	2
4	\N	Patience 	Enyaah 	Araba	1997-09-30	Female	2	-100.00	Ghana post gps 25634	0547323204	enyaahpat@gmail.com	2024-06-03	02554575	2356987	student	32	active	1
10	\N	Margaret 	Attah 		2008-05-20	Female	7	10.00	34	0551577446		2025-01-20		1234567	student	65	active	7
9	\N	Grace 	Acquah	Adomba	2015-08-11	Female	12	-16.00	fsdd	+233551577446	atlcoccus@gmail.com	2025-01-11	22	2356987	student	50	active	12
11	\N	Kojo	Nelson		2024-01-20	Male	7	50.00	fcdfd	0551577446	atlcoccus@gmail.com	2025-01-20	50865769	1234567	student	67	active	7
5	\N	Richmond	Adasu 	adzoe	1996-06-08	Male	7	3.00	ghana post gps	055136961		2024-11-08	5638954	98745632	student	36	inactive	7
14	\N	Nelson	Dorkordi		2025-02-04	Male	4	0.00	dffd	+233551577446	atlcoccus@gmail.com	2025-01-30	5638954df		student	72	active	4
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjects (subject_id, subject_name, status) FROM stdin;
3	Social Studies	active
2	Mathematics	active
1	Mathematics	deleted
4	RME	active
6	Fante	active
5	Chemistry	active
7	French	active
9	Owop	active
10	Ethics	active
11	Computing	active
8	Biology	active
12	chinese	deleted
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (supplier_id, supplier_name, contact_name, contact_phone, contact_email, address, details, status) FROM stdin;
1	CEPME	Mr. Nelson	054732204	atl@nel.com	swedru 	basic school girls uniform	active
2	Aki Ola Publications	Mr. Peter	0545686123	aki@ola.com	Akraa Legon		deleted
3	Aki Ola Publications22	Mr. Peter	0545686123	aki@ola.com	sdsdsd		deleted
\.


--
-- Data for Name: timetable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timetable (timetable_id, class_id, subject_id, teacher_id, room_id, day_of_week, period_number, start_time, end_time, semester_id) FROM stdin;
7	4	1	3	\N	Monday	1	08:00:00	09:00:00	\N
8	4	1	3	\N	Monday	2	09:00:00	12:22:00	\N
9	4	1	2	\N	Tuesday	1	08:00:00	09:00:00	\N
10	4	1	3	\N	Tuesday	2	09:00:00	12:22:00	\N
11	4	1	3	\N	Wednesday	1	08:00:00	09:00:00	\N
12	4	1	3	\N	Wednesday	2	09:00:00	12:22:00	\N
13	4	1	1	\N	Thursday	1	08:00:00	09:00:00	\N
14	4	3	1	\N	Thursday	2	09:00:00	12:22:00	\N
15	4	3	2	\N	Friday	1	08:00:00	09:00:00	\N
16	4	1	3	\N	Friday	2	09:00:00	12:22:00	\N
17	4	3	1	\N	Monday	1	08:00:00	09:00:00	1
18	4	2	3	\N	Tuesday	1	08:00:00	09:00:00	1
19	4	3	2	\N	Wednesday	1	08:00:00	09:00:00	1
20	4	1	3	\N	Thursday	1	08:00:00	09:00:00	1
21	4	1	3	\N	Friday	1	08:00:00	09:00:00	1
27	6	6	16	\N	Monday	1	08:00:00	09:00:00	1
28	6	8	16	\N	Tuesday	1	08:00:00	09:00:00	1
29	6	4	16	\N	Wednesday	1	08:00:00	09:00:00	1
30	6	5	16	\N	Thursday	1	08:00:00	09:00:00	1
31	6	3	16	\N	Friday	1	08:00:00	09:00:00	1
42	7	8	17	\N	Monday	1	08:00:00	09:00:00	1
43	7	5	17	\N	Tuesday	1	08:00:00	09:00:00	1
44	7	8	17	\N	Wednesday	1	08:00:00	09:00:00	1
45	7	8	17	\N	Thursday	1	08:00:00	09:00:00	1
46	7	8	17	\N	Friday	1	08:00:00	09:00:00	1
\.


--
-- Data for Name: user_health_record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_health_record (user_id, medical_conditions, allergies, blood_group, vaccination_status, last_physical_exam_date, created_at, updated_at, health_insurance_id, status) FROM stdin;
26	admin	admin	O+	admin	\N	2024-08-20 14:48:09.09222	2024-08-20 14:48:09.09222	\N	active
29	headache	banku	AB+	none done yet	\N	2024-08-21 22:51:03.531866	2024-08-21 22:51:03.531866	2024	active
22	gvjhjh	bnnnv	AB+	jhjgjv	\N	2024-08-19 15:32:17.380274	2024-08-19 15:32:17.380274	\N	active
21	elephantiasis	Banku	AB-	none	\N	2024-08-17 22:27:00.425717	2024-08-17 22:27:00.425717	\N	deleted
32	none 	None	A+	Polio, Missiles  	\N	2024-10-07 11:52:23.687485	2024-10-07 11:52:23.687485	27179192	active
35	none	None	A+	Covid	\N	2024-10-07 13:09:01.706378	2024-10-07 13:09:01.706378	\N	active
31	Rashes	Cassava	AB+	Yellow fever,\ncovid 19	\N	2024-08-31 17:41:24.380197	2024-08-31 17:41:24.380197	123456789	inactive
30	headache, asthma, allergies	banku, fufu, cassava	AB+	all vaccines completed	\N	2024-08-30 19:29:24.228615	2024-08-30 19:29:24.228615	2024	deleted
38	none 	none 	A-	none 	\N	2024-11-08 00:46:24.499533	2024-11-08 00:46:24.499533	23588645	active
47	None 	None	B+	Yellow fever\nhep b\npolio	\N	2025-01-11 02:06:42.421319	2025-01-11 02:06:42.421319	\N	active
36	none	none	B+	none23	\N	2024-11-08 00:13:52.11599	2024-11-08 00:13:52.11599	202453568	inactive
65	None	None	A+	None	\N	2025-01-20 10:39:02.022079	2025-01-20 10:39:02.022079	27179192	active
69	none	none		none	\N	2025-01-21 06:52:31.455345	2025-01-21 06:52:31.455345	\N	active
50	none	none	B+	none	\N	2025-01-11 02:35:43.638219	2025-01-11 02:35:43.638219	27179192	active
67	None	None	B+	None	\N	2025-01-20 10:43:36.828989	2025-01-20 10:43:36.828989	20	active
72	None 	None 		None	\N	2025-02-01 18:29:00.740949	2025-02-01 18:29:00.740949		active
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (user_id, role_id) FROM stdin;
6	1
6	2
2	2
1	2
13	2
26	1
26	2
35	3
61	2
47	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_name, user_email, role, status, password) FROM stdin;
1	nelson	atlcoccus@gmail.com	user	active	$2a$10$xasb8wrI9SuYEsaKv2zkhuV/s709ConTHiD4lNANszYCsw4pyuioe
2	John 	jhon@gmail.com	user	active	$2a$10$42RIJHDjCK3//Y7zXNbY7.RC0pMIjuKjorXm7hJcCAnk9GHfPR.jO
3	emefa	emefa@gmail.com	user	active	$2a$10$pGwshWA4F2Jir2b4yEFIl.xyEPFDgATtswzeu/YlaDELSZUSJ84Ly
4	nelson 2	nelson@gmail.com	user	active	$2a$10$bISsUI9RbE2sHqarSe0AWOXgXUSHitWKKh.BZ1vbkhre66gw2Cotq
6	nel	nel@gmail.com	admin	active	$2a$10$/tiqWC7kDu1PjVp1Lgy1X.t.5RIByDcPF5MLU6V7sMRu2.6tJEmmK
9	matilda attah emefa	atlcoccus@gmail2.com	user	active	$2a$10$jPXbX6Ed5jcVdKN80OItzO3hiJGwH/gIJCG3zRhHwbc8I12SpNxV2
12	john nyarkohakwasikumah	atlcoccus@gmail123.com	user	active	$2a$10$S302w9M0.Vze0iJUBES58e92eD1TyusxkbZ9WI0hsKtn4FTKo9z8.
13	nelson1dorkordiakwasikumah	atlcoccus@gmail586.com	user	active	$2a$10$w2JTMirgBPuskAHVZv7w5eBW8cYvqBxaFf4qXxFS6OGZJkybIs8ca
14	ernest owusunelson 	atlcoccus@gmail549.com	user	active	$2a$10$TSGDNQuOmoZMoN7PACravuEsJNwBgADKjOTjM6KdH.t3lutvPT4Gm
29	nelsondorkordi	atlcoccus@gmail.comme	student	active	$2a$10$VYySt5Nq0MXgUIinIoQj1e8PdSLUAje6W/qkvHKYX2B4AhK9fS1DO
38	emmanuel  foli 	atlcoccus@gmail.com53535	student	active	$2a$10$Srlhrv1wqf8MJrJpuEEmE.C3KX2uf7AGLRmhbfLJHpZa1te9Ahp4m
22	ernest nelson 	atlcoccus123@gmail.com25	admin	active	$2a$10$xRAuJ2oWFyC/eCeCFxyEH.qLGR0oZa9Z/XtMz1f6C2TP015i1h8/.
8	nelsondorkorditawiah	atlcoccus@gmail1.com	user	inactive	$2a$10$lnaaC1NeS6H7W9WvWhUgQuhjUAbvMX3DxYqb5xPhBhKGOt4jyWbwa
15	ernest owusu 	atlcoccus@gmail7885.com	user	inactive	$2a$10$TV6yucTJPQL2dDej47WDUOvbQl2HTj/s5TV/TgPkJ/SnHdzeOxlqu
21	ernest wilson	nelsodork@gmail24.com	head teacher	deleted	$2a$10$KY9H03YJNm5UT2emzjnIredWRZmASoj/onj3WY8pmAdpc11b6ey8G
34	yaa yaa	atlfrt@gmail.com	parent	active	$2a$10$nbePhShZQ2VELU6YgxXqmuCwK7GzxGRVn54C4x6b/hUauQngYcov2
35	patience  enyaah maame araba	enyaahpat1@gmail.com	teaching staff	active	$2a$10$/vdOaFfDXcqCRje5mFq0Nuw3Zvbauw2f75mKbwx/l.U241PxF90he
31	matilda attah 	emefa@emefa.com	student	active	$2a$10$1l.pHigQnsc2uAW45hz3xuKEVaSViCs/8kxh1xQ.Gy8UpTyCWKljS
32	patience  enyaah  araba	enyaahpat@gmail.com	student	active	$2a$10$8xjs/LWEpEvSMRVg1wF8t.sIZc2q4DJCgO64e96lB82v5eos5wcOm
30	johnnyarkoh	atlcoccus@gmail23.com	student	deleted	$2a$10$78.kDR.q.eL8PC5MuONyU.88.InJTOYPxsSwnS.v1T5NCUdSgd0K6
33	yaa nooyoo	yaanooyoo@gmail.com	parent	active	$2a$10$kVOBJMpzzhW9F1qkvNAo.OWsMeq/IAA6wnagBmf.TzsCZN4gB68lS
45	kofi nimo	kofinimo@gmail.com	parent	active	$2a$10$A.5UxsVJva052eBgBQPQjOBgsJ5r8LA7jO633JG.N22OvxZyzSjJG
39	edward 23 attah 3	parent2@gmail.com	parent	active	$2a$10$Uz9SG.8lMBYdF6kbzh28RudzBWmpw/3lYR6XX9p2h7A7j5DdG8BZq
26	adminadmin	admin@admin	admin	active	$2a$10$zXGjfNaevmcnpJXke3v07uRqi/LkOct55jtdUYzxYGYhd4Vt0Mlj2
47	alex  ankah junior		teaching staff	active	$2a$10$0gbe7cT1QVtrXLydkOYGauCKmNG24SENr7arfF.XQiPaZOktQkJlG
20	nelsonkweku 	nelsodork@gmail.com	teaching staff	inactive	$2a$10$sK5LemZWriAk67YfrTTfdO5GJyGRJy4R4JubyCh7qGZbii.qunsxS
50	grace  acquah adomba	atlcoccus@gmail.com	student	active	$2a$10$m.s5AC5A87d.7OmpR4nU/ObzzesKVgfYUnKxCoAroUwRCFo8eqJm6
56	edward 23 attah 3	parent2@gmail.com	parent	active	$2a$10$0ucpLgL/4Bvllv5WIHocyu4tPtfbXO7tL8zD4Qep1TPmd3EcBaJUu
67	nelson kojo 	atlcoccus@gmail.com	student	active	$2a$10$bZTyVvASjKsAhJKbdqO69.GCCJMj9u7Gitm/wGFODWTvZ/e6nU77e
64	innocentia  acquah		parent	active	$2a$10$5JDTpEJOYzPuIlfPySGiiuGOdzPhUw3rgjjOXqbvYSwcZhyb/1BUC
68	 acquah christiana		parent	active	$2a$10$Uyf9PEQWuFg9CDtg5wwpr.ZcJzQFAGaALJz8lDOgvnmT9GiFzDbQK
69	david attah 		teaching staff	active	$2a$10$EK6JMWrYvpw3L/zGYrm1vOIbRIUQvuwy47iHZShibacseqm4R.lZK
61	christiana gyato	parent@gmail.com	parent	active	$2a$10$.0V2s6p.MnjglQfakcQYL.b36yv3kjgHafGFhoPQinu52PXU2yUf2
62	edward 23 attah 3	parent2@gmail.com	parent	active	$2a$10$CAVAlVUu8Nsp0.b1OAVuperToGfN44Tsez1zsf9CfnuH56J8lxvEy
72	dorkordi nelson 	atlcoccus@gmail.com	student	active	$2a$10$i3WkzYm8FLGiKSTme.Sjf.u.hmYpXQ6buaVnPqCR/.s2nKwd.eone
63	alfred acquah		parent	deleted	$2a$10$ZVH6hOC7CRYXQ9I/RrD/6uKxL.uUkJFEEWTnOG0PbG.FhOWftm0Oy
36	richmond adasu  		student	inactive	$2a$10$cUQ1zkkuSMqkN71yxhIdyOZsG7g4AcgJuqpGQJcUc.Vt55F8kGiay
65	attah margaret 		student	active	$2a$10$yEFfBjPcsOatatQcJeL2V.JTgprz7gdQtmu.lMUwQHR/axM4wL/fG
66	 acquah alfred		parent	active	$2a$10$f2T3rcpJTBfm8QdMHgm9yuWYVHwjMWMx2bypntW5AzAIxyjACcbuG
\.


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 30, true);


--
-- Name: balance_adjustment_log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.balance_adjustment_log_log_id_seq', 4, true);


--
-- Name: bus_pick_up_points_pick_up_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bus_pick_up_points_pick_up_id_seq', 6, true);


--
-- Name: class_items_class_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.class_items_class_item_id_seq', 22, true);


--
-- Name: classes_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classes_class_id_seq', 13, true);


--
-- Name: departments_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_department_id_seq', 1, true);


--
-- Name: evaluations_evaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evaluations_evaluation_id_seq', 5, true);


--
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_event_id_seq', 6, true);


--
-- Name: expenses_expense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expenses_expense_id_seq', 11, true);


--
-- Name: fee_collections_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fee_collections_collection_id_seq', 49, true);


--
-- Name: feeding_fee_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feeding_fee_payments_id_seq', 5, true);


--
-- Name: grading_scheme_grade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grading_scheme_grade_id_seq', 3, true);


--
-- Name: health_incident_incident_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.health_incident_incident_id_seq', 12, true);


--
-- Name: inventory_items_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_items_inventory_id_seq', 3, true);


--
-- Name: invoices_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoices_invoice_id_seq', 26, true);


--
-- Name: items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.items_item_id_seq', 5, true);


--
-- Name: items_movement_supply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.items_movement_supply_id_seq', 3, true);


--
-- Name: items_supply_supply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.items_supply_supply_id_seq', 20, true);


--
-- Name: notification_recipients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_recipients_id_seq', 26, true);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 124, true);


--
-- Name: parents_parent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parents_parent_id_seq', 13, true);


--
-- Name: permissions_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_permission_id_seq', 71, true);


--
-- Name: procurements_procurement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.procurements_procurement_id_seq', 8, true);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 4, true);


--
-- Name: rooms_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_room_id_seq', 1, false);


--
-- Name: semesters_semester_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.semesters_semester_id_seq', 8, true);


--
-- Name: sms_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sms_logs_id_seq', 78, true);


--
-- Name: staff_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_staff_id_seq', 18, true);


--
-- Name: student_grades_grade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_grades_grade_id_seq', 29, true);


--
-- Name: student_remarks_remark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_remarks_remark_id_seq', 3, true);


--
-- Name: students_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_student_id_seq', 14, true);


--
-- Name: subjects_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_subject_id_seq', 12, true);


--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_supplier_id_seq', 3, true);


--
-- Name: timetable_timetable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timetable_timetable_id_seq', 46, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 72, true);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (attendance_id);


--
-- Name: balance_adjustment_log balance_adjustment_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance_adjustment_log
    ADD CONSTRAINT balance_adjustment_log_pkey PRIMARY KEY (log_id);


--
-- Name: bus_pick_up_points bus_pick_up_points_pick_up_point_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_pick_up_points
    ADD CONSTRAINT bus_pick_up_points_pick_up_point_name_key UNIQUE (pick_up_point_name);


--
-- Name: bus_pick_up_points bus_pick_up_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_pick_up_points
    ADD CONSTRAINT bus_pick_up_points_pkey PRIMARY KEY (pick_up_id);


--
-- Name: class_items class_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_items
    ADD CONSTRAINT class_items_pkey PRIMARY KEY (class_item_id);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (class_id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (department_id);


--
-- Name: evaluations evaluations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_pkey PRIMARY KEY (evaluation_id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (expense_id);


--
-- Name: fee_collections fee_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_collections
    ADD CONSTRAINT fee_collections_pkey PRIMARY KEY (collection_id);


--
-- Name: feeding_fee_payments feeding_fee_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feeding_fee_payments
    ADD CONSTRAINT feeding_fee_payments_pkey PRIMARY KEY (id);


--
-- Name: feeding_transport_fees feeding_transport_fees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feeding_transport_fees
    ADD CONSTRAINT feeding_transport_fees_pkey PRIMARY KEY (student_id);


--
-- Name: grading_scheme grading_scheme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grading_scheme
    ADD CONSTRAINT grading_scheme_pkey PRIMARY KEY (gradescheme_id);


--
-- Name: health_incident health_incident_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_incident
    ADD CONSTRAINT health_incident_pkey PRIMARY KEY (incident_id);


--
-- Name: inventory_class_semester inventory_class_semester_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_class_semester
    ADD CONSTRAINT inventory_class_semester_pkey PRIMARY KEY (inventory_id, class_id, semester_id);


--
-- Name: inventory_items inventory_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_pkey PRIMARY KEY (inventory_id);


--
-- Name: invoice_class_semester invoice_class_semester_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_class_semester
    ADD CONSTRAINT invoice_class_semester_pkey PRIMARY KEY (invoice_id, class_id, semester_id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (invoice_id);


--
-- Name: items_movement items_movement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_movement
    ADD CONSTRAINT items_movement_pkey PRIMARY KEY (supply_id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);


--
-- Name: items_supply items_supply_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_supply
    ADD CONSTRAINT items_supply_pkey PRIMARY KEY (supply_id);


--
-- Name: notification_recipients notification_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_recipients
    ADD CONSTRAINT notification_recipients_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: parents parents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parents
    ADD CONSTRAINT parents_pkey PRIMARY KEY (parent_id);


--
-- Name: permissions permissions_permission_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_permission_name_key UNIQUE (permission_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permission_id);


--
-- Name: procurements procurements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procurements
    ADD CONSTRAINT procurements_pkey PRIMARY KEY (procurement_id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (room_id);


--
-- Name: rooms rooms_room_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_room_name_key UNIQUE (room_name);


--
-- Name: semesters semesters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_pkey PRIMARY KEY (semester_id);


--
-- Name: sms_logs sms_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sms_logs
    ADD CONSTRAINT sms_logs_pkey PRIMARY KEY (id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


--
-- Name: student_grades student_grades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_pkey PRIMARY KEY (grade_id);


--
-- Name: student_parent student_parent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_parent
    ADD CONSTRAINT student_parent_pkey PRIMARY KEY (student_id, parent_id);


--
-- Name: student_remarks student_remarks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remarks
    ADD CONSTRAINT student_remarks_pkey PRIMARY KEY (remark_id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (subject_id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);


--
-- Name: timetable timetable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable
    ADD CONSTRAINT timetable_pkey PRIMARY KEY (timetable_id);


--
-- Name: attendance unique_attendance_record; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT unique_attendance_record UNIQUE (student_id, class_id, attendance_date);


--
-- Name: class_items unique_class_item_semester; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_items
    ADD CONSTRAINT unique_class_item_semester UNIQUE (class_id, item_id, semester_id);


--
-- Name: staff unique_staff_user_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT unique_staff_user_id UNIQUE (user_id);


--
-- Name: student_grades unique_student_grade; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT unique_student_grade UNIQUE (student_id, subject_id, class_id, semester_id);


--
-- Name: user_health_record user_health_record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_health_record
    ADD CONSTRAINT user_health_record_pkey PRIMARY KEY (user_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: departments update_departments_modtime; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_departments_modtime BEFORE UPDATE ON public.departments FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- Name: attendance attendance_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: attendance attendance_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id);


--
-- Name: attendance attendance_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(user_id);


--
-- Name: attendance attendance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: balance_adjustment_log balance_adjustment_log_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance_adjustment_log
    ADD CONSTRAINT balance_adjustment_log_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: bus_pick_up_points bus_pick_up_points_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_pick_up_points
    ADD CONSTRAINT bus_pick_up_points_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: class_items class_items_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_items
    ADD CONSTRAINT class_items_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: class_items class_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_items
    ADD CONSTRAINT class_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(item_id);


--
-- Name: class_items class_items_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_items
    ADD CONSTRAINT class_items_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id);


--
-- Name: class_items class_items_supplied_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class_items
    ADD CONSTRAINT class_items_supplied_by_fkey FOREIGN KEY (supplied_by) REFERENCES public.staff(user_id);


--
-- Name: classes classes_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: evaluations evaluations_evaluatee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_evaluatee_id_fkey FOREIGN KEY (evaluatee_id) REFERENCES public.staff(staff_id) ON DELETE CASCADE;


--
-- Name: evaluations evaluations_evaluator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_evaluator_id_fkey FOREIGN KEY (evaluator_id) REFERENCES public.staff(user_id) ON DELETE CASCADE;


--
-- Name: events events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: expenses expenses_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: expenses expenses_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: expenses expenses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: fee_collections fee_collections_received_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_collections
    ADD CONSTRAINT fee_collections_received_by_fkey FOREIGN KEY (received_by) REFERENCES public.users(user_id);


--
-- Name: fee_collections fee_collections_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fee_collections
    ADD CONSTRAINT fee_collections_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: feeding_fee_payments feeding_fee_payments_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feeding_fee_payments
    ADD CONSTRAINT feeding_fee_payments_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: feeding_fee_payments feeding_fee_payments_collected_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feeding_fee_payments
    ADD CONSTRAINT feeding_fee_payments_collected_by_fkey FOREIGN KEY (collected_by) REFERENCES public.staff(user_id);


--
-- Name: feeding_fee_payments feeding_fee_payments_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feeding_fee_payments
    ADD CONSTRAINT feeding_fee_payments_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id);


--
-- Name: feeding_fee_payments feeding_fee_payments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feeding_fee_payments
    ADD CONSTRAINT feeding_fee_payments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: feeding_transport_fees feeding_transport_fees_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feeding_transport_fees
    ADD CONSTRAINT feeding_transport_fees_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: departments fk_head_of_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT fk_head_of_department FOREIGN KEY (head_of_department) REFERENCES public.staff(staff_id);


--
-- Name: feeding_transport_fees fk_pickup_point; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feeding_transport_fees
    ADD CONSTRAINT fk_pickup_point FOREIGN KEY (pick_up_point) REFERENCES public.bus_pick_up_points(pick_up_id);


--
-- Name: health_incident health_incident_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_incident
    ADD CONSTRAINT health_incident_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: inventory_class_semester inventory_class_semester_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_class_semester
    ADD CONSTRAINT inventory_class_semester_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: inventory_class_semester inventory_class_semester_inventory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_class_semester
    ADD CONSTRAINT inventory_class_semester_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory_items(inventory_id);


--
-- Name: inventory_class_semester inventory_class_semester_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_class_semester
    ADD CONSTRAINT inventory_class_semester_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id);


--
-- Name: invoice_class_semester invoice_class_semester_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_class_semester
    ADD CONSTRAINT invoice_class_semester_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: invoice_class_semester invoice_class_semester_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_class_semester
    ADD CONSTRAINT invoice_class_semester_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id);


--
-- Name: invoice_class_semester invoice_class_semester_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_class_semester
    ADD CONSTRAINT invoice_class_semester_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id);


--
-- Name: items_movement items_movement_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_movement
    ADD CONSTRAINT items_movement_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(item_id);


--
-- Name: items_movement items_movement_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_movement
    ADD CONSTRAINT items_movement_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: items_movement items_movement_supplied_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_movement
    ADD CONSTRAINT items_movement_supplied_by_fkey FOREIGN KEY (supplied_by) REFERENCES public.staff(user_id);


--
-- Name: items_supply items_supply_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_supply
    ADD CONSTRAINT items_supply_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: items_supply items_supply_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_supply
    ADD CONSTRAINT items_supply_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(item_id);


--
-- Name: items_supply items_supply_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_supply
    ADD CONSTRAINT items_supply_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id);


--
-- Name: items_supply items_supply_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_supply
    ADD CONSTRAINT items_supply_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: items_supply items_supply_supplied_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items_supply
    ADD CONSTRAINT items_supply_supplied_by_fkey FOREIGN KEY (supplied_by) REFERENCES public.staff(staff_id);


--
-- Name: notification_recipients notification_recipients_notification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_recipients
    ADD CONSTRAINT notification_recipients_notification_id_fkey FOREIGN KEY (notification_id) REFERENCES public.notifications(notification_id);


--
-- Name: notifications notifications_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(user_id);


--
-- Name: parents parents_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parents
    ADD CONSTRAINT parents_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: procurements procurements_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procurements
    ADD CONSTRAINT procurements_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(item_id);


--
-- Name: procurements procurements_received_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procurements
    ADD CONSTRAINT procurements_received_by_fkey FOREIGN KEY (received_by) REFERENCES public.staff(staff_id);


--
-- Name: procurements procurements_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procurements
    ADD CONSTRAINT procurements_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(permission_id) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON DELETE CASCADE;


--
-- Name: sms_logs sms_logs_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sms_logs
    ADD CONSTRAINT sms_logs_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(user_id);


--
-- Name: staff staff_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: student_grades student_grades_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: student_grades student_grades_gradescheme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_gradescheme_id_fkey FOREIGN KEY (gradescheme_id) REFERENCES public.grading_scheme(gradescheme_id);


--
-- Name: student_grades student_grades_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id);


--
-- Name: student_grades student_grades_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: student_grades student_grades_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subjects(subject_id);


--
-- Name: student_grades student_grades_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.staff(user_id);


--
-- Name: student_parent student_parent_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_parent
    ADD CONSTRAINT student_parent_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.parents(parent_id);


--
-- Name: student_parent student_parent_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_parent
    ADD CONSTRAINT student_parent_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: student_remarks student_remarks_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remarks
    ADD CONSTRAINT student_remarks_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: student_remarks student_remarks_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remarks
    ADD CONSTRAINT student_remarks_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id);


--
-- Name: student_remarks student_remarks_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remarks
    ADD CONSTRAINT student_remarks_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: student_remarks student_remarks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remarks
    ADD CONSTRAINT student_remarks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: students students_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: students students_class_promoted_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_class_promoted_to_fkey FOREIGN KEY (class_promoted_to) REFERENCES public.classes(class_id);


--
-- Name: students students_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: timetable timetable_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable
    ADD CONSTRAINT timetable_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id);


--
-- Name: timetable timetable_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable
    ADD CONSTRAINT timetable_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(room_id);


--
-- Name: timetable timetable_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable
    ADD CONSTRAINT timetable_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id);


--
-- Name: timetable timetable_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable
    ADD CONSTRAINT timetable_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subjects(subject_id);


--
-- Name: timetable timetable_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable
    ADD CONSTRAINT timetable_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.staff(staff_id);


--
-- Name: user_health_record user_health_record_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_health_record
    ADD CONSTRAINT user_health_record_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

