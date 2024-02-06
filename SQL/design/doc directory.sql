-- Define ENUM types

CREATE TYPE permission_type_enum AS ENUM (
  'general_permission',
  'collection_permission',
  'task_permission'
);

CREATE TYPE collection_visibility_enum AS ENUM (
  'all',
  'team_only',
  'admin'
);

CREATE TYPE user_role_enum AS ENUM(
  'user',
  'admin'
);

-- for maintaining all users of the system (either admin or team member)

CREATE TABLE IF NOT EXISTS users (
  user_id SERIAL PRIMARY KEY,
  user_name VARCHAR(100) NOT NULL,
  user_email VARCHAR(60) UNIQUE,
  user_password VARCHAR NOT NULL,
  user_role user_role_enum DEFAULT 'user',
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS username_index ON users (user_name);
CREATE INDEX IF NOT EXISTS user_email_index ON users USING hash (user_email);

-- maintain all the permission list of the system

CREATE TABLE IF NOT EXISTS permissions (
  permission_id SERIAL PRIMARY KEY,
  permission_name VARCHAR(30) NOT NULL,
  permission_type permission_type_enum NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS permission_index ON permissions (permission_name);


-- list of all the teams with their admins

CREATE TABLE IF NOT EXISTS teams (
  team_id SERIAL PRIMARY KEY,
  team_name VARCHAR(50) NOT NULL,
  team_admin INTEGER NOT NULL,
  is_deleted BOOLEAN DEFAULT false,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  FOREIGN KEY (team_admin) REFERENCES users(user_id)
);
CREATE INDEX IF NOT EXISTS team_name_index ON teams (team_name, team_admin);

-- list of collections

CREATE TABLE IF NOT EXISTS collections (
  collection_id SERIAL PRIMARY KEY,
  collection_name VARCHAR(50) NOT NULL,
  teams_id INTEGER NOT NULL,
  users_id INTEGER NOT NULL,
  collection_visibility collection_visibility_enum DEFAULT 'team_only',
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  FOREIGN KEY (teams_id) REFERENCES teams(team_id),
  FOREIGN KEY (users_id) REFERENCES users(user_id)
);
CREATE INDEX IF NOT EXISTS collection_name_index ON collections (collection_name);
CREATE INDEX IF NOT EXISTS collections_owner_index ON collections (teams_id, users_id);

-- all the files created by teams and their collections

CREATE TABLE IF NOT EXISTS files (
  file_id SERIAL PRIMARY KEY,
  file_name VARCHAR(50) NOT NULL,
  file_url VARCHAR NOT NULL,
  collections_id INTEGER NOT NULL, 
  users_id INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  FOREIGN KEY (collections_id) REFERENCES collections(collection_id),
  FOREIGN KEY (users_id) REFERENCES users(user_id)
);
CREATE INDEX IF NOT EXISTS file_name_index ON files (file_name);
CREATE INDEX IF NOT EXISTS files_owner_index ON files (collections_id, users_id);

-- records of requests for permission by users

CREATE TABLE IF NOT EXISTS requests_permission (
  request_id SERIAL PRIMARY KEY,
  users_id INTEGER NOT NULL,
  permissions_id INTEGER NOT NULL,
  request_description TEXT NOT NULL,
  is_approved BOOLEAN DEFAULT false,
  approved_by INTEGER,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  FOREIGN KEY (users_id) REFERENCES users(user_id),
  FOREIGN KEY (permissions_id) REFERENCES permissions(permission_id),
  FOREIGN KEY (approved_by) REFERENCES users(user_id)
);
CREATE INDEX IF NOT EXISTS request_index ON requests_permission (permissions_id, users_id);

-- permissions provided to all team members

CREATE TABLE IF NOT EXISTS teams_permissions (
  permissions_id INTEGER,
  teams_id INTEGER,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
PRIMARY KEY (permissions_id, teams_id),
  FOREIGN KEY (teams_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_id) REFERENCES permissions(permission_id)
);

CREATE INDEX IF NOT EXISTS teams_permissions_index ON teams_permissions(permissions_id, teams_id);

-- extra permissions provided to team admins

CREATE TABLE IF NOT EXISTS team_admin_permissions (
  teams_id INTEGER,
  permissions_id INTEGER,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  PRIMARY KEY (teams_id, permissions_id),
  FOREIGN KEY (teams_id) REFERENCES teams(team_id),
  FOREIGN KEY (permissions_id) REFERENCES permissions(permission_id)
);

CREATE INDEX IF NOT EXISTS team_admin_permissions_index ON team_admin_permissions(teams_id, permissions_id);

-- team and their members mapping

CREATE TABLE IF NOT EXISTS teams_users (
  users_id INTEGER,
  teams_id INTEGER,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  PRIMARY KEY (users_id, teams_id),
  FOREIGN KEY (users_id) REFERENCES users(user_id),
  FOREIGN KEY (teams_id) REFERENCES teams(team_id)
);

CREATE INDEX IF NOT EXISTS team_users_index ON teams_users(users_id, teams_id);
