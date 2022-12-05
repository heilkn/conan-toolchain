
#include <array>

#include <Eigen/Core>
#include <gtest/gtest.h>

TEST(Program, LinksAndRuns)
{
	std::array<double, 3> v;
	Eigen::Map<Eigen::Vector3d>(v.data())(0) = 1.;
	ASSERT_EQ(1., v[0]);
}
