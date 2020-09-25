/**
 * 	ТЕМА: NoSQL
 * 
 *	1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
 *
 

--
-- Подготовка
--

Устанавливаем Redis
docker pull redis
docker run --name redis_gb -d redis

Устанавливаем консольный клиент redis-cli для работы с Redis в Windows
https://github.com/MicrosoftArchive/redis/releases

--
-- Решение задачи
--

Для решения задачи будем использовать коллекцию типа множество, 
где имя множества будет IP-адрес, а значение - идентификатор одного посещения.

Записываем тестовые данные:
sadd "ip:192.168.1.1" "visit:3215111"
sadd "ip:192.168.1.2" "visit:3214222"
sadd "ip:192.168.1.1" "visit:3215333"
sadd "ip:192.168.1.3" "visit:3215444"
sadd "ip:192.168.1.1" "visit:3215555"

Подсчитываем количество пеосещений с IP-адреса "192.168.1.1":
scard "ip:192.168.1.1"
> (integer) 3

*/