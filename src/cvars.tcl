## GamemodeConfig from csvars
variable gameModeConfigcsvars [CreateConfig \
[list \
name "gameModeConfigcsvars" \
prefix "gameModeConfigcsvarslist" \
filename "" \
saveProc "SaveConfigFileDummy" \
] \
[list \
"string"  [list "achievement_debug" "0" "CHEAT:Turn on achievement debug msgs."] \
"string"  [list "achievement_disable" "0" "CHEAT:Turn off achievements."] \
"string"  [list "adsp_debug" "0" ""] \
"string"  [list "ai_debug_los" "0" "CHEAT:NPC Line-Of-Sight debug mode. If 1, solid entities that block NPC LOC will be highlighted with white bounding boxes. If 2, it'l"] \
"string"  [list "ai_debug_shoot_positions" "0" "CHEAT:"] \
"string"  [list "ai_drawbattlelines" "0" "CHEAT:"] \
"string"  [list "ai_report_task_timings_on_limit" "0" ""] \
"string"  [list "ai_think_limit_label" "0" ""] \
"string"  [list "ai_vehicle_avoidance" "1" "CHEAT:"] \
"string"  [list "ammo_338mag_max" "30" ""] \
"string"  [list "ammo_357sig_max" "52" ""] \
"string"  [list "ammo_357sig_min_max" "12" ""] \
"string"  [list "ammo_357sig_p250_max" "26" ""] \
"string"  [list "ammo_357sig_small_max" "24" ""] \
"string"  [list "ammo_45acp_max" "100" ""] \
"string"  [list "ammo_50AE_max" "35" ""] \
"string"  [list "ammo_556mm_box_max" "200" ""] \
"string"  [list "ammo_556mm_max" "90" ""] \
"string"  [list "ammo_556mm_small_max" "40" ""] \
"string"  [list "ammo_57mm_max" "100" ""] \
"string"  [list "ammo_762mm_max" "90" ""] \
"string"  [list "ammo_9mm_max" "120" ""] \
"string"  [list "ammo_buckshot_max" "32" ""] \
"string"  [list "ammo_grenade_limit_default" "1" ""] \
"string"  [list "ammo_grenade_limit_flashbang" "1" ""] \
"string"  [list "ammo_grenade_limit_total" "3" ""] \
"string"  [list "ammo_item_limit_healthshot" "4" ""] \
"string"  [list "anim_twistbones_enabled" "0" "CHEAT:Enable procedural twist bones."] \
"string"  [list "bot_allow_grenades" "1" "If nonzero, bots may use grenades."] \
"string"  [list "bot_allow_machine_guns" "1" "If nonzero, bots may use the machine gun."] \
"string"  [list "bot_allow_pistols" "1" "If nonzero, bots may use pistols."] \
"string"  [list "bot_allow_rifles" "1" "If nonzero, bots may use rifles."] \
"string"  [list "bot_allow_rogues" "1" "If nonzero, bots may occasionally go 'rogue'. Rogue bots do not obey radio commands, nor pursue scenario goals."] \
"string"  [list "bot_allow_shotguns" "1" "If nonzero, bots may use shotguns."] \
"string"  [list "bot_allow_snipers" "1" "If nonzero, bots may use sniper rifles."] \
"string"  [list "bot_allow_sub_machine_guns" "1" "If nonzero, bots may use sub-machine guns."] \
"string"  [list "bot_autodifficulty_threshold_high" "0" "Upper bound above Average Human Contribution Score that a bot must be above to change its difficulty"] \
"string"  [list "bot_autodifficulty_threshold_low" "-2" "Lower bound below Average Human Contribution Score that a bot must be below to change its difficulty"] \
"string"  [list "bot_chatter" "0" "Control how bots talk. Allowed values: 'off', 'radio', 'minimal', or 'normal'."] \
"string"  [list "bot_coop_force_throw_grenade_chance" "0" "CHEAT:"] \
"string"  [list "bot_coop_idle_max_vision_distance" "1400" "CHEAT:Max distance bots can see targets (in coop) when they are idle, dormant, hiding or asleep."] \
"string"  [list "bot_crouch" "0" "CHEAT:"] \
"string"  [list "bot_debug" "0" "CHEAT:For internal testing purposes."] \
"string"  [list "bot_debug_target" "0" "CHEAT:For internal testing purposes."] \
"string"  [list "bot_defer_to_human_goals" "0" "If nonzero and there is a human on the team, the bots will not do the scenario tasks."] \
"string"  [list "bot_defer_to_human_items" "1" "If nonzero and there is a human on the team, the bots will not get scenario items."] \
"string"  [list "bot_difficulty" "3" "Defines the skill of bots joining the game. Values are: 0=easy, 1=normal, 2=hard, 3=expert."] \
"string"  [list "bot_dont_shoot" "0" "CHEAT:If nonzero, bots will not fire weapons (for debugging)."] \
"string"  [list "bot_freeze" "0" "CHEAT:"] \
"string"  [list "bot_ignore_players" "0" "CHEAT:Bots will not see non-bot players."] \
"string"  [list "bot_join_after_player" "1" "If nonzero, bots wait until a player joins before entering the game."] \
"string"  [list "bot_join_team" "0" "Determines the team bots will join into. Allowed values: 'any', 'T', or 'CT'."] \
"string"  [list "bot_loadout" "0" "CHEAT:bots are given these items at round start"] \
"string"  [list "bot_max_vision_distance_override" "-1" "CHEAT:Max distance bots can see targets."] \
"string"  [list "bot_mimic" "0" "CHEAT:"] \
"string"  [list "bot_mimic_yaw_offset" "180" "CHEAT:"] \
"string"  [list "bot_quota" "4" "Determines the total number of bots in the game."] \
"string"  [list "bot_quota_mode" "0" "Determines the type of quota.Allowed values: 'normal', 'fill', and 'match'.If 'fill', the server will adjust bots to keep N p"] \
"string"  [list "bot_randombuy" "0" "CHEAT:should bots ignore their prefered weapons and just buy weapons at random?"] \
"string"  [list "bot_show_battlefront" "0" "CHEAT:Show areas where rushing players will initially meet."] \
"string"  [list "bot_show_nav" "0" "CHEAT:For internal testing purposes."] \
"string"  [list "bot_show_occupy_time" "0" "CHEAT:Show when each nav area can first be reached by each team."] \
"string"  [list "bot_stop" "0" "CHEAT:If nonzero, immediately stops all bot processing."] \
"string"  [list "bot_traceview" "0" "CHEAT:For internal testing purposes."] \
"string"  [list "bot_zombie" "0" "CHEAT:If nonzero, bots will stay in idle mode and not attack."] \
"string"  [list "budget_averages_window" "30" "number of frames to look at when figuring out average frametimes"] \
"string"  [list "budget_background_alpha" "128" "how translucent the budget panel is"] \
"string"  [list "budget_bargraph_background_alpha" "128" "how translucent the budget panel is"] \
"string"  [list "budget_bargraph_range_ms" "16" "budget bargraph range in milliseconds"] \
"string"  [list "budget_history_numsamplesvisible" "100" "number of samples to draw in the budget history window. The lower the better as far as rendering overhead of the budget panel"] \
"string"  [list "budget_history_range_ms" "66" "budget history range in milliseconds"] \
"string"  [list "budget_panel_bottom_of_history_fraction" "0" "number between 0 and 1"] \
"string"  [list "budget_panel_height" "384" "height in pixels of the budget panel"] \
"string"  [list "budget_panel_width" "512" "width in pixels of the budget panel"] \
"string"  [list "budget_panel_x" "0" "number of pixels from the left side of the game screen to draw the budget panel"] \
"string"  [list "budget_panel_y" "50" "number of pixels from the top side of the game screen to draw the budget panel"] \
"string"  [list "budget_peaks_window" "30" "number of frames to look at when figuring out peak frametimes"] \
"string"  [list "budget_show_averages" "0" "enable/disable averages in the budget panel"] \
"string"  [list "budget_show_history" "1" "turn history graph off and on. . good to turn off on low end"] \
"string"  [list "budget_show_peaks" "1" "enable/disable peaks in the budget panel"] \
"string"  [list "bugreporter_uploadasync" "0" "Upload attachments asynchronously"] \
"string"  [list "bugreporter_username" "0" "Username to use for bugreporter"] \
"string"  [list "cash_player_bomb_defused" "200" ""] \
"string"  [list "cash_player_bomb_planted" "200" ""] \
"string"  [list "cash_player_damage_hostage" "-30" ""] \
"string"  [list "cash_player_get_killed" "0" ""] \
"string"  [list "cash_player_interact_with_hostage" "300" ""] \
"string"  [list "cash_player_killed_enemy_default" "200" ""] \
"string"  [list "cash_player_killed_enemy_factor" "0" ""] \
"string"  [list "cash_player_killed_hostage" "-1000" ""] \
"string"  [list "cash_player_killed_teammate" "-300" ""] \
"string"  [list "cash_player_rescued_hostage" "1000" ""] \
"string"  [list "cash_player_respawn_amount" "0" ""] \
"string"  [list "cash_team_elimination_bomb_map" "2700" ""] \
"string"  [list "cash_team_elimination_hostage_map_ct" "2300" ""] \
"string"  [list "cash_team_elimination_hostage_map_t" "2000" ""] \
"string"  [list "cash_team_hostage_alive" "0" ""] \
"string"  [list "cash_team_hostage_interaction" "500" ""] \
"string"  [list "cash_team_loser_bonus" "2400" ""] \
"string"  [list "cash_team_loser_bonus_consecutive_rounds" "0" ""] \
"string"  [list "cash_team_planted_bomb_but_defused" "200" ""] \
"string"  [list "cash_team_rescued_hostage" "0" ""] \
"string"  [list "cash_team_survive_guardian_wave" "1000" ""] \
"string"  [list "cash_team_terrorist_win_bomb" "2700" ""] \
"string"  [list "cash_team_win_by_defusing_bomb" "2700" ""] \
"string"  [list "cash_team_win_by_hostage_rescue" "3000" ""] \
"string"  [list "cash_team_win_by_time_running_out_bomb" "2700" ""] \
"string"  [list "cash_team_win_by_time_running_out_hostage" "2000" ""] \
"string"  [list "chet_debug_idle" "0" "If set one, many debug prints to help track down the TLK_IDLE issue. Set two for super verbose info"] \
"string"  [list "cl_allowdownload" "1" "Client downloads customization files"] \
"string"  [list "cl_allowupload" "1" "Client uploads customization files"] \
"string"  [list "cl_clock_correction" "1" "CHEAT:Enable/disable clock correction on the client."] \
"string"  [list "cl_clock_correction_adjustment_max_amount" "200" "CHEAT:Sets the maximum number of milliseconds per second it is allowed to correct the client clock. It will only correct this amount "] \
"string"  [list "cl_clock_correction_adjustment_max_offset" "90" "CHEAT:As the clock offset goes from cl_clock_correction_adjustment_min_offset to this value (in milliseconds), it moves towards apply"] \
"string"  [list "cl_clock_correction_adjustment_min_offset" "10" "CHEAT:If the clock offset is less than this amount (in milliseconds), then no clock correction is applied."] \
"string"  [list "cl_clock_correction_force_server_tick" "999" "CHEAT:Force clock correction to match the server tick + this offset (-999 disables it)."] \
"string"  [list "cl_clockdrift_max_ms" "150" "CHEAT:Maximum number of milliseconds the clock is allowed to drift before the client snaps its clock to the server's."] \
"string"  [list "cl_clockdrift_max_ms_threadmode" "0" "CHEAT:Maximum number of milliseconds the clock is allowed to drift before the client snaps its clock to the server's."] \
"string"  [list "cl_clock_showdebuginfo" "0" "CHEAT:Show debugging info about the clock drift. "] \
"string"  [list "cl_cmdrate" "64" "Max number of command packets sent to server per second"] \
"string"  [list "cl_color" "0" "Preferred teammate color"] \
"string"  [list "cl_debug_ugc_downloads" "0" ""] \
"string"  [list "cl_decryptdata_key" "0" "Key to decrypt encrypted GOTV messages"] \
"string"  [list "cl_decryptdata_key_pub" "0" "Key to decrypt public encrypted GOTV messages"] \
"string"  [list "cl_detail_scale" "2" "CHEAT:"] \
"string"  [list "cl_download_demoplayer" "1" "Determines whether downloads of external resources are allowed during demo playback (0:no,1:workshop,2:all)"] \
"string"  [list "cl_downloadfilter" "0" "Determines which files can be downloaded from the server (all, none, nosounds)"] \
"string"  [list "cl_entityreport" "0" "CHEAT:For debugging, draw entity states to console"] \
"string"  [list "cl_flushentitypacket" "0" "CHEAT:For debugging. Force the engine to flush an entity packet."] \
"string"  [list "cl_forcepreload" "0" "Whether we should force preloading."] \
"string"  [list "cl_hideserverip" "0" "If set to 1, server IPs will be hidden in the console (except when you type 'status')"] \
"string"  [list "clientport" "27005" "Host game client port"] \
"string"  [list "cl_ignorepackets" "0" "CHEAT:Force client to ignore packets (for debugging)."] \
"string"  [list "cl_interpolate" "1" "Enables or disables interpolation on listen servers or during demo playback"] \
"string"  [list "cl_logofile" "0" "Spraypoint logo decal."] \
"string"  [list "closecaption" "0" "Enable close captioning."] \
"string"  [list "cl_remove_old_ugc_downloads" "1" ""] \
"string"  [list "cl_resend" "2" "Delay in seconds before the client will resend the 'connect' attempt"] \
"string"  [list "cl_resend_timeout" "60" "Total time allowed for the client to resend the 'connect' attempt"] \
"string"  [list "cl_showevents" "0" "CHEAT:Print event firing info in the console"] \
"string"  [list "cl_showpluginmessages" "1" "Allow plugins to display messages to you"] \
"string"  [list "cl_skipslowpath" "0" "CHEAT:Set to 1 to skip any models that don't go through the model fast path"] \
"string"  [list "cl_soundfile" "0" "Jingle sound file."] \
"string"  [list "cl_steamdatagramtransport_debugticket_address" "0" "For debugging, generate our own (unsigned) ticket, using the specified gameserver address. Router must be configured to accept"] \
"string"  [list "cl_steamdatagramtransport_forceproxyaddr" "0" "Force the use of a particular set of proxy servers. Comma-separated list."] \
"string"  [list "cl_timeout" "30" "After this many seconds without receiving a packet from the server, the client will disconnect itself"] \
"string"  [list "cl_updaterate" "128" "Number of packets per second of updates you are requesting from the server"] \
"string"  [list "con_enable" "0" "Allows the console to be activated."] \
"string"  [list "con_filter_enable" "0" "Filters console output based on the setting of con_filter_text. 1 filters completely, 2 displays filtered text brighter than ot"] \
"string"  [list "con_filter_text" "0" "Text with which to filter console spew. Set con_filter_enable 1 or 2 to activate."] \
"string"  [list "con_filter_text_out" "0" "Text with which to filter OUT of console spew. Set con_filter_enable 1 or 2 to activate."] \
"string"  [list "con_logfile" "0" "Console output gets written to this file"] \
"string"  [list "cpu_frequency_monitoring" "0" "Set CPU frequency monitoring interval in seconds. Zero means disabled."] \
"string"  [list "cs_enable_player_physics_box" "0" ""] \
"string"  [list "cs_hostage_near_rescue_music_distance" "2000" "CHEAT:"] \
"string"  [list "cs_ShowStateTransitions" "-2" "CHEAT:cs_ShowStateTransitions <ent index or -1 for all>. Show player state transitions."] \
"string"  [list "CS_WarnFriendlyDamageInterval" "3" "CHEAT:Defines how frequently the server notifies clients that a player damaged a friend"] \
"string"  [list "custom_bot_difficulty" "0" "Bot difficulty for offline play."] \
"string"  [list "debug_map_crc" "0" "Prints CRC for each map lump loaded"] \
"string"  [list "debug_visibility_monitor" "0" "CHEAT:"] \
"string"  [list "demo_recordcommands" "1" "CHEAT:Record commands typed at console into .dem files."] \
"string"  [list "demo_strict_validation" "0" ""] \
"string"  [list "developer" "0" "Set developer message level"] \
"string"  [list "disable_static_prop_loading" "0" "CHEAT:If non-zero when a map loads, static props won't be loaded"] \
"string"  [list "display_game_events" "0" "CHEAT:"] \
"string"  [list "dsp_db_min" "80" "CHEAT:"] \
"string"  [list "dsp_db_mixdrop" "0" "CHEAT:"] \
"string"  [list "dsp_dist_max" "1440" "CHEAT:"] \
"string"  [list "dsp_dist_min" "0" "CHEAT:"] \
"string"  [list "dsp_enhance_stereo" "0" ""] \
"string"  [list "dsp_mix_max" "0" "CHEAT:"] \
"string"  [list "dsp_mix_min" "0" "CHEAT:"] \
"string"  [list "dsp_off" "0" "CHEAT:"] \
"string"  [list "dsp_player" "0" ""] \
"string"  [list "dsp_slow_cpu" "0" "CHEAT:"] \
"string"  [list "dsp_volume" "0" "CHEAT:"] \
"string"  [list "enable_debug_overlays" "1" "CHEAT:Enable rendering of debug overlays"] \
"string"  [list "enable_fast_math" "1" "Turns Denormals-Are-Zeroes and Flush-to-Zero on or off"] \
"string"  [list "engine_no_focus_sleep" "50" ""] \
"string"  [list "ent_messages_draw" "0" "CHEAT:Visualizes all entity input/output activity."] \
"string"  [list "ff_damage_bullet_penetration" "0" "If friendly fire is off, this will scale the penetration power and damage a bullet does when penetrating another friendly playe"] \
"string"  [list "ff_damage_reduction_bullets" "0" "How much to reduce damage done to teammates when shot. Range is from 0 - 1 (with 1 being damage equal to what is done to an en"] \
"string"  [list "ff_damage_reduction_grenade" "0" "How much to reduce damage done to teammates by a thrown grenade. Range is from 0 - 1 (with 1 being damage equal to what is don"] \
"string"  [list "ff_damage_reduction_grenade_self" "0" "How much to damage a player does to himself with his own grenade. Range is from 0 - 1 (with 1 being damage equal to what is do"] \
"string"  [list "ff_damage_reduction_other" "0" "How much to reduce damage done to teammates by things other than bullets and grenades. Range is from 0 - 1 (with 1 being damag"] \
"string"  [list "fish_dormant" "0" "CHEAT:Turns off interactive fish behavior. Fish become immobile and unresponsive."] \
"string"  [list "fog_enable_water_fog" "1" "CHEAT:"] \
"string"  [list "force_audio_english" "0" "Keeps track of whether we're forcing english in a localized language."] \
"string"  [list "fps_max" "300" "Frame rate limiter"] \
"string"  [list "fps_max_menu" "120" "Frame rate limiter, main menu"] \
"string"  [list "fps_screenshot_frequency" "10" "CHEAT:While the fps is below the threshold we will dump a screen shot this often in seconds (i.e. 10 = screen shot every 10 seconds w"] \
"string"  [list "fps_screenshot_threshold" "-1" "CHEAT:Dump a screenshot when the FPS drops below the given value."] \
"string"  [list "fs_report_sync_opens" "0" "0:Off, 1:Always, 2:Not during map load"] \
"string"  [list "func_break_max_pieces" "15" ""] \
"string"  [list "fx_new_sparks" "1" "CHEAT:Use new style sparks."] \
"string"  [list "game_mode" "0" "The current game mode (based on game type). See GameModes.txt."] \
"string"  [list "game_type" "0" "The current game type. See GameModes.txt."] \
"string"  [list "g_debug_angularsensor" "0" "CHEAT:"] \
"string"  [list "g_debug_constraint_sounds" "0" "CHEAT:Enable debug printing about constraint sounds."] \
"string"  [list "g_debug_ragdoll_removal" "0" "CHEAT:"] \
"string"  [list "g_debug_trackpather" "0" "CHEAT:"] \
"string"  [list "g_debug_vehiclebase" "0" "CHEAT:"] \
"string"  [list "g_debug_vehicledriver" "0" "CHEAT:"] \
"string"  [list "g_debug_vehicleexit" "0" "CHEAT:"] \
"string"  [list "g_debug_vehiclesound" "0" "CHEAT:"] \
"string"  [list "g_jeepexitspeed" "100" "CHEAT:"] \
"string"  [list "global_event_log_enabled" "0" "CHEAT:Enables the global event log system"] \
"string"  [list "healthshot_health" "50" "CHEAT:"] \
"string"  [list "hostage_debug" "0" "CHEAT:Show hostage AI debug information"] \
"string"  [list "hostage_is_silent" "0" "CHEAT:When set, the hostage won't play any code driven response rules lines"] \
"string"  [list "hostfile" "0" "The HOST file to load."] \
"string"  [list "host_flush_threshold" "12" "Memory threshold below which the host should flush caches between server instances"] \
"string"  [list "host_framerate" "0" "CHEAT:Set to lock per-frame time elapse."] \
"string"  [list "host_info_show" "1" "How server info gets disclosed in server queries: 0 - query disabled, 1 - show only general info, 2 - show full info"] \
"string"  [list "hostip" "-1062731456.000" "Host game server ip"] \
"string"  [list "host_map" "0" "Current map name."] \
"string"  [list "hostname" "0" "Hostname for server."] \
"string"  [list "host_name_store" "1" "Whether hostname is recorded in game events and GOTV."] \
"string"  [list "host_players_show" "1" "How players are disclosed in server queries: 0 - query disabled, 1 - show only max players count, 2 - show all players"] \
"string"  [list "hostport" "27015" "Host game server port"] \
"string"  [list "host_rules_show" "1" "How server rules get disclosed in server queries: 0 - query disabled, 1 - query enabled"] \
"string"  [list "host_sleep" "0" "CHEAT:Force the host to sleep a certain number of milliseconds each frame."] \
"string"  [list "host_timescale" "1" "CHEAT:Prescale the clock by this amount."] \
"string"  [list "hunk_track_allocation_types" "1" "CHEAT:"] \
"string"  [list "inferno_child_spawn_interval_multiplier" "0" "CHEAT:Amount spawn interval increases for each child"] \
"string"  [list "inferno_child_spawn_max_depth" "4" "CHEAT:"] \
"string"  [list "inferno_damage" "40" "CHEAT:Damage per second"] \
"string"  [list "inferno_debug" "0" "CHEAT:"] \
"string"  [list "inferno_flame_lifetime" "7" "CHEAT:Average lifetime of each flame in seconds"] \
"string"  [list "inferno_flame_spacing" "42" "CHEAT:Minimum distance between separate flame spawns"] \
"string"  [list "inferno_forward_reduction_factor" "0" "CHEAT:"] \
"string"  [list "inferno_friendly_fire_duration" "6" "CHEAT:For this long, FF is credited back to the thrower."] \
"string"  [list "inferno_initial_spawn_interval" "0" "CHEAT:Time between spawning flames for first fire"] \
"string"  [list "inferno_max_child_spawn_interval" "0" "CHEAT:Largest time interval for child flame spawning"] \
"string"  [list "inferno_max_flames" "16" "CHEAT:Maximum number of flames that can be created"] \
"string"  [list "inferno_max_range" "150" "CHEAT:Maximum distance flames can spread from their initial ignition point"] \
"string"  [list "inferno_per_flame_spawn_duration" "3" "CHEAT:Duration each new flame will attempt to spawn new flames"] \
"string"  [list "inferno_scorch_decals" "1" "CHEAT:"] \
"string"  [list "inferno_spawn_angle" "45" "CHEAT:Angular change from parent"] \
"string"  [list "inferno_surface_offset" "20" "CHEAT:"] \
"string"  [list "inferno_velocity_decay_factor" "0" "CHEAT:"] \
"string"  [list "inferno_velocity_factor" "0" "CHEAT:"] \
"string"  [list "inferno_velocity_normal_factor" "0" "CHEAT:"] \
"string"  [list "in_forceuser" "0" "CHEAT:Force user input to this split screen player."] \
"string"  [list "ip" "0" "Overrides IP for multihomed hosts"] \
"string"  [list "ip_steam" "0" "Overrides IP used to bind Steam port for multihomed hosts"] \
"string"  [list "ip_tv" "0" "Overrides IP used to bind TV port for multihomed hosts"] \
"string"  [list "ip_tv1" "0" "Overrides IP used to bind TV1 port for multihomed hosts"] \
"string"  [list "joy_axisbutton_threshold" "0" "Analog axis range before a button press is registered."] \
"string"  [list "joy_wingmanwarrior_centerhack" "0" "Wingman warrior centering hack."] \
"string"  [list "lightcache_maxmiss" "2" "CHEAT:"] \
"string"  [list "loopsingleplayermaps" "0" "CHEAT:"] \
"string"  [list "mapcycledisabled" "0" "repeats the same map after each match instead of using the map cycle"] \
"string"  [list "mat_ambient_light_b" "0" "CHEAT:"] \
"string"  [list "mat_ambient_light_g" "0" "CHEAT:"] \
"string"  [list "mat_ambient_light_r" "0" "CHEAT:"] \
"string"  [list "mat_bumpbasis" "0" "CHEAT:"] \
"string"  [list "mat_colorcorrection" "1" "CHEAT:"] \
"string"  [list "mat_debugalttab" "0" "CHEAT:"] \
"string"  [list "mat_depthbias_normal" "0" "CHEAT:"] \
"string"  [list "mat_displacementmap" "1" "CHEAT:"] \
"string"  [list "mat_drawflat" "0" "CHEAT:"] \
"string"  [list "mat_drawgray" "0" "CHEAT:"] \
"string"  [list "mat_dynamiclightmaps" "0" "CHEAT:"] \
"string"  [list "mat_dynamicPaintmaps" "0" "CHEAT:"] \
"string"  [list "mat_dynamic_tonemapping" "1" "CHEAT:"] \
"string"  [list "mat_fastnobump" "0" "CHEAT:"] \
"string"  [list "mat_fillrate" "0" "CHEAT:"] \
"string"  [list "mat_forcedynamic" "0" "CHEAT:"] \
"string"  [list "mat_force_tonemap_scale" "0" "CHEAT:"] \
"string"  [list "mat_fullbright" "0" "CHEAT:"] \
"string"  [list "mat_leafvis" "0" "CHEAT:Draw wireframe of: (0) nothing, (1) current leaf, (2) entire vis cluster, or (3) entire PVS (see mat_leafvis_draw_mask for what"] \
"string"  [list "mat_loadtextures" "1" "CHEAT:"] \
"string"  [list "mat_local_contrast_edge_scale_override" "-1000" "CHEAT:"] \
"string"  [list "mat_local_contrast_midtone_mask_override" "-1" "CHEAT:"] \
"string"  [list "mat_local_contrast_scale_override" "0" "CHEAT:"] \
"string"  [list "mat_local_contrast_vignette_end_override" "-1" "CHEAT:"] \
"string"  [list "mat_local_contrast_vignette_start_override" "-1" "CHEAT:"] \
"string"  [list "mat_luxels" "0" "CHEAT:"] \
"string"  [list "mat_measurefillrate" "0" "CHEAT:"] \
"string"  [list "mat_monitorgamma" "2" "monitor gamma (typically 2.2 for CRT and 1.7 for LCD)"] \
"string"  [list "mat_monitorgamma_tv_enabled" "0" ""] \
"string"  [list "mat_morphstats" "0" "CHEAT:"] \
"string"  [list "mat_norendering" "0" "CHEAT:"] \
"string"  [list "mat_normalmaps" "0" "CHEAT:"] \
"string"  [list "mat_normals" "0" "CHEAT:"] \
"string"  [list "mat_powersavingsmode" "0" "Power Savings Mode"] \
"string"  [list "mat_proxy" "0" "CHEAT:"] \
"string"  [list "mat_queue_mode" "-1" "The queue/thread mode the material system should use: -1=default, 0=synchronous single thread, 1=queued single thread, 2=queued"] \
"string"  [list "mat_queue_priority" "1" ""] \
"string"  [list "mat_queue_report" "0" "Report thread stalls. Positive number will filter by stalls >= time in ms. -1 reports all locks."] \
"string"  [list "mat_rendered_faces_count" "0" "CHEAT:Set to N to count how many faces each model draws each frame and spew the top N offenders from the last 150 frames (use 'mat_re"] \
"string"  [list "mat_resolveFullFrameDepth" "0" "CHEAT:Enable depth resolve to a texture. 0=disable, 1=enable via resolve tricks if supported in hw, otherwise disable, 2=force extra "] \
"string"  [list "mat_reversedepth" "0" "CHEAT:"] \
"string"  [list "mat_showlowresimage" "0" "CHEAT:"] \
"string"  [list "mat_showmiplevels" "0" "CHEAT:color-code miplevels 2: normalmaps, 1: everything else"] \
"string"  [list "mat_show_texture_memory_usage" "0" "CHEAT:Display the texture memory usage on the HUD."] \
"string"  [list "mat_softwareskin" "0" "CHEAT:"] \
"string"  [list "mat_spewalloc" "0" ""] \
"string"  [list "mat_surfaceid" "0" "CHEAT:"] \
"string"  [list "mat_surfacemat" "0" "CHEAT:"] \
"string"  [list "mat_tessellation_accgeometrytangents" "0" "CHEAT:"] \
"string"  [list "mat_tessellation_cornertangents" "1" "CHEAT:"] \
"string"  [list "mat_tessellation_update_buffers" "1" "CHEAT:"] \
"string"  [list "mat_texture_list" "0" "CHEAT:For debugging, show a list of used textures per frame"] \
"string"  [list "mat_texture_list_content_path" "0" "The content path to the materialsrc directory. If left unset, it'll assume your content directory is next to the currently runn"] \
"string"  [list "mat_wireframe" "0" "CHEAT:"] \
"string"  [list "mem_incremental_compact_rate" "0" "CHEAT:Rate at which to attempt internal heap compation"] \
"string"  [list "mm_csgo_community_search_players_min" "3" "When performing CSGO community matchmaking look for servers with at least so many human players"] \
"string"  [list "mm_server_search_lan_ports" "27015" "Ports to scan during LAN games discovery. Also used to discover and correctly connect to dedicated LAN servers behind NATs."] \
"string"  [list "molotov_throw_detonate_time" "2" "CHEAT:"] \
"string"  [list "motdfile" "0" "The MOTD file to load."] \
"string"  [list "mp_afterroundmoney" "0" "amount of money awared to every player after each round"] \
"string"  [list "mp_anyone_can_pickup_c4" "0" "If set, everyone can pick up the c4, not just Ts."] \
"string"  [list "mp_autokick" "1" "Kick idle/team-killing/team-damaging players"] \
"string"  [list "mp_autoteambalance" "1" ""] \
"string"  [list "mp_backup_restore_load_autopause" "1" "Whether to automatically pause the match after restoring round data from backup"] \
"string"  [list "mp_backup_round_auto" "1" "If enabled will keep in-memory backups to handle reconnecting players even if the backup files aren't written to disk"] \
"string"  [list "mp_backup_round_file" "0" "If set then server will save all played rounds information to files filename_date_time_team1_team2_mapname_roundnum_score1_scor"] \
"string"  [list "mp_backup_round_file_last" "0" "Every time a backup file is written the value of this convar gets updated to hold the name of the backup file."] \
"string"  [list "mp_backup_round_file_pattern" "0" "If set then server will save all played rounds information to files named by this pattern, e.g.'%prefix%_%date%_%time%_%team1%_"] \
"string"  [list "mp_buy_allow_grenades" "1" "Whether players can purchase grenades from the buy menu or not."] \
"string"  [list "mp_buy_anywhere" "0" "When set, players can buy anywhere, not only in buyzones. 0 = default. 1 = both teams. 2 = Terrorists. 3 = Counter-Terrorists."] \
"string"  [list "mp_buy_during_immunity" "0" "When set, players can buy when immune, ignoring buytime. 0 = default. 1 = both teams. 2 = Terrorists. 3 = Counter-Terrorists."] \
"string"  [list "mp_buytime" "45" "How many seconds after round start players can buy items for."] \
"string"  [list "mp_c4_cannot_be_defused" "0" "If set, the planted c4 cannot be defused."] \
"string"  [list "mp_c4timer" "40" "how long from when the C4 is armed until it blows"] \
"string"  [list "mp_competitive_endofmatch_extra_time" "15" "After a competitive match finishes rematch voting extra time is given for rankings."] \
"string"  [list "mp_consecutive_loss_aversion" "1" "How loss streak is affected with round win"] \
"string"  [list "mp_coop_force_join_ct" "0" "If set, real players will auto join CT on join."] \
"string"  [list "mp_coopmission_bot_difficulty_offset" "0" "The difficulty offset modifier for bots during coop missions."] \
"string"  [list "mp_coopmission_mission_number" "0" "Which mission the map should run after it loads."] \
"string"  [list "mp_ct_default_grenades" "0" "The default grenades that the CTs will spawn with. To give multiple grenades, separate each weapon class with a space like thi"] \
"string"  [list "mp_ct_default_melee" "0" "The default melee weapon that the CTs will spawn with. Even if this is blank, a knife will be given. To give a taser, it shou"] \
"string"  [list "mp_ct_default_primary" "0" "The default primary (rifle) weapon that the CTs will spawn with"] \
"string"  [list "mp_ct_default_secondary" "0" "The default secondary (pistol) weapon that the CTs will spawn with"] \
"string"  [list "mp_deathcam_skippable" "1" "Determines whether a player can early-out of the deathcam."] \
"string"  [list "mp_death_drop_c4" "1" "Whether c4 is droppable"] \
"string"  [list "mp_death_drop_defuser" "1" "Drop defuser on player death"] \
"string"  [list "mp_death_drop_grenade" "2" "Which grenade to drop on player death: 0=none, 1=best, 2=current or best, 3=all grenades"] \
"string"  [list "mp_death_drop_gun" "1" "Which gun to drop on player death: 0=none, 1=best, 2=current or best"] \
"string"  [list "mp_default_team_winner_no_objective" "-1" "If the map doesn't define an objective (bomb, hostage, etc), the value of this convar will declare the winner when the time run"] \
"string"  [list "mp_defuser_allocation" "2" "How to allocate defusers to CTs at start or round: 0=none, 1=random, 2=everyone"] \
"string"  [list "mp_display_kill_assists" "1" "Whether to display and score player assists"] \
"string"  [list "mp_dm_bonus_length_max" "30" "Maximum time the bonus time will last (in seconds)"] \
"string"  [list "mp_dm_bonus_length_min" "30" "Minimum time the bonus time will last (in seconds)"] \
"string"  [list "mp_dm_bonus_percent" "50" "Percent of points additionally awarded when someone gets a kill with the bonus weapon during the bonus period."] \
"string"  [list "mp_dm_time_between_bonus_max" "40" "Maximum time a bonus time will start after the round start or after the last bonus (in seconds)"] \
"string"  [list "mp_dm_time_between_bonus_min" "30" "Minimum time a bonus time will start after the round start or after the last bonus (in seconds)"] \
"string"  [list "mp_do_warmup_offine" "0" "Whether or not to do a warmup period at the start of a match in an offline (bot) match."] \
"string"  [list "mp_do_warmup_period" "1" "Whether or not to do a warmup period at the start of a match."] \
"string"  [list "mp_drop_knife_enable" "0" "Allows players to drop knives."] \
"string"  [list "mp_endmatch_votenextleveltime" "20" "If mp_endmatch_votenextmap is set, players have this much time to vote on the next map at match end."] \
"string"  [list "mp_endmatch_votenextmap" "1" "Whether or not players vote for the next map at the end of the match when the final scoreboard comes up"] \
"string"  [list "mp_endmatch_votenextmap_keepcurrent" "1" "If set, keeps the current map in the list of voting options. If not set, the current map will not appear in the list of voting"] \
"string"  [list "mp_force_assign_teams" "0" "Players don't get to choose what team they are on, it is auto assinged."] \
"string"  [list "mp_forcecamera" "1" "Restricts spectator modes for dead players. 0 = Any team. 1 = Only own team. 2 = No one; fade to black on death (previously mp_"] \
"string"  [list "mp_force_pick_time" "15" "The amount of time a player has on the team screen to make a selection before being auto-teamed"] \
"string"  [list "mp_free_armor" "1" "Determines whether armor and helmet are given automatically."] \
"string"  [list "mp_freezetime" "0" "how many seconds to keep players frozen when the round starts"] \
"string"  [list "mp_friendlyfire" "0" "Allows team members to injure other members of their team"] \
"string"  [list "mp_ggprogressive_random_weapon_kills_needed" "2" "If mp_ggprogressive_use_random_weapons is set, this is the number of kills needed with each weapon"] \
"string"  [list "mp_ggprogressive_round_restart_delay" "15" "Number of seconds to delay before restarting a round after a win in gungame progessive"] \
"string"  [list "mp_ggprogressive_use_random_weapons" "1" "If set, selects random weapons from set categories for the progression order"] \
"string"  [list "mp_ggtr_bomb_defuse_bonus" "1" "Number of bonus upgrades to award the CTs when they defuse a gun game bomb"] \
"string"  [list "mp_ggtr_bomb_detonation_bonus" "1" "Number of bonus upgrades to award the Ts when they detonate a gun game bomb"] \
"string"  [list "mp_ggtr_bomb_pts_for_flash" "4" "Kill points required in a round to get a bonus flash grenade"] \
"string"  [list "mp_ggtr_bomb_pts_for_he" "3" "Kill points required in a round to get a bonus HE grenade"] \
"string"  [list "mp_ggtr_bomb_pts_for_molotov" "5" "Kill points required in a round to get a bonus molotov cocktail"] \
"string"  [list "mp_ggtr_bomb_pts_for_upgrade" "2" "Kill points required to upgrade a player's weapon"] \
"string"  [list "mp_ggtr_bomb_respawn_delay" "0" "Number of seconds to delay before making the bomb available to a respawner in gun game"] \
"string"  [list "mp_ggtr_end_round_kill_bonus" "1" "Number of bonus points awarded in Demolition Mode when knife kill ends round"] \
"string"  [list "mp_ggtr_halftime_delay" "0" "Number of seconds to delay during TR Mode halftime"] \
"string"  [list "mp_ggtr_last_weapon_kill_ends_half" "0" "End the half and give a team round point when a player makes a kill using the final weapon"] \
"string"  [list "mp_ggtr_num_rounds_autoprogress" "3" "Upgrade the player's weapon after this number of rounds without upgrading"] \
"string"  [list "mp_give_player_c4" "1" "Whether this map should spawn a c4 bomb for a player or not."] \
"string"  [list "mp_guardian_bot_money_per_wave" "800" "The amount of money bots get time each wave the players complete. This # is absolute and not additive, the money is set to (th"] \
"string"  [list "mp_guardian_player_dist_max" "2000" "The maximum distance a player is allowed to get from the bombsite before they're killed."] \
"string"  [list "mp_guardian_player_dist_min" "1300" "The distance at which we start to warn a player when they are too far from the guarded bombsite."] \
"string"  [list "mp_guardian_special_kills_needed" "10" "The number of kills needed with a specific weapon."] \
"string"  [list "mp_guardian_special_weapon_needed" "0" "The weapon that needs to be used to increment the kills needed to complete the mission."] \
"string"  [list "mp_guardian_target_site" "-1" "If set to the index of a bombsite, will cause random spawns to be only created near that site."] \
"string"  [list "mp_halftime" "0" "Determines whether the match switches sides in a halftime event."] \
"string"  [list "mp_halftime_duration" "15" "Number of seconds that halftime lasts"] \
"string"  [list "mp_halftime_pausetimer" "0" "Set to 1 to stay in halftime indefinitely. Set to 0 to resume the timer."] \
"string"  [list "mp_hostages_max" "2" "Maximum number of hostages to spawn."] \
"string"  [list "mp_hostages_rescuetime" "1" "Additional time added to round time if a hostage is reached by a CT."] \
"string"  [list "mp_hostages_run_speed_modifier" "1" "Default is 1.0, slow down hostages by setting this to < 1.0."] \
"string"  [list "mp_hostages_spawn_farthest" "0" "When enabled will consistently force the farthest hostages to spawn."] \
"string"  [list "mp_hostages_spawn_force_positions" "0" "Comma separated list of zero based indices to force spawn positions, e.g. '0,2' or '1,6'"] \
"string"  [list "mp_hostages_spawn_same_every_round" "1" "0 = spawn hostages randomly every round, 1 = same spawns for entire match."] \
"string"  [list "mp_hostages_takedamage" "0" "Whether or not hostages can be hurt."] \
"string"  [list "mp_humanteam" "0" "Restricts human players to a single team {any, CT, T}"] \
"string"  [list "mp_ignore_round_win_conditions" "0" "Ignore conditions which would end the current round"] \
"string"  [list "mp_join_grace_time" "2" "Number of seconds after round start to allow a player to join a game"] \
"string"  [list "mp_limitteams" "2" "Max # of players 1 team can have over another (0 disables check)"] \
"string"  [list "mp_logdetail" "0" "Logs attacks. Values are: 0=off, 1=enemy, 2=teammate, 3=both)"] \
"string"  [list "mp_match_can_clinch" "1" "Can a team clinch and end the match by being so far ahead that the other team has no way to catching up?"] \
"string"  [list "mp_match_end_changelevel" "0" "At the end of the match, perform a changelevel even if next map is the same"] \
"string"  [list "mp_match_end_restart" "0" "At the end of the match, perform a restart instead of loading a new map"] \
"string"  [list "mp_match_restart_delay" "15" "Time (in seconds) until a match restarts."] \
"string"  [list "mp_maxmoney" "10000" "maximum amount of money allowed in a player's account"] \
"string"  [list "mp_maxrounds" "15" "max number of rounds to play before server changes maps"] \
"string"  [list "mp_molotovusedelay" "0" "Number of seconds to delay before the molotov can be used after acquiring it"] \
"string"  [list "mp_overtime_enable" "0" "If a match ends in a tie, use overtime rules to determine winner"] \
"string"  [list "mp_overtime_halftime_pausetimer" "0" "If set to 1 will set mp_halftime_pausetimer to 1 before every half of overtime. Set mp_halftime_pausetimer to 0 to resume the t"] \
"string"  [list "mp_overtime_maxrounds" "6" "When overtime is enabled play additional rounds to determine winner"] \
"string"  [list "mp_overtime_startmoney" "10000" "Money assigned to all players at start of every overtime half"] \
"string"  [list "mp_playercashawards" "1" "Players can earn money by performing in-game actions"] \
"string"  [list "mp_playerid" "0" "Controls what information player see in the status bar: 0 all names; 1 team names; 2 no names"] \
"string"  [list "mp_playerid_delay" "0" "Number of seconds to delay showing information in the status bar"] \
"string"  [list "mp_playerid_hold" "0" "Number of seconds to keep showing old information in the status bar"] \
"string"  [list "mp_radar_showall" "0" "Determines who should see all. 0 = default. 1 = both teams. 2 = Terrorists. 3 = Counter-Terrorists."] \
"string"  [list "mp_randomspawn" "0" "Determines whether players are to spawn. 0 = default; 1 = both teams; 2 = Terrorists; 3 = CTs."] \
"string"  [list "mp_randomspawn_dist" "0" "If using mp_randomspawn, determines whether to test distance when selecting this spot."] \
"string"  [list "mp_randomspawn_los" "0" "If using mp_randomspawn, determines whether to test Line of Sight when spawning."] \
"string"  [list "mp_respawn_immunitytime" "0" "How many seconds after respawn immunity lasts."] \
"string"  [list "mp_respawn_on_death_ct" "0" "When set to 1, counter-terrorists will respawn after dying."] \
"string"  [list "mp_respawn_on_death_t" "0" "When set to 1, terrorists will respawn after dying."] \
"string"  [list "mp_respawnwavetime_ct" "10" "Time between respawn waves for CTs."] \
"string"  [list "mp_respawnwavetime_t" "10" "Time between respawn waves for Terrorists."] \
"string"  [list "mp_restartgame" "0" "If non-zero, game will restart in the specified number of seconds"] \
"string"  [list "mp_round_restart_delay" "10" "Number of seconds to delay before restarting a round after a win"] \
"string"  [list "mp_roundtime" "10" "How many minutes each round takes."] \
"string"  [list "mp_roundtime_defuse" "2" "How many minutes each round of Bomb Defuse takes. If 0 then use mp_roundtime instead."] \
"string"  [list "mp_roundtime_deployment" "5" "How many minutes deployment for coop mission takes."] \
"string"  [list "mp_roundtime_hostage" "2" "How many minutes each round of Hostage Rescue takes. If 0 then use mp_roundtime instead."] \
"string"  [list "mp_solid_teammates" "0" "Determines whether teammates are solid or not."] \
"string"  [list "mp_spawnprotectiontime" "5" "Kick players who team-kill within this many seconds of a round restart."] \
"string"  [list "mp_spec_swapplayersides" "0" "Toggle set the player names and team names to the opposite side in which they are are on the spectator panel."] \
"string"  [list "mp_spectators_max" "2" "How many spectators are allowed in a match."] \
"string"  [list "mp_startmoney" "1000" "amount of money each player gets when they reset"] \
"string"  [list "mp_td_dmgtokick" "300" "The damage threshhold players have to exceed in a match to get kicked."] \
"string"  [list "mp_td_dmgtowarn" "200" "The damage threshhold players have to exceed in a match to get warned that they are about to be kicked."] \
"string"  [list "mp_t_default_grenades" "0" "The default grenades that the Ts will spawn with. To give multiple grenades, separate each weapon class with a space like this"] \
"string"  [list "mp_t_default_melee" "0" "The default melee weapon that the Ts will spawn with"] \
"string"  [list "mp_t_default_primary" "0" "The default primary (rifle) weapon that the Ts will spawn with"] \
"string"  [list "mp_t_default_secondary" "0" "The default secondary (pistol) weapon that the Ts will spawn with"] \
"string"  [list "mp_td_spawndmgthreshold" "50" "The damage threshold players have to exceed at the start of the round to be warned/kick."] \
"string"  [list "mp_teamcashawards" "1" "Teams can earn money by performing in-game actions"] \
"string"  [list "mp_teamflag_1" "0" "Enter a country's alpha 2 code to show that flag next to team 1's name in the spectator scoreboard."] \
"string"  [list "mp_teamflag_2" "0" "Enter a country's alpha 2 code to show that flag next to team 2's name in the spectator scoreboard."] \
"string"  [list "mp_teamlogo_1" "0" "Enter a team's shorthand image name to display their logo. Images can be found here: 'resource/flash/econ/tournaments/teams'"] \
"string"  [list "mp_teamlogo_2" "0" "Enter a team's shorthand image name to display their logo. Images can be found here: 'resource/flash/econ/tournaments/teams'"] \
"string"  [list "mp_teammatchstat_1" "0" "A non-empty string sets first team's match stat."] \
"string"  [list "mp_teammatchstat_2" "0" "A non-empty string sets second team's match stat."] \
"string"  [list "mp_teammatchstat_cycletime" "45" "Cycle match stats after so many seconds"] \
"string"  [list "mp_teammatchstat_holdtime" "5" "Decide on a match stat and hold it additionally for at least so many seconds"] \
"string"  [list "mp_teammatchstat_txt" "0" "A non-empty string sets the match stat description, e.g. 'Match 2 of 3'."] \
"string"  [list "mp_teammates_are_enemies" "0" "When set, your teammates act as enemies and all players are valid targets."] \
"string"  [list "mp_teamname_1" "0" "A non-empty string overrides the first team's name."] \
"string"  [list "mp_teamname_2" "0" "A non-empty string overrides the second team's name."] \
"string"  [list "mp_teamprediction_pct" "0" "A value between 1 and 99 will show predictions in favor of CT team."] \
"string"  [list "mp_teamprediction_txt" "0" "A value between 1 and 99 will set predictions in favor of first team."] \
"string"  [list "mp_team_timeout_time" "60" "Duration of each timeout."] \
"string"  [list "mp_timelimit" "0" "game time per map in minutes"] \
"string"  [list "mp_tkpunish" "0" "Will TK'ers and team damagers be punished in the next round? {0=no, 1=yes}"] \
"string"  [list "mp_use_respawn_waves" "0" "When set to 1, and that player's team is set to respawn, they will respawn in waves. If set to 2, teams will respawn when the w"] \
"string"  [list "mp_verbose_changelevel_spew" "1" ""] \
"string"  [list "mp_warmup_pausetimer" "0" "Set to 1 to stay in warmup indefinitely. Set to 0 to resume the timer."] \
"string"  [list "mp_warmuptime" "5" "How long the warmup period lasts. Changing this value resets warmup."] \
"string"  [list "mp_warmuptime_all_players_connected" "60" "Warmup time to use when all players have connected in official competitive. 0 to disable."] \
"string"  [list "mp_weapon_prev_owner_touch_time" "1" "CHEAT:"] \
"string"  [list "mp_weapons_allow_map_placed" "1" "If this convar is set, when a match starts, the game will not delete weapons placed in the map."] \
"string"  [list "mp_weapons_allow_typecount" "2" "Determines how many purchases of each weapon type allowed per player per round (0 to disallow purchasing, -1 to have no limit)."] \
"string"  [list "mp_weapons_allow_zeus" "1" "Determines how many Zeus purchases a player can make per round (0 to disallow, -1 to have no limit)."] \
"string"  [list "mp_weapons_glow_on_ground" "0" "If this convar is set, weapons on the ground will have a glow around them."] \
"string"  [list "mp_win_panel_display_time" "3" "The amount of time to show the win panel between matches / halfs"] \
"string"  [list "name" "0" "Current user name"] \
"string"  [list "nav_area_bgcolor" "503316480" "CHEAT:RGBA color to draw as the background color for nav areas while editing."] \
"string"  [list "nav_area_max_size" "50" "CHEAT:Max area size created in nav generation"] \
"string"  [list "nav_coplanar_slope_limit" "0" "CHEAT:"] \
"string"  [list "nav_coplanar_slope_limit_displacement" "0" "CHEAT:"] \
"string"  [list "nav_corner_adjust_adjacent" "18" "CHEAT:radius used to raise/lower corners in nearby areas when raising/lowering corners."] \
"string"  [list "nav_create_area_at_feet" "0" "CHEAT:Anchor nav_begin_area Z to editing player's feet"] \
"string"  [list "nav_create_place_on_ground" "0" "CHEAT:If true, nav areas will be placed flush with the ground when created by hand."] \
"string"  [list "nav_debug_blocked" "0" "CHEAT:"] \
"string"  [list "nav_displacement_test" "10000" "CHEAT:Checks for nodes embedded in displacements (useful for in-development maps)"] \
"string"  [list "nav_draw_limit" "500" "CHEAT:The maximum number of areas to draw in edit mode"] \
"string"  [list "nav_edit" "0" "CHEAT:Set to one to interactively edit the Navigation Mesh. Set to zero to leave edit mode."] \
"string"  [list "nav_generate_fencetops" "1" "CHEAT:Autogenerate nav areas on fence and obstacle tops"] \
"string"  [list "nav_generate_fixup_jump_areas" "1" "CHEAT:Convert obsolete jump areas into 2-way connections"] \
"string"  [list "nav_generate_incremental_range" "2000" "CHEAT:"] \
"string"  [list "nav_generate_incremental_tolerance" "0" "CHEAT:Z tolerance for adding new nav areas."] \
"string"  [list "nav_max_view_distance" "0" "CHEAT:Maximum range for precomputed nav mesh visibility (0 = default 1500 units)"] \
"string"  [list "nav_max_vis_delta_list_length" "64" "CHEAT:"] \
"string"  [list "nav_potentially_visible_dot_tolerance" "0" "CHEAT:"] \
"string"  [list "nav_quicksave" "0" "CHEAT:Set to one to skip the time consuming phases of the analysis. Useful for data collection and testing."] \
"string"  [list "nav_selected_set_border_color" "-16751516" "CHEAT:Color used to draw the selected set borders while editing."] \
"string"  [list "nav_selected_set_color" "1623785472.000" "CHEAT:Color used to draw the selected set background while editing."] \
"string"  [list "nav_show_approach_points" "0" "CHEAT:Show Approach Points in the Navigation Mesh."] \
"string"  [list "nav_show_area_info" "0" "CHEAT:Duration in seconds to show nav area ID and attributes while editing"] \
"string"  [list "nav_show_compass" "0" "CHEAT:"] \
"string"  [list "nav_show_continguous" "0" "CHEAT:Highlight non-contiguous connections"] \
"string"  [list "nav_show_danger" "0" "CHEAT:Show current 'danger' levels."] \
"string"  [list "nav_show_light_intensity" "0" "CHEAT:"] \
"string"  [list "nav_show_node_grid" "0" "CHEAT:"] \
"string"  [list "nav_show_node_id" "0" "CHEAT:"] \
"string"  [list "nav_show_nodes" "0" "CHEAT:"] \
"string"  [list "nav_show_player_counts" "0" "CHEAT:Show current player counts in each area."] \
"string"  [list "nav_show_potentially_visible" "0" "CHEAT:Show areas that are potentially visible from the current nav area"] \
"string"  [list "nav_slope_limit" "0" "CHEAT:The ground unit normal's Z component must be greater than this for nav areas to be generated."] \
"string"  [list "nav_slope_tolerance" "0" "CHEAT:The ground unit normal's Z component must be this close to the nav area's Z component to be generated."] \
"string"  [list "nav_snap_to_grid" "0" "CHEAT:Snap to the nav generation grid when creating new nav areas"] \
"string"  [list "nav_solid_props" "0" "CHEAT:Make props solid to nav generation/editing"] \
"string"  [list "nav_split_place_on_ground" "0" "CHEAT:If true, nav areas will be placed flush with the ground when split."] \
"string"  [list "nav_test_node" "0" "CHEAT:"] \
"string"  [list "nav_test_node_crouch" "0" "CHEAT:"] \
"string"  [list "nav_test_node_crouch_dir" "4" "CHEAT:"] \
"string"  [list "nav_update_visibility_on_edit" "0" "CHEAT:If nonzero editing the mesh will incrementally recompue visibility"] \
"string"  [list "net_allow_multicast" "1" ""] \
"string"  [list "net_blockmsg" "0" "CHEAT:Discards incoming message: <0|1|name>"] \
"string"  [list "net_droponsendoverflow" "0" "If enabled, channel will drop client when sending too much data causes buffer overrun"] \
"string"  [list "net_droppackets" "0" "CHEAT:Drops next n packets on client"] \
"string"  [list "net_earliertempents" "0" "CHEAT:"] \
"string"  [list "net_fakejitter" "0" "CHEAT:Jitter fakelag packet time"] \
"string"  [list "net_fakelag" "0" "CHEAT:Lag all incoming network data (including loopback) by this many milliseconds."] \
"string"  [list "net_fakeloss" "0" "CHEAT:Simulate packet loss as a percentage (negative means drop 1/n packets)"] \
"string"  [list "net_maxroutable" "1200" "Requested max packet size before packets are 'split'."] \
"string"  [list "net_public_adr" "0" "For servers behind NAT/DHCP meant to be exposed to the public internet, this is the public facing ip address string: ('x.x.x.x'"] \
"string"  [list "net_showreliablesounds" "0" "CHEAT:"] \
"string"  [list "net_showsplits" "0" "Show info about packet splits"] \
"string"  [list "net_showudp" "0" "Dump UDP packets summary to console"] \
"string"  [list "net_showudp_oob" "0" "Dump OOB UDP packets summary to console"] \
"string"  [list "net_showudp_remoteonly" "0" "Dump non-loopback udp only"] \
"string"  [list "net_splitrate" "1" "Number of fragments for a splitpacket that can be sent per frame"] \
"string"  [list "net_steamcnx_allowrelay" "1" "Allow steam connections to attempt to use relay servers as fallback (best if specified on command line: +net_steamcnx_allowrel"] \
"string"  [list "net_steamcnx_enabled" "1" "Use steam connections on listen server as a fallback, 2 forces use of steam connections instead of raw UDP."] \
"string"  [list "net_threaded_socket_burst_cap" "1024" "Max number of packets per burst beyond which threaded socket pump algorithm will start dropping packets."] \
"string"  [list "net_threaded_socket_recovery_rate" "6400" "Number of packets per second that threaded socket pump algorithm allows from client."] \
"string"  [list "net_threaded_socket_recovery_time" "60" "Number of seconds over which the threaded socket pump algorithm will fully recover client ratelimit."] \
"string"  [list "next" "0" "CHEAT:Set to 1 to advance to next frame ( when singlestep == 1 )"] \
"string"  [list "nextlevel" "0" "If set to a valid map name, will trigger a changelevel to the specified map at the end of the round"] \
"string"  [list "nextmap_print_enabled" "0" "When enabled prints next map to clients"] \
"string"  [list "noclip_fixup" "1" "CHEAT:"] \
"string"  [list "npc_ally_deathmessage" "1" "CHEAT:"] \
"string"  [list "npc_height_adjust" "1" "Enable test mode for ik height adjustment"] \
"string"  [list "occlusion_test_async" "1" "Enable asynchronous occlusion test in another thread; may save some server tick time at the cost of synchronization overhead wi"] \
"string"  [list "occlusion_test_async_jitter" "2" "CHEAT:"] \
"string"  [list "occlusion_test_async_move_tolerance" "8" "CHEAT:"] \
"string"  [list "occlusion_test_camera_margins" "12" "Amount by which the camera (viewer's eye) is expanded for occlusion test. This should be large enough to accommodate eye's move"] \
"string"  [list "occlusion_test_jump_margin" "12" "Amount by which the player bounding box is expanded up for occlusion test to account for jumping. This margin should be large e"] \
"string"  [list "occlusion_test_margins" "36" "Amount by which the player bounding box is expanded for occlusion test. This margin should be large enough to accommodate playe"] \
"string"  [list "occlusion_test_shadow_length" "144" "Max length of completely occluded shadow to consider a player for occlusion test. If shadow provably stops at this distance, th"] \
"string"  [list "occlusion_test_shadow_max_distance" "1500" "Max distance at which to consider shadows for occlusion computations"] \
"string"  [list "paintsplat_bias" "0" "CHEAT:Change bias value for computing circle buffer"] \
"string"  [list "paintsplat_max_alpha_noise" "0" "CHEAT:Max noise value of circle alpha"] \
"string"  [list "paintsplat_noise_enabled" "1" "CHEAT:"] \
"string"  [list "panel_test_title_safe" "0" "CHEAT:Test vgui panel positioning with title safe indentation"] \
"string"  [list "particle_test_attach_attachment" "0" "CHEAT:Attachment index for attachment mode"] \
"string"  [list "particle_test_attach_mode" "0" "CHEAT:Possible Values: 'start_at_attachment', 'follow_attachment', 'start_at_origin', 'follow_origin'"] \
"string"  [list "particle_test_file" "0" "CHEAT:Name of the particle system to dynamically spawn"] \
"string"  [list "password" "0" "Current server access password"] \
"string"  [list "phys_debug_check_contacts" "0" "CHEAT:"] \
"string"  [list "phys_show_active" "0" "CHEAT:"] \
"string"  [list "player_debug_print_damage" "0" "CHEAT:When true, print amount and type of all damage received by player to console."] \
"string"  [list "post_jump_crouch" "0" "CHEAT:This determines how long the third person player character will crouch for after landing a jump. This only affects the third p"] \
"string"  [list "pvs_min_player_distance" "1500" "Min distance to player at which PVS is used. At closer distances, PVS assumes we can see a shadow or something else from the pl"] \
"string"  [list "radarvisdistance" "1000" "CHEAT:at this distance and beyond you need to be point right at someone to see them"] \
"string"  [list "radarvismaxdot" "0" "CHEAT:how closely you have to point at someone to see them beyond max distance"] \
"string"  [list "radarvismethod" "1" "CHEAT:0 for traditional method, 1 for more realistic method"] \
"string"  [list "radarvispow" "0" "CHEAT:the degree to which you can point away from a target, and still see them on radar."] \
"string"  [list "r_AirboatViewDampenDamp" "1" "CHEAT:"] \
"string"  [list "r_AirboatViewDampenFreq" "7" "CHEAT:"] \
"string"  [list "r_AirboatViewZHeight" "0" "CHEAT:"] \
"string"  [list "r_ambientfraction" "0" "CHEAT:Fraction of direct lighting used to boost lighting when model requests"] \
"string"  [list "r_ambientlightingonly" "0" "CHEAT:Set this to 1 to light models with only ambient lighting (and no static lighting)."] \
"string"  [list "rate" "80000" "Max bytes/sec the host can receive data"] \
"string"  [list "r_avglight" "1" "CHEAT:"] \
"string"  [list "r_avglightmap" "0" "CHEAT:"] \
"string"  [list "r_brush_queue_mode" "0" "CHEAT:"] \
"string"  [list "r_ClipAreaFrustums" "1" "CHEAT:"] \
"string"  [list "r_ClipAreaPortals" "1" "CHEAT:"] \
"string"  [list "r_colorstaticprops" "0" "CHEAT:"] \
"string"  [list "rcon_address" "0" "Address of remote server if sending unconnected rcon commands (format x.x.x.x:p) "] \
"string"  [list "rcon_password" "0" "remote console password."] \
"string"  [list "r_debugrandomstaticlighting" "0" "CHEAT:Set to 1 to randomize static lighting for debugging. Must restart for change to take affect."] \
"string"  [list "r_DispBuildable" "0" "CHEAT:"] \
"string"  [list "r_DispWalkable" "0" "CHEAT:"] \
"string"  [list "r_dlightsenable" "1" "CHEAT:"] \
"string"  [list "r_DrawBeams" "1" "CHEAT:0=Off, 1=Normal, 2=Wireframe"] \
"string"  [list "r_drawbrushmodels" "1" "CHEAT:Render brush models. 0=Off, 1=Normal, 2=Wireframe"] \
"string"  [list "r_drawclipbrushes" "0" "CHEAT:Draw clip brushes (red=NPC+player, pink=player, purple=NPC)"] \
"string"  [list "r_drawdecals" "1" "CHEAT:Render decals."] \
"string"  [list "r_DrawDisp" "1" "CHEAT:Toggles rendering of displacment maps"] \
"string"  [list "r_drawentities" "1" "CHEAT:"] \
"string"  [list "r_drawfuncdetail" "1" "CHEAT:Render func_detail"] \
"string"  [list "r_drawleaf" "-1" "CHEAT:Draw the specified leaf."] \
"string"  [list "r_drawlightcache" "0" "CHEAT:0: off1: draw light cache entries2: draw rays"] \
"string"  [list "r_drawlightinfo" "0" "CHEAT:"] \
"string"  [list "r_drawlights" "0" "CHEAT:"] \
"string"  [list "r_DrawModelLightOrigin" "0" "CHEAT:"] \
"string"  [list "r_drawmodelstatsoverlay" "0" "CHEAT:"] \
"string"  [list "r_drawmodelstatsoverlaydistance" "500" "CHEAT:"] \
"string"  [list "r_drawmodelstatsoverlayfilter" "-1" "CHEAT:"] \
"string"  [list "r_drawmodelstatsoverlaymax" "1" "time in milliseconds beyond which a model overlay is fully red in r_drawmodelstatsoverlay 2"] \
"string"  [list "r_drawmodelstatsoverlaymin" "0" "time in milliseconds that a model must take to render before showing an overlay in r_drawmodelstatsoverlay 2"] \
"string"  [list "r_DrawPortals" "0" "CHEAT:"] \
"string"  [list "r_drawskybox" "1" "CHEAT:"] \
"string"  [list "r_drawstaticprops" "1" "CHEAT:0=Off, 1=Normal, 2=Wireframe"] \
"string"  [list "r_drawtranslucentworld" "1" "CHEAT:"] \
"string"  [list "r_drawvgui" "1" "CHEAT:Enable the rendering of vgui panels"] \
"string"  [list "r_drawworld" "1" "CHEAT:Render the world."] \
"string"  [list "r_dscale_basefov" "90" "CHEAT:"] \
"string"  [list "r_dscale_fardist" "2000" "CHEAT:"] \
"string"  [list "r_dscale_farscale" "4" "CHEAT:"] \
"string"  [list "r_dscale_neardist" "100" "CHEAT:"] \
"string"  [list "r_dscale_nearscale" "1" "CHEAT:"] \
"string"  [list "r_dynamic" "1" ""] \
"string"  [list "r_dynamiclighting" "1" "CHEAT:"] \
"string"  [list "replay_debug" "0" ""] \
"string"  [list "r_eyemove" "1" ""] \
"string"  [list "r_eyeshift_x" "0" ""] \
"string"  [list "r_eyeshift_y" "0" ""] \
"string"  [list "r_eyeshift_z" "0" ""] \
"string"  [list "r_eyesize" "0" ""] \
"string"  [list "r_flashlightbrightness" "0" "CHEAT:"] \
"string"  [list "r_flashlightclip" "0" "CHEAT:"] \
"string"  [list "r_flashlightdrawclip" "0" "CHEAT:"] \
"string"  [list "r_hwmorph" "0" "CHEAT:"] \
"string"  [list "r_itemblinkmax" "0" "CHEAT:"] \
"string"  [list "r_itemblinkrate" "4" "CHEAT:"] \
"string"  [list "r_JeepFOV" "90" "CHEAT:"] \
"string"  [list "r_JeepViewDampenDamp" "1" "CHEAT:"] \
"string"  [list "r_JeepViewDampenFreq" "7" "CHEAT:"] \
"string"  [list "r_JeepViewZHeight" "10" "CHEAT:"] \
"string"  [list "r_lightcachecenter" "1" "CHEAT:"] \
"string"  [list "r_lightcachemodel" "-1" "CHEAT:"] \
"string"  [list "r_lightcache_numambientsamples" "162" "CHEAT:number of random directions to fire rays when computing ambient lighting"] \
"string"  [list "r_lightcache_radiusfactor" "1000" "CHEAT:Allow lights to influence lightcaches beyond the lights' radii"] \
"string"  [list "r_lightinterp" "5" "CHEAT:Controls the speed of light interpolation, 0 turns off interpolation"] \
"string"  [list "r_lightmap" "-1" "CHEAT:"] \
"string"  [list "r_lightstyle" "-1" "CHEAT:"] \
"string"  [list "r_lightwarpidentity" "0" "CHEAT:"] \
"string"  [list "r_lockpvs" "0" "CHEAT:Lock the PVS so you can fly around and inspect what is being drawn."] \
"string"  [list "r_modelAmbientMin" "0" "CHEAT:Minimum value for the ambient lighting on dynamic models with more than one bone (like players and their guns)."] \
"string"  [list "r_modelwireframedecal" "0" "CHEAT:"] \
"string"  [list "r_nohw" "0" "CHEAT:"] \
"string"  [list "r_nosw" "0" "CHEAT:"] \
"string"  [list "r_novis" "0" "CHEAT:Turn off the PVS."] \
"string"  [list "r_occlusionspew" "0" "CHEAT:Activate/deactivates spew about what the occlusion system is doing."] \
"string"  [list "r_oldlightselection" "0" "CHEAT:Set this to revert to HL2's method of selecting lights"] \
"string"  [list "rope_min_pixel_diameter" "2" "CHEAT:"] \
"string"  [list "r_partition_level" "-1" "CHEAT:Displays a particular level of the spatial partition system. Use -1 to disable it."] \
"string"  [list "r_portalsopenall" "0" "CHEAT:Open all portals"] \
"string"  [list "r_proplightingpooling" "-1" "CHEAT:0 - off, 1 - static prop color meshes are allocated from a single shared vertex buffer (on hardware that supports stream offset"] \
"string"  [list "r_radiosity" "4" "CHEAT:0: no radiosity1: radiosity with ambient cube (6 samples)2: radiosity with 162 samples3: 162 samples for static props, 6 sam"] \
"string"  [list "r_randomflex" "0" "CHEAT:"] \
"string"  [list "rr_followup_maxdist" "1800" "CHEAT:'then ANY' or 'then ALL' response followups will be dispatched only to characters within this distance."] \
"string"  [list "r_rimlight" "1" "CHEAT:"] \
"string"  [list "rr_remarkable_max_distance" "1200" "CHEAT:AIs will not even consider remarkarbles that are more than this many units away."] \
"string"  [list "rr_remarkables_enabled" "1" "CHEAT:If 1, polling for info_remarkables and issuances of TLK_REMARK is enabled."] \
"string"  [list "rr_remarkable_world_entities_replay_limit" "1" "CHEAT:TLK_REMARKs will be dispatched no more than this many times for any given info_remarkable"] \
"string"  [list "rr_thenany_score_slop" "0" "CHEAT:When computing respondents for a 'THEN ANY' rule, all rule-matching scores within this much of the best score will be considere"] \
"string"  [list "r_shadow_deferred" "0" "CHEAT:Toggle deferred shadow rendering"] \
"string"  [list "r_shadowids" "0" "CHEAT:"] \
"string"  [list "r_shadows_gamecontrol" "-1" "CHEAT:"] \
"string"  [list "r_shadowwireframe" "0" "CHEAT:"] \
"string"  [list "r_showenvcubemap" "0" "CHEAT:"] \
"string"  [list "r_showz_power" "1" "CHEAT:"] \
"string"  [list "r_skin" "0" "CHEAT:"] \
"string"  [list "r_slowpathwireframe" "0" "CHEAT:"] \
"string"  [list "r_vehicleBrakeRate" "1" "CHEAT:"] \
"string"  [list "r_VehicleViewDampen" "1" "CHEAT:"] \
"string"  [list "r_visocclusion" "0" "CHEAT:Activate/deactivate wireframe rendering of what the occlusion system is doing."] \
"string"  [list "r_visualizelighttraces" "0" "CHEAT:"] \
"string"  [list "r_visualizelighttracesshowfulltrace" "0" "CHEAT:"] \
"string"  [list "r_visualizetraces" "0" "CHEAT:"] \
"string"  [list "scene_showfaceto" "0" "When playing back, show the directions of faceto events."] \
"string"  [list "scene_showlook" "0" "When playing back, show the directions of look events."] \
"string"  [list "scene_showmoveto" "0" "When moving, show the end location."] \
"string"  [list "scene_showunlock" "0" "Show when a vcd is playing but normal AI is running."] \
"string"  [list "sc_joystick_map" "1" "How to map the analog joystick deadzone and extents 0 = Scaled Cross, 1 = Concentric Mapping to Square."] \
"string"  [list "servercfgfile" "0" ""] \
"string"  [list "showbudget_texture" "0" "CHEAT:Enable the texture budget panel."] \
"string"  [list "showtriggers" "0" "CHEAT:Shows trigger brushes"] \
"string"  [list "singlestep" "0" "CHEAT:Run engine in single step mode ( set next to 1 to advance a frame )"] \
"string"  [list "sk_autoaim_mode" "1" ""] \
"string"  [list "skill" "1" "Game skill level (1-3)."] \
"string"  [list "snd_deathcamera_volume" "1" "Relative volume of the death camera music."] \
"string"  [list "snd_debug_panlaw" "0" "CHEAT:Visualize panning crossfade curves"] \
"string"  [list "snd_disable_mixer_duck" "0" "CHEAT:"] \
"string"  [list "snd_disable_mixer_solo" "0" "CHEAT:"] \
"string"  [list "snd_duckerattacktime" "0" ""] \
"string"  [list "snd_duckerreleasetime" "2" ""] \
"string"  [list "snd_duckerthreshold" "0" ""] \
"string"  [list "snd_ducking_off" "1" ""] \
"string"  [list "snd_ducktovolume" "0" ""] \
"string"  [list "snd_dvar_dist_max" "1320" "CHEAT:Play full 'far' sound at this distance"] \
"string"  [list "snd_dvar_dist_min" "240" "CHEAT:Play full 'near' sound at this distance"] \
"string"  [list "snd_filter" "0" "CHEAT:"] \
"string"  [list "snd_foliage_db_loss" "4" "CHEAT:foliage dB loss per 1200 units"] \
"string"  [list "snd_gain" "1" "CHEAT:"] \
"string"  [list "snd_gain_max" "1" "CHEAT:"] \
"string"  [list "snd_gain_min" "0" "CHEAT:"] \
"string"  [list "snd_legacy_surround" "0" ""] \
"string"  [list "snd_list" "0" "CHEAT:"] \
"string"  [list "snd_mapobjective_volume" "1" "Relative volume of map objective music."] \
"string"  [list "snd_max_same_sounds" "4" "CHEAT:"] \
"string"  [list "snd_max_same_weapon_sounds" "3" "CHEAT:"] \
"string"  [list "snd_menumusic_volume" "1" "Relative volume of the main menu music."] \
"string"  [list "snd_mixahead" "0" ""] \
"string"  [list "snd_mixer_master_dsp" "1" "CHEAT:"] \
"string"  [list "snd_mixer_master_level" "1" "CHEAT:"] \
"string"  [list "snd_musicvolume" "0" "Overall music volume"] \
"string"  [list "snd_musicvolume_multiplier_inoverlay" "0" "Music volume multiplier when Steam Overlay is active"] \
"string"  [list "snd_mute_losefocus" "1" ""] \
"string"  [list "snd_obscured_gain_dB" "-2" "CHEAT:"] \
"string"  [list "snd_op_test_convar" "1" "CHEAT:"] \
"string"  [list "snd_pause_all" "1" "CHEAT:Specifies to pause all sounds and not just voice"] \
"string"  [list "snd_pitchquality" "1" ""] \
"string"  [list "snd_prefetch_common" "1" "Prefetch common sounds from directories specified in scripts/sound_prefetch.txt"] \
"string"  [list "snd_pre_gain_dist_falloff" "1" "CHEAT:"] \
"string"  [list "snd_rear_speaker_scale" "1" "CHEAT:How much to scale rear speaker contribution to front stereo output"] \
"string"  [list "snd_refdb" "60" "CHEAT:Reference dB at snd_refdist"] \
"string"  [list "snd_refdist" "36" "CHEAT:Reference distance for snd_refdb"] \
"string"  [list "snd_report_format_sound" "0" "CHEAT:If set to 1, report all sound formats."] \
"string"  [list "snd_report_loop_sound" "0" "CHEAT:If set to 1, report all sounds that just looped."] \
"string"  [list "snd_report_start_sound" "0" "CHEAT:If set to 1, report all sounds played with S_StartSound(). The sound may not end up being played (if error occurred for example"] \
"string"  [list "snd_report_stop_sound" "0" "CHEAT:If set to 1, report all sounds stopped with S_StopSound()."] \
"string"  [list "snd_report_verbose_error" "0" "CHEAT:If set to 1, report more error found when playing sounds."] \
"string"  [list "snd_roundend_volume" "1" "Relative volume of round end music."] \
"string"  [list "snd_roundstart_volume" "1" "Relative volume of round start music."] \
"string"  [list "snd_show" "0" "CHEAT:Show sounds info"] \
"string"  [list "snd_showclassname" "0" "CHEAT:"] \
"string"  [list "snd_show_filter" "0" "CHEAT:Limit debug sounds to those containing this substring"] \
"string"  [list "snd_showmixer" "0" "CHEAT:"] \
"string"  [list "snd_show_print" "0" "CHEAT:Print to console the sounds that are normally printed on screen only. 1 = print to console and to screen; 2 = print only to con"] \
"string"  [list "snd_showstart" "0" "CHEAT:"] \
"string"  [list "snd_sos_list_operator_updates" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_block_debug" "0" "CHEAT:Spew data about the list of block entries."] \
"string"  [list "snd_sos_show_client_rcv" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_operator_entry_filter" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_operator_init" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_operator_parse" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_operator_prestart" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_operator_shutdown" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_operator_start" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_operator_stop_entry" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_operator_updates" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_queuetotrack" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_server_xmit" "0" "CHEAT:"] \
"string"  [list "snd_sos_show_startqueue" "0" "CHEAT:"] \
"string"  [list "snd_tensecondwarning_volume" "1" "Relative volume of ten second warning music."] \
"string"  [list "snd_visualize" "0" "CHEAT:Show sounds location in world"] \
"string"  [list "soundscape_debug" "0" "CHEAT:When on, draws lines to all env_soundscape entities. Green lines show the active soundscape, red lines show soundscapes that ar"] \
"string"  [list "spec_allow_roaming" "0" "CHEAT:If nonzero, allow free-roaming spectator camera."] \
"string"  [list "spec_freeze_deathanim_time" "0" "The time that the death cam will spend watching the player's ragdoll before going into the freeze death cam."] \
"string"  [list "spec_freeze_panel_extended_time" "0" "Time spent with the freeze panel still up after observer freeze cam is done."] \
"string"  [list "spec_freeze_target_fov" "42" "CHEAT:The target FOV that the deathcam should use."] \
"string"  [list "spec_freeze_target_fov_long" "90" "CHEAT:The target FOV that the deathcam should use when the cam zoom far away on the target."] \
"string"  [list "spec_freeze_time" "5" "Time spend frozen in observer freeze cam."] \
"string"  [list "spec_freeze_time_lock" "1" "Time players are prevented from skipping the freeze cam"] \
"string"  [list "spec_freeze_traveltime" "0" "Time taken to zoom in to frame a target in observer freeze cam."] \
"string"  [list "spec_replay_bot" "0" "Enable Spectator Hltv Replay when killed by bot"] \
"string"  [list "spec_replay_cam_delay" "5" "Hltv Replay delay in seconds"] \
"string"  [list "spec_replay_cam_options" "0" "Debug options for replay cam"] \
"string"  [list "spec_replay_enable" "1" "Enable Killer Replay, requires hltv server running."] \
"string"  [list "spec_replay_leadup_time" "5" "Replay time in seconds before the highlighted event"] \
"string"  [list "spec_replay_message_time" "9" "How long to show the message about Killer Replay after death. The best setting is a bit shorter than spec_replay_autostart_dela"] \
"string"  [list "spec_replay_rate_base" "1" "Base time scale of Killer Replay.Experimental."] \
"string"  [list "spec_replay_rate_limit" "3" "Minimum allowable pause between replay requests in seconds"] \
"string"  [list "spec_replay_round_delay" "0" "Round can be delayed by this much due to someone watching a replay; must be at least 3-4 seconds, otherwise the last replay wil"] \
"string"  [list "spec_replay_winddown_time" "2" "The trailing time, in seconds, of replay past the event, including fade-out"] \
"string"  [list "steam_controller_haptics" "1" ""] \
"string"  [list "suitvolume" "0" ""] \
"string"  [list "sv_accelerate" "5" "Linear acceleration amount (old value is 5.6)"] \
"string"  [list "sv_accelerate_debug_speed" "0" ""] \
"string"  [list "sv_accelerate_use_weapon_speed" "1" ""] \
"string"  [list "sv_airaccelerate" "12" ""] \
"string"  [list "sv_allowdownload" "1" "Allow clients to download files"] \
"string"  [list "sv_allow_thirdperson" "0" "Allows the server set players in third person mode without the client slamming it back (if cheats are on, all clients can set t"] \
"string"  [list "sv_allowupload" "1" "Allow clients to upload customizations files"] \
"string"  [list "sv_allow_votes" "1" "Allow voting?"] \
"string"  [list "sv_allow_wait_command" "1" "Allow or disallow the wait command on clients connected to this server."] \
"string"  [list "sv_alltalk" "1" "Players can hear all enemy communication (voice, chat)"] \
"string"  [list "sv_alternateticks" "0" "If set, server only simulates entities on even numbered ticks."] \
"string"  [list "sv_arms_race_vote_to_restart_disallowed_after" "0" "Arms Race gun level after which vote to restart is disallowed"] \
"string"  [list "sv_auto_adjust_bot_difficulty" "1" "Adjust the difficulty of bots each round based on contribution score."] \
"string"  [list "sv_autobuyammo" "0" "Enable automatic ammo purchase when inside buy zones during buy periods"] \
"string"  [list "sv_auto_full_alltalk_during_warmup_half_end" "1" "When enabled will automatically turn on full all talk mode in warmup, at halftime and at the end of the match"] \
"string"  [list "sv_bot_buy_decoy_weight" "1" "Given a bot will buy a grenade, controls the odds of the grenade type. Proportional to all other sv_bot_buy_*_weight convars."] \
"string"  [list "sv_bot_buy_flash_weight" "1" "Given a bot will buy a grenade, controls the odds of the grenade type. Proportional to all other sv_bot_buy_*_weight convars."] \
"string"  [list "sv_bot_buy_grenade_chance" "33" "Chance bots will buy a grenade with leftover money (after prim, sec and armor). Input as percent (0-100.0)"] \
"string"  [list "sv_bot_buy_hegrenade_weight" "6" "Given a bot will buy a grenade, controls the odds of the grenade type. Proportional to all other sv_bot_buy_*_weight convars."] \
"string"  [list "sv_bot_buy_molotov_weight" "1" "Given a bot will buy a grenade, controls the odds of the grenade type. Proportional to all other sv_bot_buy_*_weight convars."] \
"string"  [list "sv_bot_buy_smoke_weight" "1" "Given a bot will buy a grenade, controls the odds of the grenade type. Proportional to all other sv_bot_buy_*_weight convars."] \
"string"  [list "sv_bots_force_rebuy_every_round" "0" "If set, this strips the bots of their weapons every round and forces them to rebuy."] \
"string"  [list "sv_bots_get_easier_each_win" "0" "If > 0, some # of bots will lower thier difficulty each time they win. The argument defines how many will lower their difficult"] \
"string"  [list "sv_bots_get_harder_after_each_wave" "0" "If > 0, some # of bots will raise thier difficulty each time CTs beat a Guardian wave. The argument defines how many will raise"] \
"string"  [list "sv_bounce" "0" "Bounce multiplier for when physically simulated objects collide with other objects."] \
"string"  [list "sv_broadcast_ugc_download_progress_interval" "8" ""] \
"string"  [list "sv_broadcast_ugc_downloads" "0" ""] \
"string"  [list "sv_buy_status_override" "-1" "Override for buy status map info. 0 = everyone can buy, 1 = ct only, 2 = t only 3 = nobody"] \
"string"  [list "sv_cheats" "0" "Allow cheats on server"] \
"string"  [list "sv_client_cmdrate_difference" "0" "cl_cmdrate is moved to within sv_client_cmdrate_difference units of cl_updaterate before it is clamped between sv_mincmdrate an"] \
"string"  [list "sv_clockcorrection_msecs" "30" "The server tries to keep each player's m_nTickBase withing this many msecs of the server absolute tickcount"] \
"string"  [list "sv_coaching_enabled" "0" "Allows spectating and communicating with a team ( 'coach t' or 'coach ct' )"] \
"string"  [list "sv_competitive_minspec" "1" "Enable to force certain client convars to minimum/maximum values to help prevent competitive advantages."] \
"string"  [list "sv_competitive_official_5v5" "0" "Enable to force the server to show 5v5 scoreboards and allows spectators to see characters through walls."] \
"string"  [list "sv_consistency" "0" "Whether the server enforces file consistency for critical files"] \
"string"  [list "sv_contact" "0" "Contact email for server sysop"] \
"string"  [list "sv_ct_spawn_on_bombsite" "-1" "Force cts to spawn on a bombsite"] \
"string"  [list "sv_damage_print_enable" "1" "Turn this off to disable the player's damage feed in the console after getting killed."] \
"string"  [list "sv_dc_friends_reqd" "0" "Set this to 0 to allow direct connects to a game in progress even if no presents are present"] \
"string"  [list "sv_deadtalk" "0" "Dead players can speak (voice, text) to the living"] \
"string"  [list "sv_debugmanualmode" "0" "Make sure entities correctly report whether or not their network data has changed."] \
"string"  [list "sv_debug_ugc_downloads" "0" ""] \
"string"  [list "sv_disable_immunity_alpha" "0" "If set, clients won't slam the player model render settings each frame for immunity (mod authors use this)"] \
"string"  [list "sv_disable_observer_interpolation" "0" "Disallow interpolating between observer targets on this server."] \
"string"  [list "sv_disable_show_team_select_menu" "0" "Prevent the team select menu from showing."] \
"string"  [list "sv_downloadurl" "0" "Location from which clients can download missing files"] \
"string"  [list "sv_dumpstringtables" "0" "CHEAT:"] \
"string"  [list "sv_duplicate_playernames_ok" "0" "When enabled player names won't have the (#) in front of their names its the same as another player."] \
"string"  [list "sv_enable_delta_packing" "0" "When enabled, this allows for entity packing to use the property changes for building up the data. This is many times faster, b"] \
"string"  [list "sv_footstep_sound_frequency" "0" "CHEAT:How frequent to hear the player's step sound or how fast they appear to be running from first person."] \
"string"  [list "sv_forcepreload" "0" "Force server side preloading."] \
"string"  [list "sv_force_transmit_ents" "0" "Will transmit all entities to client, regardless of PVS conditions (will still skip based on transmit flags, however)."] \
"string"  [list "sv_force_transmit_players" "0" "Will transmit players to all clients regardless of PVS checks."] \
"string"  [list "sv_friction" "5" "World friction."] \
"string"  [list "sv_full_alltalk" "0" "Any player (including Spectator team) can speak to any other player"] \
"string"  [list "sv_gameinstructor_disable" "0" "Force all clients to disable their game instructors."] \
"string"  [list "sv_gravity" "800" "World gravity."] \
"string"  [list "sv_grenade_trajectory" "0" "CHEAT:Shows grenade trajectory visualization in-game."] \
"string"  [list "sv_grenade_trajectory_dash" "0" "Dot-dash style grenade trajectory arc"] \
"string"  [list "sv_grenade_trajectory_thickness" "0" "Visible thickness of grenade trajectory arc"] \
"string"  [list "sv_grenade_trajectory_time" "20" "Length of time grenade trajectory remains visible."] \
"string"  [list "sv_grenade_trajectory_time_spectator" "4" "Length of time grenade trajectory remains visible as a spectator."] \
"string"  [list "sv_guardian_heavy_all" "0" ""] \
"string"  [list "sv_guardian_heavy_count" "0" ""] \
"string"  [list "sv_guardian_max_wave_for_heavy" "0" ""] \
"string"  [list "sv_guardian_min_wave_for_heavy" "0" ""] \
"string"  [list "sv_hibernate_ms" "20" "# of milliseconds to sleep per frame while hibernating"] \
"string"  [list "sv_hibernate_ms_vgui" "20" "# of milliseconds to sleep per frame while hibernating but running the vgui dedicated server frontend"] \
"string"  [list "sv_hibernate_postgame_delay" "5" "# of seconds to wait after final client leaves before hibernating."] \
"string"  [list "sv_hibernate_punt_tv_clients" "0" "When enabled will punt all GOTV clients during hibernation"] \
"string"  [list "sv_hibernate_when_empty" "1" "Puts the server into extremely low CPU usage mode when no clients connected"] \
"string"  [list "sv_holiday_mode" "5" "0 = OFF, 1 = Halloween, 2 = Winter"] \
"string"  [list "sv_ignoregrenaderadio" "0" "Turn off Fire in the hole messages"] \
"string"  [list "sv_infinite_ammo" "0" "Player's active weapon will never run out of ammo. If set to 2 then player has infinite total ammo but still has to reload the "] \
"string"  [list "sv_kick_ban_duration" "15" "How long should a kick ban from the server should last (in minutes)"] \
"string"  [list "sv_kick_players_with_cooldown" "1" "(0: do not kick on insecure servers; 1: kick players with Untrusted status or convicted by Overwatch; 2: kick players with any "] \
"string"  [list "sv_ladder_scale_speed" "0" "Scale top speed on ladders"] \
"string"  [list "sv_lagcompensateself" "0" "CHEAT:Player can lag compensate themselves."] \
"string"  [list "sv_lagcompensationforcerestore" "1" "CHEAT:Don't test validity of a lag comp restore, just do it."] \
"string"  [list "sv_lan" "1" "Server is a lan server ( no heartbeat, no authentication, no non-class C addresses )"] \
"string"  [list "sv_logbans" "0" "Log server bans in the server logs."] \
"string"  [list "sv_logblocks" "0" "If true when log when a query is blocked (can cause very large log files)"] \
"string"  [list "sv_logecho" "1" "Echo log information to the console."] \
"string"  [list "sv_logfile" "1" "Log server information in the log file."] \
"string"  [list "sv_logflush" "0" "Flush the log file to disk on each write (slow)."] \
"string"  [list "sv_log_onefile" "0" "Log server information to only one file."] \
"string"  [list "sv_logsdir" "0" "Folder in the game directory where server logs will be stored."] \
"string"  [list "sv_logsecret" "0" "If set then include this secret when doing UDP logging (will use 0x53 as packet type, not usual 0x52)"] \
"string"  [list "sv_logsocket" "1" "Uses a specific outgoing socket for sv udp logging"] \
"string"  [list "sv_logsocket2" "1" "Uses a specific outgoing socket for second source of sv udp logging"] \
"string"  [list "sv_logsocket2_substr" "0" "Uses a substring match for second source of sv udp logging"] \
"string"  [list "sv_matchend_drops_enabled" "1" "Rewards gameplay time is always accumulated for players, but drops at the end of the match can be prevented"] \
"string"  [list "sv_matchpause_auto_5v5" "0" "When enabled will automatically pause the match at next freeze time if less than 5 players are connected on each team."] \
"string"  [list "sv_max_allowed_net_graph" "1" "Determines max allowed net_graph value for clients."] \
"string"  [list "sv_max_queries_sec" "10" "Maximum queries per second to respond to from a single IP address."] \
"string"  [list "sv_max_queries_sec_global" "500" "Maximum queries per second to respond to from anywhere."] \
"string"  [list "sv_max_queries_tracked_ips_max" "50000" "Window over which to average queries per second averages."] \
"string"  [list "sv_max_queries_tracked_ips_prune" "10" "Window over which to average queries per second averages."] \
"string"  [list "sv_max_queries_window" "30" "Window over which to average queries per second averages."] \
"string"  [list "sv_maxrate" "0" "Max bandwidth rate allowed on server, 0 == unlimited"] \
"string"  [list "sv_maxspeed" "320" ""] \
"string"  [list "sv_maxupdaterate" "128" "Maximum updates per second that the server will allow"] \
"string"  [list "sv_maxuptimelimit" "0" "If set, whenever a game ends, if the server uptime exceeds this number of hours, the server will exit."] \
"string"  [list "sv_maxusrcmdprocessticks" "16" "Maximum number of client-issued usrcmd ticks that can be replayed in packet loss conditions, 0 to allow no restrictions"] \
"string"  [list "sv_maxusrcmdprocessticks_holdaim" "1" "Hold client aim for multiple server sim ticks when client-issued usrcmd contains multiple actions (0: off; 1: hold this server "] \
"string"  [list "sv_maxusrcmdprocessticks_warning" "-1" "Print a warning when user commands get dropped due to insufficient usrcmd ticks allocated, number of seconds to throttle, negat"] \
"string"  [list "sv_maxvelocity" "3500" "Maximum speed any ballistically moving object is allowed to attain per axis."] \
"string"  [list "sv_memlimit" "0" "If set, whenever a game ends, if the total memory used by the server is greater than this # of megabytes, the server will exit."] \
"string"  [list "sv_mincmdrate" "128" "This sets the minimum value for cl_cmdrate. 0 == unlimited."] \
"string"  [list "sv_minrate" "100000" "Min bandwidth rate allowed on server, 0 == unlimited"] \
"string"  [list "sv_minupdaterate" "128" "Minimum updates per second that the server will allow"] \
"string"  [list "sv_minuptimelimit" "0" "If set, whenever a game ends, if the server uptime is less than this number of hours, the server will continue running regardle"] \
"string"  [list "sv_noclipaccelerate" "5" ""] \
"string"  [list "sv_noclipduringpause" "0" "CHEAT:If cheats are enabled, then you can noclip with the game paused (for doing screenshots, etc.)."] \
"string"  [list "sv_noclipspeed" "5" ""] \
"string"  [list "sv_occlude_players" "1" ""] \
"string"  [list "sv_parallel_packentities" "1" ""] \
"string"  [list "sv_parallel_sendsnapshot" "1" ""] \
"string"  [list "sv_party_mode" "0" "Party!!"] \
"string"  [list "sv_password" "0" "Server password for entry into multiplayer games"] \
"string"  [list "sv_pausable" "0" "Is the server pausable."] \
"string"  [list "sv_pure_consensus" "100000000.000" "Minimum number of file hashes to agree to form a consensus."] \
"string"  [list "sv_pure_kick_clients" "1" "If set to 1, the server will kick clients with mismatching files. Otherwise, it will issue a warning to the client."] \
"string"  [list "sv_pure_retiretime" "900" "Seconds of server idle time to flush the sv_pure file hash cache."] \
"string"  [list "sv_pure_trace" "0" "If set to 1, the server will print a message whenever a client is verifying a CRC for a file."] \
"string"  [list "sv_pushaway_hostage_force" "20000" "CHEAT:How hard the hostage is pushed away from physics objects (falls off with inverse square of distance)."] \
"string"  [list "sv_pushaway_max_hostage_force" "1000" "CHEAT:Maximum of how hard the hostage is pushed away from physics objects."] \
"string"  [list "sv_pvsskipanimation" "1" "Skips SetupBones when npc's are outside the PVS"] \
"string"  [list "sv_quota_stringcmdspersecond" "16" "How many string commands per second clients are allowed to submit, 0 to disallow all string commands"] \
"string"  [list "sv_rcon_whitelist_address" "0" "When set, rcon failed authentications will never ban this address, e.g. '127.0.0.1'"] \
"string"  [list "sv_regeneration_force_on" "0" "CHEAT:Cheat to test regenerative health systems"] \
"string"  [list "sv_region" "-1" "The region of the world to report this server in."] \
"string"  [list "sv_reliableavatardata" "0" "When enabled player avatars are exchanged via gameserver (0: off, 1: players, 2: server)"] \
"string"  [list "sv_remove_old_ugc_downloads" "1" ""] \
"string"  [list "sv_replaybots" "1" "If set to 1, the server records data needed to replay network stream from bot's perspective"] \
"string"  [list "sv_reservation_tickrate_adjustment" "0" "Adjust server tickrate upon reservation"] \
"string"  [list "sv_reservation_timeout" "45" "Time in seconds before lobby reservation expires."] \
"string"  [list "sv_search_key" "0" "When searching for a dedicated server from lobby, restrict search to only dedicated servers having the same sv_search_key."] \
"string"  [list "sv_server_graphic1" "0" "A 360x60 (<16kb) image file in /csgo/ that will be displayed to spectators."] \
"string"  [list "sv_server_graphic2" "0" "A 220x45 (<16kb) image file in /csgo/ that will be displayed to spectators."] \
"string"  [list "sv_server_verify_blood_on_player" "1" "CHEAT:"] \
"string"  [list "sv_showbullethits" "0" ""] \
"string"  [list "sv_show_cull_props" "0" "Print out props that are being culled/added by recipent proxies."] \
"string"  [list "sv_showimpacts" "0" "Shows client (red) and server (blue) bullet impact point (1=both, 2=client-only, 3=server-only)"] \
"string"  [list "sv_showimpacts_penetration" "0" "Shows extra data when bullets penetrate. (use sv_showimpacts_time to increase time shown)"] \
"string"  [list "sv_showimpacts_time" "4" "Duration bullet impact indicators remain before disappearing"] \
"string"  [list "sv_showlagcompensation" "0" "CHEAT:Show lag compensated hitboxes whenever a player is lag compensated."] \
"string"  [list "sv_show_voip_indicator_for_enemies" "0" "Makes it so the voip icon is shown over enemies as well as allies when they are talking"] \
"string"  [list "sv_skyname" "0" "Current name of the skybox texture"] \
"string"  [list "sv_spawn_afk_bomb_drop_time" "15" "Players that have never moved since they spawned will drop the bomb after this amount of time."] \
"string"  [list "sv_specaccelerate" "5" ""] \
"string"  [list "sv_spec_hear" "1" "Determines who spectators can hear: 0: only spectators; 1: all players; 2: spectated team; 3: self only; 4: nobody"] \
"string"  [list "sv_specnoclip" "1" ""] \
"string"  [list "sv_specspeed" "3" ""] \
"string"  [list "sv_staminajumpcost" "0" "Stamina penalty for jumping"] \
"string"  [list "sv_staminalandcost" "0" "Stamina penalty for landing"] \
"string"  [list "sv_staminamax" "80" "Maximum stamina penalty"] \
"string"  [list "sv_staminarecoveryrate" "60" "Rate at which stamina recovers (units/sec)"] \
"string"  [list "sv_steamdatagramtransport_port" "0" "If non zero, listen for proxied traffic on the specified port"] \
"string"  [list "sv_steamgroup" "0" "The ID of the steam group that this server belongs to. You can find your group's ID on the admin profile page in the steam comm"] \
"string"  [list "sv_steamgroup_exclusive" "0" "If set, only members of Steam group will be able to join the server when it's empty, public people will be able to join the ser"] \
"string"  [list "sv_stopspeed" "80" "Minimum stopping speed when on ground."] \
"string"  [list "sv_stressbots" "0" "If set to 1, the server calculates data and fills packets to bots. Used for perf testing."] \
"string"  [list "sv_tags" "0" "Server tags. Used to provide extra information to clients when they're browsing for servers. Separate tags with a comma."] \
"string"  [list "sv_ugc_manager_max_new_file_check_interval_secs" "1000" ""] \
"string"  [list "sv_unlockedchapters" "1" "Highest unlocked game chapter."] \
"string"  [list "sv_usercmd_custom_random_seed" "1" "When enabled server will populate an additional random seed independent of the client"] \
"string"  [list "sv_validate_edict_change_infos" "0" "Verify that edict changeinfos are being calculated properly (used to debug local network backdoor mode)."] \
"string"  [list "sv_visiblemaxplayers" "-1" "Overrides the max players reported to prospective clients"] \
"string"  [list "sv_voicecodec" "0" "Specifies which voice codec DLL to use in a game. Set to the name of the DLL without the extension."] \
"string"  [list "sv_voiceenable" "1" ""] \
"string"  [list "sv_vote_allow_in_warmup" "0" "Allow voting during warmup?"] \
"string"  [list "sv_vote_allow_spectators" "0" "Allow spectators to initiate votes?"] \
"string"  [list "sv_vote_command_delay" "2" "How long after a vote passes until the action happens"] \
"string"  [list "sv_vote_count_spectator_votes" "0" "Allow spectators to vote on issues?"] \
"string"  [list "sv_vote_creation_timer" "120" "How often someone can individually call a vote."] \
"string"  [list "sv_vote_disallow_kick_on_match_point" "0" "Disallow vote kicking on the match point round."] \
"string"  [list "sv_vote_failure_timer" "300" "A vote that fails cannot be re-submitted for this long"] \
"string"  [list "sv_vote_issue_kick_allowed" "1" "Can people hold votes to kick players from the server?"] \
"string"  [list "sv_vote_issue_loadbackup_allowed" "1" "Can people hold votes to load match from backup?"] \
"string"  [list "sv_vote_issue_restart_game_allowed" "0" "Can people hold votes to restart the game?"] \
"string"  [list "sv_vote_kick_ban_duration" "15" "How long should a kick vote ban someone from the server? (in minutes)"] \
"string"  [list "sv_vote_quorum_ratio" "0" "The minimum ratio of players needed to vote on an issue to resolve it."] \
"string"  [list "sv_vote_timer_duration" "15" "How long to allow voting on an issue"] \
"string"  [list "sv_vote_to_changelevel_before_match_point" "1" "Restricts vote to change level to rounds prior to match point (default 0, vote is never disallowed)"] \
"string"  [list "sv_workshop_allow_other_maps" "1" "When hosting a workshop collection, users can play other workshop map on this server when it is empty and then mapcycle into th"] \
"string"  [list "sys_minidumpspewlines" "500" "Lines of crash dump console spew to keep."] \
"string"  [list "texture_budget_background_alpha" "128" "how translucent the budget panel is"] \
"string"  [list "texture_budget_panel_bottom_of_history_fraction" "0" "number between 0 and 1"] \
"string"  [list "texture_budget_panel_height" "284" "height in pixels of the budget panel"] \
"string"  [list "texture_budget_panel_width" "512" "width in pixels of the budget panel"] \
"string"  [list "texture_budget_panel_x" "0" "number of pixels from the left side of the game screen to draw the budget panel"] \
"string"  [list "texture_budget_panel_y" "450" "number of pixels from the top side of the game screen to draw the budget panel"] \
"string"  [list "think_limit" "0" "Maximum think time in milliseconds, warning is printed if this is exceeded."] \
"string"  [list "tv_advertise_watchable" "0" "GOTV advertises the match as watchable via game UI, clients watching via UI will not need to type password"] \
"string"  [list "tv_allow_camera_man_steamid" "0" "Allows tournament production cameraman to run csgo.exe -interactivecaster on SteamID 7650123456XXX and be the camera man."] \
"string"  [list "tv_allow_static_shots" "1" "Auto director uses fixed level cameras for shots"] \
"string"  [list "tv_autorecord" "0" "Automatically records all games as GOTV demos."] \
"string"  [list "tv_autoretry" "1" "Relay proxies retry connection after network timeout"] \
"string"  [list "tv_broadcast" "0" "Automatically broadcasts all games as GOTV demos through Steam."] \
"string"  [list "tv_broadcast1" "0" "Automatically broadcasts all games as GOTV(1) demos through Steam."] \
"string"  [list "tv_broadcast_keyframe_interval" "3" "The frequency, in seconds, of sending keyframes and delta fragments to the broadcast relay server"] \
"string"  [list "tv_broadcast_max_requests" "20" "Max number of broadcast http requests in flight. If there is a network issue, the requests may start piling up, degrading serve"] \
"string"  [list "tv_broadcast_startup_resend_interval" "10" "The interval, in seconds, of re-sending startup data to the broadcast relay server (useful in case relay crashes, restarts or s"] \
"string"  [list "tv_broadcast_url" "0" "URL of the broadcast relay"] \
"string"  [list "tv_chatgroupsize" "0" "Set the default chat group size"] \
"string"  [list "tv_chattimelimit" "8" "Limits spectators to chat only every n seconds"] \
"string"  [list "tv_debug" "0" "GOTV debug info."] \
"string"  [list "tv_delay" "30" "GOTV broadcast delay in seconds"] \
"string"  [list "tv_delaymapchange" "1" "Delays map change until broadcast is complete"] \
"string"  [list "tv_deltacache" "2" "Enable delta entity bit stream cache"] \
"string"  [list "tv_dispatchmode" "1" "Dispatch clients to relay proxies: 0=never, 1=if appropriate, 2=always"] \
"string"  [list "tv_dispatchweight" "1" "Dispatch clients to relay proxies based on load, 1.25 will prefer for every 4 local clients to put 5 clients on every connected"] \
"string"  [list "tv_enable" "0" "Activates GOTV on server (0=off;1=on;2=on when reserved)"] \
"string"  [list "tv_enable1" "0" "Activates GOTV(1) on server (0=off;1=on;2=on when reserved)"] \
"string"  [list "tv_enable_delta_frames" "1" "Indicates whether or not the tv should use delta frames for storage of intermediate frames. This takes more CPU but significant"] \
"string"  [list "tv_encryptdata_key" "0" "When set to a valid key communication messages will be encrypted for GOTV"] \
"string"  [list "tv_encryptdata_key_pub" "0" "When set to a valid key public communication messages will be encrypted for GOTV"] \
"string"  [list "tv_maxclients" "128" "Maximum client number on GOTV server."] \
"string"  [list "tv_maxclients_relayreserved" "0" "Reserves a certain number of GOTV client slots for relays."] \
"string"  [list "tv_maxrate" "128000" "Max GOTV spectator bandwidth rate allowed, 0 == unlimited"] \
"string"  [list "tv_name" "0" "GOTV host name"] \
"string"  [list "tv_nochat" "0" "Don't receive chat messages from other GOTV spectators"] \
"string"  [list "tv_overridemaster" "0" "Overrides the GOTV master root address."] \
"string"  [list "tv_password" "0" "GOTV password for all clients"] \
"string"  [list "tv_port1" "27021" "Host GOTV(1) port"] \
"string"  [list "tv_port" "27020" "Host GOTV(0) port"] \
"string"  [list "tv_relaypassword" "0" "GOTV password for relay proxies"] \
"string"  [list "tv_relayradio" "0" "Relay team radio commands to TV: 0=off, 1=on"] \
"string"  [list "tv_relaytextchat" "1" "Relay text chat data: 0=off, 1=say, 2=say+say_team"] \
"string"  [list "tv_relayvoice" "1" "Relay voice data: 0=off, 1=on"] \
"string"  [list "tv_snapshotrate1" "32" "Snapshots broadcasted per second, GOTV(1)"] \
"string"  [list "tv_snapshotrate" "32" "Snapshots broadcasted per second"] \
"string"  [list "tv_timeout" "30" "GOTV connection timeout in seconds."] \
"string"  [list "tv_title" "0" "Set title for GOTV spectator UI"] \
"string"  [list "tv_transmitall" "1" "Transmit all entities (not only director view)"] \
"string"  [list "vgui_drawtree" "0" "CHEAT:Draws the vgui panel hiearchy to the specified depth level."] \
"string"  [list "view_punch_decay" "18" "CHEAT:Decay factor exponent for view punch"] \
"string"  [list "view_recoil_tracking" "0" "CHEAT:How closely the view tracks with the aim punch from weapon recoil"] \
"string"  [list "vis_force" "0" "CHEAT:"] \
"string"  [list "vismon_poll_frequency" "0" "CHEAT:"] \
"string"  [list "vismon_trace_limit" "12" "CHEAT:"] \
"string"  [list "voice_caster_enable" "0" "Toggle voice transmit and receive for casters. 0 = no caster, account number of caster to enable."] \
"string"  [list "voice_caster_scale" "1" ""] \
"string"  [list "voice_enable" "1" "Toggle voice transmit and receive."] \
"string"  [list "voice_forcemicrecord" "1" ""] \
"string"  [list "voice_inputfromfile" "0" "Get voice input from 'voice_input.wav' rather than from the microphone."] \
"string"  [list "voice_loopback" "0" ""] \
"string"  [list "voice_mixer_boost" "0" ""] \
"string"  [list "voice_mixer_mute" "0" ""] \
"string"  [list "voice_mixer_volume" "1" ""] \
"string"  [list "voice_player_speaking_delay_threshold" "0" "CHEAT:"] \
"string"  [list "voice_recordtofile" "0" "Record mic data and decompressed voice data into 'voice_micdata.wav' and 'voice_decompressed.wav'"] \
"string"  [list "voice_scale" "1" "Overall volume of voice over IP"] \
"string"  [list "voice_system_enable" "1" "Toggle voice system."] \
"string"  [list "voice_threshold" "4000" ""] \
"string"  [list "volume" "1" "Sound volume"] \
"string"  [list "vprof_graphheight" "256" ""] \
"string"  [list "vprof_graphwidth" "512" ""] \
"string"  [list "vprof_unaccounted_limit" "0" "number of milliseconds that a node must exceed to turn red in the vprof panel"] \
"string"  [list "vprof_verbose" "1" "Set to one to show average and peak times"] \
"string"  [list "vprof_warningmsec" "10" "Above this many milliseconds render the label red to indicate slow code."] \
"string"  [list "weapon_accuracy_nospread" "0" "CHEAT:Disable weapon inaccuracy spread"] \
"string"  [list "weapon_auto_cleanup_time" "0" "If set to non-zero, weapons will delete themselves after the specified time (in seconds) if no players are near."] \
"string"  [list "weapon_max_before_cleanup" "0" "If set to non-zero, will remove the oldest dropped weapon to maintain the specified number of dropped weapons in the world."] \
"string"  [list "weapon_recoil_cooldown" "0" "CHEAT:Amount of time needed between shots before restarting recoil"] \
"string"  [list "weapon_recoil_decay1_exp" "3" "CHEAT:Decay factor exponent for weapon recoil"] \
"string"  [list "weapon_recoil_decay2_exp" "8" "CHEAT:Decay factor exponent for weapon recoil"] \
"string"  [list "weapon_recoil_decay2_lin" "18" "CHEAT:Decay factor (linear term) for weapon recoil"] \
"string"  [list "weapon_recoil_scale" "2" "CHEAT:Overall scale factor for recoil. Used to reduce recoil on specific platforms"] \
"string"  [list "weapon_recoil_scale_motion_controller" "1" "CHEAT:Overall scale factor for recoil. Used to reduce recoil. Only for motion controllers"] \
"string"  [list "weapon_recoil_suppression_factor" "0" "CHEAT:Initial recoil suppression factor (first suppressed shot will use this factor cfgs contribs.txt devtools env.sh INSTALL LICENSE Makefile mods README.md sources.txt src standard recoil, lerping to 1 for later shots"] \
"string"  [list "weapon_recoil_suppression_shots" "4" "CHEAT:Number of shots before weapon uses full recoil"] \
"string"  [list "weapon_recoil_variance" "0" "CHEAT:Amount of variance per recoil impulse"] \
"string"  [list "weapon_recoil_vel_decay" "4" "CHEAT:Decay factor for weapon recoil velocity"] \
"string"  [list "weapon_recoil_view_punch_extra" "0" "CHEAT:Additional (non-aim) punch added to view from recoil"] \
"string"  [list "weapon_reticle_knife_show" "0" "When enabled will show knife reticle on clients. Used for game modes requiring target id display when holding a knife."] \
"string"  [list "windows_speaker_config" "-1" ""] \
"string"  [list "xbox_autothrottle" "1" ""] \
"string"  [list "xbox_throttlebias" "100" ""] \
"string"  [list "xbox_throttlespoof" "200" ""] \
] \
]
