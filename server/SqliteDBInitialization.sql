-- we don't know how to generate schema main (class Schema) :(

PRAGMA foreign_keys = on;

drop table if exists donations;
drop table if exists competitions;
delete
from sqlite_sequence
where name = 'users';
drop table if exists users;
delete
from sqlite_sequence
where name = 'teams';
drop table if exists teams;
delete
from sqlite_sequence
where name = 'institutions';
drop table if exists institutions;


create table if not exists institutions
(
    institutionID integer
        constraint institutions_pk
            primary key autoincrement,
    name          text not null
);

create unique index if not exists institutions_name_uindex
    on institutions (name);

create table if not exists teams
(
    teamID                integer
        constraint teams_pk
            primary key autoincrement,
    name                  text not null,
    donationInstitutionID integer default 1 not null
        references institutions
);

create unique index if not exists teams_name_uindex
    on teams (name);

create table if not exists users
(
    _user_ID              integer
        constraint users_pk
            primary key autoincrement,
    dateSubmited          date    default current_date,
    teamID                integer default 1 not null
        references teams,
    userID                TEXT not null,
    name                  TEXT not null,
    email                 TEXT,
    donationInstitutionID integer default 1 not null
        references institutions
);

create table if not exists competitions
(
    dateBegin   date default current_date,
    dateEnd     date default (date(current_date, '+8 day')) not null,
    asTeam      char default 'N' not null,
    competitor1 integer not null
        references users,
    competitor2 integer not null
        references users,
    constraint competitions_pk
        primary key (dateBegin desc, competitor1 asc, competitor2 asc)
);

create table if not exists donations
(
    date    datetime default current_date,
    donator integer not null
        references users,
    litros  float    default 0 not null,
    constraint donations_pk
        primary key (date, donator)
);

create unique index if not exists users_dateSubmited_teamID_userID_uindex
    on users (dateSubmited desc, teamID asc, userID asc);

/* Insert the predefined data on tables */

begin transaction;

INSERT INTO institutions (institutionID, name)
VALUES (1, 'Monthly promoted by Gym');
INSERT INTO institutions (institutionID, name)
VALUES (2, 'AMAR - Associação Macinhatense de Assistência, Recreio e Cultura');
INSERT INTO institutions (institutionID, name)
VALUES (3, 'ARCA DA BOTAREU - Associação Recreativa e Cultural de Águeda');
INSERT INTO institutions (institutionID, name)
VALUES (4, 'ARCOR - Associação Recreativa e Cultural de Óis da Ribeira');
INSERT INTO institutions (institutionID, name)
VALUES (5, 'Associação Social e Cultural de Serém');
INSERT INTO institutions (institutionID, name)
VALUES (6, 'Associação Barroense de Recreio, Cultura e Assistência - ABARCA');
INSERT INTO institutions (institutionID, name)
VALUES (7, 'Associação Fermentelense de Assistência a Crianças e Pessoas da Terceira
Idade');

INSERT INTO teams (teamID, name, donationInstitutionID)
VALUES (1, ' ', 1);
INSERT INTO teams (teamID, name, donationInstitutionID)
VALUES (2, 'Os incríveis', 1);
INSERT INTO teams (teamID, name, donationInstitutionID)
VALUES (3, 'Homens e mulheres de ferro', 1);
INSERT INTO teams (teamID, name, donationInstitutionID)
VALUES (4, 'Bastardos inglórios', 1);
INSERT INTO teams (teamID, name, donationInstitutionID)
VALUES (5, 'Turma do Scooby Doo', 1);
INSERT INTO teams (teamID, name, donationInstitutionID)
VALUES (6, 'Desistir jamais', 1);
INSERT INTO teams (teamID, name, donationInstitutionID)
VALUES (7, 'Rosa bebê', 1);
INSERT INTO teams (teamID, name, donationInstitutionID)
VALUES (8, 'Coração valente', 1);

INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (1, '2019-11-10', 1, 'rfid1', 'Manuel Sola de Sá Pato', null, 1);
INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (2, '2019-11-10', 1, 'rfid2', 'Francisco Zebedeu Sanguessuga', null, 1);
INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (3, '2019-11-10', 1, 'rfid3', 'Estácio Ponta Fina Amolador', null, 1);
INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (4, '2019-11-10', 1, 'rfid4', 'José Maria Bota Pardal', null, 1);
INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (5, '2019-11-10', 2, 'rfid5', 'Dolores Fuertes de Barriga', null, 1);
INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (6, '2019-11-10', 3, 'rfid6', 'Darcília Abraços', null, 1);
INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (7, '2019-11-10', 2, 'rfid7', 'Colapso Cardíaco da Silva', null, 1);
INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (8, '2019-11-10', 3, 'rfid8', 'Chevrolet da Silva Ford', null, 1);
INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (9, '2019-11-10', 4, 'rfid9', 'Antônio Querido Fracasso', null, 1);
INSERT INTO users (_user_ID, dateSubmited, teamID, userID, name, email, donationInstitutionID)
VALUES (10, '2019-11-10', 5, 'rfid10', 'Aleluia Sarango', null, 1);

INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 1, 0);
INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 2, 3.5);
INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 3, 1.2);
INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 4, 5.83);
INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 5, 4.4);
INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 6, 2.07);
INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 7, 3.23);
INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 8, 2.1);
INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 9, 0.3);
INSERT INTO donations (date, donator, litros)
VALUES ('2019-11-10', 10, 1.1);

