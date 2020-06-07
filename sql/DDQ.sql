--Create Tables

DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams` (
`team_id` int(11) NOT NULL AUTO_INCREMENT,
`first_name` varchar(255) NOT NULL,
`last_name` varchar(255) NOT NULL,
`active_member` boolean NOT NULL,
PRIMARY KEY (team_id),
CONSTRAINT `full_name` UNIQUE (first_name, last_name)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `seasons`;
CREATE TABLE `seasons` (
`season_id` int(11) NOT NULL AUTO_INCREMENT,
`year` int(11) NOT NULL,
`championship_team_id` int,
`runner_up_id` int,
PRIMARY KEY (season_id),
FOREIGN KEY (championship_team_id) REFERENCES teams(team_id),
FOREIGN KEY (runner_up_id) REFERENCES teams(team_id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `season_teams`;
CREATE TABLE `season_teams` (
`season_id` int,
`team_id` int,
`made_playoffs` boolean NOT NULL,
`wins` int,
`losses` int,
`ties  ` int,
`points_scored` FLOAT(10),
`points_against` FLOAT(10),
PRIMARY KEY (season_id, team_id),
FOREIGN KEY (season_id) REFERENCES seasons(season_id),
FOREIGN KEY (team_id) REFERENCES teams(team_id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `league_dues`;

CREATE TABLE `league_dues` (
`dues_id` int NOT NULL AUTO_INCREMENT,
`season_id` int,
`team_id` int,
`amount` int NOT NULL,
PRIMARY KEY (dues_id),
FOREIGN KEY (season_id) REFERENCES seasons(season_id),
FOREIGN KEY (team_id) REFERENCES teams(team_id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `matchups`;
CREATE TABLE `matchups` (
`matchup_id` int NOT NULL AUTO_INCREMENT,
`season_id` int,
`week` int(11) NOT NULL,
`home_team_id` int,
`away_team_id` int,
`home_team_score` FLOAT(10),
`away_team_score` FLOAT(10),
PRIMARY KEY (matchup_id),
FOREIGN KEY (season_id) REFERENCES seasons(season_id),
FOREIGN KEY (home_team_id) REFERENCES teams(team_id),
FOREIGN KEY (away_team_id) REFERENCES teams(team_id)
) ENGINE=InnoDB;


-- Insert into Teams - all values
INSERT INTO teams (first_name, last_name, active_member) VALUES
('Ron', 'Klein', 1), ('Adam', 'Bolton', 1), ('Dan', 'Cobert', 1), ('Dan', 'Friedman', 1),
('Justin', 'Gatt', 1), ('Derek', 'Tinkle', 1), ('Matt', 'Colville', 1), ('Neil', 'Arthur', 1),
('Zell', 'Zoerhof', 1), ('Adam', 'Kunkel', 1), ('Mitch', 'Goncalves', 1), ('Nate', 'Maziar', 1),
('Kurt', 'Peters', 0), ('Jon', 'Habshoosh', 0), ('Danny', 'Kaafrani', 0), ('Amos', 'Goldstein', 0),
('Danny', 'Ackerman', 0), ('Kyle', 'Tennenbaum', 0), ('Sam', 'Miller', 0), ('Joe', 'Demery', 0),
('Alex', 'Benfield', 0), ('Will', 'Timmer', 0);

-- Insert into Seasons
INSERT INTO seasons (year, championship_team_id, runner_up_id) VALUES
(2010, (SELECT team_id FROM teams WHERE last_name='Cobert'), (SELECT team_id FROM teams WHERE last_name='Colville')),
(2011, (SELECT team_id FROM teams WHERE last_name='Gatt'), (SELECT team_id FROM teams WHERE last_name='Klein')),
(2012, (SELECT team_id FROM teams WHERE last_name='Bolton'), (SELECT team_id FROM teams WHERE last_name='Klein')),
(2013, (SELECT team_id FROM teams WHERE last_name='Friedman'), (SELECT team_id FROM teams WHERE last_name='Bolton')),
(2014, (SELECT team_id FROM teams WHERE last_name='Bolton'), (SELECT team_id FROM teams WHERE last_name='Zoerhof')),
(2015, (SELECT team_id FROM teams WHERE last_name='Cobert'), (SELECT team_id FROM teams WHERE last_name='Kunkel')),
(2016, (SELECT team_id FROM teams WHERE last_name='Gatt'), (SELECT team_id FROM teams WHERE last_name='Cobert')),
(2017, (SELECT team_id FROM teams WHERE last_name='Tinkle'), (SELECT team_id FROM teams WHERE last_name='Maziar')),
(2018, (SELECT team_id FROM teams WHERE last_name='Klein'), (SELECT team_id FROM teams WHERE last_name='Tinkle')),
(2019, (SELECT team_id FROM teams WHERE last_name='Maziar'), (SELECT team_id FROM teams WHERE last_name='Colville'));

--Insert into Teams in Seasons
INSERT INTO season_teams (season_id, team_id, made_playoffs, wins, losses, ties, points_scored, points_against) VALUES
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Maziar'), 1, 8, 5, 0, 1190.98, 1179.66),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Bolton'), 1, 7, 6, 0, 1187, 1176.28),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Colville'), 1, 8, 5, 0, 1117.62, 1085.84),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Kunkel'), 1, 7, 6, 0, 1186.32, 1031.92),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 1, 9, 4, 0, 1192.38, 1145.78),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Gatt'), 1, 8, 5, 0, 1340.24, 1205.38),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Cobert'), 0, 3, 10, 0, 975.74, 1130.26),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Klein'), 0, 6, 7, 0, 1096.08, 1132.34),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Goncalves'), 0, 5, 8, 0, 1230.98, 1267.6),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Arthur'), 0, 7, 6, 0, 1156.28, 1155.42),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), 0, 6, 7, 0, 956.6, 1037.12),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Friedman'), 0, 4, 9, 0, 1042.9, 1125.52),

((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Maziar'), 0, 6, 7, 0, 1281.72, 1284.54),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Bolton'), 1, 8, 5, 0, 1236.18, 1281.52),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Colville'), 0, 1, 12, 0, 1052.6, 1271.54),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Kunkel'), 1, 8, 5, 0, 1290.22, 1183.9),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 1, 10, 3, 0, 1313, 1084.72),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Gatt'), 0, 3, 10, 0, 1216.26, 1350.02),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Cobert'), 0, 4, 9, 0, 1213.46, 1396.76),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Klein'), 1, 9, 4, 0, 1308.24, 1179.74),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Goncalves'), 1, 7, 6, 0, 1256.96, 1256.38),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Arthur'), 0, 7, 6, 0, 1165.74, 1086.98),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), 1, 9, 4, 0, 1274.6, 1165.52),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Friedman'), 0, 6, 7, 0, 1141.7, 1209.06),

((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Maziar'), 1, 9, 4, 0, 1128.62, 1072.68),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Bolton'), 0, 7, 6, 0, 1202.76, 1182.06),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Colville'), 0, 4, 9, 0, 993.12, 1013.24),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Kunkel'), 0, 4, 9, 0, 985.78, 1127.08),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 1, 7, 6, 0, 1241.58, 1162.64),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Gatt'), 1, 8, 5, 0, 1086.22, 1039.84),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Cobert'), 1, 7, 6, 0, 1117.72, 1123.94),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Klein'), 0, 5, 8, 0, 1106.38, 1147.36),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Goncalves'), 0, 7, 6, 0, 981.5, 956.1),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Arthur'), 1, 9, 4, 0, 1108.28, 993),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), 0, 3, 10, 0, 1045.92, 1203.36),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Friedman'), 1, 8, 5, 0, 1110.98, 1087.56),

((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Maziar'), 0, 3, 10, 0, 985.36, 1278.34),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Bolton'), 1, 8, 5, 0, 1088.6, 1112.62),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Colville'), 0, 6, 7, 0, 933.12, 967.02),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Kunkel'), 0, 3, 10, 0, 1098.98, 1214.82),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 0, 6, 7, 0, 1278.72, 1239.3),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Gatt'), 1, 9, 4, 0, 1194.46, 1077.5),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Cobert'), 1, 9, 4, 0, 1304.14, 1151.78),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Klein'), 1, 9, 4, 0, 1209.74, 1055.46),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Timmer'), 0, 7, 6, 0, 1203.32, 1219.44),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Arthur'), 1, 8, 5, 0, 1176.06, 1029.06),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), 1, 8, 5, 0, 1161.24, 1023.12),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Friedman'), 0, 2, 11, 0, 967.64, 1232.92),

((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Maziar'), 1, 8, 5, 0, 1273.56, 1182.08),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Bolton'), 1, 6, 7, 0, 1361.76, 1319.56),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Colville'), 0, 6, 7, 0, 1214.48, 1165.12),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Kunkel'), 1, 6, 7, 0, 1350.02, 1229.3),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 0, 5, 8, 0, 1082.64, 1208.66),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Gatt'), 1, 7, 6, 0, 1240.16, 1377.16),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Cobert'), 1, 10, 3, 0, 1400.32, 1208.52),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Klein'), 0, 6, 7, 0, 1212.32, 1247.62),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Timmer'), 0, 4, 9, 0, 1170.8, 1291.24),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Arthur'), 1, 8, 5, 0, 1232.92, 1252.94),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), 0, 6, 7, 0, 1094.6, 1246.96),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Friedman'), 0, 6, 7, 0, 1290.44, 1194.86),

((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Maziar'), 1, 8, 5, 0, 1391.8, 1224.3),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Bolton'), 1, 9, 4, 0, 1435.86, 1327.48),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Colville'), 0, 3, 10, 0, 1010.9, 1250.88),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Kunkel'), 0, 5, 8, 0, 1232.5, 1369.62),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 1, 7, 5, 1, 1317.4, 1263.06),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Gatt'), 1, 8, 4, 1, 1335.04, 1214.32),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Cobert'), 0, 1, 12, 0, 1220.76, 1333.88),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Klein'), 0, 7, 6, 0, 1171.04, 1215.28),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Timmer'), 0, 6, 7, 0, 1319.04, 1350.44),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Miller'), 1, 9, 4, 0, 1247.86, 1172.34),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), 1, 9, 4, 0, 1317.56, 1225.82),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Friedman'), 0, 5, 8, 0, 1275.12, 1327.46),

((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Maziar'), 1, 9, 3, 1, 1208, 1160),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Bolton'), 1, 7, 6, 0, 1058, 1102),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Colville'), 1, 7, 5, 1, 1262, 1152),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Kunkel'), 0, 5, 8, 0, 1143, 1146),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 0, 4, 7, 2, 1254, 1284),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Gatt'), 0, 6, 7, 0, 1115, 1151),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Cobert'), 0, 4, 9, 0, 1207, 1336),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Klein'), 1, 9, 4, 0, 1185, 1095),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Timmer'), 0, 5, 8, 0, 1105, 1173),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Miller'), 0, 5, 8, 0, 1193, 1302),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), 1, 8, 5, 0, 1194, 1134),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Friedman'), 1, 7, 6, 0, 1324, 1213),

((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Maziar'), 1, 7, 6, 0, 1154, 1129),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Bolton'), 1, 9, 4, 0, 1191, 1038),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Colville'), 0, 2, 10, 1, 1011, 1260),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Kaafrani'), 0, 3, 10, 0, 950, 1197),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 0, 6, 7, 0, 1072, 1198),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Gatt'), 0, 6, 7, 0, 1374, 1291),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Cobert'), 0, 5, 8, 0, 1119, 1194),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Klein'), 1, 13, 0, 0, 1244, 944),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Timmer'), 1, 7, 6, 0, 1037, 1069),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Miller'), 0, 4, 8, 1, 1197, 1208),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Benfield'), 1, 8, 5, 0, 1333, 1098),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Friedman'), 1, 7, 6, 0, 1132, 1188),

((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Maziar'), 1, 7, 6, 0, 1137, 1177),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Ackerman'), 0, 6, 7, 0, 1100, 1085),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Colville'), 1, 7, 6, 0, 986, 1095),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Demery'), 0, 5, 8, 0, 1053, 1155),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 1, 9, 4, 0, 1354, 1086),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Gatt'), 1, 9, 4, 0, 1322, 1059),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Cobert'), 0, 1, 12, 0, 953, 1264),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Klein'), 1, 10, 3, 0, 1289, 1084),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Habshoosh'), 0, 6, 7, 0, 1112, 1107),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Goldstein'), 0, 6, 7, 0, 1170, 1321),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Peters'), 0, 4, 9, 0, 1119, 1212),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Friedman'), 1, 8, 5, 0, 1366, 1316),

((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Maziar'), 1, 9, 4, 0, 1024, 950),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Ackerman'), 0, 5, 8, 0, 1096, 1190),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Colville'), 1, 7, 6, 0, 1174, 1148),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Kaafrani'), 1, 10, 3, 0, 1353, 1074),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 0, 7, 6, 0, 1142, 1253),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Gatt'), 1, 7, 6, 0, 1239, 1191),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Cobert'), 1, 9, 4, 0, 1384, 1172),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Klein'), 0, 6, 7, 0, 1060, 1118),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Peters'), 0, 1, 12, 0, 855, 1332),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Tenenbaum'), 1, 7, 6, 0, 1190, 1079),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Patel'), 0, 5, 8, 0, 1140, 1169),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Friedman'), 0, 5, 8, 0, 1239, 1220);

-- Insert into Dues
INSERT INTO league_dues (season_id, team_id, amount) VALUES
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Maziar'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Bolton'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Colville'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Kunkel'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Gatt'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Cobert'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Klein'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Goncalves'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Arthur'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Friedman'), -250),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Maziar'), 2000),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Colville'), 700),
((SELECT season_id from seasons WHERE year=2019), (SELECT team_id FROM teams WHERE last_name='Gatt'), 300),

((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Maziar'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Bolton'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Colville'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Kunkel'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Gatt'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Cobert'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Klein'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Goncalves'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Arthur'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Friedman'), -200),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Klein'), 1600),
((SELECT season_id from seasons WHERE year=2018), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 800),

((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Maziar'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Bolton'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Colville'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Kunkel'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Gatt'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Cobert'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Klein'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Goncalves'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Arthur'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Friedman'), -200),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Tinkle'), 1600),
((SELECT season_id from seasons WHERE year=2017), (SELECT team_id FROM teams WHERE last_name='Maziar'), 800),

((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Maziar'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Bolton'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Colville'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Kunkel'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Gatt'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Cobert'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Klein'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Timmer'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Arthur'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Friedman'), -150),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Gatt'), 1200),
((SELECT season_id from seasons WHERE year=2016), (SELECT team_id FROM teams WHERE last_name='Cobert'), 600),

((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Maziar'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Bolton'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Colville'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Kunkel'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Gatt'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Cobert'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Klein'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Timmer'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Arthur'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Friedman'), -100),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Cobert'), 800),
((SELECT season_id from seasons WHERE year=2015), (SELECT team_id FROM teams WHERE last_name='Kunkel'), 400),

((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Maziar'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Bolton'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Colville'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Kunkel'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Gatt'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Cobert'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Klein'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Timmer'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Miller'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Friedman'), -100),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Bolton'), 800),
((SELECT season_id from seasons WHERE year=2014), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), 400),

((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Maziar'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Bolton'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Colville'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Kunkel'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Gatt'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Cobert'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Klein'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Timmer'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Miller'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Zoerhof'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Friedman'), -50),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Friedman'), 400),
((SELECT season_id from seasons WHERE year=2013), (SELECT team_id FROM teams WHERE last_name='Bolton'), 200),

((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Maziar'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Bolton'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Colville'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Kaafrani'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Gatt'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Cobert'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Klein'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Timmer'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Miller'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Benfield'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Friedman'), -50),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Bolton'), 400),
((SELECT season_id from seasons WHERE year=2012), (SELECT team_id FROM teams WHERE last_name='Klein'), 200),

((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Maziar'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Ackerman'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Colville'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Demery'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Gatt'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Cobert'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Klein'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Habshoosh'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Goldstein'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Peters'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Friedman'), -50),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Gatt'), 400),
((SELECT season_id from seasons WHERE year=2011), (SELECT team_id FROM teams WHERE last_name='Klein'), 200),

((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Maziar'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Ackerman'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Colville'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Kaafrani'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Tinkle'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Gatt'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Cobert'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Klein'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Peters'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Tenenbaum'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Patel'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Friedman'), -50),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Cobert'), 400),
((SELECT season_id from seasons WHERE year=2010), (SELECT team_id FROM teams WHERE last_name='Colville'), 200);

-- Insert Into Matchup - Need many more values:
INSERT INTO matchups (season_id, week, home_team_id, away_team_id, home_team_score, away_team_score) VALUES
((SELECT season_id FROM seasons WHERE year=2019), (1), (SELECT team_id FROM teams WHERE last_name='Bolton'),(SELECT team_id FROM teams WHERE last_name='Goncalves'), (123.6), (107.34)),
((SELECT season_id FROM seasons WHERE year=2019), (1), (SELECT team_id FROM teams WHERE last_name='Gatt'),(SELECT team_id FROM teams WHERE last_name='Cobert'), (94.02), (63.74)),
((SELECT season_id FROM seasons WHERE year=2019), (1), (SELECT team_id FROM teams WHERE last_name='Maziar'),(SELECT team_id FROM teams WHERE last_name='Kunkel'), (125.22), (99.52));
