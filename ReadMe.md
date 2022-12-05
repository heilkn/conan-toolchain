# Conan Toolchain for CMake

This project is a proposal to enable seamless [Conan](https://conan.io/) integration into development and CI workflows based on CMake builds.

The proposal is discussed upstream in [conan-io/conan #12](https://github.com/conan-io/conan/issues/12341).

## Example Usage

The following snippet shows, how cmake can be invoked from a pwsh command-line and use conan to provide the dependencies.
(The character \` is used to break the command on several lines for readability.)

```pwsh
cmake -S <source-folder> -B <build-folder> `
    -DCMAKE_MAKE_PROGRAM=Ninja `
    -DCMAKE_BUILD_TYPE=Release `
    --toolchain <path-to:conan-toolchain.cmake> `
    -DCONAN_FILE=<path-to:conanfile.txt|conanfile.py> `
    -DCONAN_PROFILE=<path-to:conan profile>
cmake --build <build-folder> --config Release
```

Concretely, you can run from the checkout directory of this repository
```pwsh
cmake -S test -B build `
    -DCMAKE_MAKE_PROGRAM=Ninja `
    -DCMAKE_BUILD_TYPE=Release `
    --toolchain "$(pwd)/src/conan-toolchain.cmake" `
    -DCONAN_FILE="$(pwd)/test/conanfile.txt" `
    -DCONAN_PROFILE="$(pwd)/test/v143.txt"
cmake --build build --config Release
```

## Example Projects

For complete examples, check the `CMakePresets.json` or build.ps1 files in the projects contained in the [test subdirectory](./test/).

