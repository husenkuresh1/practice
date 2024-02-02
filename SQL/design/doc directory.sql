-- Define ENUM types

CREATE TYPE IF NOT EXISTSpermission_type_enum AS ENUM (
  'general_permission',
  'collection_permission',
  'task_permission'
);

CREATE TYPE IF NOT EXISTS collection_visibility_enum AS ENUM (
  'all',
  'private',
  'admin'
);

-- for maintain Administrator of database

CREATE TABLE IF NOT EXIST admins (
  admin_id SERIAL PRIMARY KEY,
  admin_name varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE IF NOT EXISTS admin_id_seq;

-- for maintain all users of system(either team admin or team member) 

CREATE TABLE IF NOT EXIST users (
  user_id SERIAL PRIMARY KEY,
  username varchar NOT NULL,
  user_email varchar unique,
  user_password varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
)
CREATE SEQUENCE IF NOT EXISTS user_id_seq;
CREATE INDEX IF NOT EXISTS username_index ON users (username);

-- maintain all the permission list of systems 

CREATE TABLE IF NOT EXIST permissions (
  permission_id SERIAL PRIMARY KEY,
  permission_name varchar NOT NULL,
  permission_type permission_type_enum,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE permission_id_seq;

-- list of all the team with it's admin

CREATE TABLE IF NOT EXIST teams (
  team_id SERIAL PRIMARY KEY,
  team_name varchar NOT NULL,
  team_admin integer,
  is_deleted boolean DEFAULT false,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (team_admin) REFERENCES users(user_id)
);
CREATE SEQUENCE team_id_seq;
CREATE INDEX IF NOT EXISTS team_name_index ON teams (team_name);

-- list of collection

CREATE TABLE IF NOT EXIST collections (
  collection_id SERIAL PRIMARY KEY,
  collection_name varchar NOT NULL,
  teams_team_id integer,
  users_user_id integer,
  collection_visibility collection_visibility_enum,
  created_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE collection_id_seq;
CREATE INDEX IF NOT EXISTS collection_name_index ON collections (collection_name);

-- all the files created by team and it's collection

CREATE TABLE IF NOT EXIST files (
  file_id SERIAL PRIMARY KEY,
  file_name varchar NOT NULL,
  file_url varchar NOT NULL,
  collections_collection_id integer,
  users_user_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (collections_collection_id) REFERENCES collections(collection_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE file_id_seq;
CREATE INDEX IF NOT EXISTS file_name_index ON files (file_name);

-- records of request of permission by user

CREATE TABLE IF NOT EXIST request_permission (
  request_id SERIAL PRIMARY KEY,
  users_user_id integer,
  permissions_permission_id integer,
  request_description text,
  is_approved boolean DEFAULT false,
  approved_by_admin_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id),
  FOREIGN key (approved_by_admin_id) REFERENCES admins(admin_id);
);
CREATE SEQUENCE request_id_seq;

-- permission provide to all the team members

CREATE TABLE IF NOT EXIST team_permmisions (
  permissions_permission_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- extra permission provide to team admin

CREATE TABLE IF NOT EXIST team_admin_permissions (
  teams_team_id integer,
  permissions_permission_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- team and their members mapping

CREATE TABLE IF NOT EXIST users_teams (
  users_user_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id)
);

-- Define ENUM types

CREATE TYPE IF NOT EXISTSpermission_type_enum AS ENUM (
  'general_permission',
  'collection_permission',
  'task_permission'
);

CREATE TYPE IF NOT EXISTS collection_visibility_enum AS ENUM (
  'all',
  'private',
  'admin'
);

-- for maintain Administrator of database

CREATE TABLE IF NOT EXIST admins (
  admin_id SERIAL PRIMARY KEY,
  admin_name varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE IF NOT EXISTS admin_id_seq;

-- for maintain all users of system(either team admin or team member) 

CREATE TABLE IF NOT EXIST users (
  user_id SERIAL PRIMARY KEY,
  username varchar NOT NULL,
  user_email varchar unique,
  user_password varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
)
CREATE SEQUENCE IF NOT EXISTS user_id_seq;
CREATE INDEX IF NOT EXISTS username_index ON users (username);

-- maintain all the permission list of systems 

CREATE TABLE IF NOT EXIST permissions (
  permission_id SERIAL PRIMARY KEY,
  permission_name varchar NOT NULL,
  permission_type permission_type_enum,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE permission_id_seq;

-- list of all the team with it's admin

CREATE TABLE IF NOT EXIST teams (
  team_id SERIAL PRIMARY KEY,
  team_name varchar NOT NULL,
  team_admin integer,
  is_deleted boolean DEFAULT false,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (team_admin) REFERENCES users(user_id)
);
CREATE SEQUENCE team_id_seq;
CREATE INDEX IF NOT EXISTS team_name_index ON teams (team_name);

-- list of collection

CREATE TABLE IF NOT EXIST collections (
  collection_id SERIAL PRIMARY KEY,
  collection_name varchar NOT NULL,
  teams_team_id integer,
  users_user_id integer,
  collection_visibility collection_visibility_enum,
  created_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE collection_id_seq;
CREATE INDEX IF NOT EXISTS collection_name_index ON collections (collection_name);

-- all the files created by team and it's collection

CREATE TABLE IF NOT EXIST files (
  file_id SERIAL PRIMARY KEY,
  file_name varchar NOT NULL,
  file_url varchar NOT NULL,
  collections_collection_id integer,
  users_user_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (collections_collection_id) REFERENCES collections(collection_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE file_id_seq;
CREATE INDEX IF NOT EXISTS file_name_index ON files (file_name);

-- records of request of permission by user

CREATE TABLE IF NOT EXIST request_permission (
  request_id SERIAL PRIMARY KEY,
  users_user_id integer,
  permissions_permission_id integer,
  request_description text,
  is_approved boolean DEFAULT false,
  approved_by_admin_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id),
  FOREIGN key (approved_by_admin_id) REFERENCES admins(admin_id);
);
CREATE SEQUENCE request_id_seq;

-- permission provide to all the team members

CREATE TABLE IF NOT EXIST team_permmisions (
  permissions_permission_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- extra permission provide to team admin

CREATE TABLE IF NOT EXIST team_admin_permissions (
  teams_team_id integer,
  permissions_permission_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- team and their members mapping

CREATE TABLE IF NOT EXIST users_teams (
  users_user_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id)
);

-- Define ENUM types

CREATE TYPE IF NOT EXISTSpermission_type_enum AS ENUM (
  'general_permission',
  'collection_permission',
  'task_permission'
);

CREATE TYPE IF NOT EXISTS collection_visibility_enum AS ENUM (
  'all',
  'private',
  'admin'
);

-- for maintain Administrator of database

CREATE TABLE IF NOT EXIST admins (
  admin_id SERIAL PRIMARY KEY,
  admin_name varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE IF NOT EXISTS admin_id_seq;

-- for maintain all users of system(either team admin or team member) 

CREATE TABLE IF NOT EXIST users (
  user_id SERIAL PRIMARY KEY,
  username varchar NOT NULL,
  user_email varchar unique,
  user_password varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
)
CREATE SEQUENCE IF NOT EXISTS user_id_seq;
CREATE INDEX IF NOT EXISTS username_index ON users (username);

-- maintain all the permission list of systems 

CREATE TABLE IF NOT EXIST permissions (
  permission_id SERIAL PRIMARY KEY,
  permission_name varchar NOT NULL,
  permission_type permission_type_enum,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE permission_id_seq;

-- list of all the team with it's admin

CREATE TABLE IF NOT EXIST teams (
  team_id SERIAL PRIMARY KEY,
  team_name varchar NOT NULL,
  team_admin integer,
  is_deleted boolean DEFAULT false,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (team_admin) REFERENCES users(user_id)
);
CREATE SEQUENCE team_id_seq;
CREATE INDEX IF NOT EXISTS team_name_index ON teams (team_name);

-- list of collection

CREATE TABLE IF NOT EXIST collections (
  collection_id SERIAL PRIMARY KEY,
  collection_name varchar NOT NULL,
  teams_team_id integer,
  users_user_id integer,
  collection_visibility collection_visibility_enum,
  created_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE collection_id_seq;
CREATE INDEX IF NOT EXISTS collection_name_index ON collections (collection_name);

-- all the files created by team and it's collection

CREATE TABLE IF NOT EXIST files (
  file_id SERIAL PRIMARY KEY,
  file_name varchar NOT NULL,
  file_url varchar NOT NULL,
  collections_collection_id integer,
  users_user_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (collections_collection_id) REFERENCES collections(collection_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE file_id_seq;
CREATE INDEX IF NOT EXISTS file_name_index ON files (file_name);

-- records of request of permission by user

CREATE TABLE IF NOT EXIST request_permission (
  request_id SERIAL PRIMARY KEY,
  users_user_id integer,
  permissions_permission_id integer,
  request_description text,
  is_approved boolean DEFAULT false,
  approved_by_admin_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id),
  FOREIGN key (approved_by_admin_id) REFERENCES admins(admin_id);
);
CREATE SEQUENCE request_id_seq;

-- permission provide to all the team members

CREATE TABLE IF NOT EXIST team_permmisions (
  permissions_permission_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- extra permission provide to team admin

CREATE TABLE IF NOT EXIST team_admin_permissions (
  teams_team_id integer,
  permissions_permission_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- team and their members mapping

CREATE TABLE IF NOT EXIST users_teams (
  users_user_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id)
);

-- Define ENUM types

CREATE TYPE IF NOT EXISTSpermission_type_enum AS ENUM (
  'general_permission',
  'collection_permission',
  'task_permission'
);

CREATE TYPE IF NOT EXISTS collection_visibility_enum AS ENUM (
  'all',
  'private',
  'admin'
);

-- for maintain Administrator of database

CREATE TABLE IF NOT EXIST admins (
  admin_id SERIAL PRIMARY KEY,
  admin_name varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE IF NOT EXISTS admin_id_seq;

-- for maintain all users of system(either team admin or team member) 

CREATE TABLE IF NOT EXIST users (
  user_id SERIAL PRIMARY KEY,
  username varchar NOT NULL,
  user_email varchar unique,
  user_password varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
)
CREATE SEQUENCE IF NOT EXISTS user_id_seq;
CREATE INDEX IF NOT EXISTS username_index ON users (username);

-- maintain all the permission list of systems 

CREATE TABLE IF NOT EXIST permissions (
  permission_id SERIAL PRIMARY KEY,
  permission_name varchar NOT NULL,
  permission_type permission_type_enum,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE permission_id_seq;

-- list of all the team with it's admin

CREATE TABLE IF NOT EXIST teams (
  team_id SERIAL PRIMARY KEY,
  team_name varchar NOT NULL,
  team_admin integer,
  is_deleted boolean DEFAULT false,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (team_admin) REFERENCES users(user_id)
);
CREATE SEQUENCE team_id_seq;
CREATE INDEX IF NOT EXISTS team_name_index ON teams (team_name);

-- list of collection

CREATE TABLE IF NOT EXIST collections (
  collection_id SERIAL PRIMARY KEY,
  collection_name varchar NOT NULL,
  teams_team_id integer,
  users_user_id integer,
  collection_visibility collection_visibility_enum,
  created_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE collection_id_seq;
CREATE INDEX IF NOT EXISTS collection_name_index ON collections (collection_name);

-- all the files created by team and it's collection

CREATE TABLE IF NOT EXIST files (
  file_id SERIAL PRIMARY KEY,
  file_name varchar NOT NULL,
  file_url varchar NOT NULL,
  collections_collection_id integer,
  users_user_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (collections_collection_id) REFERENCES collections(collection_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE file_id_seq;
CREATE INDEX IF NOT EXISTS file_name_index ON files (file_name);

-- records of request of permission by user

CREATE TABLE IF NOT EXIST request_permission (
  request_id SERIAL PRIMARY KEY,
  users_user_id integer,
  permissions_permission_id integer,
  request_description text,
  is_approved boolean DEFAULT false,
  approved_by_admin_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id),
  FOREIGN key (approved_by_admin_id) REFERENCES admins(admin_id);
);
CREATE SEQUENCE request_id_seq;

-- permission provide to all the team members

CREATE TABLE IF NOT EXIST team_permmisions (
  permissions_permission_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- extra permission provide to team admin

CREATE TABLE IF NOT EXIST team_admin_permissions (
  teams_team_id integer,
  permissions_permission_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- team and their members mapping

CREATE TABLE IF NOT EXIST users_teams (
  users_user_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id)
);

-- Define ENUM types

CREATE TYPE IF NOT EXISTSpermission_type_enum AS ENUM (
  'general_permission',
  'collection_permission',
  'task_permission'
);

CREATE TYPE IF NOT EXISTS collection_visibility_enum AS ENUM (
  'all',
  'private',
  'admin'
);

-- for maintain Administrator of database

CREATE TABLE IF NOT EXIST admins (
  admin_id SERIAL PRIMARY KEY,
  admin_name varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE IF NOT EXISTS admin_id_seq;

-- for maintain all users of system(either team admin or team member) 

CREATE TABLE IF NOT EXIST users (
  user_id SERIAL PRIMARY KEY,
  username varchar NOT NULL,
  user_email varchar unique,
  user_password varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
)
CREATE SEQUENCE IF NOT EXISTS user_id_seq;
CREATE INDEX IF NOT EXISTS username_index ON users (username);

-- maintain all the permission list of systems 

CREATE TABLE IF NOT EXIST permissions (
  permission_id SERIAL PRIMARY KEY,
  permission_name varchar NOT NULL,
  permission_type permission_type_enum,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE permission_id_seq;

-- list of all the team with it's admin

CREATE TABLE IF NOT EXIST teams (
  team_id SERIAL PRIMARY KEY,
  team_name varchar NOT NULL,
  team_admin integer,
  is_deleted boolean DEFAULT false,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (team_admin) REFERENCES users(user_id)
);
CREATE SEQUENCE team_id_seq;
CREATE INDEX IF NOT EXISTS team_name_index ON teams (team_name);

-- list of collection

CREATE TABLE IF NOT EXIST collections (
  collection_id SERIAL PRIMARY KEY,
  collection_name varchar NOT NULL,
  teams_team_id integer,
  users_user_id integer,
  collection_visibility collection_visibility_enum,
  created_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE collection_id_seq;
CREATE INDEX IF NOT EXISTS collection_name_index ON collections (collection_name);

-- all the files created by team and it's collection

CREATE TABLE IF NOT EXIST files (
  file_id SERIAL PRIMARY KEY,
  file_name varchar NOT NULL,
  file_url varchar NOT NULL,
  collections_collection_id integer,
  users_user_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (collections_collection_id) REFERENCES collections(collection_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE file_id_seq;
CREATE INDEX IF NOT EXISTS file_name_index ON files (file_name);

-- records of request of permission by user

CREATE TABLE IF NOT EXIST request_permission (
  request_id SERIAL PRIMARY KEY,
  users_user_id integer,
  permissions_permission_id integer,
  request_description text,
  is_approved boolean DEFAULT false,
  approved_by_admin_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id),
  FOREIGN key (approved_by_admin_id) REFERENCES admins(admin_id);
);
CREATE SEQUENCE request_id_seq;

-- permission provide to all the team members

CREATE TABLE IF NOT EXIST team_permmisions (
  permissions_permission_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- extra permission provide to team admin

CREATE TABLE IF NOT EXIST team_admin_permissions (
  teams_team_id integer,
  permissions_permission_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- team and their members mapping

CREATE TABLE IF NOT EXIST users_teams (
  users_user_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id)
);

-- Define ENUM types

CREATE TYPE IF NOT EXISTSpermission_type_enum AS ENUM (
  'general_permission',
  'collection_permission',
  'task_permission'
);

CREATE TYPE IF NOT EXISTS collection_visibility_enum AS ENUM (
  'all',
  'private',
  'admin'
);

-- for maintain Administrator of database

CREATE TABLE IF NOT EXIST admins (
  admin_id SERIAL PRIMARY KEY,
  admin_name varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE IF NOT EXISTS admin_id_seq;

-- for maintain all users of system(either team admin or team member) 

CREATE TABLE IF NOT EXIST users (
  user_id SERIAL PRIMARY KEY,
  username varchar NOT NULL,
  user_email varchar unique,
  user_password varchar NOT NULL,
  created_at timestamp,
  updated_at timestamp
)
CREATE SEQUENCE IF NOT EXISTS user_id_seq;
CREATE INDEX IF NOT EXISTS username_index ON users (username);

-- maintain all the permission list of systems 

CREATE TABLE IF NOT EXIST permissions (
  permission_id SERIAL PRIMARY KEY,
  permission_name varchar NOT NULL,
  permission_type permission_type_enum,
  created_at timestamp,
  updated_at timestamp
);
CREATE SEQUENCE permission_id_seq;

-- list of all the team with it's admin

CREATE TABLE IF NOT EXIST teams (
  team_id SERIAL PRIMARY KEY,
  team_name varchar NOT NULL,
  team_admin integer,
  is_deleted boolean DEFAULT false,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (team_admin) REFERENCES users(user_id)
);
CREATE SEQUENCE team_id_seq;
CREATE INDEX IF NOT EXISTS team_name_index ON teams (team_name);

-- list of collection

CREATE TABLE IF NOT EXIST collections (
  collection_id SERIAL PRIMARY KEY,
  collection_name varchar NOT NULL,
  teams_team_id integer,
  users_user_id integer,
  collection_visibility collection_visibility_enum,
  created_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE collection_id_seq;
CREATE INDEX IF NOT EXISTS collection_name_index ON collections (collection_name);

-- all the files created by team and it's collection

CREATE TABLE IF NOT EXIST files (
  file_id SERIAL PRIMARY KEY,
  file_name varchar NOT NULL,
  file_url varchar NOT NULL,
  collections_collection_id integer,
  users_user_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (collections_collection_id) REFERENCES collections(collection_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE SEQUENCE file_id_seq;
CREATE INDEX IF NOT EXISTS file_name_index ON files (file_name);

-- records of request of permission by user

CREATE TABLE IF NOT EXIST request_permission (
  request_id SERIAL PRIMARY KEY,
  users_user_id integer,
  permissions_permission_id integer,
  request_description text,
  is_approved boolean DEFAULT false,
  approved_by_admin_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id),
  FOREIGN key (approved_by_admin_id) REFERENCES admins(admin_id);
);
CREATE SEQUENCE request_id_seq;

-- permission provide to all the team members

CREATE TABLE IF NOT EXIST team_permmisions (
  permissions_permission_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- extra permission provide to team admin

CREATE TABLE IF NOT EXIST team_admin_permissions (
  teams_team_id integer,
  permissions_permission_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- team and their members mapping

CREATE TABLE IF NOT EXIST users_teams (
  users_user_id integer,
  teams_team_id integer,
  created_at timestamp,
  updated_at timestamp,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id)
);

