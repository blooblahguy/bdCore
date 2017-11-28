local bdCore, c, f = select(2, ...):unpack()


bdCore.auras = {}
bdCore.auras.raid = {
	['Grievous Wound'] = true,

	----------------------------------------------------
	-- Emerald Nightmare
	----------------------------------------------------
	-- Nythendra
	['Infested Ground'] = true,
	['Volatile Rot'] = true,
	['Rot'] = true,
	['Burst of Corruption'] = true,
	['Infested Breath'] = true,
	
	-- Illgynoth
	['Spew Corruption'] = true,
	['Eye of Fate'] = true,
	['Cursed Blood'] = true,
	['Death Blossom'] = true,
	['Dispersed Spores'] = true,
	['Touch of Corruption'] = true,
	
	-- Renferal
	['Web of Pain'] = true,
	['Necrotic Venom'] = true,
	['Dripping Fangs'] = true,
	['Raking Talons'] = true,
	['Twisting Shadows'] = true,
	['Web of Pain'] = true,
	['Tangled Webs'] = true,
	
	-- Ursoc
	['Focused Gaze'] = true,
	['Overwhelm'] = true,
	['Rend Flesh'] = true,
	
	-- Dragons
	['Nightmare Bloom'] = true,
	['Slumbering Nightmare'] = true,
	['Defiled Vines'] = true,
	['Sleeping Fog'] = true,
	['Shadow Burst'] = true,
	
	-- Cenarius
	['Nightmare Javelin'] = true,
	['Scorned Touch'] = true,
	['Spear of Nightmares'] = true,
	['Nightmare Brambles'] = true,
	
	-- Xavius
	['Dream Simulacrum'] = true,
	['Blackening Soul'] = true,	
	['Darkening Soul'] = true,	
	['Tainted Discharge'] = true,	
	['Corruption: Decent into Madness'] = true,	
	['Bonds of Terror'] = true,	
	['Tormenting Fixation'] = true,	
	
	-- trash
	['Befoulment'] = true,
	
	----------------------------------------------------
	-- Trial of Valor
	----------------------------------------------------
	-- Odyn
	['Shield of Light'] = true,
	['Arcing Storm'] = true,
	['Expel Light'] = true,
	
	-- Guarm
	['Frost Lick'] = true,
	['Flame Lick'] = true,
	['Shadow Lick'] = true,
	
	['Flaming Volatile Foam'] = true,
	['Briney Volatile Foam'] = true,
	['Shadowy Volatile Foam'] = true,
	
	-- Helya
	['Orb of Corruption'] = true,
	['Orb of Corrosion'] = true,
	['Taint of the Sea'] = true,
	['Fetid Rot'] = true,
	['Corrupted Axiom'] = true,
	
	-- trash
	['Unholy Reckoning'] = true,
	
	----------------------------------------------------
	-- Nighthold
	----------------------------------------------------
	-- Skorpyron
	['Energy Surge'] = true,
	['Broken Shard'] = true,
	['Focused Blast'] = true,
	
	-- Chromatic Anomaly
	['Time Bomb'] = true,
	['Temporal Charge'] = true,
	['Time Release'] = true,
	
	-- Trilliax
	['Arcing Bonds'] = true,
	['Sterilize'] = true,
	['Annihilation'] = true,
	
	-- Aluriel
	["Frostbitten"] = true,
	["Annihilated"] = true,
	["Searing Brand"] = true,
	["Entombed in Ice"] = true,
	["Mark of Frost"] = true,
	
	-- Tichondrius
	['Carrion Plague'] = true,
	['Feast of Blood'] = true,
	['Essence of Night'] = true,
	
	-- Krosus
	['Orb of Destruction'] = true,
	['Searing Brand'] = true,
	
	-- Botanist
	['Parasitic Fixate'] = true,
	['Parasitic Fetter'] = true,
	['Toxic Spores'] = true,
	['Call of Night'] = true,
	
	-- Augor
	['Icy Ejection'] = true,
	['Chilled'] = true,
	['Voidburst'] = true,
	['Gravitational Pull'] = true,
	['Witness the Void'] = true,
	['Absolute Zero'] = true,
	['Felflame'] = true,
	
	-- Elisande
	['Ablation'] = true,
	['Arcanetic Ring'] = true,
	['Spanning Singularity'] = true,
	['Delphuric Beam'] = true,
	['Permeliative Torment'] = true,
	
	-- Gul'dan
	['Drain'] = true,
	['Fel Efflux'] = true,
	['Soul Sever'] = true,
	['Chaos Seed'] = true,
	['Bonds of Fel'] = true,
	['Soul Siphon'] = true,
	['Flames of Sargeras'] = true,
	['Soul Corrosion'] = true,
	["Eye of Gul'dan"] = true,
	["Empowered Eye of Gul'dan"] = true,
	["Empowered Bonds of Fel"] = true,
	["Bonds of Fel"] = true,
	["Parasitic Wound"] = true,
	["Chaos Seed"] = true,
	["Severed Soul"] = true,
	["Severed"] = true,
	["Time Stop"] = true,
	["Scattering Field"] = true,
	["Shadowy Gaze"] = true,
	
	-- Trash
	['Arcanic Release'] = true,
	['Necrotic Strike'] = true,
	['Surpress'] = true,
	['Sanguine Ichor'] = true,
	['Thunderstrike'] = true,
	['Will of the Legion'] = true,
	
	
	----------------------------------------------------
	-- Tomb of Sargeras
	----------------------------------------------------
	-- Gorth
	['Melted Armor'] = true,
	['Burning Armor'] = true,
	['Crashing Comet'] = true,
	['Fel Pool'] = true,
	['Shattering Star'] = true,
	
	-- Demonic Inquisition
	['Suffocating Dark'] = true,
	['Calcified Quills'] = true,
	['Unbearable Torment'] = true,
	
	-- Harjatan
	['Jagged Abrasion'] = true,
	['Aqueous Burst'] = true,
	['Drenching Waters'] = true,
	['Driven Assault'] = true,
	
	-- Sisters of the Moon
	['Moon Burn'] = true,
	['Twilight Volley'] = true,
	['Twilight Glaive'] = true,
	['Incorporeal Shot'] = true,
	
	-- Mistress Sassz'ine
	['Consuming Hunger'] = true,
	['Delicious Bufferfish'] = true,
	['Slicing Tornado'] = true,
	['Hydra Shot'] = true,
	['Slippery'] = true,
	
	-- Desolate Host
	["Soul Bind"] = true,
	["Spirit Chains"] = true,
	["Soul Rot"] = true,
	["Spear of Anguish"] = true,
	["Shattering Scream"] = true,
	
	-- Maiden of Vigilance
	['Unstable Soul'] = true,
	
	-- Fallen Avatar
	['Tainted Essence'] = true,
	['Black Winds'] = true,
	['Dark Mark'] = true,
	
	-- Kil'jaedan
	['Felclaws'] = true,
	['Shadow Reflection: Erupting'] = true,
	['Shadow Reflection: Wailing'] = true,
	['Shadow Reflection: Hopeless'] = true,
	['Armageddon Rain'] = true,
	['Lingering Eruption'] = true,
	['Lingering Wail'] = true,
	['Soul Anguish'] = true,
	['Focused Dreadflame'] = true,


	----------------------------------
	--	Antorus the Burning Throne
	----------------------------------
	-- Garothi
	["Fel Bombardment"] = true,
	["Haywire Decimation"] = true,
	["Decimation"] = true,

	-- Felhounds
	["Smouldering"] = true,
	["Siphoned"] = true,
	["Enflamed"] = true,
	["Singed"] = true,
	["Weight of Darkness"] = true,
	["Desolate Gaze"] = true,
	["Burning Remnant"] = true,
	["Molten Touch"] = true,
	["Consuming Sphere"] = true,

	-- High Command
	["Exploit Weakness"] = true,
	["Psychic Scarring"] = true,
	["Psychic Assault"] = true,
	["Shocked"] = true,
	["Shock Grenade"] = true,

	-- Portal Keeper
	["Reality Tear"] = true,
	["Cloying Shadows"] = true,
	["Caustic Slime"] = true,
	["Everburning Flames"] = true,
	["Fiery Detonation"] = true,
	["Mind Fog"] = true,
	["Flames of Xoroth"] = true,
	["Acidic Web"] = true,
	["Delusions"] = true,
	["Hungering Gloom"] = true,
	["Felsilk Wrap"] = true,

	-- Eonar
	["Feedback - Arcane Singularity"] = true,
	["Feedback - Targeted"] = true,
	["Feedback - Burning Embers"] = true,
	["Feedback - Foul Steps"] = true,
	["Fel Wake"] = true,
	["Rain of Fel"] = true,

	-- Imonar
	["Sever"] = true,
	["Charged Blasts"] = true,
	["Empowered Pulse Grenade"] = true,
	["Shrapnel Blast"] = true,
	["Shock Lance"] = true,
	["Empowered Shock Lance"] = true,
	["Shocked"] = true,
	["Conflagration"] = true,
	["Slumber Gas"] = true,
	["Sleep Canister"] = true,
	["Seared Skin"] = true,
	["Infernal Rockets"] = true,

	-- Kin'gorath
	["Forging Strike"] = true,
	["Ruiner"] = true,
	["Purging Protocol"] = true,

	-- Varimathras
	["Misery"] = true,
	["Echoes of Doom"] = true,
	["Necrotic Embrace"] = true,
	["Dark Fissure"] = true,
	["Marked Prey"] = true,

	-- Coven
	["Fiery Strike"] = true,
	["Flashfreeze"] = true,
	["Fury of Golganneth"] = true,
	["Fulminating Pulse"] = true,
	["Chilled Blood"] = true,
	["Cosmic Glare"] = true,
	["Spectral Army of Norgannon"] = true,
	["Whirling Saber"] = true,

	-- Aggramar
	["Taeshalach's Reach"] = true,
	["Empowered Flame Rend"] = true,
	["Foe Breaker"] = true,
	["Ravenous Blaze"] = true,
	["Wake of Flame"] = true,
	["Blazing Eruption"] = true,
	["Scorching Blaze"] = true,
	["Molten Remnants"] = true,

	-- Argus
	["Sweeping Scythe"] = true,
	["Avatar of Aggramar"] = true,
	["Soulburst"] = true,
	["Soulbomb"] = true,
	["Death Fog"] = true,
	["Soulblight"] = true,
	["Cosmic Ray"] = true,
	["Edge of Obliteration"] = true,
	["Gift of the Sea"] = true,
	["Gift of the Sky"] = true,
	["Cosmic Beacon"] = true,
	["Cosmic Smash"] = true,
	["Ember of Rage"] = true,
	["Deadly Scythe"] = true,
	["Soul Detonation"] = true
}

