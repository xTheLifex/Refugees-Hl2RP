
function PLUGIN:AddOverwatchVoice(clip, key, value, soldier)
    local soldier = soldier or true
    local vtype = "OTA"
    if (soldier) then
        Schema.voices.Add(vtype, key, value, "npc/combine_soldier/vo/" .. clip .. ".wav")
    else
        Schema.voices.Add(vtype, key, value, "npc/metropolice/vo/" .. clip .. ".wav")
    end
end

function PLUGIN:AddCPVoice(clip, key, value, soldier)
    local soldier = soldier or false
    local vtype = "CP"
    if (soldier) then
        Schema.voices.Add(vtype, key, value, "npc/combine_soldier/vo/" .. clip .. ".wav")
    else
        Schema.voices.Add(vtype, key, value, "npc/metropolice/vo/" .. clip .. ".wav")
    end
end

-- SHARED LINES
Schema.voices.Add("CP", "AFFIRMATIVE2", "Affirmative.", "npc/combine_soldier/vo/affirmative2.wav")
Schema.voices.Add("CP", "AFFIRMATIVE3", "Affirmative.", "npc/combine_soldier/vo/affirmative.wav")
Schema.voices.Add("CP", "NO CONTACT", "No contact.", "npc/metropolice/vo/nocontact.wav")
Schema.voices.Add("OTA", "AFFIRMATIVE2", "Affirmative.", "npc/combine_soldier/vo/affirmative2.wav")
Schema.voices.Add("OTA", "AFFIRMATIVE3", "Affirmative.", "npc/combine_soldier/vo/affirmative.wav")
Schema.voices.Add("OTA", "NO CONTACT", "No contact.", "npc/metropolice/vo/nocontact.wav")

