/**
 * 2. Добавить необходимую таблицу/таблицы для того, чтобы можно было использовать лайки для медиафайлов, постов и пользователей.
 */

-- Вариант #1
-- здесь оч компактно, мне этот вариант больше нравится - заложена возможность расширения
drop table if exists likes;
create table likes(
	id serial primary key,
	user_id bigint unsigned not null,
	created_at datetime default current_timestamp,
	target_type ENUM('post', 'photo', 'user') not null,
	target_id bigint unsigned not null,
	foreign key (user_id) references users(id)
);

-- Вариант #2
-- есть ощущение, что с таким подходом можно огрести в будущем, 
-- т.к. для внешнего ключа допустимо значение NULL в данном случае
drop table if exists likes;
create table likes(
	id serial primary key,
	user_id bigint unsigned not null,
	created_at datetime default current_timestamp,
	target_post_id bigint unsigned,
	target_photo_id bigint unsigned,
	target_user_id bigint unsigned,
	foreign key (user_id) references users(id),
	foreign key (target_post_id) references posts(id),
	foreign key (target_photo_id) references photos(id),
	foreign key (target_user_id) references users(id)
);

-- Вариант #3
-- мне кажется это избыточный варианант, но идеальный в плане структуры по внешним ключам
drop table if exists likes_for_post;
create table likes_for_post(
	id serial primary key,
	created_at datetime default current_timestamp,
	user_id bigint unsigned not null,
	post_id bigint unsigned not null,
	foreign key (user_id) references users(id),
	foreign key (post_id) references posts(id)
);

drop table if exists likes_for_photo;
create table likes_for_photo(
	id serial primary key,
	created_at datetime default current_timestamp,
	user_id bigint unsigned not null,
	photo_id bigint unsigned not null,
	foreign key (user_id) references users(id),
	foreign key (photo_id) references photos(id)
);

drop table if exists likes_for_user;
create table likes_for_user(
	id serial primary key,
	created_at datetime default current_timestamp,
	user_id bigint unsigned not null,
	target_user_id bigint unsigned not null,
	foreign key (user_id) references users(id),
	foreign key (target_user_id) references users(id)
);