bdCore.auras.whitelist = {
	-- Warriors
	["Die by the Sword"] = true,
	["Shield Wall"] = true,
	["Demoralizing Shout"] = true,
	--["Enraged Regeneration"] = true,
	--["Last Stand"] = true,
	["Safeguard"] = true,
	["Vigilance"] = true,
	["Shockwave"] = true,
	
	-- Druids
	["Barkskin"] = true,
	["Survival Instincts"] = true,
	["Ironbark"] = true,
	["Bristling Fur"] = true,
	["Cyclone"] = true,
	["Entangling Roots"] = true,
	["Rapid Innervation"] = true,
	["Mark of Ursol"] = true,
	["Ironfur"] = true,
	["Frenzied Regeneration"] = true,
	["Rage of the Sleeper"] = true,

	-- Shamans
	["Shamanistic Rage"] = true,
	["Astral Shift"] = true,
	["Stone Bulwark Totem"] = true,
	["Hex"] = true,
	["Reincarnation"] = true,
	
	-- Death Knights
	["Icebound Fortitude"] = true,
	["Anti-Magic Shell"] = true,
	["Anti-Magic Zone"] = true,
	["Vampiric Blood"] = true,
	["Rune Tap"] = true,
	["Strangulate"] = true,
	
	-- Rogues
	["Feint"] = true,
	["Cloak of Shadows"] = true,
	["Riposte"] = true,
	["Smoke Bomb"] = true,
	["Between the Eyes"] = true,
	["Sap"] = true,
	["Evasion"] = true,
	["Crimson Vial"] = true,
	
	-- Mages
	["Ice Block"] = true,
	["Temporal Shield"] = true,
	["Cauterize"] = true,
	["Greater Invisibility"] = true,
	["Amplify Magic"] = true,
	["Evanesce"] = true,
	["Polymorph"] = true,
	["Polymorph: Fish"] = true,
	
	-- Warlocks
	["Dark Bargain"] = true,
	["Unending Resolve"] = true,
	
	-- Paladins
	["Divine Shield"] = true,
	["Divine Protection"] = true,
	["Blessing of Freedom"] = true,
	["Blessing of Sacrifice"] = true,
	["Ardent Defender"] = true,
	["Guardian of Ancient Kings"] = true,
	["Forbearance"] = true,
	["Hammer of Justice"] = true,
	
	
	-- Monks
	["Fortifying Brew"] = true,
	["Zen Meditation"] = true,
	["Diffuse Magic"] = true,
	["Dampen Harm"] = true,
	["Touch of Karma"] = true,
	["Paralyze"] = true,
	
	-- Hunters
	["Aspect of the Turtle"] = true,
	["Roar of Sacrifice"] = true,
	
	-- Priests
	["Dispersion"] = true,
	["Spectral Guise"] = true,
	["Pain Suppression"] = true,
	["Fear"] = true,
	["Mind Bomb"] = true,
	["Surrender Soul"] = true,
	["Guardian Spirit"] = true,
	
	-- Demon hunters
	['Blur'] = true,
	['Demon Spikes'] = true,
	['Metamorphosis'] = true,
	['Empower Wards'] = true,
	['Netherwalk'] = true,
	
	-- all palyers
	['Draenic Channeled Mana Potion'] = true,
	['Leytorrent Potion'] = true,
	['Sanguine Ichor'] = true,
}
bdCore.auras.blacklist = {
	-- paladins
	["Unyielding Faith"] = true,
	["Glyph of Templar's Verdict"] = true,
	["Beacon's Tribute"] = true,
	
	-- warlocks
	["Soul Leech"] = true,
	["Empowered Grasp"] = true,
	["Twilight Ward"] = true,
	["Shadow Trance"] = true,
	["Dark Refund"] = true,
	
	-- warriors
	["Bloody Healing"] = true,
	["Flurry"] = true,
	["Victorious"] = true,
	["Deep Wounds"] = true,
	["Mortal Wounds"] = true,
	["Enrage"] = true,
	["Blood Craze"] = true,
	["Ultimatum"] = true,
	["Sword and Board"] = true,
	
	-- Death Knights
	["Purgatory"] = true,
	
	-- misc
	["Honorless Target"] = true,
	["Spirit Heal"] = true,
	["Capacitance"] = true,
	
	["Sated"] = true,
	["Exhaustion"] = true,
	["Insanity"] = true,
	["Temporal Displacement"] = true,
	["Void-Touched"] = true,
	["Awesome!"] = true,
	["Griefer"] = true,
	["Vivianne Defeated"] = true,
	["Recently Mass Resurrected"] = true,
	
	
	-- Priests
	["Weakened Soul"] = true,
	
	-- Paladins
	["Beacon's Tribute"] = true
}

