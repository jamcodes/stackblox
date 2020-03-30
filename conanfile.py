from conans import ConanFile

class Conan(ConanFile):
    name = "StackBlox"
    version = ""
    settings = "os"
    generators = "cmake"

    def build_requirements(self):
        if self.settings.os == "Android":
            self.build_requires("android_sdl2/0.1.0#1aea09bd255829b7b78634e74c7fd296d99e4582")
        self.build_requires("cmake_utils/0.3.1#b92e3b563e31a4fe0e55849f3bfdb55eb7b06284")

    def requirements(self):
        self.requires("gtest/1.10.0#1dc34103486deb0c4056a3326c005456f805fc6b")
        self.requires("ssrobins_engine/0.3.0")
