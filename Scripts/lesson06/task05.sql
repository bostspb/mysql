/**
 *	5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
 */
 
select 
	u.id, u.name, u.surname,
	(select count(*) from likes l where l.user_id = u.id) likes_count,
	(select count(*) from comments ct where ct.user_id = u.id) comments_count,
	(select count(*) from users_communities uc where uc.user_id = u.id) communities_count,
	(select count(*) from friend_requests fr where fr.initiator_user_id = u.id) requests_count,
	(select count(*) from messages m where m.from_user_id = u.id) messages_count,
	(select count(*) from photos ph where ph.user_id = u.id) photos_count,
	(select count(*) from posts p where p.user_id = u.id) posts_count	
from users u 
order by likes_count*3 + comments_count*3 + communities_count*2 +requests_count*2 + messages_count + photos_count + posts_count*4
limit 10



