# Engeto_datova_analyza
SQL, py.
PROJEKT SQL ENGETO / POPIS
Snažím se určit faktory, které ovlivňují rychlost šíření koronaviru na úrovni jednotlivých států. Chtěl bych Vás, coby datového analytika, požádat o pomoc s přípravou dat, která potom budu statisticky zpracovávat. Prosím Vás o dodání dat podle požadavků sepsaných níže.
Výsledná data budou panelová, klíče budou stát (country) a den (date). Budu vyhodnocovat model, který bude vysvětlovat denní nárůsty nakažených v jednotlivých zemích. Samotné počty nakažených mi nicméně nejsou nic platné - je potřeba vzít v úvahu také počty provedených testů a počet obyvatel daného státu. Z těchto tří proměnných je potom možné vytvořit vhodnou vysvětlovanou proměnnou. Denní počty nakažených chci vysvětlovat pomocí proměnných několika typů. Každý sloupec v tabulce bude představovat jednu proměnnou. 
Pri tvorbe SQL tabulky t_peter_hudak_projekt_sql_final som postupoval:
-	Rychlost tvorby = 51.581sec
-	Pomocne tabulky = nie, vsetko robene cez JOIN
-	Chybajuce data v zdrojovych tabulkach oznacene NULL
-	Pouzite tabulky: countries, economies, life_expectancy, religions, covid19_basic_differences, covid19_testing, weather, lookup_table.

KLUCE
  -	klíče budou stát (country) a den (date)
  	#L3  - #L4 tvorba klucov (country a date) z tab  covid19_tests ct   

STLPCE KTORE POTREBUJEME ZISKAT
Časové proměnné
1.	Work_day = binární proměnná pro víkend / pracovní den (WEEK / NO_WEEK)
  	#L5 - #L8 udaje z  ‚date‘  stlpca  z tab  covid19_tests ct  

2.	Season = roční období daného dne (zakódujte prosím jako 0 až 3)
  	#L9 - #L14  udaje z  ‚date‘  stlpca  z tab  covid19_tests ct  
  	Rocne obdobia rozdelene podla mesiacov  roku
    i.	0 = JAN – MAR (zima)
    ii.	1 = APR – JUN (jar)
    iii.	2 = JUL – SEPT (leto)
    iv.	3 = OKT – DEC (jesen)

Proměnné specifické pro daný stát

3.	‚tests_performed‘  = počty provedených testů
  	#L15 udaje z tab covid19_tests ct   
  	Chybajuce hodnoty oznacene NULL

4.	‚ population_density‘ = hustota zalidnění - ve státech s vyšší hustotou zalidnění se nákaza může šířit rychleji
  	#L16 pomocny stlpec „capital city’ z tab countries (L38 – L46). Potrebne k tvorbe pocasia
  	#L16  ziskanie udajov  z tab countries (L38 – L46)

5.	‚ population‘ = pocet obyvatelov statui
  	#L17  ziskanie udajov  z tab countries (L38 – L46)

6.	`HDP na obyvatela‘  = použijeme jako indikátor ekonomické vyspělosti státu
  	#L18  ziskanie udajov  z tab economies (L48 – L58)

7.	‚GINI‘ = GINI koeficient - má majetková nerovnost vliv na šíření koronaviru?
  	#L19 ziskanie udajov  z tab economies (L48  – L58)

8.	‚mortaliy_under5‘  = dětská úmrtnost - použijeme jako indikátor kvality zdravotnictví
  	#L20 ziskanie udajov  z tab economies (L48 – L58)

9.	‚median_age_2018‘ = medián věku obyvatel v roce 2018 - státy se starším obyvatelstvem mohou být postiženy více
  	#L21  ziskanie udajov  z tab countries (L38 – L46).

10.	podíly jednotlivých náboženství - použijeme jako proxy proměnnou pro kulturní specifika. Pro každé náboženství v daném státě bych chtěl procentní podíl jeho příslušníků na celkovém obyvatelstvu
  	#L22 - #L29 stlpce s nabozenstvami
  	ziskanie udajov  (L95 – L173)

11.	‚avg_life‘ = rozdíl mezi očekávanou dobou dožití v roce 1965 a v roce 2015 - státy, ve kterých proběhl rychlý rozvoj mohou reagovat jinak než země, které jsou vyspělé už delší dobu
  	#L30 ziskanie udajov  z tab economies (L84 – L94)


Počasí (ovlivňuje chování lidí a také schopnost šíření viru)

12.	‚capital_city‘ = pomocny stlpec k JOIN pocasia
  	#L31 ziskanie udajov  z tab economies (L40 – L48)

13.	‚average_daily_temp‘  =   průměrná denní (nikoli noční!) teplota
  	Teplota v case 9:00 do 18:00
  	#L32 ziskanie udajov  z tab economies (L62 – L82)

14.	‚rain_per_day ‚ = počet hodin v daném dni, kdy byly srážky nenulové
  	#L33 ziskanie udajov  z tab economies (L62 – L82)

15.	‚gust_per_day‘ =  maximální síla větru v nárazech během dne
  	#L34 ziskanie udajov  z tab economies (L62 – L82)


VYSTUP
-	tabulka na databázi t_peter_hudak_projekt_sql_final, ze které se požadovaná data dají získat jedním selectem. 

POZNAMKA
Na svém GitHub účtu vytvořte repozitář (může být soukromý), kam uložíte všechny informace k projektu - hlavně SQL skript generující výslednou tabulku, popis mezivýsledků, informace o výstupních datech (například kde chybí hodnoty apod.). Případné pomocné tabulky neukládejte na DB jako view! Vždy vytvořte novou tabulku (z důvodu anonymity).
