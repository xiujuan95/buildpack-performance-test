#! /bin/bash

testPath="https://github.com/cloudfoundry/cf-acceptance-tests.git"
CODE_PATH=$1
current_time0=$(date "+%Y-%m-%d %H:%M:%S")
echo "[INFO] begin: current time is $current_time0"
current_time_second0=$(date --date="$current_time0" +%s)

git clone $testPath -b master --single-branch --depth 1
current_time1=$(date "+%Y-%m-%d %H:%M:%S")
echo "[INFO] git clone: current time is $current_time1"
current_time_second1=$(date --date="$current_time1" +%s)

sub_time=$(($current_time_second1-$current_time_second0))
echo "[INFO] the time of git clone is $sub_time s"

cd cf-acceptance-tests/assets
pack build us.icr.io/zoe_namespace/buildpack-test --builder gcr.io/paketo-buildpacks/builder:latest --path $CODE_PATH

current_time2=$(date)
echo "[INFO] build:  current time is $current_time2"
current_time_second2=$(date --date="$current_time2" +%s)
sub_time1=$(($current_time_second2-$current_time_second1))
echo "[INFO] the time of build is $sub_time1 s"

docker push us.icr.io/zoe_namespace/buildpack-test
current_time3=$(date)
echo "[INFO] push:  current time is $current_time3"
current_time_second3=$(date --date="$current_time3" +%s)
sub_time2=$(($current_time_second3-$current_time_second2))
echo "[INFO] the time of docker push is $sub_time2 s"

sub_time3=$(($current_time_second3-$current_time_second0))
echo "[INFO] the total time is $sub_time3 s"
cd ../..
rm -rf cf-acceptance-tests