Schema.voices.Add("OTA", "AFFIRMATIVE", "Affirmative.", "npc/metropolice/vo/affirmative.wav")
Schema.voices.Add("OTA", "ALL UNITS MOVE", "All units, move in!", "npc/metropolice/vo/allunitsmovein.wav")
Schema.voices.Add("OTA", "AMPUTATE", "Amputate.", "npc/metropolice/vo/amputate.wav")
Schema.voices.Add("OTA", "ANTICITIZEN", "Anti-citizen.", "npc/metropolice/vo/anticitizen.wav")
Schema.voices.Add("OTA", "APEX", "Apex.", "npc/combine_soldier/vo/apex.wav")
Schema.voices.Add("OTA", "APPLY", "Apply.", "npc/metropolice/vo/apply.wav")
Schema.voices.Add("OTA", "AT LOCATION REPORT", "Protection-teams at location, report in.", "npc/metropolice/vo/ptatlocationreport.wav")
Schema.voices.Add("OTA", "BLOCK", "Block!", "npc/metropolice/vo/block.wav")
Schema.voices.Add("OTA", "BOOMER", "Boomer.", "npc/combine_soldier/vo/boomer.wav")
Schema.voices.Add("OTA", "CANAL", "Canal.", "npc/metropolice/vo/canal.wav")
Schema.voices.Add("OTA", "CANALBLOCK", "Canalblock!", "npc/metropolice/vo/canalblock.wav")
Schema.voices.Add("OTA", "CAUTERIZE", "Cauterize.", "npc/metropolice/vo/cauterize.wav")
Schema.voices.Add("OTA", "CHECK MISCOUNT", "Check for miscount.", "npc/metropolice/vo/checkformiscount.wav")
Schema.voices.Add("OTA", "CITIZEN", "Citizen.", "npc/metropolice/vo/citizen.wav")
Schema.voices.Add("OTA", "CLEAR CODE 100", "Clear and code one-hundred.", "npc/metropolice/vo/clearandcode100.wav")
Schema.voices.Add("OTA", "CODE 100", "Code one-hundred.", "npc/metropolice/vo/code100.wav")
Schema.voices.Add("OTA", "CODE 2", "All units, code two!", "npc/metropolice/vo/allunitscode2.wav")
Schema.voices.Add("OTA", "CODE 7", "Code seven.", "npc/metropolice/vo/code7.wav")
Schema.voices.Add("OTA", "CONDEMNED", "Condemned zone!", "npc/metropolice/vo/condemnedzone.wav")
Schema.voices.Add("OTA", "CONTROL 100", "Control is one-hundred percent this location, no sign of that 647-E.", "npc/metropolice/vo/control100percent.wav")
Schema.voices.Add("OTA", "CONTROLSECTION", "Control-section!", "npc/metropolice/vo/controlsection.wav")
Schema.voices.Add("OTA", "CONVERGING", "Converging.", "npc/metropolice/vo/converging.wav")
Schema.voices.Add("OTA", "DAGGER", "Dagger.", "npc/combine_soldier/vo/dagger.wav")
Schema.voices.Add("OTA", "DASH", "Dash.", "npc/combine_soldier/vo/dash.wav")
Schema.voices.Add("OTA", "DESIGNATE SUSPECT", "Designate suspect as...", "npc/metropolice/vo/designatesuspectas.wav")
Schema.voices.Add("OTA", "DESTROY COVER", "Destroy that cover!", "npc/metropolice/vo/destroythatcover.wav")
Schema.voices.Add("OTA", "DISMOUNTING HARDPOINT", "Dismounting hardpoint.", "npc/metropolice/vo/dismountinghardpoint.wav")
Schema.voices.Add("OTA", "DISTRIBUTION BLOCK", "Distribution block.", "npc/metropolice/vo/distributionblock.wav")
Schema.voices.Add("OTA", "DOCUMENT", "Document.", "npc/metropolice/vo/document.wav")
Schema.voices.Add("OTA", "ECHO", "Echo.", "npc/combine_soldier/vo/echo.wav")
Schema.voices.Add("OTA", "GHOST", "Ghost.", "npc/combine_soldier/vo/ghost.wav")
Schema.voices.Add("OTA", "GRID", "Grid.", "npc/combine_soldier/vo/grid.wav")
Schema.voices.Add("OTA", "HAMMER", "Hammer.", "npc/combine_soldier/vo/hammer.wav")
Schema.voices.Add("OTA", "HELIX", "Helix.", "npc/combine_soldier/vo/helix.wav")
Schema.voices.Add("OTA", "HUNTER", "Hunter.", "npc/combine_soldier/vo/hunter.wav")
Schema.voices.Add("OTA", "HURRICANE", "Hurricane.", "npc/combine_soldier/vo/hurricane.wav")
Schema.voices.Add("OTA", "ICE", "Ice.", "npc/combine_soldier/vo/ice.wav")
Schema.voices.Add("OTA", "INBOUND", "Inbound.", "npc/combine_soldier/vo/inbound.wav")
Schema.voices.Add("OTA", "INFECTED", "Infected.", "npc/combine_soldier/vo/infected.wav")
Schema.voices.Add("OTA", "INFECTION", "Infection!", "npc/metropolice/vo/infection.wav")
Schema.voices.Add("OTA", "INFESTED", "Infested zone.", "npc/metropolice/vo/infestedzone.wav")
Schema.voices.Add("OTA", "INJECT", "Inject!", "npc/metropolice/vo/inject.wav")
Schema.voices.Add("OTA", "INOCULATE", "Inoculate.", "npc/metropolice/vo/innoculate.wav")
Schema.voices.Add("OTA", "INTERCEDE", "Intercede!", "npc/metropolice/vo/intercede.wav")
Schema.voices.Add("OTA", "INTERLOCK", "Interlock!", "npc/metropolice/vo/interlock.wav")
Schema.voices.Add("OTA", "INVESTIGATE", "Investigate.", "npc/metropolice/vo/investigate.wav")
Schema.voices.Add("OTA", "ION", "Ion.", "npc/combine_soldier/vo/ion.wav")
Schema.voices.Add("OTA", "IS 10-8", "Unit is 10-8, standing by.", "npc/metropolice/vo/unitis10-8standingby.wav")
Schema.voices.Add("OTA", "IS DOWN", "Is down!", "npc/metropolice/vo/isdown.wav")
Schema.voices.Add("OTA", "IS INBOUND", "Unit is inbound.", "npc/combine_soldier/vo/unitisinbound.wav")
Schema.voices.Add("OTA", "ISOLATE", "Isolate!", "npc/metropolice/vo/isolate.wav")
Schema.voices.Add("OTA", "JET", "Jet.", "npc/combine_soldier/vo/jet.wav")
Schema.voices.Add("OTA", "JUDGE", "Judge.", "npc/combine_soldier/vo/judge.wav")
Schema.voices.Add("OTA", "JURISDICTION", "Stabilization-jurisdiction.", "npc/metropolice/vo/stabilizationjurisdiction.wav")
Schema.voices.Add("OTA", "JURY", "Jury!", "npc/metropolice/vo/jury.wav")
Schema.voices.Add("OTA", "KILO", "Kilo.", "npc/combine_soldier/vo/kilo.wav")
Schema.voices.Add("OTA", "KING", "King!", "npc/metropolice/vo/king.wav")
Schema.voices.Add("OTA", "LEADER", "Leader.", "npc/combine_soldier/vo/leader.wav")
Schema.voices.Add("OTA", "LINE", "Line!", "npc/metropolice/vo/line.wav")
Schema.voices.Add("OTA", "LOCATION", "Location?", "npc/metropolice/vo/location.wav")
Schema.voices.Add("OTA", "LOCK", "Lock!", "npc/metropolice/vo/lock.wav")
Schema.voices.Add("OTA", "MOVE IN", "Move in!", "npc/combine_soldier/vo/movein.wav")
Schema.voices.Add("OTA", "MOVE", "Move!", "npc/metropolice/vo/move.wav")
Schema.voices.Add("OTA", "NOMAD", "Nomad.", "npc/combine_soldier/vo/nomad.wav")
Schema.voices.Add("OTA", "NONPATROL", "Non-patrol region.", "npc/metropolice/vo/nonpatrolregion.wav")
Schema.voices.Add("OTA", "NOVA", "Nova.", "npc/combine_soldier/vo/nova.wav")
Schema.voices.Add("OTA", "OVERWATCH", "Overwatch.", "npc/combine_soldier/vo/overwatch.wav")
Schema.voices.Add("OTA", "PATROL", "Patrol!", "npc/metropolice/vo/patrol.wav")
Schema.voices.Add("OTA", "PAYBACK", "Payback.", "npc/combine_soldier/vo/payback.wav")
Schema.voices.Add("OTA", "PHANTOM", "Phantom.", "npc/combine_soldier/vo/phantom.wav")
Schema.voices.Add("OTA", "PROSECUTE", "Prosecute!", "npc/metropolice/vo/prosecute.wav")
Schema.voices.Add("OTA", "PROSECUTING", "Prosecuting.", "npc/combine_soldier/vo/prosecuting.wav")
Schema.voices.Add("OTA", "QUICK", "Quick!", "npc/metropolice/vo/quick.wav")
Schema.voices.Add("OTA", "QUICKSAND", "Quicksand.", "npc/combine_soldier/vo/quicksand.wav")
Schema.voices.Add("OTA", "RANGE", "Range.", "npc/combine_soldier/vo/range.wav")
Schema.voices.Add("OTA", "RANGER", "Ranger.", "npc/combine_soldier/vo/ranger.wav")
Schema.voices.Add("OTA", "RAZOR", "Razor.", "npc/combine_soldier/vo/razor.wav")
Schema.voices.Add("OTA", "READY CHARGES", "Ready charges!", "npc/combine_soldier/vo/readycharges.wav")
Schema.voices.Add("OTA", "READY PROSECUTE", "Ready to prosecute!", "npc/metropolice/vo/readytoprosecute.wav")
Schema.voices.Add("OTA", "READY WEAPONS", "Ready weapons!", "npc/combine_soldier/vo/readyweapons.wav")
Schema.voices.Add("OTA", "REAPER", "Reaper.", "npc/combine_soldier/vo/reaper.wav")
Schema.voices.Add("OTA", "REPORT CLEAR", "Reporting clear.", "npc/combine_soldier/vo/reportingclear.wav")
Schema.voices.Add("OTA", "REPORT STATUS", "Local CP-teams, report status.", "npc/metropolice/vo/localcptreportstatus.wav")
Schema.voices.Add("OTA", "REPURPOSED", "Repurposed area.", "npc/metropolice/vo/repurposedarea.wav")
Schema.voices.Add("OTA", "RESIDENTIAL BLOCK", "Residential block.", "npc/metropolice/vo/residentialblock.wav")
Schema.voices.Add("OTA", "RESPONDING", "Responding.", "npc/metropolice/vo/responding2.wav")
Schema.voices.Add("OTA", "RESTRICT", "Restrict!", "npc/metropolice/vo/restrict.wav")
Schema.voices.Add("OTA", "RESTRICTED", "Restricted block.", "npc/metropolice/vo/restrictedblock.wav")
Schema.voices.Add("OTA", "RESTRICTION ZONE", "Terminal restriction-zone!", "npc/metropolice/vo/terminalrestrictionzone.wav")
Schema.voices.Add("OTA", "RIPCORD", "Ripcord", "npc/combine_soldier/vo/ripcord.wav")
Schema.voices.Add("OTA", "ROLLER", "Roller!", "npc/metropolice/vo/roller.wav")
Schema.voices.Add("OTA", "SAVAGE", "Savage.", "npc/combine_soldier/vo/savage.wav")
Schema.voices.Add("OTA", "SCAR", "Scar.", "npc/combine_soldier/vo/scar.wav")
Schema.voices.Add("OTA", "SEARCH", "Search!", "npc/metropolice/vo/search.wav")
Schema.voices.Add("OTA", "SECTOR NOT SECURE", "Sector is not secure.", "npc/combine_soldier/vo/sectorisnotsecure.wav")
Schema.voices.Add("OTA", "SECTOR IS NOT SECURE", "Sector is not secure.", "npc/combine_soldier/vo/sectorisnotsecure.wav")
Schema.voices.Add("OTA", "SECTOR NOT STERILE", "Confirmed- sector not sterile.", "npc/combine_soldier/vo/confirmsectornotsterile.wav")
Schema.voices.Add("OTA", "SECURE", "Secure.", "npc/combine_soldier/vo/secure.wav")
Schema.voices.Add("OTA", "SHADOW", "Shadow.", "npc/combine_soldier/vo/shadow.wav")
Schema.voices.Add("OTA", "SHARPZONE", "Sharpzone.", "npc/combine_soldier/vo/sharpzone.wav")
Schema.voices.Add("OTA", "SHIT", "Shit!", "npc/metropolice/vo/shit.wav")
Schema.voices.Add("OTA", "SLAM", "Slam.", "npc/combine_soldier/vo/slam.wav")
Schema.voices.Add("OTA", "SLASH", "Slash.", "npc/combine_soldier/vo/slash.wav")
Schema.voices.Add("OTA", "SOCIOCIDE", "Sociocide.", "npc/metropolice/vo/sociocide.wav")
Schema.voices.Add("OTA", "SOCIOSTABLE", "We are socio-stable at this location.", "npc/metropolice/vo/wearesociostablethislocation.wav")
Schema.voices.Add("OTA", "SPEAR", "Spear.", "npc/combine_soldier/vo/spear.wav")
Schema.voices.Add("OTA", "STAB", "Stab.", "npc/combine_soldier/vo/stab.wav")
Schema.voices.Add("OTA", "STANDING BY", "Standing by.", "npc/combine_soldier/vo/standingby.wav")
Schema.voices.Add("OTA", "STAR", "Star.", "npc/combine_soldier/vo/star.wav")
Schema.voices.Add("OTA", "STATIONBLOCK", "Stationblock.", "npc/metropolice/vo/stationblock.wav")
Schema.voices.Add("OTA", "STAY ALERT", "Stay alert.", "npc/combine_soldier/vo/stayalert.wav")
Schema.voices.Add("OTA", "STERILIZE", "Sterilize!", "npc/metropolice/vo/sterilize.wav")
Schema.voices.Add("OTA", "STINGER", "Stinger.", "npc/combine_soldier/vo/stinger.wav")
Schema.voices.Add("OTA", "STORM", "Storm.", "npc/combine_soldier/vo/storm.wav")
Schema.voices.Add("OTA", "STRIKER", "Striker.", "npc/combine_soldier/vo/striker.wav")
Schema.voices.Add("OTA", "SUBJECT 505", "Subject is 505!", "npc/metropolice/vo/subjectis505.wav")
Schema.voices.Add("OTA", "SUBJECT HIGH SPEED", "All units, be advised, subject is now high-speed!", "npc/metropolice/vo/subjectisnowhighspeed.wav")
Schema.voices.Add("OTA", "SUBJECT", "Subject!", "npc/metropolice/vo/subject.wav")
Schema.voices.Add("OTA", "SUNDOWN", "Sundown.", "npc/combine_soldier/vo/sundown.wav")
Schema.voices.Add("OTA", "SUSPECT AS", "Designate suspect as...", "npc/metropolice/vo/designatesuspectas.wav")
Schema.voices.Add("OTA", "SUSPEND", "Suspend!", "npc/metropolice/vo/suspend.wav")
Schema.voices.Add("OTA", "SWEEPER", "Sweeper.", "npc/combine_soldier/vo/sweeper.wav")
Schema.voices.Add("OTA", "SWEEPING IN", "Sweeping in!", "npc/combine_soldier/vo/sweepingin.wav")
Schema.voices.Add("OTA", "SWEEPING SUSPECT", "Sweeping for suspect!", "npc/metropolice/vo/sweepingforsuspect.wav")
Schema.voices.Add("OTA", "SWIFT", "Swift.", "npc/combine_soldier/vo/swift.wav")
Schema.voices.Add("OTA", "SWORD", "Sword.", "npc/combine_soldier/vo/sword.wav")
Schema.voices.Add("OTA", "TAG 10-91D", "Tag 10-91d!", "npc/metropolice/vo/tag10-91d.wav")
Schema.voices.Add("OTA", "TAG BUG", "Tag one bug!", "npc/metropolice/vo/tagonebug.wav")
Schema.voices.Add("OTA", "TAG NECROTIC", "Tag one necrotic!", "npc/metropolice/vo/tagonenecrotic.wav")
Schema.voices.Add("OTA", "TAG PARASITIC", "Tag one parasitic!", "npc/metropolice/vo/tagoneparasitic.wav")
Schema.voices.Add("OTA", "TAP", "Tap!", "npc/metropolice/vo/tap.wav")
Schema.voices.Add("OTA", "TARGET", "Target.", "npc/combine_soldier/vo/target.wav")
Schema.voices.Add("OTA", "TRACKER", "Tracker.", "npc/combine_soldier/vo/tracker.wav")
Schema.voices.Add("OTA", "TRANSITBLOCK", "Transit-block.", "npc/metropolice/vo/transitblock.wav")
Schema.voices.Add("OTA", "UNIFORM", "Uniform.", "npc/combine_soldier/vo/uniform.wav")
Schema.voices.Add("OTA", "UNION", "Union!", "npc/metropolice/vo/union.wav")
Schema.voices.Add("OTA", "VAMP", "Vamp.", "npc/combine_soldier/vo/vamp.wav")
Schema.voices.Add("OTA", "VICTOR", "Victor!", "npc/metropolice/vo/victor.wav")
Schema.voices.Add("OTA", "VISCON", "Viscon.", "npc/combine_soldier/vo/viscon.wav")
Schema.voices.Add("OTA", "VISUAL EXOGEN", "Visual on exogen.", "npc/combine_soldier/vo/visualonexogens.wav")
Schema.voices.Add("OTA", "WASTERIVER", "Wasteriver.", "npc/metropolice/vo/wasteriver.wav")
Schema.voices.Add("OTA", "WINDER", "Winder.", "npc/combine_soldier/vo/winder.wav")
Schema.voices.Add("OTA", "WORKFORCE", "Workforce intake.", "npc/metropolice/vo/workforceintake.wav")
Schema.voices.Add("OTA", "WRAP IT UP", "That's it, wrap it up.", "npc/combine_soldier/vo/thatsitwrapitup.wav")
Schema.voices.Add("OTA", "XRAY", "XRay!", "npc/metropolice/vo/xray.wav")
Schema.voices.Add("OTA", "YELLOW", "Yellow!", "npc/metropolice/vo/yellow.wav")
Schema.voices.Add("OTA", "ZONE", "Zone!", "npc/metropolice/vo/zone.wav")
Schema.voices.Add("OTA", "10-2", "10-2.", "npc/metropolice/vo/ten2.wav")
Schema.voices.Add("OTA", "10-4", "10-4.", "npc/metropolice/vo/ten4.wav")

