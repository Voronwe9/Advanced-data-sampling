-- название и год выхода альбомов, вышедших в 2018 году
select albom_name, year_of_release from albom_list
where year_of_release >= '2018-01-01' and year_of_release <= '2018-12-31';

--название и продолжительность самого длительного трека
select track_name, track_time_sec from track_list
where track_time_sec = (SELECT max(track_time_sec)from track_list);

--название треков, продолжительность которых не менее 3,5 минуты. добавил столбец track_time_sec, для лучшей наглядности.
select track_name, track_time_sec from track_list
where track_time_sec >= 210;

--названия сборников, вышедших в период с 2018 по 2020 год включительно; добавил столбец year_of_release, для лучшей наглядности.
select collection_name, year_of_release from collection
where year_of_release >= '2018-01-01' and year_of_release <= '2020-12-31';

--исполнители, чье имя состоит из 1 слова; топорно конечно и может сработать не во всех случаях
select executor_name from executor_list
where executor_name not like '% %';

--название треков, которые содержат слово "мой"/"my". сделал пробелы, что бы искал по СЛОВУ
select track_name from track_list
where track_name LIKE '% мой %' or track_name LIKE '% my %';
-- в данном запросе выводится только по слову my, но если оно в середине, то же не до конца правильно я считаю, как сделать правильно?
select track_name from track_list
where track_name LIKE '%мой%' or track_name LIKE '%my%';