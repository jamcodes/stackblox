set -e

build_dir=build_ios

cd $(dirname "$0")
mkdir -p $build_dir
cd $build_dir

conan remote add bintray-stever https://api.bintray.com/conan/stever/conan --insert --force

conan install --update .. -s os=iOS -s arch=armv7 -s os.version=8.0 -s compiler.version=11.0

cmake -G Xcode -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_ARCHITECTURES="armv7 arm64" -DCMAKE_OSX_DEPLOYMENT_TARGET=8.0 -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY ..

python3 ../add_xcode_folder_reference.py --project=StackBlox.xcodeproj/project.pbxproj --folderPath=src/StackBlox.xcassets --target=StackBlox
python3 ../add_xcode_folder_reference.py --project=StackBlox.xcodeproj/project.pbxproj --folderPath=src/assets --target=StackBlox

cmake --build . --config Release

xcodebuild -workspace StackBlox.xcodeproj/project.xcworkspace -scheme StackBlox archive -archivePath StackBlox.xcarchive
xcodebuild -exportArchive -archivePath StackBlox.xcarchive -exportOptionsPlist ../exportOptions.plist -exportPath .
