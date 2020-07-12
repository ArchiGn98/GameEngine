workspace "Hazel"
    architecture "x64"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

outdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Hazel"
    location "Hazel"
    kind "SharedLib"
    language "c++"

    targetdir ("bin/" .. outdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
	}

    includedirs
    {
        "%{prj.name}/vendor/spdlog/include;"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "10.0.18362.0"

        defines
        {
        "HZ_PLATFORM_WINDOWS",
        "HZ_BUILD_DLL",
        "_WINDLL"
        }

        postbuildcommands
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outdir .. "/SandBox")
		}

    filter "configurations:Debug"
        defines "HZ_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "HZ_RELEASE"
        symbols "On"

    filter "configurations:Dist"
        defines "HZ_DIST"
        symbols "On"




project "SandBox"
    location "SandBox"
    kind "ConsoleApp"
    language "c++"

    targetdir ("bin/" .. outdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
	}

    includedirs
    {
        "Hazel/vendor/spdlog/include;",
        "Hazel/src"
    }

    links
    {
        "Hazel"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "10.0.18362.0"

        defines
        {
        "HZ_PLATFORM_WINDOWS",
        "_WINDLL"
        }

    filter "configurations:Debug"
        defines "HZ_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "HZ_RELEASE"
        symbols "On"

    filter "configurations:Dist"
        defines "HZ_DIST"
        symbols "On"