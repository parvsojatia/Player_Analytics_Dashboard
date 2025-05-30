

CREATE TABLE IF NOT EXISTS public.competitions
(
    competition_id integer NOT NULL,
    name text COLLATE pg_catalog."default",
    CONSTRAINT competitions_pkey PRIMARY KEY (competition_id)
);

CREATE TABLE IF NOT EXISTS public.events
(
    ball_receipt_outcome text COLLATE pg_catalog."default",
    ball_recovery_recovery_failure boolean,
    block_deflection boolean,
    clearance_aerial_won boolean,
    clearance_body_part text COLLATE pg_catalog."default",
    counterpress boolean,
    dribble_nutmeg boolean,
    dribble_outcome text COLLATE pg_catalog."default",
    dribble_overrun boolean,
    duel_outcome text COLLATE pg_catalog."default",
    duel_type text COLLATE pg_catalog."default",
    duration double precision,
    foul_committed_advantage boolean,
    foul_committed_card text COLLATE pg_catalog."default",
    foul_committed_penalty boolean,
    foul_won_advantage boolean,
    foul_won_defensive boolean,
    foul_won_penalty boolean,
    goalkeeper_body_part text COLLATE pg_catalog."default",
    goalkeeper_outcome text COLLATE pg_catalog."default",
    goalkeeper_position text COLLATE pg_catalog."default",
    goalkeeper_technique text COLLATE pg_catalog."default",
    goalkeeper_type text COLLATE pg_catalog."default",
    id text COLLATE pg_catalog."default" NOT NULL,
    index bigint,
    interception_outcome text COLLATE pg_catalog."default",
    match_id integer,
    minute bigint,
    off_camera boolean,
    "out" boolean,
    pass_aerial_won boolean,
    pass_angle double precision,
    pass_assisted_shot_id text COLLATE pg_catalog."default",
    pass_body_part text COLLATE pg_catalog."default",
    pass_cross boolean,
    pass_cut_back boolean,
    pass_goal_assist boolean,
    pass_height text COLLATE pg_catalog."default",
    pass_inswinging boolean,
    pass_length double precision,
    pass_outcome text COLLATE pg_catalog."default",
    pass_outswinging boolean,
    pass_recipient text COLLATE pg_catalog."default",
    pass_recipient_id double precision,
    pass_shot_assist boolean,
    pass_switch boolean,
    pass_technique text COLLATE pg_catalog."default",
    pass_through_ball boolean,
    pass_type text COLLATE pg_catalog."default",
    period bigint,
    play_pattern text COLLATE pg_catalog."default",
    player_id integer,
    "position" text COLLATE pg_catalog."default",
    possession bigint,
    possession_team_id integer,
    second bigint,
    shot_aerial_won boolean,
    shot_body_part text COLLATE pg_catalog."default",
    shot_first_time boolean,
    shot_key_pass_id text COLLATE pg_catalog."default",
    shot_one_on_one boolean,
    shot_outcome text COLLATE pg_catalog."default",
    shot_statsbomb_xg double precision,
    shot_technique text COLLATE pg_catalog."default",
    shot_type text COLLATE pg_catalog."default",
    substitution_outcome text COLLATE pg_catalog."default",
    substitution_outcome_id double precision,
    substitution_replacement_id double precision,
    team_id integer,
    "timestamp" time without time zone,
    type text COLLATE pg_catalog."default",
    under_pressure boolean,
    block_offensive boolean,
    foul_committed_offensive boolean,
    foul_committed_type text COLLATE pg_catalog."default",
    goalkeeper_shot_saved_to_post boolean,
    pass_deflected boolean,
    shot_deflected boolean,
    shot_saved_to_post boolean,
    clearance_other boolean,
    goalkeeper_punched_out boolean,
    injury_stoppage_in_chain boolean,
    dribble_no_touch boolean,
    miscontrol_aerial_won boolean,
    pass_miscommunication boolean,
    pass_no_touch boolean,
    pass_straight boolean,
    bad_behaviour_card text COLLATE pg_catalog."default",
    block_save_block boolean,
    ball_recovery_offensive boolean,
    goalkeeper_lost_in_play boolean,
    goalkeeper_success_in_play boolean,
    goalkeeper_shot_saved_off_target boolean,
    shot_saved_off_target boolean,
    shot_open_goal boolean,
    shot_redirect boolean,
    shot_follows_dribble boolean,
    half_start_late_video_start boolean,
    location_x double precision,
    location_y double precision,
    pass_end_location_x double precision,
    pass_end_location_y double precision,
    goalkeeper_end_location_x double precision,
    goalkeeper_end_location_y double precision,
    carry_end_location_x double precision,
    carry_end_location_y double precision,
    shot_end_location_x double precision,
    shot_end_location_y double precision,
    CONSTRAINT events_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.matches
(
    match_id bigint NOT NULL,
    match_date timestamp without time zone,
    home_team text COLLATE pg_catalog."default",
    away_team text COLLATE pg_catalog."default",
    home_score bigint,
    away_score bigint,
    competition_stage text COLLATE pg_catalog."default",
    competition_id integer,
    season_id integer,
    CONSTRAINT matches_pkey PRIMARY KEY (match_id)
);

CREATE TABLE IF NOT EXISTS public.players
(
    player_id integer NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    "position" character varying(30) COLLATE pg_catalog."default",
    team_id integer,
    CONSTRAINT players_pkey PRIMARY KEY (player_id)
);

CREATE TABLE IF NOT EXISTS public.seasons
(
    season_id integer NOT NULL,
    competition_id integer,
    season_name text COLLATE pg_catalog."default",
    CONSTRAINT seasons_pkey PRIMARY KEY (season_id)
);

CREATE TABLE IF NOT EXISTS public.teams
(
    team_id integer NOT NULL,
    team character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT teams_pkey PRIMARY KEY (team_id)
);

ALTER TABLE IF EXISTS public.events
    ADD CONSTRAINT fk_events_match_id FOREIGN KEY (match_id)
    REFERENCES public.matches (match_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.events
    ADD CONSTRAINT fk_events_player_id FOREIGN KEY (player_id)
    REFERENCES public.players (player_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.events
    ADD CONSTRAINT fk_events_possession_team_id FOREIGN KEY (possession_team_id)
    REFERENCES public.teams (team_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.events
    ADD CONSTRAINT fk_events_team_id FOREIGN KEY (team_id)
    REFERENCES public.teams (team_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.matches
    ADD CONSTRAINT fk_matches_competition_id FOREIGN KEY (competition_id)
    REFERENCES public.competitions (competition_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.matches
    ADD CONSTRAINT fk_matches_season_id FOREIGN KEY (season_id)
    REFERENCES public.seasons (season_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.players
    ADD CONSTRAINT fk_players_team_id FOREIGN KEY (team_id)
    REFERENCES public.teams (team_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
CREATE INDEX IF NOT EXISTS idx_players_team_id
    ON public.players(team_id);


ALTER TABLE IF EXISTS public.seasons
    ADD CONSTRAINT fk_seasons_competition_id FOREIGN KEY (competition_id)
    REFERENCES public.competitions (competition_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;