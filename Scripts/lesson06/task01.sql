/**
 *	1. Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).
 */
 
-- Без конкретной цели сложно предложить какие-то улучшения ((
-- Поэтому просто поправил все запросы, чтобы они отрабатывали на моих данных

-- персональная страница пользователя
select 
	name,
	surname,
	hometown,
	(select ph.file from photos ph where ph.id = u.photo_id) as 'personal_photo'
	, (select count(friend_id) from (select target_user_id as friend_id from friend_requests where initiator_user_id = 6 and status ='approved' union select initiator_user_id as friend_id from friend_requests where target_user_id = 6 and status ='approved') as fr_list) as friends	 
	, (select count(fr.initiator_user_id) as friend_id from friend_requests fr where fr.target_user_id = u.id and fr.status ='requested') as 'followers'
	, (select count(*) from photos p where p.user_id = u.id) as 'photos'
from users u
where u.id = 6;

select count(*) cnt from photos p where p.user_id = 6;

select count(friend_id) 
from (
	select target_user_id as friend_id 
	from friend_requests 
	where initiator_user_id = 6 and status ='approved' 
	union 
	select initiator_user_id as friend_id 
	from friend_requests 
	where target_user_id = 6 and status ='approved') as fr_list

-- Получить id друзей пользователя №1
select target_user_id as friend_id from friend_requests where initiator_user_id = 6 and status ='approved'
union
select initiator_user_id as friend_id from friend_requests where target_user_id = 6 and status ='approved';

-- Получить id друзей пользователя №2
select * from (select
		case 
		  when initiator_user_id = 6 and status = 'approved' then target_user_id
		  when target_user_id = 6  and status = 'approved' then initiator_user_id 
		end as friend_id
	    from friend_requests) as fr_list where friend_id is not null
	    
-- Список друзей пользователя 1
select name, surname from users where id in 
(select target_user_id as friend_id from friend_requests where initiator_user_id = 6 and status ='approved'
union
select initiator_user_id as friend_id from friend_requests where target_user_id = 6 and status ='approved');

-- Список друзей пользователя 1 с преобразованием пола и возраста 
select 
	name, 
	surname,
	timestampdiff(year, birthday, now()) as 'age', 
	case(gender)
		when 'м' then 'Мужчина'
		when 'ж' then 'Женщина'
	end as 'gender'
from users where id in 
(select target_user_id as friend_id from friend_requests where initiator_user_id = 6 and status ='approved'
union
select initiator_user_id as friend_id from friend_requests where target_user_id = 6 and status ='approved');

-- непрочитанные сообщения, адресованные пользователю 1
select 
	count(from_user_id) 'unread_msg', 
	(select concat(name, ' ', surname) from users where id  = from_user_id) 'name'
from messages 
where to_user_id = 6 and is_read = 0 group by from_user_id;

-- непрочитанные сообщения, адресованные пользователю 1 от друзей 
select 
	count(from_user_id) 'unread_msg', 
	(select concat(name, ' ', surname) from users where id  = from_user_id) 'name'
from messages 
where to_user_id = 6 and is_read = 0 and from_user_id in 
(select target_user_id as friend_id from friend_requests where initiator_user_id = 6 and status ='approved'
union
select initiator_user_id as friend_id from friend_requests where target_user_id = 6 and status ='approved'
) group by from_user_id;

-- среднее количество постов, опубликованных каждым пользователем
select avg(`total_user_news`) from (select count(*) as `total_user_news` from posts group by user_id) `tlbn`;

-- архив новостей 
select count(*) `total_news`, monthname(created_at) as `month` from posts group by `month` order by  `total_news` desc;

-- Среднее количество групп у всех пользователей
-- вариант 1 (неправильно!)
select avg(`total_communities`) from (select count(*) as `total_communities` from users_communities group by user_id) `tbl2`;
-- вариант 2
select (select count(*) from users_communities)/(select count(*) from users)

