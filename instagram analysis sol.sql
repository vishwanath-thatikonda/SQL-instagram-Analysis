-- ---------------- INSTAGRAM ANALYSIS----------------

use ig_clone;


-- 1. Find five oldest 5 active users?

SELECT username AS Five_oldest_users
FROM users
ORDER BY created_at
LIMIT 5;

-- 2.What day of the week do most users register on?

select dayname(created_at) as register_day,count(*) as most_users_registered_date from users
group by dayname(created_at);

-- 3. Find the users who have never posted a photo?

SELECT username as users_never_posted_photos FROM users u
left JOIN photos p ON u.id = p.user_id
WHERE p.image_url is null;

-- 4. Find the person who got more likes for one post?

select username,count(*) as no_of_likes from users u
join photos p
on u.id = p.user_id
join likes l
on l.user_id = p.user_id
group by username
order by no_of_likes desc
limit 1;


-- 5. How many times does the average user post?

select round(sum(no_of_posts) / count(username),2)  as average_users_post from (
select username,count(*) as no_of_posts from users u
left  join photos p
on u.id = p.user_id
group by username
order by no_of_posts desc) as x;

-- 6. Find total post by users?

select username,count(*) as no_of_posts from users u
join photos p
on u.id = p.user_id
group by username
order by no_of_posts desc;


-- 7. Total numbers of users who have posted at least one time?

select username,count(*) as no_of_posts from users u
join photos p
on u.id = p.user_id
group by username
having count(*) >=  1
order by no_of_posts desc;


-- 8. What are the top 5 most commonly used hashtags?

 select t.tag_name,count(*) as most_popular_tags from users u
join photos p
on u.id = p.user_id
join photo_tags pt
on pt.photo_id = p.id
join tags t
on t.id = pt.tag_id
group by t.tag_name
order by most_popular_tags desc
limit 5;


-- 9. Find users who have liked every single photo on the site?

 select distinct username from users u
join likes l
on l.user_id = u.id;

-- 10. Find users who have never commented on a photo?

select distinct username from users u
left join comments c
on u.id = c.user_id
where comment_text is null;

-- 11. Find the percentage of our users who have either never commented on a photo or have liked on every photo?

select (select count(distinct username) count_username from users u
left join comments c
on u.id = c.user_id
where comment_text is null) * 100 /
(select count(distinct username) from users u
join likes l
on l.user_id = u.id) as Percentage;


-- 12. Find users who have ever commented on a photo?

select distinct username from users u
join comments c
on u.id = c.user_id;

