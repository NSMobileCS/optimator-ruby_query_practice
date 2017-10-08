def all_players_loop
    players = []
    queries = 1 #since we do Player.all on the next line
    for p in Player.all
        players.push({:teamname=>p.team.name, :teammascot=>p.team.mascot, :stadium=>p.team.stadium})
        queries += 1 #unless it actually has to do 3? console only shows sql query happening once i think..
        end
    puts "Queries: #{ queries }"
    players
end

##Leads to at least 580 queries (perhaps even 1738?)

#########################################################################

2.3.1 :030 > players = Player.includes(:team)
Player Load (10.9ms)  SELECT "players".* FROM "players"
Team Load (4.2ms)  SELECT "teams".* FROM "teams" WHERE "teams"."id" IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30)
for p in players
    puts "#{ p.name } |===> #{ p.team.name } #{ p.team.mascot } #{ p.team.stadium }"
end

##Makes it only 2 queries


#########################################################################

#########################################################################

#########################################################################

#########################################################################



#players on the chicago bulls
2.3.1 :015 > bulls_players = Player.joins(:team).where("teams.name='Chicago Bulls'")
Player Load (15.1ms)  SELECT "players".* FROM "players" INNER JOIN "teams" ON "teams"."id" = "players"."team_id" WHERE (teams.name='Chicago Bulls')
+----+-------------------+---------+--------------------+---------------------+
| id | name              | team_id | created_at         | updated_at          |
+----+-------------------+---------+--------------------+---------------------+
| 78 | Ryan Arcidiacono  | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 79 | Antonio Blakeney  | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 80 | Kris Dunn         | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 81 | Jarell Eddie      | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 82 | Cristiano Felicio | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 83 | Jerian Grant      | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 84 | Justin Holiday    | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 85 | Jaylen Johnson    | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 86 | Bronson Koenig    | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 87 | Zach LaVine       | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 88 | Robin Lopez       | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 89 | Lauri Markkanen   | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 90 | Nikola Mirotic    | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 91 | David Nwaba       | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 92 | Cameron Payne     | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 93 | Quincy Pondexter  | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 94 | Bobby Portis      | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 95 | Diamond Stone     | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 96 | Denzel Valentine  | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
| 97 | Paul Zipser       | 5       | 2017-10-07 20:0... | 2017-10-07 20:06... |
+----+-------------------+---------+--------------------+---------------------+
20 rows in set
2.3.1 :016 > 


#########################################################################

#########################################################################

#########################################################################

#########################################################################


2.3.1 :037 > st_ctr_teams = Team.includes(:players).where(stadium: 'Staples Center')      
Team Load (3.8ms)  SELECT "teams".* FROM "teams" WHERE "teams"."stadium" = ?  [["stadium", "Staples Center"]]
Player Load (4.3ms)  SELECT "players".* FROM "players" WHERE "players"."team_id" IN (13, 14)
+----+--------------+-------------+--------------+-------------+--------------+
| id | name         | mascot      | stadium      | created_at  | updated_at   |
+----+--------------+-------------+--------------+-------------+--------------+
| 13 | Los Angel... | Chuck       | Staples C... | 2017-10-... | 2017-10-0... |
| 14 | Los Angel... | Jack Nic... | Staples C... | 2017-10-... | 2017-10-0... |
+----+--------------+-------------+--------------+-------------+--------------+
2 rows in set
2.3.1 :038 > for team in st_ctr_teams
2.3.1 :039?>   for player in team.players
2.3.1 :040?>     puts "#{ player.name } #{ player.team.name } (@Staples Center)"
2.3.1 :041?>     end
2.3.1 :042?>   end
Patrick Beverley Los Angeles Clippers (@Staples Center)
Sam Dekker Los Angeles Clippers (@Staples Center)
Jawun Evans Los Angeles Clippers (@Staples Center)
Danilo Gallinari Los Angeles Clippers (@Staples Center)
Blake Griffin Los Angeles Clippers (@Staples Center)
Montrezl Harrell Los Angeles Clippers (@Staples Center)
LaDontae Henton Los Angeles Clippers (@Staples Center)
Brice Johnson Los Angeles Clippers (@Staples Center)
Wesley Johnson Los Angeles Clippers (@Staples Center)
DeAndre Jordan Los Angeles Clippers (@Staples Center)
Marshall Plumlee Los Angeles Clippers (@Staples Center)
Willie Reed Los Angeles Clippers (@Staples Center)
Austin Rivers Los Angeles Clippers (@Staples Center)
Milos Teodosic Los Angeles Clippers (@Staples Center)
Sindarius Thornwell Los Angeles Clippers (@Staples Center)
Tyrone Wallace Los Angeles Clippers (@Staples Center)
C.J. Williams Los Angeles Clippers (@Staples Center)
Lou Williams Los Angeles Clippers (@Staples Center)
Jamil Wilson Los Angeles Clippers (@Staples Center)
Lonzo Ball Los Angeles Lakers (@Staples Center)
V.J. Beachem Los Angeles Lakers (@Staples Center)
Vander Blue Los Angeles Lakers (@Staples Center)
Andrew Bogut Los Angeles Lakers (@Staples Center)
Corey Brewer Los Angeles Lakers (@Staples Center)
Thomas Bryant Los Angeles Lakers (@Staples Center)
Kentavious Caldwell-Pope Los Angeles Lakers (@Staples Center)
Alex Caruso Los Angeles Lakers (@Staples Center)
Jordan Clarkson Los Angeles Lakers (@Staples Center)
Luol Deng Los Angeles Lakers (@Staples Center)
Tyler Ennis Los Angeles Lakers (@Staples Center)
Josh Hart Los Angeles Lakers (@Staples Center)
Brandon Ingram Los Angeles Lakers (@Staples Center)
Kyle Kuzma Los Angeles Lakers (@Staples Center)
Brook Lopez Los Angeles Lakers (@Staples Center)
Larry Nance Jr. Los Angeles Lakers (@Staples Center)
Julius Randle Los Angeles Lakers (@Staples Center)
Briante Weber Los Angeles Lakers (@Staples Center)
Stephen Zimmerman Los Angeles Lakers (@Staples Center)
Ivica Zubac Los Angeles Lakers (@Staples Center)
+----+--------------+-------------+--------------+-------------+--------------+
| id | name         | mascot      | stadium      | created_at  | updated_at   |
+----+--------------+-------------+--------------+-------------+--------------+
| 13 | Los Angel... | Chuck       | Staples C... | 2017-10-... | 2017-10-0... |
| 14 | Los Angel... | Jack Nic... | Staples C... | 2017-10-... | 2017-10-0... |
+----+--------------+-------------+--------------+-------------+--------------+
2 rows in set
2.3.1 :043 > 

