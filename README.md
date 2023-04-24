# EPICS Windows Configuration

Configuration meant to simplify executing builds of EPICS software on windows.

### Setup

To begin, you will need to perform a one time install of necessary external software, including git, python, perl, make, re2c, wget, tar, and Visual Studio build tools. To simplify this process, a batch script has been written. Simply open an administrator command prompt (Start Menu -> CMD -> Run as Administrator), and execute the batch script:

```
dependencyInstall.bat
```

This will perform the following operations:

* Create `C:\EPICS` and `C:\EPICS\TOOLS` directories
* Install a portable version of git to the tools directory and add it to the path
* Install wget, make, re2c and a handful of other one off executables to a `bin` folder in `TOOLS`
* Install a portable version of 7zip to `TOOLS`
* Install a portable version of Python to `TOOLS`
* Install a portable version of Strawberry Perl to `TOOLS`
* Download the visual studio build tools installer to `TOOLS`
* Execute an automatic install of the build tools in passive mode - a popup will come up to show progress, wait until this is done before continuing

Once the dependency installer script has completed, you are ready to perform a build.

### Executing Builds

To execute a build, you must first complete the setup process as described above. Next, open a new command prompt (not as an administrator). From this directory, execute the script for configuring the build environment:

```
configureEnv.bat
```

This should add all the above installed tools to your path, and execute a Visual Studio vcvarsall.bat script.

From here, you should be ready to execute a build. To create a development build, use

```
make localinstall
```

To perform a build with a traditional tarball archive as the output, use

```
make bundle
```

The tarball will be placed in the `INSTALL` directory.

If you would like an archive that compresses all of the EPICS software into a flat stucture (like with the EPICS rpm deployed on RHEL systems), use:

```
make flatbundle
```


