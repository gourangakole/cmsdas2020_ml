# CMS DAS 2020 - Machine Learning Exercise [![Deploy images](https://github.com/riga/cmsdas2020_ml/workflows/Deploy%20images/badge.svg)](https://github.com/riga/cmsdas2020_ml/actions?query=workflow%3A%22Deploy+images%22)

### Starting the notebook

There are three methods to start the exercise notebook.
The first two methods require [docker](https://www.docker.com/get-started) to be installed on your system.
If this is the case, then methods 1 and 2 are recommended.
If not, go to method 3 and start the exercise on the CERN SWAN service.


#### 1. Docker image with a local checkout (recommended for working on your local machine)

To start the exercise in a dedicated docker image that contains all the software you need, you should clone this repostory and start the container with the helper script located at [docker/run.sh](docker/run.sh).

```shell
git clone https://github.com/riga/cmsdas2020_ml
cd cmsdas2020_ml
./docker/run.sh
```

The script will start the container with your local repostiroy mounted into it so that changes you make to the notebook persist when the container stops.

Make sure **not** to execute any command with `sudo` as a port will be opened on your machine to run and host the notebook server.
Otherwise, you potentially allow people within your local network to access your system with root permissions!

Then, open a web browser at the displayed location and click on `exercise.ipynb` to access the notebook.

**Note on docker**:
If you installed docker for the first time to run this exercise, and you appear to miss the permission to execute docker with your user account, add yourself to the "docker" group (e.g. via `sudo usermod -a -G docker $(whoami)`).


#### 2. Standalone docker image from the docker hub

If you just want to give the exercise a go without cloning a repository, you can run the docker image in a standalone fashion.
Just keep in mind that any changes you make to the notebook are stored **only within the container** and, without any further action, might not persist after the container process exits.

As above, make sure not to run the container as root!

```shell
docker run -ti -u $(id -u):$(id -g) -p 8888:8888 riga/cmsdas2020_ml
```


#### 3. SWAN (recommended for working remotely on CERN machines)

First, click on [![SWAN](http://swanserver.web.cern.ch/swanserver/images/badge_swan_white_150.png)](https://cern.ch/swanserver/cgi-bin/go?projurl=https://github.com/riga/cmsdas2020_ml.git).

You will be asked to configure the environment in a small dialog.
Select

- **16 GB of RAM**,
- **2 or 4 CPUs**,

and press the "Start my Session" button at the bottom of the form.
Finally, click on `exercise.ipynb` to start the exercise notebook.
