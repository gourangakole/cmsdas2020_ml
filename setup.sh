#!/usr/bin/env bash

# Script that sets up the environment for the CMS DAS 2020 ML exercise
# and installs software when the SWAN environment is detected.
# Arguments:
# 1. Install mode (default "default"). When "fresh", the software is removed if existing before
#    installing. When "force", the install instructions are executed on top of potentially existing
#    software.

action() {
    # check where we are
    local this_file="$( [ ! -z "$ZSH_VERSION" ] && echo "${(%):-%x}" || echo "${BASH_SOURCE[0]}" )"
    local this_dir="$( cd "$( dirname "$this_file" )" && pwd )"

    # fix some variables that look weird on SWAN
    export HOME="${HOME%/}"
    export CERNBOX_HOME="${CERNBOX_HOME%/}"

    # public paths and urls for this exercise
    export DASML_SWAN_BASE="/eos/user/m/mrieger/cmsdas2020_ml"
    export DASML_SWAN_DATA="$DASML_SWAN_BASE/data"
    export DASML_CERNBOX_DATA_URL="https://cernbox.cern.ch/index.php/s/6CK0CwO5W6HSgZB"

    # variables used by the exercise
    export DASML_BASE="$this_dir"
    export DASML_DATA="$DASML_BASE/data"
    export DASML_SOFTWARE="$DASML_BASE/software"

    # update software paths
    local pyv="$( python3 -c "import sys; print('{0.major}.{0.minor}'.format(sys.version_info))" )"
    export PATH="$DASML_SOFTWARE/bin:$PATH"
    export PYTHONPATH="$DASML_SOFTWARE/lib/python${pyv}/site-packages:$PYTHONPATH"
    export PYTHONUSERBASE="$DASML_SOFTWARE"

    # also add the users potential SWAN_project so that the dasml package will be available
    export PYTHONPATH="$DASML_BASE:$PYTHONPATH"

    # install software on swan
    if [ ! -z "$SWAN_HOME" ]; then
        # get the install mode
        local install_mode="${1:-default}"

        # delete the current installation when required
        if [ -d "$DASML_SOFTWARE" ] && [ "$install_mode" = "fresh" ]; then
            echo "removing software at $DASML_SOFTWARE"
            rm -rf "$DASML_SOFTWARE"
        fi

        # start the installation
        if [ ! -d "$DASML_SOFTWARE" ] || [ "$install_mode" = "force" ]; then
            # actual installation, one package at a time
            echo "installing software into $DASML_SOFTWARE"
            mkdir -p "$DASML_SOFTWARE"
            cat "$DASML_BASE/requirements.txt" | xargs -l pip3 install --no-cache-dir --user
        else
            echo "software already installed at $DASML_SOFTWARE"
            echo "for a fresh reinstallation, pass 'fresh' as the first argument to this script"
            echo "to force the installation on top of the existing one, pass 'force'"
        fi

        # in any case, fix the google namespace package in case it was corrupted
        touch "$DASML_SOFTWARE/lib/python${pyv}/site-packages/google/__init__.py"
    fi

    echo "environment successfully set up"
}
action "$@"
