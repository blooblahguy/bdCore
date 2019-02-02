local bdCore, c, f = select(2, ...):unpack()

bdCore.caches = {}
bdCore.caches.auras = {}

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
	["Sargeras' Rage"] = true,
	["Sargeras' Fear"] = true,
	["Unleashed Rage"] = true,
	["Crushing Fear"] = true,
	["Sentence of Sargeras"] = true,
	["Shattered Bonds"] = true,
	["Soul Detonation"] = true,



	------------------------------------------
	-- Uldir
	------------------------------------------
	-- Taloc
	["Plasma Dischard"] = true,
	["Blood Storm"] = true,
	["Hardened Arteries"] = true,
	["Enlarged Heart"] = true,
	["Uldir Defense Beam"] = true,

	-- Mother
	['Clinging Corruption'] = true,
	['Bacterial Outbreak'] = true,
	['Endemic Virus'] = true,
	['Spreading Epidemic'] = true,
	['Cleansing Purge'] = true,
	['Sanitizing Strike'] = true,
	['Purifying Flames'] = true,

	-- Fetic Devourer
	['Maldorous Miasma'] = true,
	['Putrid Paroxysm'] = true,

	-- Zek'voz
	['Titan Spark'] = true,
	['Void Lash'] = true,
	['Shatter'] = true,
	['Jagged Mandible'] = true,
	['Roiling Deceit'] = true,
	["Corruptor's Pact"] = true,
	['Will of the Corruptor'] = true,
	['Void Wail'] = true,
	['Psionic Blast'] = true,

	-- Vectis
	['Omega Vector'] = true,
	['Lingering Infection'] = true,
	['Bursting Legions'] = true,
	['Evolving Affliction'] = true,
	['Gestate'] = true,
	['Immunosuppression'] = true,
	['Plague Bomb'] = true,

	-- Zul
	['Absorbed in Darkness'] = true,
	['Corrupted Blood'] = true,
	['Unleashed Shadow'] = true,
	['Bound by Shadow'] = true,
	['Pit of Despair'] = true,
	['Engorged Burst'] = true,
	['Rupturing Blood'] = true,
	['Corrupted Blood'] = true,
	['Death Wish'] = true,

	-- Mythrax
	["Annihilation"] = true,
	["Essence Shear"] = true,
	["Obilivion Sphere"] = true,
	["Imminent Ruin"] = true,
	["Oblivion Veil"] = true,
	["Obliteration Beam"] = true,
	["Mind Flay"] = true,

	-- Ghuun
	["Blood Host"] = true,
	["Explosive Corruption"] = true,
	["Blighted Ground"] = true,
	["Torment"] = true,
	["Decaying Eruption"] = true,
	["Power Matrix"] = true,
	["Imperfect Physiology"] = true,
	["Matrix Surge"] = true,
	["Reorigination Blast"] = true,
	["Undulating Mass"] = true,
	["Tendrils of Corruption"] = true,
	["Unclean Contagion"] = true,
	["Growing Corruption"] = true,
	["Putrid Blood"] = true,
	["Blood Feast"] = true,
	["Gaze of G'Huun"] = true,

	-- BFA DUNGEONS
	["Stinging Venom"] = true,
	["Slicing Blast"] = true,
	["Deadeye"] = true,
	["Plague Step"] = true,
	["Jagged Nettles"] = true,
	["Iced Spritzer"] = true,
	["Neurotoxin"] = true,
	["Embalming Fluid"] = true,
	["Blood Maw"] = true,
	["Tainted Blood"] = true,
	["Cursed Slash"] = true,
	["Carve Flesh"] = true,
	["Incendiary Rounds"] = true,
	["Rat Traps"] = true,
	["Soul Thorns"] = true,
	["Brain Freeze"] = true,
	["Heart Attack"] = true,
	["Severing Blade"] = true,
	["Savage Cleave"] = true,
	["Venomfang Strike"] = true,
	["Crushing Slam"] = true,
	["Unending Darkness"] = true,
	["Massive Chomp"] = true,
	["Infected Wound"] = true,
	["Death Lens"] = true,
	["Rock Lance"] = true,
	["Snake Charm"] = true,
	["Suppression Slam"] = true,
	["Thirst For Blood"] = true,
	["Serrated Teeth"] = true,
	["Putrid Waters"] = true,
	["Rip Mind"] = true,
	["Itchy Bite"] = true,
	["Scabrous Bite"] = true,
	["Jagged Cut"] = true,
	["Blinding Sand"] = true,
	["Axe Barrage"] = true,
	["Serrated Fangs"] = true,
	["Abyssal Strike"] = true,
	["Sand Trap"] = true,
	["A Knot of Snakes"] = true,
	["Drain Fluids"] = true,
	["Putrid Blood"] = true,
	["Vicious Mauling"] = true,
	["Galvanize"] = true,
	["Dessication"] = true,
	["Explosive Burst"] = true,
	["Plague"] = true,
	["Shattered Defenses"] = true,
	