INSERT INTO competitions (dateBegin, dateEnd, asTeam, competitor1, competitor2)
VALUES ('2019-11-10', '2019-11-18', 'N', 1, 2);
INSERT INTO competitions (dateBegin, dateEnd, asTeam, competitor1, competitor2)
VALUES ('2019-11-10', '2019-11-18', 'N', 3, 4);
INSERT INTO competitions (dateBegin, dateEnd, asTeam, competitor1, competitor2)
VALUES ('2019-11-10', '2019-11-18', 'S', 5, 6);
INSERT INTO competitions (dateBegin, dateEnd, asTeam, competitor1, competitor2)
VALUES ('2019-11-10', '2019-11-18', 'S', 7, 8);
INSERT INTO competitions (dateBegin, dateEnd, asTeam, competitor1, competitor2)
VALUES ('2019-11-10', '2019-11-18', 'N', 9, 10);

/* Reset the tables autoincrement sequences to predefined value */

update sqlite_sequence
set seq=7
where name = 'institutions';
update sqlite_sequence
set seq=8
where name = 'teams';
update sqlite_sequence
set seq=10
where name = 'users';

commit transaction;


Drop VIEW IF EXISTS getViewDonations;
CREATE VIEW IF NOT EXISTS getViewDonations
            (date, litros, donator, teamID, userID, name, donationInstitutionID, dateSubmited, email)
AS
select d.date,
       d.litros,
       d.donator,
       u.teamID,
       u.userID,
       u.name,
       u.donationInstitutionID,
       u.dateSubmited,
       u.email
from donations d,
     users u
where d.donator = u._user_ID
  and d.date >= u.dateSubmited;

Drop VIEW IF EXISTS getViewUsersCompetitions;
-- Select is working but not creates the view
CREATE VIEW IF NOT EXISTS getViewUsersCompetition
            (dateBegin, dateEnd, competitor1, teamID1, poupancaL1, competitor2, teamID2, poupancaL2, asTeam)
AS
select compet1.dateBegin   as dateBegin,
       compet1.dateEnd     as dateEnd,
       compet1.competitor1 as competitor1,
       compet1.teamID      as teamID1,
       compet1.poupancaL   as poupancaL1,
       compet1.competitor2 as competitor2,
       compet2.teamID      as teamID2,
       compet2.poupancaL   as poupancaL2,
       compet1.asTeam      as asTeam
