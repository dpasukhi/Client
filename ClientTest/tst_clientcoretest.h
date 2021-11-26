#ifndef TST_CLIENTCORETEST_H
#define TST_CLIENTCORETEST_H

#include <gtest/gtest.h>
#include <gmock/gmock-matchers.h>

using namespace testing;

TEST(CleintTest, ClientCoreTest)
{
  EXPECT_EQ(1, 1);
  ASSERT_THAT(0, Eq(0));
}

#endif // TST_CLIENTCORETEST_H
