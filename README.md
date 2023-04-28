```
  ___        _              _____ ______ _____  ______           _             
 / _ \      | |            |  __ \| ___ \_   _| |  _  \         | |            
/ /_\ \_   _| |_ ___ ______| |  \/| |_/ / | |   | | | |___ _ __ | | ___  _   _ 
|  _  | | | | __/ _ \______| | __ |  __/  | |   | | | / _ \ '_ \| |/ _ \| | | |
| | | | |_| | || (_) |     | |_\ \| |     | |   | |/ /  __/ |_) | | (_) | |_| |
\_| |_/\__,_|\__\___/       \____/\_|     \_/   |___/ \___| .__/|_|\___/ \__, |
                                                          | |             __/ |
                                                          |_|            |___/ 
```
AutoGPT Deploy is a versatile shell script and Dockerfile combination that simplifies the deployment of Auto-GPT. This tool automates the building, running, and management of your Autonomous GPT A.I. Agents.

**Table of Contents 📑**
- [Description 📖](#description-)
- [Getting Started 🚀](#getting-started-)
- [Usage 🛠️](#usage-️)
  - [Pre-requisites](#pre-requisites)
  - [Build the Docker Image 🏗️](#build-the-docker-image-️)
  - [Create \& Run the Docker Container 🏃](#create--run-the-docker-container-)
  - [Attach to the Docker Container 🖇️](#attach-to-the-docker-container-️)
  - [Remove the Docker Image and Container 🧹](#remove-the-docker-image-and-container-)
- [Changelog 📜](#changelog-)
  - [2023-04-28](#2023-04-28)
- [TODO 📝](#todo-)
- [Links 🔗](#links-)

## Description 📖

AutoGPT Deploy is a powerful tool developed by [Lakeshore Technical](https://www.lakeshoretechnical.com) to help you effortlessly deploy Autonomous GPT A.I. Agents. It comes to you as a boilerplate `*.sh` script & `Dockerfile` that you run in your terminal. It will ask you a few questions, and then it will build, run, and manage your Auto-GPT Docker container for you.

## Getting Started 🚀

To get started, simply clone this repository and follow the usage instructions below.

Assumes:
- Docker
- Redis
- key.txt

```bash
#steps
```

## Usage 🛠️

### Pre-requisites

| Name   | Description                                                   | Specific Use Case                                    |
| ------ | ------------------------------------------------------------- | ---------------------------------------------------- |
| bash   | A Unix shell and command-line interface                       | Running the shell script                             |
| Docker | A platform for developing, shipping, and running applications | Building, running, and managing the Docker container |
| sed    | A Unix utility for parsing and transforming text files        | Replacing text in the script to create a new version |
| echo   | A command to display a line of text                           | Printing messages to the terminal                    |
| cat    | A command to concatenate and display files                    | Displaying ASCII art in the terminal                 |
| chmod  | A command to change file permissions                          | Making the new script executable                     |
| read   | A command to read a line from standard input                  | Getting user input in the terminal                   |

### Build the Docker Image 🏗️

To build the Docker image, run:

```bash
./autogpt-deploy.sh -b
```
or

```bash
./autogpt-deploy.sh --build
```

### Create & Run the Docker Container 🏃

To create and run the Docker container, run:

```bash
./autogpt-deploy.sh -c
```

or

```bash
./autogpt-deploy.sh --create
```

### Attach to the Docker Container 🖇️

To attach to the Docker container, run:

```bash
./autogpt-deploy.sh -a
```
or

```bash
./autogpt-deploy.sh --attach
```

### Remove the Docker Image and Container 🧹

To remove the Docker image and container, run:

```bash
./autogpt-deploy.sh -x
```
or

```bash
./autogpt-deploy.sh --remove
```

## Changelog 📜

### 2023-04-28

- Project started, researched, coded, and tested today.
- README.md file created.

## TODO 📝

- [ ] Add support to toggle `localCache` or `redis` as Memory Bank type.
- [ ] Expose options for host ip and port for `redis` in the generation of a new boilerplate shell script.
- [ ] Support using a `*.json` file to configure the boilerplate shell script.
- [ ] Support for piping `*.json` to stdin for configuration of the boilerplate shell script (*instead of answering questions old school style*)
- [ ] Functionality for tthe user to be able to supply the Auto-GPT Prompts ahead of time.
- [ ] Add support for docker alternatives, or no docker, and refactor the switches accordingly.

## Links 🔗

Useful links for this project:

- [Auto-GPT GitHub Repository](https://github.com/Significant-Gravitas/Auto-GPT)
- [Setting up Auto-GPT](https://significant-gravitas.github.io/Auto-GPT/setup/)
- [Getting Started with Auto-GPT for Beginners: Setup & Usage](https://bytexd.com/getting-started-with-auto-gpt-for-beginners-setup-usage/)