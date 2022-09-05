#!/usr/bin/env bash

##### JUST STARTED NOT TESTED DO NOT RUN ###########

##### SETUP FOR BRIGHTXF #####
# Requires:
#           sudo

#### Assumes:
### ~/.local/bin exists and is in PATH

#### Prefers/Will Attempt to Create:
### /etc/startup

bright_dir=$(pwd)
script_dir="${HOME}/.local/bin"
mod_dir="/etc/startup"
service_dir="/etc/systemd/system"

linkFiles() {
    if [ -f "${bright_dir}/${1}" && -d "${script_dir}" ]; then
    printf "Creating New Symlink at: %s\n" "${script_dir}/${1}"
    #echo "Creating New Symlink: ${script_dir}/${1}"
    chmod +x "${bright_dir}"/"${1}" && ln -n "${bright_dir}"/"${1}" "${script_dir}"
    else
    printf "Failed at Creating New Symlink at: %s\n" "${script_dir}/${1}"
    #echo "Failed at Creating New Symlink: ${script_dir}"
    fi
}
linkFile brightxf
linkFile brup
linkFile brwn
linkFile brcur
linkFile brmx

if [ -d "${mod_dir}" ]; then
    printf "Setting Up Mod Script at: %s\n" "${mod_dir}"
    chmod +x "${bright_dir}"/brightness_mod.sh && sudo cp "${bright_dir}"/brightness_mod.sh "${mod_dir}"/
else
    printf "Making and Setting Up Mod Script at: %s\n" "${mod_dir}"
    sudo mkdir -p /etc/startup && chmod +x "${bright_dir}"/brightness_mod.sh && sudo cp "${bright_dir}"/brightness_mod.sh "${mod_dir}"/
fi 

if [ -d "${service_dir}" ]; then
    printf "Setting Up and Service at: %s\n" "${service_dir}"
    sudo cp "${bright_dir}"/brightness_mod.service "${service_dir}"/brightness_mod.service && sudo systemctl enable brightness_mod.service && sudo systemctl daemon-reload
else
    printf "Failed at copying or starting Service Mod to: %s\n" "${service_dir}"
fi