PLUGIN:AddCPVoice("zero", "0", "Zero")
PLUGIN:AddCPVoice("one", "1", "One")
PLUGIN:AddCPVoice("two", "2", "Two")
PLUGIN:AddCPVoice("three", "3", "Three")
PLUGIN:AddCPVoice("four", "4", "Four")
PLUGIN:AddCPVoice("five", "5", "Five")
PLUGIN:AddCPVoice("six", "6", "Six")
PLUGIN:AddCPVoice("seven", "7", "Seven")
PLUGIN:AddCPVoice("eight", "8", "Eight")
PLUGIN:AddCPVoice("nine", "9", "Nine")
PLUGIN:AddCPVoice("ten", "10", "Ten")
PLUGIN:AddCPVoice("eleven", "11", "Eleven")
PLUGIN:AddCPVoice("twelve", "12", "Twelve")
PLUGIN:AddCPVoice("thirteen", "13", "Thirteen")
PLUGIN:AddCPVoice("fourteen", "14", "Fourteen")
PLUGIN:AddCPVoice("fifteen", "15", "Fifteen")
PLUGIN:AddCPVoice("sixteen", "16", "Sixteen")
PLUGIN:AddCPVoice("seventeen", "17", "Seventeen")
PLUGIN:AddCPVoice("eighteen", "18", "Eighteen")
PLUGIN:AddCPVoice("nineteen", "19", "Nineteen")
PLUGIN:AddCPVoice("twenty", "20", "Twenty")
PLUGIN:AddCPVoice("thirty", "30", "Thirty")
PLUGIN:AddCPVoice("fourty", "40", "Fourty")
PLUGIN:AddCPVoice("fifty", "50", "Fifty")
PLUGIN:AddCPVoice("sixty", "60", "Sixty")
PLUGIN:AddCPVoice("seventy", "70", "Seventy")
PLUGIN:AddCPVoice("eighty", "80", "Eighty")
PLUGIN:AddCPVoice("ninety", "90", "Ninety")
PLUGIN:AddCPVoice("onehundred", "100", "One-hundred")
PLUGIN:AddCPVoice("twohundred", "200", "Two-hundred")
PLUGIN:AddCPVoice("threehundred", "300", "Three-hundred")

