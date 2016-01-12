-- cd Desktop/justbear/Liman/BuildScript/
-- build-vs2015.bat
dofile("utils.lua")
------------------------------------------------------------------
os.chdir(os.getcwd() .. "/../")
working_dir = os.getcwd() .. "/"
 -- assets_dir = "Assets/"
 -- source_dir = "Liman/"
 --  dependsies_dir = "Dependencies/"
 --   libraries_dir = "Libraries/"
 --   include_dir = "Include/"
 -- build_dir = "Build/"
 --  resources_dir = "Resources/"
 -- temp_dir = "Temp/"
 -- lib_dir = "Lib/"
------------------------------------------------------------------
lib_ide_path = ""
if (_ACTION == "vs2013") then
	lib_ide_path = working_dir .. "Dependencies/Library/vs2013"
elseif (_ACTION == "vs2015") then
	lib_ide_path = working_dir .. "Dependencies/Library/vs2015"
end
------------------------------------------------------------------
-- print(working_dir)
------------------------------------------------------------------
if (_ACTION == "clean") then
	cleaning = true else cleaning = false
end
----------------------------------------------------------------
if (cleaning or os.is("macosx")) then premake_ver = 4  else premake_ver = 5 end
----------------------------------------------------------------
-- Maths solution
------------------------------------------------------------------
solution("Maths")

	if(premake_ver == 5) then
		startproject("Tests")
	end
	location(working_dir .. "Source/")
	includedirs { working_dir .. "Dependencies/Include" }

	if (ide_os == "windows") then
		platforms { "x32", "x64" }
		if (premake_ver == 5) then system "windows" end
		defines { "WINDOWS" }
	-- elseif (ide_os == "linux") then
	-- elseif (ide_os == "macosx") then
	-- 	-- platforms { "osX", "ios" }
	-- 	-- system "macosx"
	-- 	defines { "MACOSX" }
	end

	configurations { "Debug", "Release" }

	configuration "Debug"
		libdirs { lib_ide_path, lib_ide_path .. "/Debug" }
		defines { "DEBUG", "_DEBUG", "_DEBUG_", "Debug" }

	configuration "Release"
		libdirs { lib_ide_path, lib_ide_path .. "/Release" }
		defines { "NDEBUG", "NDebug" }

	------------------------------------------------------------
	-- "Maths" library project
	------------------------------------------------------------
	project ("Maths")
		language "C++"
		kind "StaticLib"

		targetname ("Maths")
		if (ide_os == "windows") then targetextension ".lib" end
		location (working_dir .. "Source")

		files {
			working_dir .. "Source" .. "/**.h",
			working_dir .. "Source" .. "/**.cpp"
		}

		defines { "_LIB", "_CONSOLE" }

		configuration "Debug"
			flags { "Unicode" }
			flags { "Symbols" }
			objdir (working_dir .. "Temp" .. "/Maths" .. "/Debug")
			targetdir (working_dir .. "Build" .. "/Maths" .. "/Debug")
			if (premake_ver == 5) then optimize "Debug" end

		configuration "Release"
			flags { "Unicode" }
			flags { "Optimize" }
			objdir (working_dir .. "Temp" .. "/Maths" .. "/Release")
			targetdir (working_dir .. "Build" .. "/Maths" .. "/Release")
			if (premake_ver == 5) then optimize "Full" end
	
	------------------------------------------------------------------
	-- "Maths Test One" library project
	------------------------------------------------------------------
	project ("Tests")
		language "C++"
		kind "ConsoleApp"

		if(premake_ver == 5) then
			dependson { "Maths" }
		end

		targetname ("Tests")
		if (ide_os == "windows") then targetextension ".exe" end
		location (working_dir .. "Tests" .. "/")

		files {
			working_dir .. "Tests" .. "/**.h",
			working_dir .. "Tests" .. "/**.cpp"
		}

		includedirs { working_dir .. "Source" }
		links {
			"Maths"
		}

		defines { "_CONSOLE" }

		configuration "Debug"
			flags { "Unicode" }
			flags { "Symbols" }
			objdir (working_dir .. "Temp" .. "/Tests" .. "/Debug")
			targetdir (working_dir .. "Build" .. "/Tests" .. "/Debug")
			if (premake_ver == 5) then optimize "Debug" end

		configuration "Release"
			flags { "Unicode" }
			flags { "Optimize" }
			objdir (working_dir .. "Temp" .. "/Tests" .. "/Release")
			targetdir (working_dir .. "Build" .. "/Tests" .. "/Release")
			if (premake_ver == 5) then optimize "Full" end