-- these only show when you are playing that class
bdCore.auras['Personal Auras'] = {
	preist = {
		["Weakened Soul"] = true,
	},
	paladin = {
		
	},
	deathknight = {
		
	},
	rogue = {
		
	},
	shaman = {
		
	},
	warlock = {
		
	},
	mage = {
		
	},
	monk = {
		
	},
	hunter = {
		
	},
	druid = {
		
	},
	warrior = {
		
	},
	demonhunter = {
		
	},
}

-- these are mostly just helpful for healers
bdCore.auras.mine = {
	-- Warlock
	['Soulstone'] = true,

	-- Monk
	['Renewing Mist'] = true,
	['Soothing Mist'] = true,
	['Essence Font'] = true,
	['Enveloping Mist'] = true,

	-- Shamans
	['Riptide'] = true,
	['Healing Rain'] = true,

	-- Druids
	["Efflorenscence"] = true,
	["Lifebloom"] = true,
	["Rejuvenation"] = true,
	["Regrowth"] = true,
	["Wild Growth"] = true,
	["Cenarion Ward"] = true,
	["Rejuvenation (Germination)"] = true,
	
	-- Paladin
	["Bestow Faith"] = true,
	["Beacon of Virtue"] = true,
	["Beacon of Light"] = true,
	["Beacon of Faith"] = true,
	["Tyr's Deliverance"] = true,
	
	-- Priest
	["Weakened Soul"] = true,
	["Renew"] = true,
	["Prayer of Mending"] = true,
	["Atonement"] = true,
	["Penance"] = true,
	["Shadow Mend"] = true,
	["Power Word: Shield"] = true,

}