-- COMBINE SOLDIER ONLY
Schema.voices.Add("OTA", "PAIN1", "Owwch!", "npc/combine_soldier/pain1.wav")
Schema.voices.Add("OTA", "PAIN2", "Argh!", "npc/combine_soldier/pain2.wav")
Schema.voices.Add("OTA", "PAIN3", "Arh!", "npc/combine_soldier/pain3.wav")

PLUGIN:AddOverwatchVoice("alert1", "ALERT 1", "Alert one!")
PLUGIN:AddOverwatchVoice("nomad", "N", "Nomad")
PLUGIN:AddOverwatchVoice("closing", "CLOSING", "Closing.")
PLUGIN:AddOverwatchVoice("closing2", "CLOSING2", "Closing.")
PLUGIN:AddOverwatchVoice("anticitizenone", "AC1", "Anti-Citizen One")
PLUGIN:AddOverwatchVoice("anticitizenone", "AC ONE", "Anti-Citizen One")
PLUGIN:AddOverwatchVoice("anticitizenone", "ANTICITIZEN 1", "Anti-Citizen One")
PLUGIN:AddOverwatchVoice("anticitizenone", "ANTI-CITIZEN 1", "Anti-Citizen One")
PLUGIN:AddOverwatchVoice("overwatchrequestreserveactivation", "REQUEST RESERVE", "Overwatch, request reserve activation!")
PLUGIN:AddOverwatchVoice("overwatchrequestreserveactivation", "REQUEST RESERVES", "Overwatch, request reserve activation!")
PLUGIN:AddOverwatchVoice("overwatchrequestreserveactivation", "OVERWATCH REQUEST RESERVE ACTIVATION", "Overwatch, request reserve activation!")
PLUGIN:AddOverwatchVoice("overwatchrequestreserveactivation", "OVERWATCH REQUEST RESERVE", "Overwatch, request reserve activation!")
PLUGIN:AddOverwatchVoice("isfinalteamunitbackup", "IS FINAL TEAM UNIT", "is final team unit, request backup!")
PLUGIN:AddOverwatchVoice("isfinalteamunitbackup", "IS FINAL UNIT", "is final team unit, request backup!")


