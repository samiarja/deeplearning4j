#!/bin/bash

set -euo pipefail

# Set devtoolset to version 3 because of problems with ASan (AddressSanitizer) problems in version 4
if [ -f /etc/redhat-release ]; then
    source /opt/rh/devtoolset-3/enable
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    export CC=$(ls -1 /usr/local/bin/gcc-? | head -n 1)
    export CXX=$(ls -1 /usr/local/bin/g++-? | head -n 1)
fi

cmake -G "Unix Makefiles" && make -j4 && layers_tests/runtests --gtest_output="xml:../target/surefire-reports/cpu_test_results.xml"