-- Battle for Dazar'alor,
	-- Grong,
	["Apetagonizer Core"] = 1,
	["Rending Bite"] = 1,
	["Bestial Throw Target"] = 2,

	--Jadefire,
	["Searing Embers"] = 2,
	["Rising Flames"] = 1,

	--Opulence,
	["Liquid Gold"] = 1,
	["Thief's bane"] = 1,
	-- Your designated gem (de)buff,
	["Volatile Charge"] = 1,
	["Hex of Lethargy"] = 2,

	--Conclave,
	["Bwomsamdi Curse"] = 1,
	["Kimbul Targeting Debuff"] = 1,
	["Mind Wipe"] = 2,
	["Crawling Hex"] = 1,
	["Lacerating Claws"] = 1,
	
	--Rastakhan,
	["Grievous Axe"] = 2,
	["Caress of Death"] = 1,
	["Scorching Detonation"] = 1,
	["Toad Toxin"] = 1,
	["Death's door"] = 1,

	--Mekkatorque,
	["Discombobulation"] = 1,
	["Gigavolt Blast"] = 1,
	["Gigavolt Charge"] = 1,
	["Buster Cannon "] = 1,
	["Gigavolt Radiation"] = 1,
	["Sheep Shrapnel"] = 1,

	--Blockade,
	["Tempting Song"] = 1,
	["Storm's Wail"] = 1,
	["Kelp-Wrapped"] = 1,

	--Jaina,
	["Grasp of Frost"] = 2,
	["Hand of Frost"] = 2,
	["Broadside"] = 1,
	["Siegebreaker Blast"] = 1,
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

-- register everything with shared media
local shared = LibStub:GetLibrary("LibSharedMedia-3.0")
shared:Register("font", "bdFont", bdCore.media.font)
shared:Register("statusbar", "bdSmooth", bdCore.media.smooth)
shared:Register("background", "bdSmooth", bdCore.media.smooth)
shared:Register("statusbar", "bdFlat", bdCore.media.flat)
shared:Register("background", "bdFlat", bdCore.media.flat)
shared:Register("border", "bdShadow", bdCore.media.shadow)

-- general
	bdCore.general = {}
	bdCore.general[#bdCore.general+1] = {warning = {
		type = "text",
		value = "Changing font and background are still a work in progress."
	}}
	bdCore.general[#bdCore.general+1] = {font = {
		type = "dropdown",
		value = "bdFont",
		options = {},
		label = "Font",
		persistent = true,
		tooltip = "The font which all bdAddons use as their font.",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}
	bdCore.general[#bdCore.general+1] = {fontScale = {
		type = "slider"
		, label = "Scale of all base UI fonts"
		, value = 1
		, min = 0.5
		, max = 2.0
		, step = 0.1
		, callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}

	bdCore.general[#bdCore.general+1] = {background = {
		type = "dropdown",
		value = "bdSmooth",
		options = {},
		label = "Backgrounds Texture",
		persistent = true,
		tooltip = "The texture which all bdAddons use as their background.",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}

	bdCore.general[#bdCore.general+1] = {border = {
		type = "slider",
		value = 2,
		min = 0,
		max = 2,
		step = 1,
		label = "Border Width",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}

	bdCore.general[#bdCore.general+1] = {errorblock = {
		type = "checkbox",
		value = true,
		label = "Block Red Error Text Spam",
	}}
	bdCore.general[#bdCore.general+1] = {changefonts = {
		type = "checkbox",
		value = true,
		label = "Change UI Fonts",
	}}
	bdCore.general[#bdCore.general+1] = {interrupt = {
		type = "checkbox",
		value = true,
		label = "Announce Interrupts",
	}}
	bdCore.general[#bdCore.general+1] = {doubleclickbo = {
		type = "checkbox",
		value = true,
		label = "Double Click buyout",
		tooltip = "When double clicking on an auction it will buyout.",
	}}
	bdCore.general[#bdCore.general+1] = {alteratepowerbar = {
		type = "checkbox",
		value = true,
		label = "Use Alternate Power Bar",
	}}
	bdCore.general[#bdCore.general+1] = {forcescale = {
		type = "checkbox",
		value = true,
		label = "Force UI scale for pixel perfect borders",
	}}

