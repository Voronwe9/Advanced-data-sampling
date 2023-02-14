--количество исполнителей в каждом жанре;
select count(executor_id), genre_id 
from genre_executor 
GROUP by genre_id

--количество треков, вошедших в альбомы 2019-2020 годов;

select count(track_id) 
from track_list
where albom_id in (select albom_id 
                  from albom_list 
                  where year_of_release >= '2019-01-01' and year_of_release <= '2020-12-31')

--средняя продолжительность треков по каждому альбому;

select avg(track_time_sec), albom_id 
from track_list 
GROUP by albom_id


--все исполнители, которые не выпустили альбомы в 2020 году;

select executor_name 
from executor_list 
where executor_id not in (select ax.executor_id 
						  from albom_list al
						  left join albom_executor ax on ax.albom_id = al.albom_id
						  where al.year_of_release >= '2020-01-01' and al .year_of_release <= '2020-12-31')

--названия сборников, в которых присутствует конкретный исполнитель (выберите сами);

select collection_name
from collection c 
left join track_collection tc on c.collection_id = tc.collection_id
left join track_list tl on tc.track_id = tl.track_id
left join albom_executor ae on ae.albom_id = tl.albom_id
inner join executor_list el on el.executor_id = ae.executor_id and executor_name = 'Порно фильмы'
--where executor_name = 'Порно фильмы';

--название альбомов, в которых присутствуют исполнители более 1 жанра;
select albom_name 
from albom_list al
where albom_id in (select albom_id 
					from (
					select 
					albom_id, 
					ge.executor_id, 
					count(ge.genre_id) cntge  
					from albom_executor ae
					join genre_executor ge on ae.executor_id = ge.executor_id 
					group by 1,2
					) a 
					where cntge > 1)

--наименование треков, которые не входят в сборники;
select track_name
from track_list tl 
where track_id in (select track_id 
					from (
					select 
					collection_id,  
					count(tc.track_id) cntc  
					from track_collection tc
					join track_list tl on tc.track_id = tl.track_id 
					group by 1
					) a 
					where cntc = 0)

--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
select executor_name
from executor_list
where executor_id in (select ax.executor_id 
						  from albom_list al
						  left join albom_executor ax on ax.albom_id = al.albom_id
						  left join track_list tl on tl.albom_id = al.albom_id
						  where tl.track_time_sec = (
						  select min(tl.track_time_sec) 
						  from track_list tl ))

-- Второнй вариант						  
select el.executor_name 
from albom_list al
						  left join albom_executor ax on ax.albom_id = al.albom_id
						  left join track_list tl on tl.albom_id = al.albom_id
						  left join executor_list el on ax.executor_id = el.executor_id
						  where tl.track_time_sec = (
						  select min(tl.track_time_sec) 
						  from track_list tl )			  
						  
										     
--название альбомов, содержащих наименьшее количество треков.
select albom_name 
from (
select al.albom_name, count(track_id) cnt1
from albom_list al 
left join track_list tl  on al.albom_id = tl.albom_id
group by al.albom_name	
)	mcnt		  
where cnt1 =  (select min(cnt1) 
				from (
				select count(track_id) cnt1, albom_id 
					  from track_list 
					  group by albom_id) cnt)
				  	
-- Второнй вариант	

with mcnt as
(
select al.albom_name, count(track_id) cnt1
from albom_list al 
left join track_list tl  on al.albom_id = tl.albom_id
group by al.albom_name  
)  




select albom_name 
from mcnt      
where cnt1 =  (select min(cnt1) 
        from mcnt)
						  					 