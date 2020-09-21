-- join

-- [inner] join

select * from communities c 
join users_communities uc 
	on c.id = uc.community_id;
	

-- left join

select * from communities c 
left join users_communities uc 
	on c.id = uc.community_id;
	
-- выбрать группы без пользователей 

select * from communities c 
left join users_communities uc 
	on c.id = uc.community_id
where community_id is null;


-- right join 

select * from communities c 
right join users_communities uc 
on c.id = uc.community_id;


-- right join 

select * from users_communities uc 
right join communities c 
	on c.id = uc.community_id;	