PLUGIN:AddOverwatchVoice("targetblackout", "TARGET BLACKOUT", "Target blackout, sweep and resume.")
PLUGIN:AddOverwatchVoice("lostcontact", "LOST CONTACT", "lost contact.")
PLUGIN:AddOverwatchVoice("motioncheckallradials", "MOTION CHECK ALL RADIALS", "Motion check all radials.")
PLUGIN:AddOverwatchVoice("motioncheckallradials", "CHECK ALL RADIALS", "Motion check all radials.")
PLUGIN:AddOverwatchVoice("motioncheckallradials", "MOTION CHECK", "Motion check all radials.")
PLUGIN:AddOverwatchVoice("stayalertreportsightlines", "STAY ALERT REPORT SIGHTLINES", "Stay alert, report sightlines.")
PLUGIN:AddOverwatchVoice("stayalertreportsightlines", "REPORT SIGHTLINES", "Stay alert, report sightlines.")
PLUGIN:AddOverwatchVoice("fixsightlinesmovein", "FIX SIGHTLINES", "Fix sightlines, move in!")
PLUGIN:AddOverwatchVoice("fixsightlinesmovein", "FIX SIGHTLINE", "Fix sightlines, move in!")
PLUGIN:AddOverwatchVoice("engagedincleanup", "ENGAGED IN CLEANUP", "engaged in cleanup")
PLUGIN:AddOverwatchVoice("engagedincleanup", "IN CLEANUP", "engaged in cleanup")
PLUGIN:AddOverwatchVoice("cleaned", "CLEANED", "Cleaned.")
PLUGIN:AddOverwatchVoice("necrotics", "NECROTICS", "Necrotics.")
PLUGIN:AddOverwatchVoice("necroticsinbound", "NECROTICS INBOUND", "Necrotics inbound.")
PLUGIN:AddOverwatchVoice("weareinaninfestationzone", "INFESTATION ZONE", "we are in an infestation zone.")
PLUGIN:AddOverwatchVoice("weareinaninfestationzone", "WE ARE IN AN INFESTATION ZONE", "we are in an infestation zone.")
PLUGIN:AddOverwatchVoice("wehavenontaggedviromes", "VIROMES", "we have non-tagged viromes.")
PLUGIN:AddOverwatchVoice("swarmoutbreakinsector", "SWARM OUTBREAK IN SECTOR", "swarm outbreak in sector")
PLUGIN:AddOverwatchVoice("swarmoutbreakinsector", "SWARM OUTBREAK", "swarm outbreak in sector")
PLUGIN:AddOverwatchVoice("wehavenontaggedviromes", "VIROMES", "we have non-tagged viromes.")
PLUGIN:AddOverwatchVoice("wehavenontaggedviromes", "NON-TAGGED VIROMES", "we have non-tagged viromes.")
PLUGIN:AddOverwatchVoice("wehavenontaggedviromes", "NONTAGGED VIROMES", "we have non-tagged viromes.")
PLUGIN:AddOverwatchVoice("wehavenontaggedviromes", "WE HAVE NON-TAGGED VIROMES", "we have non-tagged viromes.")
PLUGIN:AddOverwatchVoice("wehavenontaggedviromes", "WE HAVE NONTAGGED VIROMES", "we have non-tagged viromes.")
PLUGIN:AddOverwatchVoice("callcontactparasitics", "CALL CONTACT PARASITE", "Call contact, parasitics.")
PLUGIN:AddOverwatchVoice("callcontactparasitics", "CALL CONTACT PARASITES", "Call contact, parasitics.")
PLUGIN:AddOverwatchVoice("callcontactparasitics", "CALL CONTACT PARASITICS", "Call contact, parasitics.")
PLUGIN:AddOverwatchVoice("callcontactparasitics", "CONTACT PARASITE", "Call contact, parasitics.")
PLUGIN:AddOverwatchVoice("callcontactparasitics", "CONTACT PARASITES", "Call contact, parasitics.")
PLUGIN:AddOverwatchVoice("callcontactparasitics", "CONTACT PARASITIC", "Call contact, parasitics.")
PLUGIN:AddOverwatchVoice("callcontactparasitics", "CONTACT PARASITICS", "Call contact, parasitics.")
PLUGIN:AddOverwatchVoice("wehavefreeparasites", "FREE PARASITE", "We have free parasites.")
PLUGIN:AddOverwatchVoice("wehavefreeparasites", "FREE PARASITES", "We have free parasites.")
PLUGIN:AddOverwatchVoice("wehavefreeparasites", "WE HAVE FREE PARASITE", "We have free parasites.")
PLUGIN:AddOverwatchVoice("wehavefreeparasites", "WE HAVE FREE PARASITES", "We have free parasites.")
PLUGIN:AddOverwatchVoice("contact", "CONTACT", "Contact.")
PLUGIN:AddOverwatchVoice("sterilized", "STERILIZED", "Sterilized.")
PLUGIN:AddOverwatchVoice("contained", "CONTAINED", "Contained.")
PLUGIN:AddOverwatchVoice("containmentproceeding", "CONTAINMENT PROCEEDING", "Containment proceeding.")
PLUGIN:AddOverwatchVoice("overwatchteamisdown", "TEAM IS DOWN", "Overwatch team is down, sector is not controlled.")
PLUGIN:AddOverwatchVoice("overwatchsectoroverrun", "SECTOR OVERRUN", "Overwatch, Sector Overrun repeat Sector Overrun.")
PLUGIN:AddOverwatchVoice("overwatchrequestskyshield", "REQUEST SKYSHIELD", "Overwatch, request Skyshield.")
PLUGIN:AddOverwatchVoice("overwatchrequestwinder", "REQUEST WINDER", "Overwatch, request Winder dispatch.")
PLUGIN:AddOverwatchVoice("hasnegativemovement", "HAS NO MOVEMENT", "Has negative movement.")
PLUGIN:AddOverwatchVoice("hasnegativemovement", "NO MOVEMENT", "Has negative movement.")
PLUGIN:AddOverwatchVoice("hasnegativemovement", "HAS NEGATIVE MOVEMENT", "Has negative movement.")
PLUGIN:AddOverwatchVoice("hasnegativemovement", "NEGATIVE MOVEMENT", "Has negative movement.")
PLUGIN:AddOverwatchVoice("sector", "SECTOR", "Sector")
PLUGIN:AddOverwatchVoice("copy", "COPY", "Copy")
PLUGIN:AddOverwatchVoice("standingby]", "STANDING BY", "Standing by")
PLUGIN:AddOverwatchVoice("copythat", "COPY THAT", "Copy that")
PLUGIN:AddOverwatchVoice("requestmedical", "REQUEST MEDICAL", "Request Medical!")
PLUGIN:AddOverwatchVoice("requeststimdose", "REQUEST STIMDOSE", "Request Stimdose!")
PLUGIN:AddOverwatchVoice("displace", "DISPLACE", "Displace!")
PLUGIN:AddOverwatchVoice("displace2", "DISPLACE2", "Displace!")
PLUGIN:AddOverwatchVoice("alert1", "ALERT ONE", "Alert one!")
PLUGIN:AddOverwatchVoice("bouncerbouncer", "BOUNCER", "Bouncer, bouncer!")
PLUGIN:AddOverwatchVoice("callcontacttarget1", "TARGET ONE", "Call contact suspect Target One.")
PLUGIN:AddOverwatchVoice("contactconfim", "CONTACT CONFIRM", "Contact confirm.")
PLUGIN:AddOverwatchVoice("contactconfirmprosecuting", "CONTACT CONFIRM PROSECUTING", "Contact confirm. Prosecuting!")
PLUGIN:AddOverwatchVoice("cover", "COVER", "Cover.")
PLUGIN:AddOverwatchVoice("coverhurt", "COVER!", "Cover!")
PLUGIN:AddOverwatchVoice("coverme", "COVER ME", "Cover me.")
PLUGIN:AddOverwatchVoice("designatetargetas", "DESIGNATE TARGET AS", "Designate target as... ")
PLUGIN:AddOverwatchVoice("designatetargetas", "TARGET AS", "Designate target as... ")
PLUGIN:AddOverwatchVoice("engaging", "ENGAGING", "Engaging.")
PLUGIN:AddOverwatchVoice("fist", "FIST", "Fist")
PLUGIN:AddOverwatchVoice("flaredown", "FLARE", "Flare down!")
PLUGIN:AddOverwatchVoice("flash", "FLASH", "Flash!")
PLUGIN:AddOverwatchVoice("flatline", "FLATLINE", "Flatline")
PLUGIN:AddOverwatchVoice("flush", "FLUSH", "Flush")
PLUGIN:AddOverwatchVoice("fullactive", "FULL ACTIVE", "Full active.")
PLUGIN:AddOverwatchVoice("executingfullresponse", "FULL RESPONSE", "Executing full response!")
PLUGIN:AddOverwatchVoice("executingfullresponse", "EXECUTING FULL RESPONSE", "Executing full response!")
PLUGIN:AddOverwatchVoice("goactiveintercept", "GO ACTIVE INTERCEPT", "Go active intercept.")
PLUGIN:AddOverwatchVoice("gosharp", "GO SHARP", "Go sharp!")
PLUGIN:AddOverwatchVoice("holdingon10-14duty", "10-14", "Holding on 10-14 duty.")
PLUGIN:AddOverwatchVoice("isatcode", "IS AT CODE", "is at code")
PLUGIN:AddOverwatchVoice("isholdingatcode", "IS HOLDING AT CODE", "is holding at code")
PLUGIN:AddOverwatchVoice("noviscon", "NO VISCON", "No Viscon.")
PLUGIN:AddOverwatchVoice("outbreak", "OUTBREAK", "Outbreak!")
PLUGIN:AddOverwatchVoice("reportallpositionsclear", "REPORT ALL CLEAR", "Report all positions clear")
PLUGIN:AddOverwatchVoice("reportallpositionsclear", "REPORT ALL POSITIONS CLEAR", "Report all positions clear")
PLUGIN:AddOverwatchVoice("reportallradialsfree", "REPORT ALL RADIALS FREE", "Report all radials free.")
PLUGIN:AddOverwatchVoice("reportallradialsfree", "REPORT ALL RADIALS", "Report all radials free.")
PLUGIN:AddOverwatchVoice("ripcordripcord", "RIPCORD RIPCORD", "Ripcord! Ripcord")
PLUGIN:AddOverwatchVoice("ripcordripcord", "RIPCORD2", "Ripcord! Ripcord")
PLUGIN:AddOverwatchVoice("sectorissecurenovison", "SECTOR SECURE NO VISCON", "Sector is secure, no Viscon.")
PLUGIN:AddOverwatchVoice("sectorissecurenovison", "SECURE NO VISCON", "Sector is secure, no Viscon.")
PLUGIN:AddOverwatchVoice("sightlineisclear", "SIGHTLINE CLEAR", "Sightline is clear.")
PLUGIN:AddOverwatchVoice("sightlineisclear", "SIGHTLINE IS CLEAR", "Sightline is clear.")
PLUGIN:AddOverwatchVoice("stabilizationteamhassector", "TEAM HAS SECTOR CONTROL", "Stabilization team has sector control.")
PLUGIN:AddOverwatchVoice("stabilizationteamhassector", "TEAM HAS SECTOR", "Stabilization team has sector control.")
PLUGIN:AddOverwatchVoice("stabilizationteamholding", "STABILIZATION TEAM HOLDING IN POSITION", "Stabilization team holding in position.")
PLUGIN:AddOverwatchVoice("stabilizationteamholding", "STABILIZATION TEAM HOLDING", "Stabilization team holding in position.")
PLUGIN:AddOverwatchVoice("stabilizationteamholding", "TEAM HOLDING", "Stabilization team holding in position.")
PLUGIN:AddOverwatchVoice("stabilizationteamholding", "TEAM HOLDING", "Stabilization team is holding in position.")
PLUGIN:AddOverwatchVoice("suppressing", "SUPPRESSING", "Suppressing.")
PLUGIN:AddOverwatchVoice("targetcompromisedmovein", "TARGET COMPROMISED", "Target compromised, move in! Move in!")
PLUGIN:AddOverwatchVoice("targetcontactat", "TARGET AT", "Target contact at")
PLUGIN:AddOverwatchVoice("targetineffective", "TARGET INEFFECTIVE", "Target ineffective.")
PLUGIN:AddOverwatchVoice("targetineffective", "TARGET NO EFFECT", "Target ineffective.")
PLUGIN:AddOverwatchVoice("bodypackholding", "BODYPACK HOLDING", "Bodypack holding.")
PLUGIN:AddOverwatchVoice("targetcontactat", "TARGET CONTACT AT", "Target contact at")
PLUGIN:AddOverwatchVoice("teamdeployedandscanning", "TEAM DEPLOYED", "Team is deployed and scanning.")
PLUGIN:AddOverwatchVoice("teamdeployedandscanning", "TEAM DEPLOYED", "Team is deployed and scanning.")
PLUGIN:AddOverwatchVoice("unitisclosing", "UNIT IS CLOSING", "Unit is closing.")
PLUGIN:AddOverwatchVoice("unitisinbound", "UNIT IS INBOUND", "Unit is inbound.")
PLUGIN:AddOverwatchVoice("unitismovingin", "UNIT IS MOVING IN", "Unit is moving in.")
PLUGIN:AddOverwatchVoice("unitismovingin", "UNIT IS MOVING", "Unit is moving in.")

