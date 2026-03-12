Config = Config or {}

Config.AnimDict = 'amb@world_human_seat_wall_tablet@female@base'
Config.Prop = 'prop_cs_tablet'
Config.Bone = 28422

Config.ShadyMan = {
	ped = "s_m_y_construct_02",
	name = "Construction Worker",
	animName = "base",
	animDist = "missdocksshowoffcar@idle_a",
	tag ="Union Worker",
	tagcolor = "#E8923C",
}

Config.ShadyWait = 90000--180000

Config.RussianPaymentMin = 1250
Config.RussianPaymentMax = 1750
Config.RussianInfo = {
	ped = "u_m_o_finguru_01",
	name = '"The Russian"',
	animName = "base",
	animDist = "amb@world_human_cop_idles@male@idle_b",
	tag ="Organized Crime Boss",
	tagcolor = "#696969",
	driverPed = "a_m_m_farmer_01",
	driverAnimName = "base",
	driverAnimDist = "misscarsteal4@vendor",
	truckModel = "bison3",
	houseParkCoords = vector4(-1796.1,401.08,112.37,307.89),
	russianDoorCoords = vector4(-1797.95,409.01,113.67,29.69),
	driverIdleCoords = vector4(-1789.35,395.53,112.79,285.22)
}

Config.RussianSpawns = {
	[1] = {
		russian = vector4(-652.32,-1212.87,11.02,300.74),
		truck = vector4(-645.63,-1214.27,10.86,303.33),
		driver = vector4(-646.59,-1212.27,11.34,22.15),
	},
	[2] = {
		russian = vector4(1082.69,-787.83,58.26,209.82),
		truck = vector4(1085.76,-793.04,57.8,272.38),
		driver = vector4(1086.81,-791.43,58.26,17.07),
	},
	[3] = {
		russian = vector4(185.58,307.6,105.39,156.95),
		truck = vector4(183.72,301.73,104.92,224.63),
		driver = vector4(183.41,305.4,105.4,151.8),
	},
	[4] = {
		russian = vector4(-1522.05,-560.7,33.28,23.36),
		truck = vector4(-1522.1,-553.57,32.77,125.11),
		driver = vector4(-1522.04,-557.96,33.26,171.06),
	},
}

Config.MaterialPile = vector4(59.48,-397.88,39.92,75.79)



Config.Car = {
    model = "bison3",
    plate = "TRUK",
	spawn = vector4(32.43,-418.96,39.92,70.82)
}

Config.Barriers ="prop_barrier_wat_03b"
Config.Sign = "prop_barrier_work04a"
Config.FibreOp = "prop_cablespool_05"
Config.Supervisor = "s_m_y_construct_01"
Config.DirtPile = "prop_pile_dirt_03"
Config.ShovelProp = "prop_tool_shovel"

Config.DefaultRep = 15
Config.ConstructionRepBonus = 5
Config.NegativeRep = 100

Config.Pay = 500
Config.PayBonus = 100
Config.UnionDues = 50


Config.FibreOpticSpawns = {
	[1] = vector4(-748.01,684.13,150.42,71.33),
	[2] = vector4(57.16,-367.87,39.92,299.78),
	[3] = vector4(-822.37,-797.88,19.56,93.79),
	[4] = vector4(-1099.1,-1658.7,7.36,194.62),
	[5] = vector4(606.59,-436.4,24.74,169.12),
}

Config.RoadWorkUniforms = {
	['male'] = {
		outfitData = {
			['t-shirt'] = {item = 59, texture = 0}, --Shirt
			['torso2']  = {item = 38, texture = 0}, --Jacket
			['arms']    = {item = 47, texture = 0},
			['pants']   = {item = 9, texture = 0},
			['shoes']   = {item = 24, texture = 0},
            ['hats']    = {item = 145,texture = 1},
		}
	},
	['female'] = {
	 	outfitData = {
			['t-shirt'] = {item = 36, texture = 1}, --Shirt
			['torso2']  = {item = 50, texture = 0}, --Jacket
			['arms']    = {item = 47, texture = 0},
			['pants']   = {item = 9, texture = 0},
			['shoes']   = {item = 24, texture = 0},
            ['hats']    = {item = 145,texture = 1},
	 	}
	},
}

Config.Locales = {
	jobStarted = "Job started, grab the truck from the parking lot and get to the job site!",
	endjob = "Press ~b~E~w~ to return truck",
	jobEnded = "Good work. Come back later for another shift",
	returnVan = "Return truck to Union HQ garage",
	stillActive = "Finish the job we already gave you!",
}



Config.ConstructionSpawn = vector4(114.6,-427.45,41.08,329.81)
Config.ElectricalSpawn = vector4(523.81,-1599.49,29.3,45.5)
Config.PortSpawn = vector4(1189.33, -3105.84,5.65,177.38)
Config.GarbageSpawn = vector4(-362.8,-1566.27,24.86,203.65)


