
-- Utility functions
function appendTable(tableA, tableB)
    for _,v in ipairs(tableB) do 
        table.insert(tableA, v) 
    end
end

-- Main library project
project "spdlog"
    kind "StaticLib"
    language "C++"
    staticruntime "on"
    location "build"
    targetdir "bin/%{cfg.buildcfg}"
    --system "Windows"
    --architecture "x86_64"

    filter "configurations:Debug"
        defines { "DEBUG", "_DEBUG", "NDEPLOY" }
        runtime "Debug"
        symbols "On"
        optimize "Off"

    filter "configurations:Release"
        defines { "NDEBUG", "NDEPLOY" }
        runtime "Release"
        symbols "On"
        optimize "On"

    filter "configurations:Deploy"
        defines { "NDEBUG", "DEPLOY" }
        runtime "Release"
        symbols "Off"
        optimize "On"

    filter {}


    -- Include directories
    local _includedirs = { 
        _SCRIPT_DIR .. "/include"
    }
    includedirs (_includedirs)

    
    -- Main source files
    files ({ "include/**", "src/**" })
    defines "SPDLOG_COMPILED_LIB"




    -- Include and linker information for premake projects using this library
    SPDLOG_INCLUDE_DIRS = {}
    appendTable(SPDLOG_INCLUDE_DIRS, _includedirs)

    SPDLOG_LINK_DIRS = {}
    appendTable(SPDLOG_LINK_DIRS, _SCRIPT_DIR .. "/bin/%{cfg.buildcfg}/")

    SPDLOG_LINKS = { "spdlog", "pthread" }

    SPDLOG_DEFINES = { "SPDLOG_COMPILED_LIB" }
