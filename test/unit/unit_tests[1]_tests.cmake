add_test( BoundaryConditionTest.CheckData /opt/apollo/contrib/hephaestus/bin/unit_tests [==[--gtest_filter=BoundaryConditionTest.CheckData]==] --gtest_also_run_disabled_tests --data_directory /opt/apollo/contrib/hephaestus/data/)
set_tests_properties( BoundaryConditionTest.CheckData PROPERTIES WORKING_DIRECTORY /opt/apollo/contrib/hephaestus/test/unit SKIP_REGULAR_EXPRESSION [==[\[  SKIPPED \]]==])
add_test( InputParametersTest.CheckData /opt/apollo/contrib/hephaestus/bin/unit_tests [==[--gtest_filter=InputParametersTest.CheckData]==] --gtest_also_run_disabled_tests --data_directory /opt/apollo/contrib/hephaestus/data/)
set_tests_properties( InputParametersTest.CheckData PROPERTIES WORKING_DIRECTORY /opt/apollo/contrib/hephaestus/test/unit SKIP_REGULAR_EXPRESSION [==[\[  SKIPPED \]]==])
add_test( VariablesTest.CheckSetup /opt/apollo/contrib/hephaestus/bin/unit_tests [==[--gtest_filter=VariablesTest.CheckSetup]==] --gtest_also_run_disabled_tests --data_directory /opt/apollo/contrib/hephaestus/data/)
set_tests_properties( VariablesTest.CheckSetup PROPERTIES WORKING_DIRECTORY /opt/apollo/contrib/hephaestus/test/unit SKIP_REGULAR_EXPRESSION [==[\[  SKIPPED \]]==])
set( unit_tests_TESTS BoundaryConditionTest.CheckData InputParametersTest.CheckData VariablesTest.CheckSetup)