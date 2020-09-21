/**
 *	2. Пусть задан некоторый пользователь. 
 *  Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
 */

select u.id, u.name, u.surname
from users u 
where u.id =
	(select 
		case 
		  when m.from_user_id = 6 then m.to_user_id
		  when m.to_user_id = 6  then m.from_user_id 
		end as friend_id
	from messages m 
	where 
		(m.to_user_id = 6 -- кто писал пользователю
			and m.from_user_id in (
				select target_user_id as friend_id from friend_requests where initiator_user_id = 6 and status ='approved'
				union
				select initiator_user_id as friend_id from friend_requests where target_user_id = 6 and status ='approved') 
		) or (
			m.from_user_id = 6 -- кому писал пользователь
			and m.to_user_id in (
				select target_user_id as friend_id from friend_requests where initiator_user_id = 6 and status ='approved'
				union
				select initiator_user_id as friend_id from friend_requests where target_user_id = 6 and status ='approved') 
		)
	group by friend_id
	order by count(*) desc
	limit 1);