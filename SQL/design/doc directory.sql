-- Define ENUM types

CREATE TYPE permission_type_enum AS ENUM (
  'general_permission',
  'collection_permission',
  'task_permission'
);

CREATE TYPE collection_visibility_enum AS ENUM (
  'all',
  'private',
  'admin'
);

-- for maintaining Administrators of the database

CREATE TABLE IF NOT EXISTS admins (
  admin_id SERIAL PRIMARY KEY,
  admin_name VARCHAR NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- for maintaining all users of the system (either team admin or team member)

CREATE TABLE IF NOT EXISTS users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR NOT NULL,
  user_email VARCHAR UNIQUE,
  user_password VARCHAR NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS username_index ON users (username, user_email);

-- maintain all the permission list of the system

CREATE TABLE IF NOT EXISTS permissions (
  permission_id SERIAL PRIMARY KEY,
  permission_name VARCHAR NOT NULL,
  permission_type permission_type_enum,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS permission_index ON permissions (permission_name);


-- list of all the teams with their admins

CREATE TABLE IF NOT EXISTS teams (
  team_id SERIAL PRIMARY KEY,
  team_name VARCHAR NOT NULL,
  team_admin INTEGER,
  is_deleted BOOLEAN DEFAULT false,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  FOREIGN KEY (team_admin) REFERENCES users(user_id)
);
CREATE INDEX IF NOT EXISTS team_name_index ON teams (team_name, team_admin);

-- list of collections

CREATE TABLE IF NOT EXISTS collections (
  collection_id SERIAL PRIMARY KEY,
  collection_name VARCHAR NOT NULL,
  teams_team_id INTEGER,
  users_user_id INTEGER,
  collection_visibility collection_visibility_enum,
  created_at TIMESTAMP,
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE INDEX IF NOT EXISTS collection_name_index ON collections (collection_name, teams_team_id);

-- all the files created by teams and their collections

CREATE TABLE IF NOT EXISTS files (
  file_id SERIAL PRIMARY KEY,
  file_name VARCHAR NOT NULL,
  file_url VARCHAR NOT NULL,
  collections_collection_id INTEGER,
  users_user_id INTEGER,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  FOREIGN KEY (collections_collection_id) REFERENCES collections(collection_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id)
);
CREATE INDEX IF NOT EXISTS file_name_index ON files (file_name, collection_id);

-- records of requests for permission by users

CREATE TABLE IF NOT EXISTS request_permission (
  request_id SERIAL PRIMARY KEY,
  users_user_id INTEGER,
  permissions_permission_id INTEGER,
  request_description TEXT,
  is_approved BOOLEAN DEFAULT false,
  approved_by_admin_id INTEGER,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id),
  FOREIGN KEY (approved_by_admin_id) REFERENCES admins(admin_id)
);
CREATE INDEX IF NOT EXISTS request_index ON request_permission (permissions_permission_id, users_user_id);

-- permissions provided to all team members

CREATE TABLE IF NOT EXISTS team_permissions (
  permissions_permission_id INTEGER,
  teams_team_id INTEGER,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (permissions_permission_id, teams_team_id),
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- extra permissions provided to team admins

CREATE TABLE IF NOT EXISTS team_admin_permissions (
  teams_team_id INTEGER,
  permissions_permission_id INTEGER,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (teams_team_id, permissions_permission_id),
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_permission_id) REFERENCES permissions(permission_id)
);

-- team and their members mapping

CREATE TABLE IF NOT EXISTS users_teams (
  users_user_id INTEGER,
  teams_team_id INTEGER,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  PRIMARY KEY (users_user_id, teams_team_id),
  FOREIGN KEY (users_user_id) REFERENCES users(user_id),
  FOREIGN KEY (teams_team_id) REFERENCES teams(team_id)
);