from
    /* 1l = 1dm cubico; preco metro cubico = 0.40€*/
    (select sum(d.litros)                            poupancaL,
            (round(sum(d.litros) * 0.001 * 0.40, 5)) Eur,
            c.dateBegin,
            c.dateEnd,
            c.competitor1,
            c.competitor2,
            u.teamID,
            c.asTeam
     from donations d,
          competitions c,
          users u
     where d.donator = c.competitor1
       and u._user_ID = c.competitor1
       and d.date between c.dateBegin and c.dateEnd
       and u.dateSubmited between c.dateBegin and c.dateEnd
     group by c.dateBegin, c.competitor1, u._user_ID, u.teamID, c.asTeam
     having asTeam = 'N'
     order by c.dateBegin desc, poupancaL desc, Eur desc, teamID, competitor1) compet1,
    (select sum(d.litros)                            poupancaL,
            (round(sum(d.litros) * 0.001 * 0.40, 5)) Eur,
            c.dateBegin,
            c.dateEnd,
            c.competitor1,
            c.competitor2,
            u.teamID,
            c.asTeam
     from donations d,
          competitions c,
          users u
     where d.donator = c.competitor2
       and u._user_ID = c.competitor2
       and d.date between c.dateBegin and c.dateEnd
       and u.dateSubmited between c.dateBegin and c.dateEnd
     group by c.dateBegin, c.competitor2, u._user_ID, u.teamID, c.asTeam
     having asTeam = 'N'
     order by c.dateBegin desc, poupancaL desc, Eur desc, teamID, competitor2) compet2
where compet1.dateBegin = compet2.dateBegin
  and compet1.competitor1 = compet2.competitor1
  and compet1.competitor2 = compet2.competitor2;

Drop VIEW IF EXISTS getViewTeamsCompetitions;
-- Select is working but not creates the view
CREATE VIEW IF NOT EXISTS getViewTeamsCompetition
            (dateBegin, dateEnd, competitor1, teamID1, poupancaL1, competitor2, teamID2, poupancaL2, asTeam)
AS
select compet1.dateBegin   as dateBegin,
       compet1.dateEnd     as dateEnd,
       compet1.competitor1 as competitor1,
       compet1.teamID      as teamID1,
       compet1.poupancaL   as poupancaL1,
       compet1.competitor2 as competitor2,
       compet2.teamID      as teamID2,
       compet2.poupancaL   as poupancaL2,
       compet1.asTeam      as asTeam
from
    /* 1l = 1dm cubico; preco metro cubico = 0.40€*/
    (select sum(d.litros)                            poupancaL,
            (round(sum(d.litros) * 0.001 * 0.40, 5)) Eur,
            c.dateBegin,
            c.dateEnd,
            c.competitor1,
            c.competitor2,
            u.teamID,
            c.asTeam
     from donations d,
          competitions c,
          users u
     where d.donator = c.competitor1
       and u._user_ID = c.competitor1
       and d.date between c.dateBegin and c.dateEnd
       and u.dateSubmited between c.dateBegin and c.dateEnd
     group by c.dateBegin, c.competitor1, u._user_ID, u.teamID, c.asTeam
     having asTeam = 'S'
     order by c.dateBegin desc, poupancaL desc, Eur desc, teamID, competitor1) compet1,
    (select sum(d.litros)                            poupancaL,
            (round(sum(d.litros) * 0.001 * 0.40, 5)) Eur,
            c.dateBegin,
            c.dateEnd,
            c.competitor1,
            c.competitor2,
            u.teamID,
            c.asTeam
     from donations d,
          competitions c,
          users u
     where d.donator = c.competitor2
       and u._user_ID = c.competitor2
       and d.date between c.dateBegin and c.dateEnd
       and u.dateSubmited between c.dateBegin and c.dateEnd
     group by c.dateBegin, c.competitor2, u._user_ID, u.teamID, c.asTeam
     having asTeam = 'S'
     order by c.dateBegin desc, poupancaL desc, Eur desc, teamID, competitor2) compet2
where compet1.dateBegin = compet2.dateBegin
  and compet1.competitor1 = compet2.competitor1
  and compet1.competitor2 = compet2.competitor2;
