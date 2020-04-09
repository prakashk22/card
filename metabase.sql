-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 09, 2020 at 06:01 PM
-- Server version: 5.7.29-0ubuntu0.16.04.1
-- PHP Version: 7.0.33-0ubuntu0.16.04.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `metabase`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity`
--

CREATE TABLE `activity` (
  `id` int(11) NOT NULL,
  `topic` varchar(32) NOT NULL,
  `timestamp` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `model` varchar(16) DEFAULT NULL,
  `model_id` int(11) DEFAULT NULL,
  `database_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `custom_id` varchar(48) DEFAULT NULL,
  `details` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `card_label`
--

CREATE TABLE `card_label` (
  `id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `label_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `collection`
--

CREATE TABLE `collection` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL COMMENT 'The unique, user-facing name of this Collection.',
  `slug` varchar(254) NOT NULL COMMENT 'URL-friendly, sluggified, indexed version of name.',
  `description` text COMMENT 'Optional description for this Collection.',
  `color` char(7) NOT NULL COMMENT 'Seven-character hex color for this Collection, including the preceding hash sign.',
  `archived` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Whether this Collection has been archived and should be hidden from users.',
  `location` varchar(254) NOT NULL DEFAULT '/' COMMENT 'Directory-structure path of ancestor Collections. e.g. "/1/2/" means our Parent is Collection 2, and their parent is Collection 1.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Collections are an optional way to organize Cards and handle permissions for them.';

-- --------------------------------------------------------

--
-- Table structure for table `collection_revision`
--

CREATE TABLE `collection_revision` (
  `id` int(11) NOT NULL,
  `before` text NOT NULL COMMENT 'Serialized JSON of the collections graph before the changes.',
  `after` text NOT NULL COMMENT 'Serialized JSON of the collections graph after the changes.',
  `user_id` int(11) NOT NULL COMMENT 'The ID of the admin who made this set of changes.',
  `created_at` datetime NOT NULL COMMENT 'The timestamp of when these changes were made.',
  `remark` text COMMENT 'Optional remarks explaining why these changes were made.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Used to keep track of changes made to collections.';

-- --------------------------------------------------------

--
-- Table structure for table `computation_job`
--

CREATE TABLE `computation_job` (
  `id` int(11) NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `type` varchar(254) NOT NULL,
  `status` varchar(254) NOT NULL,
  `context` text,
  `ended_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores submitted async computation jobs.';

-- --------------------------------------------------------

--
-- Table structure for table `computation_job_result`
--

CREATE TABLE `computation_job_result` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `permanence` varchar(254) NOT NULL,
  `payload` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores results of async computation jobs.';

-- --------------------------------------------------------

--
-- Table structure for table `core_session`
--

CREATE TABLE `core_session` (
  `id` varchar(254) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `core_user`
--

CREATE TABLE `core_user` (
  `id` int(11) NOT NULL,
  `email` varchar(254) NOT NULL,
  `first_name` varchar(254) NOT NULL,
  `last_name` varchar(254) NOT NULL,
  `password` varchar(254) NOT NULL,
  `password_salt` varchar(254) NOT NULL DEFAULT 'default',
  `date_joined` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` bit(1) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `reset_token` varchar(254) DEFAULT NULL,
  `reset_triggered` bigint(20) DEFAULT NULL,
  `is_qbnewb` bit(1) NOT NULL DEFAULT b'1',
  `google_auth` bit(1) NOT NULL DEFAULT b'0',
  `ldap_auth` bit(1) NOT NULL DEFAULT b'0',
  `login_attributes` text COMMENT 'JSON serialized map with attributes used for row level permissions',
  `updated_at` datetime DEFAULT NULL COMMENT 'When was this User last updated?'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dashboardcard_series`
--

CREATE TABLE `dashboardcard_series` (
  `id` int(11) NOT NULL,
  `dashboardcard_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `position` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_favorite`
--

CREATE TABLE `dashboard_favorite` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'ID of the User who favorited the Dashboard.',
  `dashboard_id` int(11) NOT NULL COMMENT 'ID of the Dashboard favorited by the User.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Presence of a row here indicates a given User has favorited a given Dashboard.';

-- --------------------------------------------------------

--
-- Table structure for table `DATABASECHANGELOG`
--

CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DATABASECHANGELOG`
--

INSERT INTO `DATABASECHANGELOG` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES
('1', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:00:42', 1, 'EXECUTED', '8:29a8f482877466643f65adb20c6d2139', 'createTable tableName=core_organization; createTable tableName=core_user; createTable tableName=core_userorgperm; addUniqueConstraint constraintName=idx_unique_user_id_organization_id, tableName=core_userorgperm; createIndex indexName=idx_userorgp...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('2', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:00:45', 2, 'EXECUTED', '8:983477ec51adb1236dd9d76ebf604be9', 'createTable tableName=core_session', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('4', 'cammsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:00:46', 3, 'EXECUTED', '8:a8e7822a91ea122212d376f5c2d4158f', 'createTable tableName=setting', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('5', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:00:51', 4, 'EXECUTED', '8:4f8653d16f4b102b3dff647277b6b988', 'addColumn tableName=core_organization', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('6', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:01:03', 5, 'EXECUTED', '8:2d2f5d1756ecb81da7c09ccfb9b1565a', 'dropNotNullConstraint columnName=organization_id, tableName=metabase_database; dropForeignKeyConstraint baseTableName=metabase_database, constraintName=fk_database_ref_organization_id; dropNotNullConstraint columnName=organization_id, tableName=re...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('7', 'cammsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:01:09', 6, 'EXECUTED', '8:c57c69fd78d804beb77d261066521f7f', 'addColumn tableName=metabase_field', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('8', 'tlrobinson', 'migrations/000_migrations.yaml', '2020-04-09 17:01:12', 7, 'EXECUTED', '8:960ec59bbcb4c9f3fa8362eca9af4075', 'addColumn tableName=metabase_table; addColumn tableName=metabase_field', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('9', 'tlrobinson', 'migrations/000_migrations.yaml', '2020-04-09 17:01:14', 8, 'EXECUTED', '8:d560283a190e3c60802eb04f5532a49d', 'addColumn tableName=metabase_table', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('10', 'cammsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:01:17', 9, 'EXECUTED', '8:96e54d9100db3f9cdcc00eaeccc200a3', 'createTable tableName=revision; createIndex indexName=idx_revision_model_model_id, tableName=revision', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('11', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:01:17', 10, 'EXECUTED', '8:ca6561cab1eedbcf4dcb6d6e22cd46c6', 'sql', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('12', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:01:37', 11, 'EXECUTED', '8:bedbea570e5dfc694b4cf5a8f6a4f445', 'addColumn tableName=report_card', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('13', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:01:45', 12, 'EXECUTED', '8:0cbc15990a7e73c8cc1fa5961ec2ba97', 'createTable tableName=activity; createIndex indexName=idx_activity_timestamp, tableName=activity; createIndex indexName=idx_activity_user_id, tableName=activity; createIndex indexName=idx_activity_custom_id, tableName=activity', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('14', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:01:53', 13, 'EXECUTED', '8:7dc558da864d98b79f8d13a427ca3858', 'createTable tableName=view_log; createIndex indexName=idx_view_log_user_id, tableName=view_log; createIndex indexName=idx_view_log_timestamp, tableName=view_log', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('15', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:01:54', 14, 'EXECUTED', '8:505b91530103673a9be3382cd2db1070', 'addColumn tableName=revision', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('16', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:01:55', 15, 'EXECUTED', '8:b81df46fe16c3e8659a81798b97a4793', 'dropNotNullConstraint columnName=last_login, tableName=core_user', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('17', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:01:56', 16, 'EXECUTED', '8:051c23cd15359364b9895c1569c319e7', 'addColumn tableName=metabase_database; sql', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('18', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:01:57', 17, 'EXECUTED', '8:62a0483dde183cfd18dd0a86e9354288', 'createTable tableName=data_migrations; createIndex indexName=idx_data_migrations_id, tableName=data_migrations', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('19', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:01:59', 18, 'EXECUTED', '8:269b129dbfc39a6f9e0d3bc61c3c3b70', 'addColumn tableName=metabase_table', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('20', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:02:26', 19, 'EXECUTED', '8:7ec10b2c7acbab0fc38043be575ff907', 'createTable tableName=pulse; createIndex indexName=idx_pulse_creator_id, tableName=pulse; createTable tableName=pulse_card; createIndex indexName=idx_pulse_card_pulse_id, tableName=pulse_card; createIndex indexName=idx_pulse_card_card_id, tableNam...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('21', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:02:30', 20, 'EXECUTED', '8:492a1b64ff9c792aa6ba97d091819261', 'createTable tableName=segment; createIndex indexName=idx_segment_creator_id, tableName=segment; createIndex indexName=idx_segment_table_id, tableName=segment', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('22', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:02:33', 21, 'EXECUTED', '8:80bc8a62a90791a79adedcf1ac3c6f08', 'addColumn tableName=revision', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('23', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:02:47', 22, 'EXECUTED', '8:b6f054835db2b2688a1be1de3707f9a9', 'modifyDataType columnName=rows, tableName=metabase_table', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('24', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:02:55', 23, 'EXECUTED', '8:5e7354b3f92782d1151be0aa9d3fe625', 'createTable tableName=dependency; createIndex indexName=idx_dependency_model, tableName=dependency; createIndex indexName=idx_dependency_model_id, tableName=dependency; createIndex indexName=idx_dependency_dependent_on_model, tableName=dependency;...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('25', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:03:05', 24, 'EXECUTED', '8:cea300a621393501d4534b0ff41eb91c', 'createTable tableName=metric; createIndex indexName=idx_metric_creator_id, tableName=metric; createIndex indexName=idx_metric_table_id, tableName=metric', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('26', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:03:06', 25, 'EXECUTED', '8:ddef40b95c55cf4ac0e6a5161911a4cb', 'addColumn tableName=metabase_database; sql', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('27', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:03:25', 26, 'EXECUTED', '8:017050df833b3b678d1b52b1a0f4de50', 'createTable tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_dashboardcard_id, tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_card_id, tableName=dashboardcard_series', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('28', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:03:32', 27, 'EXECUTED', '8:428e4eb05e4e29141735adf9ae141a0b', 'addColumn tableName=core_user', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('29', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:03:43', 28, 'EXECUTED', '8:8b02731cc34add3722c926dfd7376ae0', 'addColumn tableName=pulse_channel', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('30', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:03:46', 29, 'EXECUTED', '8:2c3a50cef177cb90d47a9973cd5934e5', 'addColumn tableName=metabase_field; addNotNullConstraint columnName=visibility_type, tableName=metabase_field', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('31', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:03:48', 30, 'EXECUTED', '8:30a33a82bab0bcbb2ccb6738d48e1421', 'addColumn tableName=metabase_field', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('32', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:03:56', 31, 'EXECUTED', '8:40830260b92cedad8da273afd5eca678', 'createTable tableName=label; createIndex indexName=idx_label_slug, tableName=label; createTable tableName=card_label; addUniqueConstraint constraintName=unique_card_label_card_id_label_id, tableName=card_label; createIndex indexName=idx_card_label...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('32', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:04:15', 32, 'EXECUTED', '8:ca6efc1c0a7aa82467d2c84421e812eb', 'createTable tableName=raw_table; createIndex indexName=idx_rawtable_database_id, tableName=raw_table; addUniqueConstraint constraintName=uniq_raw_table_db_schema_name, tableName=raw_table; createTable tableName=raw_column; createIndex indexName=id...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('34', 'tlrobinson', 'migrations/000_migrations.yaml', '2020-04-09 17:04:17', 33, 'EXECUTED', '8:52b082600b05bbbc46bfe837d1f37a82', 'addColumn tableName=pulse_channel', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('35', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:04:19', 34, 'EXECUTED', '8:91b72167fca724e6b6a94b64f886cf09', 'modifyDataType columnName=value, tableName=setting', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('36', 'agilliland', 'migrations/000_migrations.yaml', '2020-04-09 17:04:38', 35, 'EXECUTED', '8:252e08892449dceb16c3d91337bd9573', 'addColumn tableName=report_dashboard; addNotNullConstraint columnName=parameters, tableName=report_dashboard; addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=parameter_mappings, tableName=report_dashboardcard', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('37', 'tlrobinson', 'migrations/000_migrations.yaml', '2020-04-09 17:04:44', 36, 'EXECUTED', '8:07d959eff81777e5690e2920583cfe5f', 'addColumn tableName=query_queryexecution; addNotNullConstraint columnName=query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_queryexecution_query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_querye...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('38', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:05:50', 37, 'EXECUTED', '8:43604ab55179b50306eb39353e760b46', 'addColumn tableName=metabase_database; addColumn tableName=metabase_table; addColumn tableName=metabase_field; addColumn tableName=report_dashboard; addColumn tableName=metric; addColumn tableName=segment; addColumn tableName=metabase_database; ad...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('39', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:05:52', 38, 'EXECUTED', '8:334adc22af5ded71ff27759b7a556951', 'addColumn tableName=core_user', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('40', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:06:18', 39, 'EXECUTED', '8:ee7f50a264d6cf8d891bd01241eebd2c', 'createTable tableName=permissions_group; createIndex indexName=idx_permissions_group_name, tableName=permissions_group; createTable tableName=permissions_group_membership; addUniqueConstraint constraintName=unique_permissions_group_membership_user...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('41', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:06:24', 40, 'EXECUTED', '8:fae0855adf2f702f1133e32fc98d02a5', 'dropColumn columnName=field_type, tableName=metabase_field; addDefaultValue columnName=active, tableName=metabase_field; addDefaultValue columnName=preview_display, tableName=metabase_field; addDefaultValue columnName=position, tableName=metabase_...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('42', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:06:53', 41, 'EXECUTED', '8:e32b3a1624fa289a6ee1f3f0a2dac1f6', 'dropForeignKeyConstraint baseTableName=query_queryexecution, constraintName=fk_queryexecution_ref_query_id; dropColumn columnName=query_id, tableName=query_queryexecution; dropColumn columnName=is_staff, tableName=core_user; dropColumn columnName=...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('43', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:06:55', 42, 'EXECUTED', '8:165e9384e46d6f9c0330784955363f70', 'createTable tableName=permissions_revision', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('44', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:07:05', 43, 'EXECUTED', '8:2e356e8a1049286f1c78324828ee7867', 'dropColumn columnName=public_perms, tableName=report_card; dropColumn columnName=public_perms, tableName=report_dashboard; dropColumn columnName=public_perms, tableName=pulse', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('45', 'tlrobinson', 'migrations/000_migrations.yaml', '2020-04-09 17:07:15', 44, 'EXECUTED', '8:421edd38ee0cb0983162f57193f81b0b', 'addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=visualization_settings, tableName=report_dashboardcard', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('46', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:07:23', 45, 'EXECUTED', '8:131df3cdd9a8c67b32c5988a3fb7fe3d', 'addNotNullConstraint columnName=row, tableName=report_dashboardcard; addNotNullConstraint columnName=col, tableName=report_dashboardcard; addDefaultValue columnName=row, tableName=report_dashboardcard; addDefaultValue columnName=col, tableName=rep...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('47', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:07:34', 46, 'EXECUTED', '8:1d2474e49a27db344c250872df58a6ed', 'createTable tableName=collection; createIndex indexName=idx_collection_slug, tableName=collection; addColumn tableName=report_card; createIndex indexName=idx_card_collection_id, tableName=report_card', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('48', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:07:41', 47, 'EXECUTED', '8:720ce9d4b9e6f0917aea035e9dc5d95d', 'createTable tableName=collection_revision', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('49', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:08:03', 48, 'EXECUTED', '8:56dcab086b21de1df002561efeac8bb6', 'addColumn tableName=report_card; createIndex indexName=idx_card_public_uuid, tableName=report_card; addColumn tableName=report_dashboard; createIndex indexName=idx_dashboard_public_uuid, tableName=report_dashboard; dropNotNullConstraint columnName...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('50', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:08:12', 49, 'EXECUTED', '8:388da4c48984aad647709514e4ba9204', 'addColumn tableName=report_card; addColumn tableName=report_dashboard', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('51', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:08:15', 50, 'EXECUTED', '8:43c90b5b9f6c14bfd0e41cc0b184617e', 'createTable tableName=query_execution; createIndex indexName=idx_query_execution_started_at, tableName=query_execution; createIndex indexName=idx_query_execution_query_hash_started_at, tableName=query_execution', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('52', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:08:22', 51, 'EXECUTED', '8:329695cb161ceb86f6d9473819359351', 'createTable tableName=query_cache; createIndex indexName=idx_query_cache_updated_at, tableName=query_cache; addColumn tableName=report_card', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('53', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:08:23', 52, 'EXECUTED', '8:78d015c5090c57cd6972eb435601d3d0', 'createTable tableName=query', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('54', 'tlrobinson', 'migrations/000_migrations.yaml', '2020-04-09 17:08:24', 53, 'EXECUTED', '8:e410005b585f5eeb5f202076ff9468f7', 'addColumn tableName=pulse', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('55', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:08:31', 54, 'EXECUTED', '8:87c4becde5fe208ba2c356128df86fba', 'addColumn tableName=report_dashboard; createTable tableName=dashboard_favorite; addUniqueConstraint constraintName=unique_dashboard_favorite_user_id_dashboard_id, tableName=dashboard_favorite; createIndex indexName=idx_dashboard_favorite_user_id, ...', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('56', 'wwwiiilll', 'migrations/000_migrations.yaml', '2020-04-09 17:08:33', 55, 'EXECUTED', '8:9f46051abaee599e2838733512a32ad0', 'addColumn tableName=core_user', 'Added 0.25.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('57', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:09:06', 56, 'EXECUTED', '8:aab81d477e2d19a9ab18c58b78c9af88', 'addColumn tableName=report_card', 'Added 0.25.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('58', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:09:52', 57, 'EXECUTED', '8:3554219ca39e0fd682d0fba57531e917', 'createTable tableName=dimension; addUniqueConstraint constraintName=unique_dimension_field_id_name, tableName=dimension; createIndex indexName=idx_dimension_field_id, tableName=dimension', 'Added 0.25.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('59', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:12:01', 58, 'EXECUTED', '8:5b6ce52371e0e9eee88e6d766225a94b', 'addColumn tableName=metabase_field', 'Added 0.26.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('60', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:12:11', 59, 'EXECUTED', '8:4f997b2cd3309882e900493892381f38', 'addColumn tableName=metabase_database', 'Added 0.26.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('61', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:13:17', 60, 'EXECUTED', '8:7dded6fd5bf74d79b9a0b62511981272', 'addColumn tableName=metabase_field', 'Added 0.26.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('62', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:13:19', 61, 'EXECUTED', '8:cb32e6eaa1a2140703def2730f81fef2', 'addColumn tableName=metabase_database', 'Added 0.26.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('63', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:13:21', 62, 'EXECUTED', '8:226f73b9f6617495892d281b0f8303db', 'addColumn tableName=metabase_database', 'Added 0.26.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('64', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:13:22', 63, 'EXECUTED', '8:4dcc8ffd836b56756f494d5dfce07b50', 'dropForeignKeyConstraint baseTableName=raw_table, constraintName=fk_rawtable_ref_database', 'Added 0.26.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('66', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:13:22', 64, 'EXECUTED', '8:e77d66af8e3b83d46c5a0064a75a1aac', 'sql; sql', 'Added 0.26.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('67', 'attekei', 'migrations/000_migrations.yaml', '2020-04-09 17:13:30', 65, 'EXECUTED', '8:59dfc37744fc362e0e312488fbc9a69b', 'createTable tableName=computation_job; createTable tableName=computation_job_result', 'Added 0.27.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('68', 'sbelak', 'migrations/000_migrations.yaml', '2020-04-09 17:13:33', 66, 'EXECUTED', '8:ca201aeb20c1719a46c6bcc3fc95c81d', 'addColumn tableName=computation_job', 'Added 0.27.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('69', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:13:39', 67, 'EXECUTED', '8:97b7768436b9e8d695bae984020d754c', 'addColumn tableName=pulse; dropNotNullConstraint columnName=name, tableName=pulse', 'Added 0.27.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('70', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:13:53', 68, 'EXECUTED', '8:4e4eff7abb983b1127a32ba8107e7fb8', 'addColumn tableName=metabase_field; addNotNullConstraint columnName=database_type, tableName=metabase_field', 'Added 0.28.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('71', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:14:11', 69, 'EXECUTED', '8:755e5c3dd8a55793f29b2c95cb79c211', 'dropNotNullConstraint columnName=card_id, tableName=report_dashboardcard', 'Added 0.28.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('72', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:14:15', 70, 'EXECUTED', '8:ed16046dfa04c139f48e9068eb4faee4', 'addColumn tableName=pulse_card', 'Added 0.28.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('73', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:14:17', 71, 'EXECUTED', '8:3c0f03d18ff78a0bcc9915e1d9c518d6', 'addColumn tableName=metabase_database', 'Added 0.29.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('74', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:14:19', 72, 'EXECUTED', '8:16726d6560851325930c25caf3c8ab96', 'addColumn tableName=metabase_field', 'Added 0.29.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('75', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:14:27', 73, 'EXECUTED', '8:6072cabfe8188872d8e3da9a675f88c1', 'addColumn tableName=report_card', 'Added 0.28.2', NULL, '3.6.3', NULL, NULL, '6431792268'),
('76', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:14:31', 74, 'EXECUTED', '8:9b7190c9171ccca72617d508875c3c82', 'addColumn tableName=metabase_table', 'Added 0.30.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('77', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:14:37', 75, 'EXECUTED', '8:07f0a6cd8dbbd9b89be0bd7378f7bdc8', 'addColumn tableName=core_user', 'Added 0.30.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('79', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:14:58', 76, 'EXECUTED', '8:3f31cb67f9cdf7754ca95cade22d87a2', 'addColumn tableName=report_dashboard; createIndex indexName=idx_dashboard_collection_id, tableName=report_dashboard; addColumn tableName=pulse; createIndex indexName=idx_pulse_collection_id, tableName=pulse', 'Added 0.30.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('80', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:15:02', 77, 'EXECUTED', '8:199d0ce28955117819ca15bcc29323e5', 'addColumn tableName=collection; createIndex indexName=idx_collection_location, tableName=collection', '', NULL, '3.6.3', NULL, NULL, '6431792268'),
('81', 'camsaul', 'migrations/000_migrations.yaml', '2020-04-09 17:15:26', 78, 'EXECUTED', '8:3a6dc22403660529194d004ca7f7ad39', 'addColumn tableName=report_dashboard; addColumn tableName=report_card; addColumn tableName=pulse', 'Added 0.30.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('82', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:15:44', 79, 'EXECUTED', '8:ac4b94df8c648f88cfff661284d6392d', 'addColumn tableName=core_user; sql', 'Added 0.30.0', NULL, '3.6.3', NULL, NULL, '6431792268'),
('84', 'senior', 'migrations/000_migrations.yaml', '2020-04-09 17:34:27', 80, 'EXECUTED', '8:58afc10c3e283a8050ea471aac447a97', 'renameColumn newColumnName=archived, oldColumnName=is_active, tableName=metric; addDefaultValue columnName=archived, tableName=metric; renameColumn newColumnName=archived, oldColumnName=is_active, tableName=segment; addDefaultValue columnName=arch...', 'Added 0.30.0', NULL, '3.6.3', NULL, NULL, '6431792268');

-- --------------------------------------------------------

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DATABASECHANGELOGLOCK`
--

INSERT INTO `DATABASECHANGELOGLOCK` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES
(1, b'1', '2020-04-09 16:59:52', '192.168.0.4 (192.168.0.4)');

-- --------------------------------------------------------

--
-- Table structure for table `data_migrations`
--

CREATE TABLE `data_migrations` (
  `id` varchar(254) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dependency`
--

CREATE TABLE `dependency` (
  `id` int(11) NOT NULL,
  `model` varchar(32) NOT NULL,
  `model_id` int(11) NOT NULL,
  `dependent_on_model` varchar(32) NOT NULL,
  `dependent_on_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dimension`
--

CREATE TABLE `dimension` (
  `id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL COMMENT 'ID of the field this dimension row applies to',
  `name` varchar(254) NOT NULL COMMENT 'Short description used as the display name of this new column',
  `type` varchar(254) NOT NULL COMMENT 'Either internal for a user defined remapping or external for a foreign key based remapping',
  `human_readable_field_id` int(11) DEFAULT NULL COMMENT 'Only used with external type remappings. Indicates which field on the FK related table to use for display',
  `created_at` datetime NOT NULL COMMENT 'The timestamp of when the dimension was created.',
  `updated_at` datetime NOT NULL COMMENT 'The timestamp of when these dimension was last updated.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores references to alternate views of existing fields, such as remapping an integer to a description, like an enum';

-- --------------------------------------------------------

--
-- Table structure for table `label`
--

CREATE TABLE `label` (
  `id` int(11) NOT NULL,
  `name` varchar(254) NOT NULL,
  `slug` varchar(254) NOT NULL,
  `icon` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `metabase_database`
--

CREATE TABLE `metabase_database` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(254) NOT NULL,
  `description` text,
  `details` text,
  `engine` varchar(254) NOT NULL,
  `is_sample` bit(1) NOT NULL DEFAULT b'0',
  `is_full_sync` bit(1) NOT NULL DEFAULT b'1',
  `points_of_interest` text,
  `caveats` text,
  `metadata_sync_schedule` varchar(254) NOT NULL DEFAULT '0 50 * * * ? *' COMMENT 'The cron schedule string for when this database should undergo the metadata sync process (and analysis for new fields).',
  `cache_field_values_schedule` varchar(254) NOT NULL DEFAULT '0 50 0 * * ? *' COMMENT 'The cron schedule string for when FieldValues for eligible Fields should be updated.',
  `timezone` varchar(254) DEFAULT NULL COMMENT 'Timezone identifier for the database, set by the sync process',
  `is_on_demand` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Whether we should do On-Demand caching of FieldValues for this DB. This means FieldValues are updated when their Field is used in a Dashboard or Card param.',
  `options` text COMMENT 'Serialized JSON containing various options like QB behavior.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `metabase_field`
--

CREATE TABLE `metabase_field` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(254) NOT NULL,
  `base_type` varchar(255) NOT NULL,
  `special_type` varchar(255) DEFAULT NULL,
  `active` bit(1) NOT NULL DEFAULT b'1',
  `description` text,
  `preview_display` bit(1) NOT NULL DEFAULT b'1',
  `position` int(11) NOT NULL DEFAULT '0',
  `table_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `display_name` varchar(254) DEFAULT NULL,
  `visibility_type` varchar(32) NOT NULL DEFAULT 'normal',
  `fk_target_field_id` int(11) DEFAULT NULL,
  `raw_column_id` int(11) DEFAULT NULL,
  `last_analyzed` datetime DEFAULT NULL,
  `points_of_interest` text,
  `caveats` text,
  `fingerprint` text COMMENT 'Serialized JSON containing non-identifying information about this Field, such as min, max, and percent JSON. Used for classification.',
  `fingerprint_version` int(11) NOT NULL DEFAULT '0' COMMENT 'The version of the fingerprint for this Field. Used so we can keep track of which Fields need to be analyzed again when new things are added to fingerprints.',
  `database_type` varchar(255) NOT NULL,
  `has_field_values` text COMMENT 'Whether we have FieldValues ("list"), should ad-hoc search ("search"), disable entirely ("none"), or infer dynamically (null)"'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `metabase_fieldvalues`
--

CREATE TABLE `metabase_fieldvalues` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `values` text,
  `human_readable_values` text,
  `field_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `metabase_table`
--

CREATE TABLE `metabase_table` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(254) NOT NULL,
  `rows` bigint(20) DEFAULT NULL,
  `description` text,
  `entity_name` varchar(254) DEFAULT NULL,
  `entity_type` varchar(254) DEFAULT NULL,
  `active` bit(1) NOT NULL,
  `db_id` int(11) NOT NULL,
  `display_name` varchar(254) DEFAULT NULL,
  `visibility_type` varchar(254) DEFAULT NULL,
  `schema` varchar(254) DEFAULT NULL,
  `raw_table_id` int(11) DEFAULT NULL,
  `points_of_interest` text,
  `caveats` text,
  `show_in_getting_started` bit(1) NOT NULL DEFAULT b'0',
  `fields_hash` text COMMENT 'Computed hash of all of the fields associated to this table'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `metric`
--

CREATE TABLE `metric` (
  `id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `name` varchar(254) NOT NULL,
  `description` text,
  `archived` bit(1) DEFAULT b'0',
  `definition` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `points_of_interest` text,
  `caveats` text,
  `how_is_this_calculated` text,
  `show_in_getting_started` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `metric_important_field`
--

CREATE TABLE `metric_important_field` (
  `id` int(11) NOT NULL,
  `metric_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `object` varchar(254) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `permissions_group`
--

CREATE TABLE `permissions_group` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `permissions_group_membership`
--

CREATE TABLE `permissions_group_membership` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `permissions_revision`
--

CREATE TABLE `permissions_revision` (
  `id` int(11) NOT NULL,
  `before` text NOT NULL COMMENT 'Serialized JSON of the permissions before the changes.',
  `after` text NOT NULL COMMENT 'Serialized JSON of the permissions after the changes.',
  `user_id` int(11) NOT NULL COMMENT 'The ID of the admin who made this set of changes.',
  `created_at` datetime NOT NULL COMMENT 'The timestamp of when these changes were made.',
  `remark` text COMMENT 'Optional remarks explaining why these changes were made.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Used to keep track of changes made to permissions.';

-- --------------------------------------------------------

--
-- Table structure for table `pulse`
--

CREATE TABLE `pulse` (
  `id` int(11) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `name` varchar(254) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `skip_if_empty` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Skip a scheduled Pulse if none of its questions have any results',
  `alert_condition` varchar(254) DEFAULT NULL COMMENT 'Condition (i.e. "rows" or "goal") used as a guard for alerts',
  `alert_first_only` bit(1) DEFAULT NULL COMMENT 'True if the alert should be disabled after the first notification',
  `alert_above_goal` bit(1) DEFAULT NULL COMMENT 'For a goal condition, alert when above the goal',
  `collection_id` int(11) DEFAULT NULL COMMENT 'Options ID of Collection this Pulse belongs to.',
  `collection_position` smallint(6) DEFAULT NULL COMMENT 'Optional pinned position for this item in its Collection. NULL means item is not pinned.',
  `archived` bit(1) DEFAULT b'0' COMMENT 'Has this pulse been archived?'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pulse_card`
--

CREATE TABLE `pulse_card` (
  `id` int(11) NOT NULL,
  `pulse_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `include_csv` bit(1) NOT NULL DEFAULT b'0' COMMENT 'True if a CSV of the data should be included for this pulse card',
  `include_xls` bit(1) NOT NULL DEFAULT b'0' COMMENT 'True if a XLS of the data should be included for this pulse card'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pulse_channel`
--

CREATE TABLE `pulse_channel` (
  `id` int(11) NOT NULL,
  `pulse_id` int(11) NOT NULL,
  `channel_type` varchar(32) NOT NULL,
  `details` text NOT NULL,
  `schedule_type` varchar(32) NOT NULL,
  `schedule_hour` int(11) DEFAULT NULL,
  `schedule_day` varchar(64) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `schedule_frame` varchar(32) DEFAULT NULL,
  `enabled` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pulse_channel_recipient`
--

CREATE TABLE `pulse_channel_recipient` (
  `id` int(11) NOT NULL,
  `pulse_channel_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `query`
--

CREATE TABLE `query` (
  `query_hash` binary(32) NOT NULL,
  `average_execution_time` int(11) NOT NULL COMMENT 'Average execution time for the query, round to nearest number of milliseconds. This is updated as a rolling average.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Information (such as average execution time) for different queries that have been previously ran.';

-- --------------------------------------------------------

--
-- Table structure for table `query_cache`
--

CREATE TABLE `query_cache` (
  `query_hash` binary(32) NOT NULL,
  `updated_at` datetime NOT NULL COMMENT 'The timestamp of when these query results were last refreshed.',
  `results` blob NOT NULL COMMENT 'Cached, compressed results of running the query with the given hash.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Cached results of queries are stored here when using the DB-based query cache.';

-- --------------------------------------------------------

--
-- Table structure for table `query_execution`
--

CREATE TABLE `query_execution` (
  `id` int(11) NOT NULL,
  `hash` binary(32) NOT NULL COMMENT 'The hash of the query dictionary. This is a 256-bit SHA3 hash of the query.',
  `started_at` datetime NOT NULL COMMENT 'Timestamp of when this query started running.',
  `running_time` int(11) NOT NULL COMMENT 'The time, in milliseconds, this query took to complete.',
  `result_rows` int(11) NOT NULL COMMENT 'Number of rows in the query results.',
  `native` bit(1) NOT NULL COMMENT 'Whether the query was a native query, as opposed to an MBQL one (e.g., created with the GUI).',
  `context` varchar(32) DEFAULT NULL COMMENT 'Short string specifying how this query was executed, e.g. in a Dashboard or Pulse.',
  `error` text COMMENT 'Error message returned by failed query, if any.',
  `executor_id` int(11) DEFAULT NULL COMMENT 'The ID of the User who triggered this query execution, if any.',
  `card_id` int(11) DEFAULT NULL COMMENT 'The ID of the Card (Question) associated with this query execution, if any.',
  `dashboard_id` int(11) DEFAULT NULL COMMENT 'The ID of the Dashboard associated with this query execution, if any.',
  `pulse_id` int(11) DEFAULT NULL COMMENT 'The ID of the Pulse associated with this query execution, if any.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='A log of executed queries, used for calculating historic execution times, auditing, and other purposes.';

-- --------------------------------------------------------

--
-- Table structure for table `query_queryexecution`
--

CREATE TABLE `query_queryexecution` (
  `id` int(11) NOT NULL,
  `uuid` varchar(254) NOT NULL,
  `version` int(11) NOT NULL,
  `json_query` text NOT NULL,
  `raw_query` text NOT NULL,
  `status` varchar(254) NOT NULL,
  `started_at` datetime NOT NULL,
  `finished_at` datetime DEFAULT NULL,
  `running_time` int(11) NOT NULL,
  `error` text NOT NULL,
  `result_file` varchar(254) NOT NULL,
  `result_rows` int(11) NOT NULL,
  `result_data` text NOT NULL,
  `additional_info` text NOT NULL,
  `executor_id` int(11) DEFAULT NULL,
  `query_hash` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `raw_column`
--

CREATE TABLE `raw_column` (
  `id` int(11) NOT NULL,
  `raw_table_id` int(11) NOT NULL,
  `active` bit(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `column_type` varchar(128) DEFAULT NULL,
  `is_pk` bit(1) NOT NULL,
  `fk_target_column_id` int(11) DEFAULT NULL,
  `details` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `raw_table`
--

CREATE TABLE `raw_table` (
  `id` int(11) NOT NULL,
  `database_id` int(11) NOT NULL,
  `active` bit(1) NOT NULL,
  `schema` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `details` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `report_card`
--

CREATE TABLE `report_card` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(254) NOT NULL,
  `description` text,
  `display` varchar(254) NOT NULL,
  `dataset_query` text NOT NULL,
  `visualization_settings` text NOT NULL,
  `creator_id` int(11) NOT NULL,
  `database_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `query_type` varchar(16) DEFAULT NULL,
  `archived` bit(1) NOT NULL DEFAULT b'0',
  `collection_id` int(11) DEFAULT NULL COMMENT 'Optional ID of Collection this Card belongs to.',
  `public_uuid` char(36) DEFAULT NULL COMMENT 'Unique UUID used to in publically-accessible links to this Card.',
  `made_public_by_id` int(11) DEFAULT NULL COMMENT 'The ID of the User who first publically shared this Card.',
  `enable_embedding` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Is this Card allowed to be embedded in different websites (using a signed JWT)?',
  `embedding_params` text COMMENT 'Serialized JSON containing information about required parameters that must be supplied when embedding this Card.',
  `cache_ttl` int(11) DEFAULT NULL COMMENT 'The maximum time, in seconds, to return cached results for this Card rather than running a new query.',
  `result_metadata` text COMMENT 'Serialized JSON containing metadata about the result columns from running the query.',
  `read_permissions` text COMMENT 'Permissions required to view this Card and run its query.',
  `collection_position` smallint(6) DEFAULT NULL COMMENT 'Optional pinned position for this item in its Collection. NULL means item is not pinned.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `report_cardfavorite`
--

CREATE TABLE `report_cardfavorite` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `card_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `report_dashboard`
--

CREATE TABLE `report_dashboard` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(254) NOT NULL,
  `description` text,
  `creator_id` int(11) NOT NULL,
  `parameters` text NOT NULL,
  `points_of_interest` text,
  `caveats` text,
  `show_in_getting_started` bit(1) NOT NULL DEFAULT b'0',
  `public_uuid` char(36) DEFAULT NULL COMMENT 'Unique UUID used to in publically-accessible links to this Dashboard.',
  `made_public_by_id` int(11) DEFAULT NULL COMMENT 'The ID of the User who first publically shared this Dashboard.',
  `enable_embedding` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Is this Dashboard allowed to be embedded in different websites (using a signed JWT)?',
  `embedding_params` text COMMENT 'Serialized JSON containing information about required parameters that must be supplied when embedding this Dashboard.',
  `archived` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Is this Dashboard archived (effectively treated as deleted?)',
  `position` int(11) DEFAULT NULL COMMENT 'The position this Dashboard should appear in the Dashboards list, lower-numbered positions appearing before higher numbered ones.',
  `collection_id` int(11) DEFAULT NULL COMMENT 'Optional ID of Collection this Dashboard belongs to.',
  `collection_position` smallint(6) DEFAULT NULL COMMENT 'Optional pinned position for this item in its Collection. NULL means item is not pinned.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `report_dashboardcard`
--

CREATE TABLE `report_dashboardcard` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `sizeX` int(11) NOT NULL,
  `sizeY` int(11) NOT NULL,
  `row` int(11) NOT NULL DEFAULT '0',
  `col` int(11) NOT NULL DEFAULT '0',
  `card_id` int(11) DEFAULT NULL,
  `dashboard_id` int(11) NOT NULL,
  `parameter_mappings` text NOT NULL,
  `visualization_settings` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `revision`
--

CREATE TABLE `revision` (
  `id` int(11) NOT NULL,
  `model` varchar(16) NOT NULL,
  `model_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `object` text NOT NULL,
  `is_reversion` bit(1) NOT NULL DEFAULT b'0',
  `is_creation` bit(1) NOT NULL DEFAULT b'0',
  `message` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `segment`
--

CREATE TABLE `segment` (
  `id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `name` varchar(254) NOT NULL,
  `description` text,
  `archived` bit(1) DEFAULT b'0',
  `definition` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `points_of_interest` text,
  `caveats` text,
  `show_in_getting_started` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `key` varchar(254) NOT NULL,
  `value` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_log`
--

CREATE TABLE `view_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `model` varchar(16) NOT NULL,
  `model_id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity`
--
ALTER TABLE `activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activity_timestamp` (`timestamp`),
  ADD KEY `idx_activity_user_id` (`user_id`),
  ADD KEY `idx_activity_custom_id` (`custom_id`);

--
-- Indexes for table `card_label`
--
ALTER TABLE `card_label`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_card_label_card_id_label_id` (`card_id`,`label_id`),
  ADD KEY `idx_card_label_card_id` (`card_id`),
  ADD KEY `idx_card_label_label_id` (`label_id`);

--
-- Indexes for table `collection`
--
ALTER TABLE `collection`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_collection_slug` (`slug`),
  ADD KEY `idx_collection_location` (`location`);

--
-- Indexes for table `collection_revision`
--
ALTER TABLE `collection_revision`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_collection_revision_user_id` (`user_id`);

--
-- Indexes for table `computation_job`
--
ALTER TABLE `computation_job`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_computation_job_ref_user_id` (`creator_id`);

--
-- Indexes for table `computation_job_result`
--
ALTER TABLE `computation_job_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_computation_result_ref_job_id` (`job_id`);

--
-- Indexes for table `core_session`
--
ALTER TABLE `core_session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_session_ref_user_id` (`user_id`);

--
-- Indexes for table `core_user`
--
ALTER TABLE `core_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `dashboardcard_series`
--
ALTER TABLE `dashboardcard_series`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dashboardcard_series_dashboardcard_id` (`dashboardcard_id`),
  ADD KEY `idx_dashboardcard_series_card_id` (`card_id`);

--
-- Indexes for table `dashboard_favorite`
--
ALTER TABLE `dashboard_favorite`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dashboard_favorite_user_id_dashboard_id` (`user_id`,`dashboard_id`),
  ADD KEY `idx_dashboard_favorite_user_id` (`user_id`),
  ADD KEY `idx_dashboard_favorite_dashboard_id` (`dashboard_id`);

--
-- Indexes for table `DATABASECHANGELOGLOCK`
--
ALTER TABLE `DATABASECHANGELOGLOCK`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `data_migrations`
--
ALTER TABLE `data_migrations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_data_migrations_id` (`id`);

--
-- Indexes for table `dependency`
--
ALTER TABLE `dependency`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dependency_model` (`model`),
  ADD KEY `idx_dependency_model_id` (`model_id`),
  ADD KEY `idx_dependency_dependent_on_model` (`dependent_on_model`),
  ADD KEY `idx_dependency_dependent_on_id` (`dependent_on_id`);

--
-- Indexes for table `dimension`
--
ALTER TABLE `dimension`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dimension_field_id_name` (`field_id`,`name`),
  ADD KEY `fk_dimension_displayfk_ref_field_id` (`human_readable_field_id`),
  ADD KEY `idx_dimension_field_id` (`field_id`);

--
-- Indexes for table `label`
--
ALTER TABLE `label`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_label_slug` (`slug`);

--
-- Indexes for table `metabase_database`
--
ALTER TABLE `metabase_database`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `metabase_field`
--
ALTER TABLE `metabase_field`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_field_table_id` (`table_id`),
  ADD KEY `fk_field_parent_ref_field_id` (`parent_id`);

--
-- Indexes for table `metabase_fieldvalues`
--
ALTER TABLE `metabase_fieldvalues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fieldvalues_field_id` (`field_id`);

--
-- Indexes for table `metabase_table`
--
ALTER TABLE `metabase_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_table_db_id` (`db_id`),
  ADD KEY `idx_metabase_table_show_in_getting_started` (`show_in_getting_started`),
  ADD KEY `idx_metabase_table_db_id_schema` (`db_id`,`schema`);

--
-- Indexes for table `metric`
--
ALTER TABLE `metric`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_metric_creator_id` (`creator_id`),
  ADD KEY `idx_metric_table_id` (`table_id`),
  ADD KEY `idx_metric_show_in_getting_started` (`show_in_getting_started`);

--
-- Indexes for table `metric_important_field`
--
ALTER TABLE `metric_important_field`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_metric_important_field_metric_id_field_id` (`metric_id`,`field_id`),
  ADD KEY `idx_metric_important_field_metric_id` (`metric_id`),
  ADD KEY `idx_metric_important_field_field_id` (`field_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_id` (`group_id`,`object`),
  ADD KEY `idx_permissions_group_id` (`group_id`),
  ADD KEY `idx_permissions_object` (`object`),
  ADD KEY `idx_permissions_group_id_object` (`group_id`,`object`);

--
-- Indexes for table `permissions_group`
--
ALTER TABLE `permissions_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_permissions_group_name` (`name`),
  ADD KEY `idx_permissions_group_name` (`name`);

--
-- Indexes for table `permissions_group_membership`
--
ALTER TABLE `permissions_group_membership`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_permissions_group_membership_user_id_group_id` (`user_id`,`group_id`),
  ADD KEY `idx_permissions_group_membership_group_id` (`group_id`),
  ADD KEY `idx_permissions_group_membership_user_id` (`user_id`),
  ADD KEY `idx_permissions_group_membership_group_id_user_id` (`group_id`,`user_id`);

--
-- Indexes for table `permissions_revision`
--
ALTER TABLE `permissions_revision`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_permissions_revision_user_id` (`user_id`);

--
-- Indexes for table `pulse`
--
ALTER TABLE `pulse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pulse_creator_id` (`creator_id`),
  ADD KEY `idx_pulse_collection_id` (`collection_id`);

--
-- Indexes for table `pulse_card`
--
ALTER TABLE `pulse_card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pulse_card_pulse_id` (`pulse_id`),
  ADD KEY `idx_pulse_card_card_id` (`card_id`);

--
-- Indexes for table `pulse_channel`
--
ALTER TABLE `pulse_channel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pulse_channel_pulse_id` (`pulse_id`),
  ADD KEY `idx_pulse_channel_schedule_type` (`schedule_type`);

--
-- Indexes for table `pulse_channel_recipient`
--
ALTER TABLE `pulse_channel_recipient`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pulse_channel_recipient_ref_user_id` (`user_id`),
  ADD KEY `fk_pulse_channel_recipient_ref_pulse_channel_id` (`pulse_channel_id`);

--
-- Indexes for table `query`
--
ALTER TABLE `query`
  ADD PRIMARY KEY (`query_hash`);

--
-- Indexes for table `query_cache`
--
ALTER TABLE `query_cache`
  ADD PRIMARY KEY (`query_hash`),
  ADD KEY `idx_query_cache_updated_at` (`updated_at`);

--
-- Indexes for table `query_execution`
--
ALTER TABLE `query_execution`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_query_execution_started_at` (`started_at`),
  ADD KEY `idx_query_execution_query_hash_started_at` (`hash`,`started_at`);

--
-- Indexes for table `query_queryexecution`
--
ALTER TABLE `query_queryexecution`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `idx_queryexecution_executor_id` (`executor_id`),
  ADD KEY `idx_query_queryexecution_query_hash` (`query_hash`),
  ADD KEY `idx_query_queryexecution_started_at` (`started_at`);

--
-- Indexes for table `raw_column`
--
ALTER TABLE `raw_column`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_raw_column_table_name` (`raw_table_id`,`name`),
  ADD KEY `fk_rawcolumn_fktarget_ref_rawcolumn` (`fk_target_column_id`),
  ADD KEY `idx_rawcolumn_raw_table_id` (`raw_table_id`);

--
-- Indexes for table `raw_table`
--
ALTER TABLE `raw_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_raw_table_db_schema_name` (`database_id`,`schema`,`name`),
  ADD KEY `idx_rawtable_database_id` (`database_id`);

--
-- Indexes for table `report_card`
--
ALTER TABLE `report_card`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `public_uuid` (`public_uuid`),
  ADD KEY `idx_card_creator_id` (`creator_id`),
  ADD KEY `fk_report_card_ref_database_id` (`database_id`),
  ADD KEY `fk_report_card_ref_table_id` (`table_id`),
  ADD KEY `idx_card_collection_id` (`collection_id`),
  ADD KEY `fk_card_made_public_by_id` (`made_public_by_id`),
  ADD KEY `idx_card_public_uuid` (`public_uuid`);

--
-- Indexes for table `report_cardfavorite`
--
ALTER TABLE `report_cardfavorite`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_unique_cardfavorite_card_id_owner_id` (`card_id`,`owner_id`),
  ADD KEY `idx_cardfavorite_card_id` (`card_id`),
  ADD KEY `idx_cardfavorite_owner_id` (`owner_id`);

--
-- Indexes for table `report_dashboard`
--
ALTER TABLE `report_dashboard`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `public_uuid` (`public_uuid`),
  ADD KEY `idx_dashboard_creator_id` (`creator_id`),
  ADD KEY `idx_report_dashboard_show_in_getting_started` (`show_in_getting_started`),
  ADD KEY `fk_dashboard_made_public_by_id` (`made_public_by_id`),
  ADD KEY `idx_dashboard_public_uuid` (`public_uuid`),
  ADD KEY `idx_dashboard_collection_id` (`collection_id`);

--
-- Indexes for table `report_dashboardcard`
--
ALTER TABLE `report_dashboardcard`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dashboardcard_card_id` (`card_id`),
  ADD KEY `idx_dashboardcard_dashboard_id` (`dashboard_id`);

--
-- Indexes for table `revision`
--
ALTER TABLE `revision`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_revision_ref_user_id` (`user_id`),
  ADD KEY `idx_revision_model_model_id` (`model`,`model_id`);

--
-- Indexes for table `segment`
--
ALTER TABLE `segment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_segment_creator_id` (`creator_id`),
  ADD KEY `idx_segment_table_id` (`table_id`),
  ADD KEY `idx_segment_show_in_getting_started` (`show_in_getting_started`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `view_log`
--
ALTER TABLE `view_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_view_log_user_id` (`user_id`),
  ADD KEY `idx_view_log_timestamp` (`model_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity`
--
ALTER TABLE `activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `card_label`
--
ALTER TABLE `card_label`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `collection`
--
ALTER TABLE `collection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `collection_revision`
--
ALTER TABLE `collection_revision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `computation_job`
--
ALTER TABLE `computation_job`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `computation_job_result`
--
ALTER TABLE `computation_job_result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `core_user`
--
ALTER TABLE `core_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dashboardcard_series`
--
ALTER TABLE `dashboardcard_series`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dashboard_favorite`
--
ALTER TABLE `dashboard_favorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dependency`
--
ALTER TABLE `dependency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dimension`
--
ALTER TABLE `dimension`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `label`
--
ALTER TABLE `label`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `metabase_database`
--
ALTER TABLE `metabase_database`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `metabase_field`
--
ALTER TABLE `metabase_field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `metabase_fieldvalues`
--
ALTER TABLE `metabase_fieldvalues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `metabase_table`
--
ALTER TABLE `metabase_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `metric`
--
ALTER TABLE `metric`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `metric_important_field`
--
ALTER TABLE `metric_important_field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `permissions_group`
--
ALTER TABLE `permissions_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `permissions_group_membership`
--
ALTER TABLE `permissions_group_membership`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `permissions_revision`
--
ALTER TABLE `permissions_revision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pulse`
--
ALTER TABLE `pulse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pulse_card`
--
ALTER TABLE `pulse_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pulse_channel`
--
ALTER TABLE `pulse_channel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pulse_channel_recipient`
--
ALTER TABLE `pulse_channel_recipient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `query_execution`
--
ALTER TABLE `query_execution`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `query_queryexecution`
--
ALTER TABLE `query_queryexecution`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `raw_column`
--
ALTER TABLE `raw_column`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `raw_table`
--
ALTER TABLE `raw_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `report_card`
--
ALTER TABLE `report_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `report_cardfavorite`
--
ALTER TABLE `report_cardfavorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `report_dashboard`
--
ALTER TABLE `report_dashboard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `report_dashboardcard`
--
ALTER TABLE `report_dashboardcard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `revision`
--
ALTER TABLE `revision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `segment`
--
ALTER TABLE `segment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `view_log`
--
ALTER TABLE `view_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity`
--
ALTER TABLE `activity`
  ADD CONSTRAINT `fk_activity_ref_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `card_label`
--
ALTER TABLE `card_label`
  ADD CONSTRAINT `fk_card_label_ref_card_id` FOREIGN KEY (`card_id`) REFERENCES `report_card` (`id`),
  ADD CONSTRAINT `fk_card_label_ref_label_id` FOREIGN KEY (`label_id`) REFERENCES `label` (`id`);

--
-- Constraints for table `collection_revision`
--
ALTER TABLE `collection_revision`
  ADD CONSTRAINT `fk_collection_revision_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `computation_job`
--
ALTER TABLE `computation_job`
  ADD CONSTRAINT `fk_computation_job_ref_user_id` FOREIGN KEY (`creator_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `computation_job_result`
--
ALTER TABLE `computation_job_result`
  ADD CONSTRAINT `fk_computation_result_ref_job_id` FOREIGN KEY (`job_id`) REFERENCES `computation_job` (`id`);

--
-- Constraints for table `core_session`
--
ALTER TABLE `core_session`
  ADD CONSTRAINT `fk_session_ref_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `dashboardcard_series`
--
ALTER TABLE `dashboardcard_series`
  ADD CONSTRAINT `fk_dashboardcard_series_ref_card_id` FOREIGN KEY (`card_id`) REFERENCES `report_card` (`id`),
  ADD CONSTRAINT `fk_dashboardcard_series_ref_dashboardcard_id` FOREIGN KEY (`dashboardcard_id`) REFERENCES `report_dashboardcard` (`id`);

--
-- Constraints for table `dashboard_favorite`
--
ALTER TABLE `dashboard_favorite`
  ADD CONSTRAINT `fk_dashboard_favorite_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `report_dashboard` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dashboard_favorite_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dimension`
--
ALTER TABLE `dimension`
  ADD CONSTRAINT `fk_dimension_displayfk_ref_field_id` FOREIGN KEY (`human_readable_field_id`) REFERENCES `metabase_field` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dimension_ref_field_id` FOREIGN KEY (`field_id`) REFERENCES `metabase_field` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `metabase_field`
--
ALTER TABLE `metabase_field`
  ADD CONSTRAINT `fk_field_parent_ref_field_id` FOREIGN KEY (`parent_id`) REFERENCES `metabase_field` (`id`),
  ADD CONSTRAINT `fk_field_ref_table_id` FOREIGN KEY (`table_id`) REFERENCES `metabase_table` (`id`);

--
-- Constraints for table `metabase_fieldvalues`
--
ALTER TABLE `metabase_fieldvalues`
  ADD CONSTRAINT `fk_fieldvalues_ref_field_id` FOREIGN KEY (`field_id`) REFERENCES `metabase_field` (`id`);

--
-- Constraints for table `metabase_table`
--
ALTER TABLE `metabase_table`
  ADD CONSTRAINT `fk_table_ref_database_id` FOREIGN KEY (`db_id`) REFERENCES `metabase_database` (`id`);

--
-- Constraints for table `metric`
--
ALTER TABLE `metric`
  ADD CONSTRAINT `fk_metric_ref_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `core_user` (`id`),
  ADD CONSTRAINT `fk_metric_ref_table_id` FOREIGN KEY (`table_id`) REFERENCES `metabase_table` (`id`);

--
-- Constraints for table `metric_important_field`
--
ALTER TABLE `metric_important_field`
  ADD CONSTRAINT `fk_metric_important_field_metabase_field_id` FOREIGN KEY (`field_id`) REFERENCES `metabase_field` (`id`),
  ADD CONSTRAINT `fk_metric_important_field_metric_id` FOREIGN KEY (`metric_id`) REFERENCES `metric` (`id`);

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `fk_permissions_group_id` FOREIGN KEY (`group_id`) REFERENCES `permissions_group` (`id`);

--
-- Constraints for table `permissions_group_membership`
--
ALTER TABLE `permissions_group_membership`
  ADD CONSTRAINT `fk_permissions_group_group_id` FOREIGN KEY (`group_id`) REFERENCES `permissions_group` (`id`),
  ADD CONSTRAINT `fk_permissions_group_membership_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `permissions_revision`
--
ALTER TABLE `permissions_revision`
  ADD CONSTRAINT `fk_permissions_revision_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `pulse`
--
ALTER TABLE `pulse`
  ADD CONSTRAINT `fk_pulse_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `collection` (`id`),
  ADD CONSTRAINT `fk_pulse_ref_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `pulse_card`
--
ALTER TABLE `pulse_card`
  ADD CONSTRAINT `fk_pulse_card_ref_card_id` FOREIGN KEY (`card_id`) REFERENCES `report_card` (`id`),
  ADD CONSTRAINT `fk_pulse_card_ref_pulse_id` FOREIGN KEY (`pulse_id`) REFERENCES `pulse` (`id`);

--
-- Constraints for table `pulse_channel`
--
ALTER TABLE `pulse_channel`
  ADD CONSTRAINT `fk_pulse_channel_ref_pulse_id` FOREIGN KEY (`pulse_id`) REFERENCES `pulse` (`id`);

--
-- Constraints for table `pulse_channel_recipient`
--
ALTER TABLE `pulse_channel_recipient`
  ADD CONSTRAINT `fk_pulse_channel_recipient_ref_pulse_channel_id` FOREIGN KEY (`pulse_channel_id`) REFERENCES `pulse_channel` (`id`),
  ADD CONSTRAINT `fk_pulse_channel_recipient_ref_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `query_queryexecution`
--
ALTER TABLE `query_queryexecution`
  ADD CONSTRAINT `fk_queryexecution_ref_user_id` FOREIGN KEY (`executor_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `raw_column`
--
ALTER TABLE `raw_column`
  ADD CONSTRAINT `fk_rawcolumn_fktarget_ref_rawcolumn` FOREIGN KEY (`fk_target_column_id`) REFERENCES `raw_column` (`id`),
  ADD CONSTRAINT `fk_rawcolumn_tableid_ref_rawtable` FOREIGN KEY (`raw_table_id`) REFERENCES `raw_table` (`id`);

--
-- Constraints for table `report_card`
--
ALTER TABLE `report_card`
  ADD CONSTRAINT `fk_card_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `collection` (`id`),
  ADD CONSTRAINT `fk_card_made_public_by_id` FOREIGN KEY (`made_public_by_id`) REFERENCES `core_user` (`id`),
  ADD CONSTRAINT `fk_card_ref_user_id` FOREIGN KEY (`creator_id`) REFERENCES `core_user` (`id`),
  ADD CONSTRAINT `fk_report_card_ref_database_id` FOREIGN KEY (`database_id`) REFERENCES `metabase_database` (`id`),
  ADD CONSTRAINT `fk_report_card_ref_table_id` FOREIGN KEY (`table_id`) REFERENCES `metabase_table` (`id`);

--
-- Constraints for table `report_cardfavorite`
--
ALTER TABLE `report_cardfavorite`
  ADD CONSTRAINT `fk_cardfavorite_ref_card_id` FOREIGN KEY (`card_id`) REFERENCES `report_card` (`id`),
  ADD CONSTRAINT `fk_cardfavorite_ref_user_id` FOREIGN KEY (`owner_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `report_dashboard`
--
ALTER TABLE `report_dashboard`
  ADD CONSTRAINT `fk_dashboard_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `collection` (`id`),
  ADD CONSTRAINT `fk_dashboard_made_public_by_id` FOREIGN KEY (`made_public_by_id`) REFERENCES `core_user` (`id`),
  ADD CONSTRAINT `fk_dashboard_ref_user_id` FOREIGN KEY (`creator_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `report_dashboardcard`
--
ALTER TABLE `report_dashboardcard`
  ADD CONSTRAINT `fk_dashboardcard_ref_card_id` FOREIGN KEY (`card_id`) REFERENCES `report_card` (`id`),
  ADD CONSTRAINT `fk_dashboardcard_ref_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `report_dashboard` (`id`);

--
-- Constraints for table `revision`
--
ALTER TABLE `revision`
  ADD CONSTRAINT `fk_revision_ref_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`);

--
-- Constraints for table `segment`
--
ALTER TABLE `segment`
  ADD CONSTRAINT `fk_segment_ref_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `core_user` (`id`),
  ADD CONSTRAINT `fk_segment_ref_table_id` FOREIGN KEY (`table_id`) REFERENCES `metabase_table` (`id`);

--
-- Constraints for table `view_log`
--
ALTER TABLE `view_log`
  ADD CONSTRAINT `fk_view_log_ref_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
