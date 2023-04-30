#!/bin/bash
: '
autogpt-deploy.sh

v.0.1 - 2023-04-28 - Matt Seabrook

See README.md or CTRL + F "Main Entrypoint" in this file
'

APP_PORT=4000
DOCKER_IMAGE="autogpt-docker-image"
DOCKER_CONTAINER="autogpt-docker-container"

#
# Function to display cool ASCII text
#
function display_ascii {
    cat <<"EOF"
  ___        _              _____ ______ _____  ______           _             
 / _ \      | |            |  __ \| ___ \_   _| |  _  \         | |            
/ /_\ \_   _| |_ ___ ______| |  \/| |_/ / | |   | | | |___ _ __ | | ___  _   _ 
|  _  | | | | __/ _ \______| | __ |  __/  | |   | | | / _ \ '_ \| |/ _ \| | | |
| | | | |_| | || (_) |     | |_\ \| |     | |   | |/ /  __/ |_) | | (_) | |_| |
\_| |_/\__,_|\__\___/       \____/\_|     \_/   |___/ \___| .__/|_|\___/ \__, |
                                                          | |             __/ |
                                                          |_|            |___/ 
Auto-GPT Deploy v.0.1

Lakeshore Technical
https://www.lakeshoretechnical.com
info@lakeshoretechnical.com
EOF
}

: '
/*
================
create_new_script

Create a new shell script based on this one
================
*/
'
function create_new_script {
    echo

    read -p "Enter the name of the project: " project_name
    read -p "Enter the port number: " port_number

    # Replace spaces with underscores
    safe_project_name=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g')
    new_script_name="${safe_project_name}.sh"

    # Replace unique aspects in the shell script
    cp "$0" "$new_script_name"
    sed -i -e "s/autogpt-docker-image/${safe_project_name}/g" \
        -e "s/autogpt-docker-container/${safe_project_name}_container/g" \
        -e "s/APP_PORT=4000/APP_PORT=${port_number}/g" \
        -e '/-g, --generate/d' \
        -e 's/.*-g, --generate.*//g' \
        "$new_script_name"

    # Remove multiline comments and stray characters related to create_new_script
    sed -i -e '/: '\''$/,/^'\''$/d' -e '/^\/\*/,/^================$/d' "$new_script_name"

    # Remove create_new_script function
    sed -i -e '/^function create_new_script/,/^}$/d' "$new_script_name"

    # Replace create_new_script with ./"$(basename "$0")" --build && ./"$(basename "$0")" --create
    sed -i -e 's|create_new_script|./"$(basename "$0")" --build \&\& ./"$(basename "$0")" --create|g' "$new_script_name"

    chmod +x "$new_script_name"
    echo -e "\nNew shell script created: ${new_script_name}\n"
}

: '
/*
================
cli_interface

Process CLI arguments

@param      $@      string(s)       All of the ARGVs provided via stdin, $2, $3, etc.
================
*/
'
function cli_interface {
    case $1 in
    # Attach to the Docker Container
    -a | --attach)
        if [ "$(docker inspect -f '{{.State.Running}}' "$DOCKER_CONTAINER")" = "true" ]; then
            docker attach "$DOCKER_CONTAINER"
        else
            echo "Container $DOCKER_CONTAINER is not running. Use: docker start $DOCKER_CONTAINER"
        fi
        ;;
    # Build the Docker Image
    -b | --build)
        docker build -t "$DOCKER_IMAGE" .
        ;;
    # Create & Run the Docker Container
    -c | --create)
        docker run \
            -it \
            --net=host \
            --name "$DOCKER_CONTAINER" \
            "$DOCKER_IMAGE" \
            bash
        ;;
    # Remove the Docker Image and Container
    -x | --remove)
        docker rm "$DOCKER_CONTAINER"
        docker rmi "$DOCKER_IMAGE"
        ;;
    # Help
    -h | --help)
        cli_help
        ;;
    # No arguments
    "")
        create_new_script
        ;;
    *)
        echo "ERROR: Invalid command line arguments/parameters: $@"
        echo
        echo "Usage: ./autogpt-deploy.sh {switch} {parameter}"
        echo
        cli_help
        ;;
    esac
}

: '
/*
================
cli_help

Print help related text on the screen like a standard CLI application
================
*/
'
function cli_help {
    echo
    echo -e "Usage: ./autogpt-deploy.sh\t{switch} {parameters...}"
    echo
    echo -e "\t-a, --attach\tAttach to this project's Docker Container."
    echo -e "\t-b, --build\tBuild Docker Image as specified in the Dockerfile."
    echo -e "\t-c, --create\tCreate & Run the Docker Container in terminal."
    echo -e "\t-g, --generate\tGenerate a new unique version of this shell script."
    echo -e "\t-x, --remove\tRemove the Docker Image and Container."
    echo -e "\t-h, --help\tDisplay this help text."
    echo
    echo "Please see README.md for more specific information"
    echo
}

: '
//==========================================================================

/*
================
Main Entrypoint

Upon execution of the shell script
================
*/
'

display_ascii
cli_interface "$@"
