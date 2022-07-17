create database capstone;
CREATE SCHEMA public;
-- 사용자
create table users(
user_no serial not null,
user_id varchar(20) not null,
user_pw varchar(100) not null,
user_name varchar(20) not null,
user_level varchar(20) DEFAULT 1,
state integer not null DEFAULT 1,
reg_dt timestamp not null DEFAULT now(),
CONSTRAINT users_pkey PRIMARY KEY (user_no)
);
COMMENT ON COLUMN public.users.state IS '0 탈퇴 1 정상 2 계정잠금';
COMMENT ON COLUMN public.users.user_level IS '1 일반인 2 중간관리자 3 최고관리자';

-- 기계정보
create table machine(
ma_no serial not null,
ma_name varchar not null,
user_no int4 not NULL,
ma_mac varchar null,
state integer not null DEFAULT 1,
reg_dt timestamp not null DEFAULT now(),
recent_dt timestamp not null DEFAULT now(),
CONSTRAINT users_pkey PRIMARY KEY (ma_no)
CONSTRAINT users_user_no_fkey FOREIGN KEY (user_no) REFERENCES public.users(user_no) ON DELETE CASCADE ON UPDATE CASCADE
);
COMMENT ON COLUMN public.machine.state IS '0 비활성 1 정상 2 전원꺼짐';
COMMENT ON COLUMN public.machine.reg_dt IS '추가시간';
COMMENT ON COLUMN public.machine.recent_dt IS '서버와 통신을 마지막으로 한시간';

-- 수집정보
CREATE TABLE Collection_info (
	co_no serial4 NOT NULL,
    co_misae NUMERIC,
	co_humidity NUMERIC,
	co_temperature NUMERIC,
	state int4 NOT NULL DEFAULT 1,
	reg_dt timestamp NOT NULL DEFAULT now(),	
	CONSTRAINT Collection_info_pkey PRIMARY KEY (co_no),
	CONSTRAINT machine_ma_no_fkey FOREIGN KEY (ma_no) REFERENCES public.machine(ma_no) ON DELETE CASCADE ON UPDATE CASCADE
);
COMMENT ON COLUMN public.Collection_info.state IS '0 삭제 1 정상 2 고장';
COMMENT ON COLUMN public.Collection_info.reg_dt IS '추가시간';
COMMENT ON COLUMN public.Collection_info.end_dt IS '최종수정시간';

CREATE TABLE openapi(
    oa_no serial4 NOT NULL,
    oa_data jsonb,
    reg_dt timestamp not null DEFAULT now(),
   	CONSTRAINT Collection_info_pkey PRIMARY KEY (co_no)
)
COMMENT ON COLUMN public.openapi.oa_data IS '공공데이터 결과값';
COMMENT ON COLUMN public.openapi.reg_dt IS '공공데이터 발급시간';
