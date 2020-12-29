print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricebeer = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local fabricHudFile = "Paletten/hud_fill_fabric.dds"
	local fabricHudFileSmall = "Paletten/hud_fill_fabric_smal.dds"
	
    local fabricFilType = g_fillTypeManager:addFillType("fabric", g_i18n:getText("fabric"), true, pricebeer * 4.5, 0.00045, math.rad(10), fabricHudFile, fabricHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasfabric=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasfabric=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "fabric" then
		hasfabric=true
	end;
		
end;

		if hasmaize and not hasfabric then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("fabric")
		local price = g_fillTypeManager:getFillTypeByName("fabric").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("fabric")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)