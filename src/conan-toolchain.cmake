 

if (NOT CONAN_TOOLCHAIN)

	set(CONAN_TOOLCHAIN ${CMAKE_BINARY_DIR}
		CACHE INTERNAL "Indicate that conan toolchain was already generated.")
	execute_process(
		COMMAND "conan"
			"install" "${CMAKE_SOURCE_DIR}/${CONAN_FILE}"
			"-pr" "${CONAN_PROFILE}"
			"-pr:b=default"
			"-if" ${CMAKE_BINARY_DIR}
			"-c" "tools.cmake.cmaketoolchain:generator=Ninja"
	)

	set(CMAKE_TRY_COMPILE_PLATFORM_VARIABLES CONAN_TOOLCHAIN)
endif()

include("${CONAN_TOOLCHAIN}/conan_toolchain.cmake")
