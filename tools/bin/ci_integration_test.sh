#!/usr/bin/env bash

set -e

. tools/lib/lib.sh

# runs integration tests for an integration name

connector="$1"
all_integration_tests=$(./gradlew integrationTest --dry-run | grep 'integrationTest SKIPPED' | cut -d: -f 4)
run() {
if [[ "$connector" == "all" ]] ; then
  echo "Running: ./gradlew --no-daemon --scan integrationTest"
  ./gradlew --no-daemon --scan integrationTest
else
  if [[ "$connector" == *"base-normalization"* ]]; then
    selected_integration_test="base-normalization"
    integrationTestCommand="$(_to_gradle_path "airbyte-integrations/bases/base-normalization" integrationTest)"
    export SUB_BUILD="CONNECTORS_BASE"
    ./gradlew --no-daemon --scan airbyteDocker
  elif [[ "$connector" == *"bases"* ]]; then
    connector_name=$(echo $connector | cut -d / -f 2)
    selected_integration_test=$(echo "$all_integration_tests" | grep "^$connector_name$" || echo "")
    integrationTestCommand="$(_to_gradle_path "airbyte-integrations/$connector" integrationTest)"
    export SUB_BUILD="CONNECTORS_BASE"
  elif [[ "$connector" == *"connectors"* ]]; then
    connector_name=$(echo $connector | cut -d / -f 2)
    selected_integration_test=$(echo "$all_integration_tests" | grep "^$connector_name$" || echo "")
    integrationTestCommand="$(_to_gradle_path "airbyte-integrations/$connector" unitTest)"
  else
    selected_integration_test=$(echo "$all_integration_tests" | grep "^$connector$" || echo "")
    integrationTestCommand=":airbyte-integrations:connectors:$connector:integrationTest"
  fi
  if [ -n "$selected_integration_test" ] ; then
    echo "Running: ./gradlew --no-daemon --scan $integrationTestCommand"
    ./gradlew --no-daemon --scan "$integrationTestCommand"
  else
    echo "Connector '$connector' not found..."
    return 1
  fi
fi
}

# Copy command output to extract gradle scan link.
run | tee build.out
# return status of "run" command, not "tee"
# https://tldp.org/LDP/abs/html/internalvariables.html#PIPESTATUSREF
run_status=${PIPESTATUS[0]}

test $run_status == "0" || {
   # Build failed
   link=$(cat build.out | grep -A1 "Publishing build scan..." | tail -n1 | tr -d "\n")
   # Save gradle scan link to github GRADLE_SCAN_LINK variable for next job.
   # https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-environment-variable
   echo "GRADLE_SCAN_LINK=$link" >> $GITHUB_ENV
   exit $run_status
}

# Build successed
coverage_report=`sed -n '/--- coverage: /,/TOTAL   /p' build.out | tr '\n' '|' |  sed 's/|/\<br\/\>/g' | sed 's/\s/\&nbsp;/g'`

echo "COVERAGE_REPORT=$coverage_report" >> $GITHUB_ENV

