
<#
.SYNOPSIS Builds the test project in this directory.
#>
function Build-TestProject {

    $ErrorActionPreference='Stop'

    $TOOLCHAIN = "$PSScriptRoot/../src/conan-toolchain.cmake"
    $SourceDirectory = $PSScriptRoot
    $BuildDirectory = "$PSScriptRoot/../build"

    cmake -S $SourceDirectory -B $BuildDirectory `
        -G Ninja `
        -DCMAKE_BUILD_TYPE=Release `
        --toolchain $TOOLCHAIN `
        -DCONAN_FILE="$SourceDirectory/conanfile.txt" `
        -DCONAN_PROFILE="$SourceDirectory/v143.txt"

    cmake --build $BuildDirectory --config Release -v

    ctest --test-dir $BuildDirectory -C Release
   


}

Build-TestProject