----------------------------------------
-- skinning
----------------------------------------
	bdCore.general[#bdCore.general+1] = {skingmotd = {
		type = "checkbox",
		value = true,
		label = "Show popup GMOTD",
	}}
	bdCore.general[#bdCore.general+1] = {skinwas = {
		type = "checkbox",
		value = false,
		label = "Skin Weak Auras to bd Style",
	}}
	-- bdCore.general[#bdCore.general+1] = {fancymenu = {
	-- 	type = "checkbox",
	-- 	value = false,
	-- 	label = "Replace Game Menu with Fancy Menu",
	-- }}

----------------------------------------
-- viewports
----------------------------------------
	bdCore.general[#bdCore.general+1] = {tab = {
		type = "tab",
		value = "Viewports"
	}}
	bdCore.general[#bdCore.general+1] = {text = {
		type = "text",
		value = "Personal recommendation: a 60px viewport at the top and bottom of your screen can mimic an extended camera zoom distance.",
	}}
	bdCore.general[#bdCore.general+1] = {topViewport = {
		type = "slider",
		value = 0,
		min = 0,
		max = 500,
		step = 2,
		label = "Top Viewport",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}
	
	bdCore.general[#bdCore.general+1] = {topViewportBGColor={
		type="color",
		value = {.09,.1,.13, 1},
		name="Top Viewport Color",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}

	bdCore.general[#bdCore.general+1] = {bottomViewport = {
		type = "slider",
		value = 0,
		min = 0,
		max = 500,
		step = 2,
		label = "Bottom Viewport",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}
	
	bdCore.general[#bdCore.general+1] = {bottomViewportBGColor={
		type="color",
		value = {.09,.1,.13, 1},
		name="Bottom Viewport Color",
		callback = function() bdCore:triggerEvent("bdcore_redraw") end
	}}

----------------------------------------
bdCore.auraconfig = {}
bdCore.auraconfig[#bdCore.auraconfig+1] = {tab = {
	type="tab",
	value="Whitelist"
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {text = {
	type="text",
	value="Nothing is shown by default, add an aura to this list to have it show up. Useful for personal cooldowns, raid encounter debuffs, or other player auras."
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {whitelist = {
	type = "list",
	value = bdCore.auras.whitelist,
	label = "Whitelisted Auras",
}}

-- Mine
bdCore.auraconfig[#bdCore.auraconfig+1] = {tab = {
	type="tab",
	value="My Casts"
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {text = {
	type="text",
	value="Shows spells that are cast only by you."
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {mine = {
	type = "list",
	value = bdCore.auras.mine,
	label = "Auras Cast by Me",
}}

-- Class
bdCore.auraconfig[#bdCore.auraconfig+1] = {tab = {
	type="tab",
	value="All "..bdCore.class.." Auras"
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {text = {
	type="text",
	value="Shows spells that are cast only by the class you are currently playing. IE show paladin beacons while you are a paladin."
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {[bdCore.class] = {
	type = "list",
	value = bdCore.auras['Personal Auras'][bdCore.class],
	label = 'All '..bdCore.class.." Auras",
}}

-- Blacklist
bdCore.auraconfig[#bdCore.auraconfig+1] = {tab = {
	type="tab",
	value="Blacklist"
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {text = {
	type="text",
	value="The blacklist overrides all previous aura configurations and hides an aura if its in this list."
}}
bdCore.auraconfig[#bdCore.auraconfig+1] = {blacklist = {
	type = "list",
	value = bdCore.auras.blacklist,
	label = "Blacklisted Auras",
}}