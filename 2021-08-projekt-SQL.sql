CREATE TABLE t_peter_hudak_projekt_sql_final
SELECT
		ct.country,
		ct.`date`,
		IF((weekday(ct.`date`) BETWEEN 0 AND 4),
	'WEEK',
	'NO_WEEK') AS 'work_day',
	/*(0 = Monday, 1 = Tuesday,	... 6 = Sunday)*/
	ct.tests_performed,
	(CASE
		WHEN MONTH(ct.`date`) BETWEEN 01 AND 03 THEN 0
		WHEN MONTH(ct.`date`) BETWEEN 04 AND 06 THEN 1
		WHEN MONTH(ct.`date`) BETWEEN 07 AND 09 THEN 2
		WHEN MONTH(ct.`date`) BETWEEN 10 AND 12 THEN 3
	END) AS 'Season',
		c_source.capital_city,
		c_source.population_density,
		c_source.median_age_2018,
		c_source.population,
		hdp_2020.hdp_per_cap AS 'HDP na obyvatela',
		hdp_2020.gini,
		hdp_2020.mortaliy_under5,
		w_source.average_daily_temp,
		w_source.rain_per_day,
		w_source.gust_per_day,
		life_source.avg_life,
		rel_chris.population / c_source.population AS 'Christianity',
		rel_islam.population / c_source.population AS 'Islam',
		rel_judaism.population / c_source.population AS 'Judaism',
		rel_unaffiliated_religions.population / c_source.population AS 'Unaffiliated_Religions',
		rel_hinduism.population / c_source.population AS 'Hinduism',
		rel_buddhism.population / c_source.population AS 'Buddhism',
		rel_folk_religions.population / c_source.population AS 'Folk_Religions',
		rel_other_religions.population / c_source.population AS 'Other_Religions'
FROM
	covid19_tests ct
LEFT JOIN (
	SELECT
		country,
		capital_city,
		population_density,
		median_age_2018,
		population
	FROM
		countries c) c_source ON
	ct.country = c_source.country
LEFT JOIN (
	SELECT
		country,
		`year`,
		GDP / population AS hdp_per_cap,
		gini,
		mortaliy_under5
	FROM
		economies e
	WHERE
		`year` = '2018' ) hdp_2020 ON
	ct.country = hdp_2020.country
LEFT JOIN (
	SELECT
		city,
		`date`,
		AVG(REPLACE(temp, ' °c', '')) AS average_daily_temp,
		SUM(REPLACE(rain, ' mm', '')) AS rain_per_day,
		MAX(gust) AS gust_per_day
	FROM
		weather w
	WHERE
		city IS NOT NULL
		AND 
	(`time` = '06:00'
			OR `time` = '09:00'
			OR `time` = '12:00'
			OR `time` = '15:00'
			OR `time` = '18:00' )
	GROUP BY
		city,
		`date`) w_source ON
	c_source.capital_city = w_source.city
	AND ct.`date` = w_source.`date`
LEFT JOIN (
	SELECT
		country,
		`year`,
		AVG(life_expectancy) AS avg_life
	FROM
		life_expectancy
	WHERE
		`YEAR` BETWEEN 1950 AND 2015
	GROUP BY
		country) life_source ON
	ct.country = life_source.country
LEFT JOIN (
	SELECT
		country,
		population
	FROM
		religions r
	WHERE
		YEAR = '2020'
		AND religion = 'Christianity') rel_chris ON
	ct.country = rel_chris.country
LEFT JOIN (
	SELECT
		country,
		population
	FROM
		religions r
	WHERE
		YEAR = '2020'
		AND religion = 'Islam') rel_islam ON
	ct.country = rel_islam.country
LEFT JOIN (
	SELECT
		country,
		population
	FROM
		religions r
	WHERE
		YEAR = '2020'
		AND religion = 'Judaism') rel_Judaism ON
	ct.country = rel_Judaism.country
LEFT JOIN (
	SELECT
		country,
		population
	FROM
		religions r
	WHERE
		YEAR = '2020'
		AND religion = 'Unaffiliated Religions') rel_unaffiliated_religions ON
	ct.country = rel_unaffiliated_religions.country
LEFT JOIN (
	SELECT
		country,
		population
	FROM
		religions r
	WHERE
		YEAR = '2020'
		AND religion = 'Hinduism') rel_hinduism ON
	ct.country = rel_hinduism.country
LEFT JOIN (
	SELECT
		country,
		population
	FROM
		religions r
	WHERE
		YEAR = '2020'
		AND religion = 'Buddhism') rel_buddhism ON
	ct.country = rel_buddhism.country
LEFT JOIN (
	SELECT
		country,
		population
	FROM
		religions r
	WHERE
		YEAR = '2020'
		AND religion = 'Folk Religions') rel_Folk_Religions ON
	ct.country = rel_Folk_Religions.country
LEFT JOIN (
	SELECT
		country,
		population
	FROM
		religions r
	WHERE
		YEAR = '2020'
		AND religion = 'Other Religions') rel_Other_Religions ON
	ct.country = rel_Other_Religions.country;