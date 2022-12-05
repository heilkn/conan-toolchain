 

message(DEBUG "CONAN_FILE ${CONAN_FILE}")
message(DEBUG "CONAN_PROFILE ${CONAN_PROFILE}")
message(DEBUG "CMAKE_BINARY_DIR ${CMAKE_BINARY_DIR}")
message(DEBUG "CMAKE_SOURCE_DIR ${CMAKE_SOURCE_DIR}")
message(DEBUG "CONAN_TOOLCHAIN ${CONAN_TOOLCHAIN}")
message(DEBUG "CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE}")
message(DEBUG "CMAKE_TOOLCHAIN_FILE ${CMAKE_TOOLCHAIN_FILE}")

 
if (NOT CONAN_TOOLCHAIN)

	file(REAL_PATH ${CONAN_FILE} CONAN_FILE_REAL)
	# Do not propagate toolchain into the conan invocation.
	set(ENV{CMAKE_TOOLCHAIN_FILE})

	set(CONAN_ERROR_LOG "${CMAKE_BINARY_DIR}/conan/error.log")
	message(NOTICE "Invoking conan CLI. Errors are logged to ${CONAN_ERROR_LOG}.")
	file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/conan")
	execute_process(
		COMMAND_ERROR_IS_FATAL ANY
		RESULTS_VARIABLE CONAN_RESULT
		ERROR_FILE ${CONAN_ERROR_LOG}
		COMMAND "conan"
			"install" ${CONAN_FILE_REAL}
			"-pr" ${CONAN_PROFILE}
			"-pr:b=default"
			"-s" "build_type=${CMAKE_BUILD_TYPE}"
			"-if" "${CMAKE_BINARY_DIR}/conan"
			"-c" "tools.cmake.cmaketoolchain:generator=Ninja"
			"-b" "missing"
	)

	# Remember generated toolchain file
	set(CONAN_TOOLCHAIN "${CMAKE_BINARY_DIR}/conan"
		CACHE INTERNAL "Indicate that conan toolchain was already generated and is located in this directory.")
	set(ENV{CMAKE_TOOLCHAIN_FILE} "${CONAN_TOOLCHAIN}/conan_toolchain.cmake")
	set(CMAKE_TRY_COMPILE_PLATFORM_VARIABLES CONAN_TOOLCHAIN)

endif()

include("${CONAN_TOOLCHAIN}/conan_toolchain.cmake")


#[[
	For later, cache check sum of conan file, to not invoke conan if not necessary
	but force invocation if conanfile changes.

if (CONAN_FILE) # not set for try_compile runs
	file(SHA256 "${CMAKE_SOURCE_DIR}/${CONAN_FILE}" CURRENT_CONANFILE_CHECKSUM)
endif()

NOT ("${LAST_CONANFILE_CHECKSUM}" STREQUAL "${CURRENT_CONANFILE_CHECKSUM}")))

set(LAST_CONANFILE_CHECKSUM ${CURRENT_CONANFILE_CHECKSUM} CACHE INTERNAL "SHA256 value of the last run" FORCE)


#]]