/**
 *	3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
 */

-- -------------
-- ПОЛЕ БИТВЫ --
----------------

-- не можем ограничить выборку в подзапросе
select count(*) likes_count
from likes l
where l.user_id in 
	(select u.id
	from users u 
	order by timestampdiff(year, u.birthday, now()), u.id;
	-- limit 10 -- не прокатило ((
);


-- из-за второго столбца в результате не можем использовать в качестве подзапроса к предыдущему
-- хотя и без него вылетает ошибка
select @i:=@i+1 num, u.id 
from users u, (select @i:=0) X
where @i < 10
order by timestampdiff(year, u.birthday, now()), u.id;

    
 -- как просуммировать результат????  
select  (select count(*) from likes l where l.user_id = u.id) cnt -- ,u.id
from users u
order by timestampdiff(year, u.birthday, now()), u.id
limit 10
	
	
-- как просуммировать результат????
select count(l.id) -- ,u.id
from likes l
left join users u on u.id = l.user_id 
group by u.id
order by timestampdiff(year, u.birthday, now()), u.id
limit 10;	
	
	
	
	
	
	
	