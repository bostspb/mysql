/**
 *	3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
 */

select count(*) likes_count
from likes l
where l.user_id in (
	select youngest_users_10.* from (
		select u.id from users u 
		order by timestampdiff(year, u.birthday, now()), u.id
		limit 10
	) youngest_users_10
)

	