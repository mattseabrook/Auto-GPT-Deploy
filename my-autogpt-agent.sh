#!/bin/bash

APP_PORT=4000
DOCKER_IMAGE="my-autogpt-agent"
DOCKER_CONTAINER="my-autogpt-agent_container"

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
        ./"$(basename "$0")" --build && ./"$(basename "$0")" --create
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

function cli_help {
    echo
    echo -e "Usage: ./autogpt-deploy.sh\t{switch} {parameters...}"
    echo
    echo -e "\t-a, --attach\tAttach to this project's Docker Container."
    echo -e "\t-b, --build\tBuild Docker Image as specified in the Dockerfile."
    echo -e "\t-c, --create\tCreate & Run the Docker Container in terminal."
    echo -e "\t-x, --remove\tRemove the Docker Image and Container."
    echo -e "\t-h, --help\tDisplay this help text."
    echo
    echo "Please see README.md for more specific information"
    echo
}


display_ascii
cli_interface "$@"
