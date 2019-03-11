ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  @@stub_match = {"id"=>14319721, "parsed_id"=>14309450, "filename"=>"122ffe06-c803-beab-83b6-819e0fbae780", "size"=>764909, "game_type"=>"HeroLeague", "game_date"=>"2019-02-01 04:13:44", "game_map"=>"Alterac Pass", "game_length"=>1016, "game_version"=>"2.42.2.71931", "fingerprint"=>"122ffe06-c803-beab-83b6-819e0fbae780", "region"=>1, "processed"=>true, "deleted"=>false, "url"=>"http://hotsapi.s3-website-eu-west-1.amazonaws.com/122ffe06-c803-beab-83b6-819e0fbae780.StormReplay", "created_at"=>"2019-02-01 04:14:10", "updated_at"=>"2019-02-01 04:14:13", "bans"=>[["Kael'thas", "Mal'Ganis", nil], ["Orphea", "Stukov", "Tracer"]], "players"=>[{"hero"=>"Gul'dan", "hero_level"=>15, "team"=>0, "winner"=>true, "blizz_id"=>311972, "party"=>0, "silenced"=>false, "battletag"=>"LayjaylaGoos#1862", "talents"=>{"1"=>"GuldanCorruptionEchoedCorruption", "4"=>"GuldanLifeTapImprovedLifeTap", "7"=>"GuldanFelFlameBoundByShadow", "10"=>"GuldanHorrify", "13"=>"GuldanFelFlameFelArmor", "16"=>"GuldanCorruptionRuinousAffliction"}, "score"=>{"level"=>20, "kills"=>3, "assists"=>17, "takedowns"=>20, "deaths"=>2, "highest_kill_streak"=>9, "hero_damage"=>62958, "siege_damage"=>98584, "structure_damage"=>26564, "minion_damage"=>64080, "creep_damage"=>20474, "summon_damage"=>7940, "time_cc_enemy_heroes"=>15252, "healing"=>15573, "self_healing"=>15444, "damage_taken"=>25939, "experience_contribution"=>8102, "town_kills"=>4, "time_spent_dead"=>66, "merc_camp_captures"=>0, "watch_tower_captures"=>0, "meta_experience"=>74881}}, {"hero"=>"Malthael", "hero_level"=>20, "team"=>0, "winner"=>true, "blizz_id"=>540716, "party"=>0, "silenced"=>false, "battletag"=>"GoremayChef#1749", "talents"=>{"1"=>"MalthaelOnAPaleHorse", "4"=>"MalthaelDieAlone", "7"=>"MalthaelColdHand", "10"=>"MalthaelLastRites", "13"=>"MalthaelSoulSiphon", "16"=>"MalthaelSoulCollector", "20"=>"MalthaelAngelOfDeath"}, "score"=>{"level"=>20, "kills"=>9, "assists"=>11, "takedowns"=>20, "deaths"=>4, "highest_kill_streak"=>9, "hero_damage"=>42439, "siege_damage"=>77442, "structure_damage"=>9596, "minion_damage"=>57359, "creep_damage"=>16929, "summon_damage"=>10487, "time_cc_enemy_heroes"=>122, "healing"=>15650, "self_healing"=>15538, "damage_taken"=>52933, "experience_contribution"=>9912, "town_kills"=>3, "time_spent_dead"=>146, "merc_camp_captures"=>1, "watch_tower_captures"=>0, "meta_experience"=>74881}}, {"hero"=>"Azmodan", "hero_level"=>20, "team"=>1, "winner"=>false, "blizz_id"=>840873, "party"=>0, "silenced"=>false, "battletag"=>"volatile#1118", "talents"=>{"1"=>"AzmodanWrath", "4"=>"AzmodanBattleborn", "7"=>"AzmodanBombardment", "10"=>"AzmodanTideOfSin", "13"=>"AzmodanChainOfCommand", "16"=>"AzmodanTotalAnnihilation"}, "score"=>{"level"=>17, "kills"=>3, "assists"=>8, "takedowns"=>11, "deaths"=>4, "highest_kill_streak"=>5, "hero_damage"=>64119, "siege_damage"=>77434, "structure_damage"=>4837, "minion_damage"=>72597, "creep_damage"=>10395, "summon_damage"=>0, "time_cc_enemy_heroes"=>15253, "healing"=>nil, "self_healing"=>0, "damage_taken"=>38919, "experience_contribution"=>9695, "town_kills"=>0, "time_spent_dead"=>113, "merc_camp_captures"=>1, "watch_tower_captures"=>0, "meta_experience"=>59533}}, {"hero"=>"Mephisto", "hero_level"=>20, "team"=>1, "winner"=>false, "blizz_id"=>889335, "party"=>0, "silenced"=>false, "battletag"=>"Sauveur#1284", "talents"=>{"1"=>"MephistoSkullMissileUnyieldingPower", "4"=>"MephistoSkullMissileHatefulMending", "7"=>"MephistoShadeOfMephistoGhastlyArmor", "10"=>"MephistoConsumeSouls", "13"=>"MephistoSkullMissileAbhorredSkull", "16"=>"MephistoLightningNovaStaticField"}, "score"=>{"level"=>17, "kills"=>1, "assists"=>7, "takedowns"=>8, "deaths"=>1, "highest_kill_streak"=>5, "hero_damage"=>56543, "siege_damage"=>76458, "structure_damage"=>1905, "minion_damage"=>74553, "creep_damage"=>3612, "summon_damage"=>0, "time_cc_enemy_heroes"=>190, "healing"=>nil, "self_healing"=>8627, "damage_taken"=>34855, "experience_contribution"=>9057, "town_kills"=>0, "time_spent_dead"=>29, "merc_camp_captures"=>0, "watch_tower_captures"=>0, "meta_experience"=>59533}}, {"hero"=>"Thrall", "hero_level"=>20, "team"=>1, "winner"=>false, "blizz_id"=>1451302, "party"=>0, "silenced"=>false, "battletag"=>"enerathus#1298", "talents"=>{"1"=>"ThrallEchooftheElements", "4"=>"ThrallFeralResilience", "7"=>"GenericTalentFollowThrough", "10"=>"ThrallHeroicAbilityEarthquake", "13"=>"ThrallMasteryFrostwolfsGrace", "16"=>"ThrallAlphaWolf"}, "score"=>{"level"=>17, "kills"=>4, "assists"=>5, "takedowns"=>9, "deaths"=>6, "highest_kill_streak"=>5, "hero_damage"=>38232, "siege_damage"=>46537, "structure_damage"=>0, "minion_damage"=>46537, "creep_damage"=>24155, "summon_damage"=>0, "time_cc_enemy_heroes"=>98, "healing"=>18270, "self_healing"=>18238, "damage_taken"=>47804, "experience_contribution"=>8939, "town_kills"=>0, "time_spent_dead"=>186, "merc_camp_captures"=>2, "watch_tower_captures"=>0, "meta_experience"=>59533}}, {"hero"=>"Li Li", "hero_level"=>20, "team"=>0, "winner"=>true, "blizz_id"=>4803991, "party"=>0, "silenced"=>false, "battletag"=>"LastSacred#1265", "talents"=>{"1"=>"LiLiFreeDrinks", "4"=>"LiLiHinderingWinds", "7"=>"LiLiMasteryHealingBrewTheGoodStuff", "10"=>"LiLiHeroicAbilityJugof1000Cups", "13"=>"LiLiMasteryBlindingWindGaleForce", "16"=>"LiLiMasteryHealingBrewTwoForOne", "20"=>"LiLiMistweaver"}, "score"=>{"level"=>20, "kills"=>2, "assists"=>19, "takedowns"=>21, "deaths"=>2, "highest_kill_streak"=>9, "hero_damage"=>21227, "siege_damage"=>18376, "structure_damage"=>3534, "minion_damage"=>11456, "creep_damage"=>7156, "summon_damage"=>3386, "time_cc_enemy_heroes"=>55, "healing"=>85988, "self_healing"=>0, "damage_taken"=>30093, "experience_contribution"=>7285, "town_kills"=>3, "time_spent_dead"=>63, "merc_camp_captures"=>0, "watch_tower_captures"=>0, "meta_experience"=>74881}}, {"hero"=>"Diablo", "hero_level"=>8, "team"=>0, "winner"=>true, "blizz_id"=>4918015, "party"=>0, "silenced"=>false, "battletag"=>"TalliaSkye#1692", "talents"=>{"1"=>"DiabloMasteryFeastOnFearBlackSoulstone", "4"=>"DiabloFireStompSoulsToTheFlame", "7"=>"DiabloShadowChargeOverpowerEternalFlames", "10"=>"DiabloHeroicAbilityLightningBreath", "13"=>"DiabloHellfire", "16"=>"DiabloDebilitatingFlames", "20"=>"DiabloHellgate"}, "score"=>{"level"=>20, "kills"=>2, "assists"=>16, "takedowns"=>18, "deaths"=>2, "highest_kill_streak"=>8, "hero_damage"=>32074, "siege_damage"=>53067, "structure_damage"=>8987, "minion_damage"=>37996, "creep_damage"=>8724, "summon_damage"=>6084, "time_cc_enemy_heroes"=>114, "healing"=>11937, "self_healing"=>23579, "damage_taken"=>81539, "experience_contribution"=>10944, "town_kills"=>4, "time_spent_dead"=>10, "merc_camp_captures"=>0, "watch_tower_captures"=>0, "meta_experience"=>74881}}, {"hero"=>"Muradin", "hero_level"=>20, "team"=>1, "winner"=>false, "blizz_id"=>5307137, "party"=>0, "silenced"=>false, "battletag"=>"annigator#1923", "talents"=>{"1"=>"MuradinStormboltPerfectStorm", "4"=>"MuradinMasteryThunderburn", "7"=>"MuradinMasteryDwarfTossHeavyImpact", "10"=>"MuradinHeroicAbilityAvatar", "13"=>"MuradinMasteryThunderclapHealingStatic", "16"=>"MuradinMasteryPassiveStoneform"}, "score"=>{"level"=>17, "kills"=>1, "assists"=>6, "takedowns"=>7, "deaths"=>5, "highest_kill_streak"=>6, "hero_damage"=>24157, "siege_damage"=>11897, "structure_damage"=>0, "minion_damage"=>11897, "creep_damage"=>9519, "summon_damage"=>0, "time_cc_enemy_heroes"=>238, "healing"=>16604, "self_healing"=>16496, "damage_taken"=>70466, "experience_contribution"=>4471, "town_kills"=>0, "time_spent_dead"=>172, "merc_camp_captures"=>2, "watch_tower_captures"=>0, "meta_experience"=>59533}}, {"hero"=>"Artanis", "hero_level"=>20, "team"=>0, "winner"=>true, "blizz_id"=>5883416, "party"=>0, "silenced"=>false, "battletag"=>"DukeBacchus#1859", "talents"=>{"1"=>"GenericTalentSeasonedMarksman", "4"=>"ArtanisShieldOverloadShieldBattery", "7"=>"GenericTalentFollowThrough", "10"=>"ArtanisHeroicAbilitySpearofAdunPurifierBeam", "13"=>"ArtanisTwinBladesTripleStrike", "16"=>"ArtanisTwinBladesTitanKiller", "20"=>"ArtanisPlasmaBurn"}, "score"=>{"level"=>20, "kills"=>6, "assists"=>15, "takedowns"=>21, "deaths"=>2, "highest_kill_streak"=>8, "hero_damage"=>47120, "siege_damage"=>62351, "structure_damage"=>20887, "minion_damage"=>36484, "creep_damage"=>23880, "summon_damage"=>4980, "time_cc_enemy_heroes"=>15252, "healing"=>nil, "self_healing"=>21797, "damage_taken"=>61323, "experience_contribution"=>9663, "town_kills"=>4, "time_spent_dead"=>64, "merc_camp_captures"=>1, "watch_tower_captures"=>0, "meta_experience"=>74881}}, {"hero"=>"Malfurion", "hero_level"=>14, "team"=>1, "winner"=>false, "blizz_id"=>6520606, "party"=>0, "silenced"=>false, "battletag"=>"Dachsung#1444", "talents"=>{"1"=>"MalfurionCelestialAlignment", "4"=>"MalfurionMasteryStranglingVinesEntanglingRoots", "7"=>"MalfurionNaturesCureRegrowth", "10"=>"MalfurionHeroicAbilityTranquility", "13"=>"MalfurionRegrowthNaturesSwiftness", "16"=>"MalfurionRegrowthNaturesBalance"}, "score"=>{"level"=>17, "kills"=>2, "assists"=>6, "takedowns"=>8, "deaths"=>6, "highest_kill_streak"=>6, "hero_damage"=>15322, "siege_damage"=>8814, "structure_damage"=>202, "minion_damage"=>8612, "creep_damage"=>8109, "summon_damage"=>0, "time_cc_enemy_heroes"=>21, "healing"=>50368, "self_healing"=>0, "damage_taken"=>26141, "experience_contribution"=>4619, "town_kills"=>0, "time_spent_dead"=>201, "merc_camp_captures"=>3, "watch_tower_captures"=>0, "meta_experience"=>59533}}]}

  @@stub_draft_props = {
    map: "Alterac Pass",
    bans: ["Malthael", "Gul'dan", "Azmodan", "Mephisto"],
    with_heroes: ["Thrall", "Li Li"],
    against_heroes: ["Diablo", "Muradin", "Artanis"]
  }
end
