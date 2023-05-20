# My Aurora OS Application

Short description of my Aurora OS Application

The source code of the project is provided under
[the license](LICENSE.BSD-3-CLAUSE.md),
that allows it to be used in third-party applications.

## Project Structure

The project has a common structure
of an application based on C++ and QML for Aurora OS.

* **[ru.auroraos.game.pro](ru.auroraos.game.pro)** file
  describes the project structure for the qmake build system.
* **[icons](icons)** directory contains application icons for different screen resolutions.
* **[qml](qml)** directory contains the QML source code and the UI resources.
  * **[cover](qml/cover)** directory contains the application cover implementations.
  * **[icons](qml/icons)** directory contains the custom UI icons.
  * **[pages](qml/pages)** directory contains the application pages.
  * **[game.qml](qml/game.qml)** file
    provides the application window implementation.
* **[rpm](rpm)** directory contains the rpm-package build settings.
  **[ru.auroraos.game.spec](rpm/ru.auroraos.game.spec)** file is used by rpmbuild tool.
  It is generated from **[ru.auroraos.game.yaml](rpm/ru.auroraos.game.yaml)** file.
* **[src](src)** directory contains the C++ source code.
  * **[main.cpp](src/main.cpp)** file is the application entry point.
* **[translations](translations)** directory contains the UI translation files.
* **[ru.auroraos.game.desktop](ru.auroraos.game.desktop)** file
  defines the display and parameters for launching the application.