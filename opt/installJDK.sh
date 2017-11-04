#!/bin/bash

# You must accept the Oracle Binary Code License
# http://www.oracle.com/technetwork/java/javase/terms/license/index.html
# ext: rpm
# jdk_version: default 8

function getLatestJDK() {
    ext=rpm
    jdk_version=8

    url="http://www.oracle.com"
    jdk_download_url1="$url/technetwork/java/javase/downloads/index.html"
    jdk_download_url2=`curl -s $jdk_download_url1 | grep -Po "\/technetwork\/java/\javase\/downloads\/jdk${jdk_version}-downloads-.+?\.html" | head -1`
    [[ -z "$jdk_download_url2" ]] && error "Could not get jdk download url - $jdk_download_url1"
    jdk_download_url3="${url}${jdk_download_url2}"
    jdk_download_url4=`curl -s $jdk_download_url3 | egrep -o "http\:\/\/download.oracle\.com\/otn-pub\/java\/jdk\/[7-8]u[0-9]+\-(.*)+\/jdk-[7-8]u[0-9]+(.*)linux-x64.${ext}" | tail -1`

    wget --no-cookies \
         --no-check-certificate \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         -N $jdk_download_url4
}

mkdir tmp
cd tmp
getLatestJDK
fileName=$(ls | grep "jdk-[0-9]u[0-9]*-linux-x64.rpm")
echo $fileName
rpm -Uhv $fileName
cd ../
rm -rf tmp