PLUGIN:AddOverwatchVoice("zero", "0", "Zero")
PLUGIN:AddOverwatchVoice("one", "1", "One")
PLUGIN:AddOverwatchVoice("two", "2", "Two")
PLUGIN:AddOverwatchVoice("three", "3", "Three")
PLUGIN:AddOverwatchVoice("four", "4", "Four")
PLUGIN:AddOverwatchVoice("five", "5", "Five")
PLUGIN:AddOverwatchVoice("six", "6", "Six")
PLUGIN:AddOverwatchVoice("seven", "7", "Seven")
PLUGIN:AddOverwatchVoice("eight", "8", "Eight")
PLUGIN:AddOverwatchVoice("niner", "9", "Nine")
PLUGIN:AddOverwatchVoice("ten", "10", "Ten")
PLUGIN:AddOverwatchVoice("eleven", "11", "Eleven")
PLUGIN:AddOverwatchVoice("twelve", "12", "Twelve")
PLUGIN:AddOverwatchVoice("thirteen", "13", "Thirteen")
PLUGIN:AddOverwatchVoice("fourteen", "14", "Fourteen")
PLUGIN:AddOverwatchVoice("fifteen", "15", "Fifteen")
PLUGIN:AddOverwatchVoice("sixteen", "16", "Sixteen")
PLUGIN:AddOverwatchVoice("seventeen", "17", "Seventeen")
PLUGIN:AddOverwatchVoice("eighteen", "18", "Eighteen")
PLUGIN:AddOverwatchVoice("nineteen", "19", "Nineteen")
PLUGIN:AddOverwatchVoice("twenty", "20", "Twenty")
PLUGIN:AddOverwatchVoice("thirty", "30", "Thirty")
PLUGIN:AddOverwatchVoice("fourty", "40", "Fourty")
PLUGIN:AddOverwatchVoice("fifty", "50", "Fifty")
PLUGIN:AddOverwatchVoice("sixty", "60", "Sixty")
PLUGIN:AddOverwatchVoice("seventy", "70", "Seventy")
PLUGIN:AddOverwatchVoice("eighty", "80", "Eighty")
PLUGIN:AddOverwatchVoice("ninety", "90", "Ninety")
PLUGIN:AddOverwatchVoice("onehundred", "100", "One-hundred")
PLUGIN:AddOverwatchVoice("twohundred", "200", "Two-hundred")
PLUGIN:AddOverwatchVoice("threehundred", "300", "Three-hundred")

PLUGIN:AddOverwatchVoice("meters", "METERS", "Meters")
PLUGIN:AddOverwatchVoice("bearing", "BEARING", "Bearing")
PLUGIN:AddOverwatchVoice("degrees", "DEGREES", "Degrees")
