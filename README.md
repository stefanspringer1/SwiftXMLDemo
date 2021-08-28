# SwiftXMLDemo

This is a demo for the [SwiftXML](https://github.com/stefanspringer1/SwiftXML) library.

After installing Swift as explained below, build it with `swift build -c release` inside the x64 Native Tools Command Prompt of Visual Studio and from within the project directory. The resulting executable can be found in the subdirectory `.build/release`. It needs some libraries to be executed, the accordings paths are set after mentioned installation.

Run it with: `./SwiftXMLDemo <source> [<target>] [-w] [-p]`

Arguments:

1st path argumten: Give the path to an XML file as argument to the program and it prints the document to standard output.

2nd path argument: Give a second path as second argument to the program and the XML document will be written to this second path.

`-w`: Aftr reading the document, wait for press of the RETURN key. (This can be used to see the memory consumption for the XML tree.)

`-p`: Print the document to standard output.

The total time will be displayed at the end, if `-w` is not set.

This demo is published under the Apache License 2.0. For questions or remarks see my contact information on [my website](https://stefanspringer.com).

## Usage on Windows

_First we describe how to install Swift on Windows._

1. The Swift Package Manager uses symbolic links, but Microsoft has decided that symbolic links might be harmful (see [there](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-vista/cc766301(v=ws.10)) under "Create symbolic links"). You can test if you can set symbolic links with the command `mklink newfile oldfile`, creating a symbolic link file named `newfile` pointing to `oldfile`. If this command is successful, everything is OK. Else, you can try to activate the Deverloper Mode in the Windows settings and then restart the computer. You should then be able to create symbolic links (test with the mentioned command again). If not, you need to set the SE_CREATE_SYMBOLIC_LINK privilege using the `gpedit.msc` tool (start it via the context menu of the Windows Explorer as Administrator). (Note that other security policies for your computer might overwrite this setting.) If you have the Home edition of of Windows, you first have to get this tool from Microsoft using the following script (open the command line window as Administrator):

```Batch
@echo off 

pushd "%~dp0" 

dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt 

dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt 

for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i" 

pause
```

You can then set the privilege in the `gpedit.msc` tool under Computer Configuration / Windows Settings / Security Settings / Local Policies / User Rights Assignment (use a right-click for the listed setting and choose Properties / Enhanced / Search to add yourself as user). Then restart your computer.

Note that group policies might forbid setting the above privilege. You might then have to speak with your IT apartment.

1. Install Visual Studio (get it from [https://visualstudio.microsoft.com](https://visualstudio.microsoft.com)).
   
2. Install the Swift toolchain (get it from [https://swift.org/download](https://swift.org/download)). Swift will be installed to `C:\Library`. In a newly opened comamnd line windows, the command `swift -version` should then print the Swift version.

3. You will have to make the Windows SDK accessable to Swift. Open the `x64 Native Tools for VS2019 Command Prompt` with Administrator rights (via the context menu of the entry for `x64 Native Tools for VS2019 Command Prompt` in the start menu) and inside it, execute the following commands. (Please also see the documentation [https://swift.org/getting-started/](https://swift.org/getting-started/) in case something has changed.)

```batch
copy %SDKROOT%\usr\share\ucrt.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\ucrt\module.modulemap"
copy %SDKROOT%\usr\share\visualc.modulemap "%VCToolsInstallDir%\include\module.modulemap"
copy %SDKROOT%\usr\share\visualc.apinotes "%VCToolsInstallDir%\include\visualc.apinotes"
copy %SDKROOT%\usr\share\winsdk.modulemap "%UniversalCRTSdkDir%\Include\%UCRTVersion%\um\module.modulemap"
```

_Next, we describe to use this Swift package in the Clion IDE. If you do not want to change this package but only would like to build and run it as-is, instead of using Clion you could just run the command `swift build -c release` from within the package to build it._

5. Different options could be considered for editing Swift source code. We describe the usage of CLion, a commercial IDE. You can get the installer from [https://www.jetbrains.com/clion](https://www.jetbrains.com/clion).

6. Start Clion.

7. Add the Swift plugin via the CLion Settings dialog.

8. Configure the Swift toolchain in CLion (the settings for the Swift plugin might be the last entry in the Settings dialog). Choose the toolchain under `C:\Library\Developer\Toolchains` (select the subdirectory in `Toolchains`).

9. Check-out this Swift package and open in in CLion (open `Package.swift` in CLion and choose "open as project").

10.   Click the Run symbol in CLion. (You can also execute `swift build -c release` for building or `swift run -c release` for also running inside your package. The Swift plugin for CLion is quite new, so this might even be necessary.) With the current state of the project (May 11, 2021) the document should then get validated, validation errors printed, and entity definitions and their usage will be displayed.
