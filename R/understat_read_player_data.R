library(worldfootballR)
library(dplyr)

df_manchester_city <- worldfootballR::understat_team_players_stats("https://understat.com/team/Manchester_City/2023")
df_liverpool <- worldfootballR::understat_team_players_stats("https://understat.com/team/Liverpool/2023")
df_arsenal <- worldfootballR::understat_team_players_stats("https://understat.com/team/Arsenal/2023")
df_tottenham <- worldfootballR::understat_team_players_stats("https://understat.com/team/Tottenham/2023")
df_aston_villa <- worldfootballR::understat_team_players_stats("https://understat.com/team/Aston_Villa/2023")
df_brighton <- worldfootballR::understat_team_players_stats("https://understat.com/team/Brighton/2023")
df_west_ham <- worldfootballR::understat_team_players_stats("https://understat.com/team/West_Ham/2023")
df_newcastle_united <- worldfootballR::understat_team_players_stats("https://understat.com/team/Newcastle_United/2023")
df_crystal_palace <- worldfootballR::understat_team_players_stats("https://understat.com/team/Crystal_Palace/2023")
df_manchester_united <- worldfootballR::understat_team_players_stats("https://understat.com/team/Manchester_United/2023")
df_chelsea <- worldfootballR::understat_team_players_stats("https://understat.com/team/Chelsea/2023")
df_nottingham_forest <- worldfootballR::understat_team_players_stats("https://understat.com/team/Nottingham_Forest/2023")
df_fulham <- worldfootballR::understat_team_players_stats("https://understat.com/team/Fulham/2023")
df_brentford <- worldfootballR::understat_team_players_stats("https://understat.com/team/Brentford/2023")
df_wolves <- worldfootballR::understat_team_players_stats("https://understat.com/team/Wolverhampton_Wanderers/2023")
df_everton <- worldfootballR::understat_team_players_stats("https://understat.com/team/Everton/2023")
df_luton <- worldfootballR::understat_team_players_stats("https://understat.com/team/Luton/2023")
df_burnley <- worldfootballR::understat_team_players_stats("https://understat.com/team/Burnley/2023")
df_bournemouth <- worldfootballR::understat_team_players_stats("https://understat.com/team/Bournemouth/2023")
df_sheffield_united <- worldfootballR::understat_team_players_stats("https://understat.com/team/Sheffield_United/2023")

df_understat_players <- rbind(df_manchester_city, df_liverpool, df_arsenal, df_tottenham, df_aston_villa, 
                              df_brighton, df_west_ham, df_newcastle_united, df_crystal_palace, df_manchester_united, 
                              df_chelsea, df_nottingham_forest, df_fulham, df_brentford, df_wolves,
                              df_everton, df_luton, df_burnley, df_bournemouth, df_sheffield_united) %>%
  dplyr::mutate(npxG90 = npxG/time*90,
                xA90 = xA/time*90,
                npxG_plus_xA90 = npxG90 + xA90) %>%
  dplyr::arrange(desc(npxG_plus_xA90)) %>%
  dplyr::filter(time > 270) %>%
  select(player_name, team_name, games, time, goals, assists, shots, key_passes, xG, xA, npxG, npxG90, xA90, npxG_plus_xA90)

write.csv(df_understat_players, "data/understat_player_data.csv")
