-- запрос который выведет всех пользователей в возрасте от 20 лет с количеством книг более 5
SELECT u.id, u.first_name, u.last_name, u.age from users as u
INNER JOIN users_books as ub
ON ub.user_id = u.id
WHERE u.age >= 20
GROUP BY ub.user_id
HAVING count(ub.book_id) > 5;

-- запрос который выведет пользователей в имени которых присутствует число 3
SELECT * FROM users WHERE first_name LIKE '%3%';

-- запрос который выведет список пользователей которые не брали книгу с именем "Book #21"
SELECT u.* FROM users as u
WHERE u.id not in 
(SELECT ub.user_id
FROM users_books as ub
JOIN books as b
ON b.id = ub.book_id
WHERE title='Book #21');

-- запрос который добавит поле is_active в таблицу users;
ALTER TABLE users ADD COLUMN is_active INT(1) NOT NULL;

-- запрос, который проставит is_active = 1 для пользователей, которые взяли как минимум одну книгу
UPDATE users as u
SET is_active=1
WHERE u.id in 
(SELECT ub.user_id
FROM users_books as ub
GROUP BY ub.user_id
HAVING count(ub.user_id) >= 1);

-- запрос который добавит поле isbestseller (bool) в таблицу books
ALTER TABLE books ADD COLUMN isbestseller bool;

-- запрос который выставит isbestseller = 1 для книг, которые были взяты пользователями более 10 раз
UPDATE books as b
SET b.isbestseller = 1
WHERE b.id IN 
(SELECT ub.book_id
FROM users_books as ub
GROUP BY ub.book_id 
HAVING count(ub.book_id) > 10
);