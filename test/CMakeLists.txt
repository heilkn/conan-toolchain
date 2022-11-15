cmake_minimum_required(VERSION 3.23.0)

project("test-auto-conan")

add_executable(testprogram "main.cpp")

find_package(Eigen3 REQUIRED)
find_package(GTest REQUIRED)
target_link_libraries(testprogram
	PRIVATE
		Eigen3::Eigen
		GTest::gtest_main
)
