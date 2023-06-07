# Bachelor Thesis

My bachelor's thesis!

## Getting Started

### Dependencies

* Docker
* Docker-Compose

#### Recommended

* JetBrains IntelliJ
  * TeXiFy IDEA Plugin
  * PDF Viewer Plugin
* Visual Studio
* Visual Studio Code

### Installation

* Download dependencies
  * Docker
  * Docker-Compose
* Clone repository

### Usage

Start docker container:

```bash
$ docker-compose up -d
```

Compile PDF:

```bash
$ sh ./dev-ops/build.sh
```

Clear build and cache files:

```bash
$ sh ./dev-ops/clear.sh
```

Track PDF compilation log output in separate shell:

```bash
$ tail -f ./build/temp/main.log
```

The document source files are found in the ```src``` directory.

The compiled PDF file and log output are
saved to the ```build``` directory.

On initial execution the command will build the docker 
image with texlive-full and biber, which can take a few
minutes. After that, compiling the PDF should only take
a few seconds, but that also depends on hardware.
