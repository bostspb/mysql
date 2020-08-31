"""
    3. Сгенерировать данные не с помощью сервисов, а используя знакомые языки программирования
    либо соответствующую функциональность в фреймворках
"""

import pymysql
from faker import Faker


def user_insert(db_config, faker):
    user = (
        faker.ascii_free_email(),                                       # email
        faker.md5(),                                                    # pass
        faker.first_name(),                                             # name
        faker.last_name(),                                              # surname
        faker.numerify(text='+7 (%%%) %##-##-##'),                      # phone
        faker.random_element(elements=('м', 'ж')),                      # gender
        faker.date(pattern='%Y-%m-%d', end_datetime='-18y'),            # birthday
        faker.city(),                                                   # hometown
        None,                                                           # photo_id
        faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),  # created_at
    )

    con = pymysql.connect(**db_config)

    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO users ' \
                    '(email,pass,name,surname,phone,gender,birthday,hometown,photo_id,created_at) VALUES ' \
                    '(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
            cursor.execute(query, user)
        con.commit()
        with con.cursor() as cursor:
            sql = "SELECT id FROM users WHERE email=%s"
            cursor.execute(sql, (user[0],))
            user_id = cursor.fetchone()
    finally:
        con.close()
    return user_id[0]


def settings_insert(db_config, faker, user_id):
    settings = (
        user_id,                                                                            # user_id
        faker.random_element(elements=('all', 'friends_of_friends', 'friends')),            # can_see
        faker.random_element(elements=('all', 'friends_of_friends', 'friends', 'nobody')),  # can_comment
        faker.random_element(elements=('all', 'friends_of_friends', 'friends')),            # can_message
    )
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO settings (user_id,can_see,can_comment,can_message) VALUES (%s,%s,%s,%s)'
            cursor.execute(query, settings)
        con.commit()
    finally:
        con.close()


def message_insert(db_config, faker, from_user_id, to_user_id):
    message = (
        from_user_id,                                                   # from_user_id
        to_user_id,                                                     # to_user_id
        faker.paragraph(),                                              # body
        faker.boolean(chance_of_getting_true=25),                       # is_read
        faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),  # created_at
    )
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO messages (from_user_id,to_user_id,body,is_read,created_at) VALUES (%s,%s,%s,%s,%s)'
            cursor.execute(query, message)
        con.commit()
    finally:
        con.close()


def friend_request_insert(db_config, faker, initiator_user_id, target_user_id):
    friend_request = (
        initiator_user_id,                                                                  # initiator_user_id
        target_user_id,                                                                     # target_user_id
        faker.random_element(elements=('requested', 'approved', 'unfriended', 'declined')), # status
        faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),                      # requested_at
        faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),                      # confirmed_at
    )
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO friend_requests (initiator_user_id,target_user_id,status,requested_at,confirmed_at) VALUES (%s,%s,%s,%s,%s)'
            cursor.execute(query, friend_request)
        con.commit()
    finally:
        con.close()


def community_insert(db_config, faker):
    community = (
        faker.catch_phrase(),  # name
    )
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO communities (name) VALUES (%s)'
            cursor.execute(query, community)
        con.commit()
        with con.cursor() as cursor:
            sql = "SELECT id FROM communities WHERE name=%s"
            cursor.execute(sql, (community[0],))
            community_id = cursor.fetchone()
    finally:
        con.close()
    return community_id[0]


def user_to_community_insert(db_config, faker, user_id, community_id):
    user_to_community = (
        user_id,                                    # user_id
        community_id,                               # community_id
        faker.boolean(chance_of_getting_true=5),    # is_admin
    )
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO users_communities (user_id,community_id,is_admin) VALUES (%s,%s,%s)'
            cursor.execute(query, user_to_community)
        con.commit()
    finally:
        con.close()


def post_insert(db_config, faker, user_id):
    post = (
        user_id,                                                        # user_id
        faker.text(max_nb_chars=1500),                                  # body
        faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),  # created_at
        faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),  # updated_at
    )
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO posts (user_id,body,created_at,updated_at) VALUES (%s,%s,%s,%s)'
            cursor.execute(query, post)
        con.commit()
        with con.cursor() as cursor:
            sql = "SELECT id FROM posts WHERE body=%s"
            cursor.execute(sql, (post[1],))
            post_id = cursor.fetchone()
    finally:
        con.close()
    return post_id[0]


