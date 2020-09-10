/**
 *	4. Определить кто больше поставил лайков (всего) - мужчины или женщины?
 */
 
-- Вариант раз
select 
	(select 
		case(u.gender)
			when 'м' then 'Мужчина'
			when 'ж' then 'Женщина'
	   	end gender
   	from users u 
   	where u.id = l.user_id) gender, 
   	count(*) likes_count
from likes l 
group by gender 
order by likes_count desc
limit 1


-- Вариант двас
select case(gender)
		when 'м' then 'Мужчина'
		when 'ж' then 'Женщина'
	   end gender, count(*) likes_count
from likes l 
left join users u on u.id = l.user_id 
group by gender 
order by likes_count desc
limit 1


