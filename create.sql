create table if not exists genre_list (
genre_id integer primary key,
genre_name text unique not null
);
create table if not exists executor_list (
executor_id integer primary key,
executor_name text unique  not null
);
create table if not exists genre_executor (
executor_id integer not null references executor_list(executor_id),
genre_id integer not null references gere_list(genre_id),
constraint genre_executor_id primary key (executor_id, genre_id)
);
create table if not exists albom_list (
albom_id integer primary key,
albom_name text unique not null,
year_of_release date not null
);
create table if not exists albom_executor (
executor_id integer not null references executor_list(executor_id),
albom_id integer not null references albom_list(albom_id),
constraint albom_executor_id primary key (executor_id, albom_id)
);
create table if not exists track_list (
track_id integer primary key,
track_name text unique not null,
track_time_sec integer not null,
albom_id integer not null references albom_list(albom_id)
);
create table if not exists collection (
collection_id integer primary key,
collection_name text unique not null,
year_of_release date not null
);	
create table if not exists track_collection (
collection_id integer references collection(collection_id),
track_id integer references track_list(track_id),
constraint track_collection_id primary key (collection_id, track_id)
);