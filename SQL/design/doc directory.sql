-- Make sure to attach design image/pdf in the same folder.
-- Write your DDL queries here.


-- for maintain Administrator of database
Table Admin {
  admin_id integer [primary key]
  admin_name varchar 
  created_at timestamp
}

-- for maintain all users of system(either team admin or team member) 
Table User {
  user_id integer [primary key]
  username varchar 
  created_at timestamp
}

-- maintain all the permission list of systems 
Table Permissions {
  permission_id integer [primary key]
  permission_name varchar
  permission_type permission.type
  created_at timestamp
}

-- enum for type of permission
Enum permission.type {
  general_permission
  collection_permission
  task_permission

}

-- list of all the team with it's admin
Table Team {
    team_id int [primary key]
    team_name varchar
    team_admin integer [ref: > User.user_id] 
}

-- list of collection
Table Collections{
  collection_id integer [primary key]
  collection_name varchar
  createdBy_team integer [ ref: > Team.team_id]
  createdBy_user integer [ref: > User.user_id]
  collection_visibility collections.collection_visibility
  created_at timestamp
}

-- enum for collection visibility 
Enum collections.collection_visibility{
  all
  private
  admin
}

-- all the files created by team and it's collection
Table Files {
  file_id integer [primary key]
  file_url varchar 
  collection_of_file integer [ref: > Collections.collection_id]
  owner integer [ref: > User.user_id]
}

-- permission assign to user
Table User_Permission_map {
  user_id integer [ref: > User.user_id]
  permission_id integer [ref: > Permissions.permission_id]
}

-- records of request of permission by user
Table Request_permission {
  request_id integer [primary key]
  user_id integer [ref: > User.user_id]
  permission_id integer [ref: > Permissions.permission_id]
  request_description text 
  is_approved boolean
  approved_by integer [ref: > Admin.admin_id]
}

-- permission provide to all the team members
Table Team_Permmision {
  permission_id integer [ref: > Permissions.permission_id]
  team_id integer [ref: > Team.team_id]
}

-- extra permission provide to team admin
Table Team_Admin_Permission{
  team_id integer [ref: > Team.team_id]
  permission_id integer [ref: > Permissions.permission_id]
}

-- team and their members mapping
Table User_Team_map {
  user_id integer [ref: > User.user_id]
  team_id integer [ref: > Team.team_id]
}