Config.RoadLocations = {
	[1] = {
		jobStart = vector4(-1262.58,-60.33,44.46,63.78),
		coneLocations = {
			[1] = vector4(-1238.22,-78.25, 43.5,235.88),
			[2] = vector4(-1236.91,-76.42,43.38,237.6),
			[3] = vector4(-1244.05,-74.81,43.88,58.52),
			[4] = vector4(-1251.2,-70.94,44.31,61.01),
			[5] = vector4(-1257.43,-67.58,44.7,73.55),
			[6] = vector4(-1261.77,-65.41,44.98,240.22),
		},
		signSpawn = vector4(-1233.58,-79.05,43.2,60.17),
		workAreas = {
			[1] = vector4(-1257.97,-65.85,44.72,329.12),
			[2] = vector4(-1247.17,-65.43,44.15,250.32),
			[3] = vector4(-1237.96,-71.61,43.53,196.96),
			[4] = vector4(-1243.17,-73.96,43.81,75.77),
			[5] = vector4(-1249.42,-68.55,44.14,88.53),
			[6] = vector4(-1240.37,-73.22,43.57,147.41)
		},
		supeLocs = {
			[1] = vector4(-1250.73,-61.15,44.35,185.74),
			[2] = vector4(-1249.08,-62.02,44.24,117.3),
			[3] = vector4(-1234.56,-72.53,43.37,110.06)
		},
		animName = "",
		animDist = "",
		prop = "",
	},
	[2] = {
		jobStart = vector4(-228.91,-1043.18,27.47,340.37),
		coneLocations = {
			[1] = vector4(-249.64,-1098.03,23.88,164.73),
			[2] = vector4(-251.97,-1096.7526,24.01,164.73),
			[3] = vector4(-248.88,-1087.53,24.6,334.79),
			[4] = vector4(-245.05,-1075.93,25.47,162.95),
			[5] = vector4(-239.33,-1060.83,26.66,339.34),
			[6] = vector4(-235.03,-1049.59,27.53,339.72)
		},
		signSpawn = vector4(-252.15,-1101.36,23.73,340.29),
		workAreas = {
			[1] = vector4(-234.58,-1051.76,27.38,245.09),
			[2] = vector4(-235.56,-1065.16,26.44,165.47),
			[3] = vector4(-244.63,-1077.81,25.33,160.26),
			[4] = vector4(-243.86,-1086.12,24.63,172.49),
			[5] = vector4(-241.61,-1070.35,25.91,351.66),
			[6] = vector4(-243.64,-1088.49,24.65,160.48)
		},
		supeLocs = {
			[1] = vector4(-241.07,-1085.67,24.9,77.94),
			[2] = vector4(-240.19,-1083.67,25.05,102.44),
			[3] = vector4(-231.33,-1058.08,27.05,84.13)
		},
		animName = "",
		animDist = "",
		prop = "",
	},
	[3] = {
		jobStart = vector4(275.98,-1551.16,28.7,300.58),
		coneLocations = {
			[1] = vector4(238.49,-1572.2,29.2,105.72),
			[2] = vector4(238.9,-1569.0,29.3,299.72),
			[3] = vector4(244.43,-1564.94,29.32,321.74),
			[4] = vector4(253.87,-1560.06,29.31,299.18),
			[5] = vector4(261.6,-1555.37,29.31,300.1),
			[6] = vector4(269.82,-1550.46,29.32,300.34)
		},
		signSpawn = vector4(233.68,-1573.31,29.27,298.91),
		workAreas = {
			[1] = vector4(266.11,-1557.11,29.16,160.48),
			[2] = vector4(258.24,-1558.63,29.29,195.87),
			[3] = vector4(254.42,-1564.85,29.11,149.83),
			[4] = vector4(246.14,-1565.86,29.28,99.09),
			[5] = vector4(242.85,-1571.05,29.14,136.24),
			[6] = vector4(262.85,-1564.1,29.16,123.56)
		},
		supeLocs = {
			[1] = vector4(257.17,-1572.94,29.29,324.71),
			[2] = vector4(259.33,-1572.99,29.29,48.88),
			[3] = vector4(259.33, -1571.43, 29.29, 107.14)
		},
		animName = "",
		animDist = "",
		prop = "",
	},
	[4] = {
		jobStart = vector4(910.96,-784.42,38.49,219.27),
		coneLocations = {
			[1] = vector4(879.59,-744.44,41.51,35.66),
			[2] = vector4(882.64,-743.34,41.49,302.4),
			[3] = vector4(889.17,-751.19,41.03,228.57),
			[4] = vector4(899.1,-761.2,40.43,220.84),
			[5] = vector4(906.81,-770.0,39.9,220.63),
			[6] = vector4(912.76,-777.41,39.38,216.8)
		},
		supeLocs = {
			[1] = vector4(902.16, -775.3, 39.65,318.46),
			[2] = vector4(903.34,-775.98,39.59,26.25),
			[3] = vector4(894.02,-765.59,40.24,312.32)
		},
		signSpawn = vector4(875.51,-739.23,41.82,224.4),
		workAreas = {
			[1] = vector4(902.57,-772.99,39.78,69.39),
			[2] = vector4(900.19,-763.67,40.31,29.71),
			[3] = vector4(890.65,-758.45,40.65,51.78),
			[4] = vector4(887.46,-750.69,41.09,27.97),
			[5] = vector4(879.57,-747.32,41.39,53.45),
			[6] = vector4(906.75,-778.4,39.37,39.37)
		},
		animName = "",
		animDist = "",
		prop = "",
	},
}