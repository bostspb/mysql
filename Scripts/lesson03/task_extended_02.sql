/**
 * 2. Реализовать древовидные комментарии к постам (как в vk.com)
 */

drop table if exists comments;
create table comments(
	id serial primary key,
	user_id bigint unsigned not null,
	post_id bigint unsigned not null,
	parent_comment_id bigint unsigned, -- просто создаем ссылку на родительский комментарий
	body text, 
	created_at datetime default current_timestamp,
	foreign key (user_id) references users(id),
	foreign key (post_id) references posts(id),
	foreign key (parent_comment_id) references comments(id)
);