def comment_insert(db_config, faker, user_id, post_id, parent_comment_id):
    comment = (
        user_id,            # user_id
        post_id,            # post_id
        parent_comment_id,  # parent_comment_id
        faker.paragraph(),  # body
        faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),  # created_at
    )
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO comments (user_id,post_id,parent_comment_id,body,created_at) VALUES (%s,%s,%s,%s,%s)'
            cursor.execute(query, comment)
        con.commit()
        with con.cursor() as cursor:
            sql = "SELECT id FROM comments WHERE body=%s"
            cursor.execute(sql, (comment[3],))
            comment_id = cursor.fetchone()
    finally:
        con.close()
    return comment_id[0]


def photo_insert(db_config, faker, user_id):
    photo = (
        user_id,            # user_id
        faker.sentence(),   # description
        faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),  # created_at
    )
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO photos (user_id,description,created_at) VALUES (%s,%s,%s)'
            cursor.execute(query, photo)
        con.commit()
        with con.cursor() as cursor:
            sql = "SELECT id FROM photos WHERE description=%s"
            cursor.execute(sql, (photo[1],))
            photo_id = cursor.fetchone()
    finally:
        con.close()
    return photo_id[0]


def avatar_insert(db_config, faker, user_id):
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            sql = "SELECT name, surname FROM users WHERE id=%s"
            cursor.execute(sql, (user_id,))
            user = cursor.fetchone()
        photo_description = str(user[0]) + ' ' + str(user[1])
        photo = (
            user_id,            # user_id
            photo_description,  # description
            faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),  # created_at
        )
        with con.cursor() as cursor:
            query = 'INSERT INTO photos (user_id,description,created_at) VALUES (%s,%s,%s)'
            cursor.execute(query, photo)
        con.commit()
        with con.cursor() as cursor:
            sql = "SELECT id FROM photos WHERE description=%s"
            cursor.execute(sql, (photo[1],))
            photo_id = cursor.fetchone()
        with con.cursor() as cursor:
            query = 'UPDATE users SET photo_id=%s WHERE id=%s;'
            cursor.execute(query, (photo_id[0],user_id))
        con.commit()
    finally:
        con.close()


def like_insert(db_config, faker, user_id, target_type, target_id):
    like = (
        user_id,                                                        # user_id
        faker.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S.0'),  # created_at
        target_type,                                                    # target_type
        target_id,                                                      # target_id
    )
    con = pymysql.connect(**db_config)
    try:
        with con.cursor() as cursor:
            query = 'INSERT INTO likes (user_id,created_at,target_type,target_id) VALUES (%s,%s,%s,%s)'
            cursor.execute(query, like)
        con.commit()
    finally:
        con.close()


db_connection_config = {
    'host':     '127.0.0.1',
    'port':     3308,
    'user':     'root',
    'password': 'root',
    'db':       'vk',
    'charset':  'utf8'
}


data_faker = Faker('ru_RU')
previous_user_id = 0
previous_comment_id = None
for _ in range(150):
    new_user_id = user_insert(db_connection_config, data_faker)
    settings_insert(db_connection_config, data_faker, new_user_id)
    if previous_user_id != new_user_id and previous_user_id != 0:
        message_insert(db_connection_config, data_faker, previous_user_id, new_user_id)
        friend_request_insert(db_connection_config, data_faker, new_user_id, previous_user_id)
        like_insert(db_connection_config, data_faker, new_user_id, 'user', previous_user_id)
    new_community_id = community_insert(db_connection_config, data_faker)
    user_to_community_insert(db_connection_config, data_faker, new_user_id, new_community_id)
    new_post_id = post_insert(db_connection_config, data_faker, new_user_id)
    new_comment_id = comment_insert(db_connection_config, data_faker, new_user_id, new_post_id, previous_comment_id)
    new_photo_id = photo_insert(db_connection_config, data_faker, new_user_id)
    avatar_insert(db_connection_config, data_faker, new_user_id)

    like_insert(db_connection_config, data_faker, new_user_id, 'photo', new_photo_id)
    like_insert(db_connection_config, data_faker, new_user_id, 'post', new_post_id)

    previous_user_id = new_user_id
    previous_comment_id = new_comment_id

