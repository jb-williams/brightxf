#!/usr/bin/env bash
set -eo pipefail
##################################
####### SETUP FOR BRIGHTXF #######
##################################

##### JUST STARTED NOT TESTED DO NOT RUN ###########
# Reqs:
    # systemd
    # sudo

## INSTAL SCRIPT NOT TESTED YET 
# Setup Script Expects:
    # `/tmp/brightxf`(usually setup by initial curl install)
    # `~/bin`
    # `/etc/startup`(will be automated by SETUP.sh soon)

####################
####### VARS #######
####################
bright_dir="/tmp/brightxf"
shell_config="${HOME}""/.$(echo "${SHELL}" | cut -d "/" -f 3)rc"
script_dir="${HOME}""/bin"
mod_dir="/etc/startup"
service_dir="/etc/systemd/system"
user_scripts=("brightxf
    brmx
    brcur
    brup
    brwn")

##########################
####### USER SETUP #######
##########################
check_path() {
    req_path=$(echo "${PATH}" | grep -q "${script_dir}")
    #if [ "$?" -ne 0 ]; then
    if ! "${req_path}"; then
        printf "%s does not exits in PATH.. May need to check if the rest of the script ran properly.\n" "${script_dir}" \
        && echo -e ". ${HOME}/bin" >> "${shell_config}" \
        && mkdir -p "${script_dir}"
    else
        printf "PATH is setup correctly.\n"
    fi
}

bright_clone() {
    if [ ! -d "${bright_dir}" ]; then
        git clone https://github.com/jb-williams/brightxf.git "${bright_dir}"
    else
        printf "%s is setup correctly.\n" "${bright_dir}"
    fi
}

check_script_dir() {
    if [ -d "${script_dir}" ]; then
            setup_user_files
    else
        printf "%s does not exits... Attempting to make directory and retrying user file setup... May need to check if the rest of the script ran properly.\n" "${script_dir}" \
        && mkdir -p "${script_dir}" \
        && setup_user_files
    fi
}

setup_user_files() {
    for sc in "${user_scripts[@]}"; 
    do
        if [ -f "${bright_dir}/${sc}" ]; then
            chown "${USER}":"${USER}" "${bright_dir}/${sc}" \
            && chmod 555 "${bright_dir}/${sc}" \
            && cp "${bright_dir}/${sc}" "${script_dir}/${sc}" 
            if [ -f "${script_dir}/${sc}" ]; then
                printf "Successfully copied user script: %s/%s to %s/%s .......\n" "${bright_dir}" "${sc}" "${service_dir}" "${sc}"
            else
                printf "Failed to copying user script: %s/%s to %s/%s .......\n" "${bright_dir}" "${sc}" "${service_dir}" "${sc}"
            fi
        else
            printf "Could not find: %s .......\n" "${bright_dir}"
        fi
    done
}

############################
####### SYSTEM SETUP #######    
############################
setup_mod() {
    if [ -d "${mod_dir}" ]; then
        printf "Setting Up Mod Script at: %s\n" "${mod_dir}"
        sudo chown root:adm "${bright_dir}"/brightness_mod.sh \
        && sudo chmod 550 "${bright_dir}"/brightness_mod.sh \
        && sudo cp "${bright_dir}"/brightness_mod.sh "${mod_dir}"/brightness_mod.sh
    else
        printf "Making Directory and Setting Up Mod Script at: %s\n" "${mod_dir}"
        sudo mkdir -p /etc/startup \
        && sudo chown root:adm "${bright_dir}"/brightness_mod.sh \
        && sudo chmod 550 "${bright_dir}"/brightness_mod.sh \
        && sudo cp "${bright_dir}"/brightness_mod.sh "${mod_dir}"/brightness_mod.sh
    fi 
}

setup_service() {
    if [ -d "${service_dir}" ]; then
        printf "Setting Up Service at: %s\n" "${service_dir}"
        sudo chown root:adm "${bright_dir}"/brightness_mod.service \
        && sudo chmod 444 "${bright_dir}"/brightness_mod.service \
        && sudo cp "${bright_dir}"/brightness_mod.service "${service_dir}"/brightness_mod.service \
        && sudo systemctl enable brightness_mod.service \
        && sudo systemctl daemon-reload
    else
        printf "Failed at copying or starting Service Mod to: %s.\n" "${service_dir}"
    fi
}

########################
####### MAIN RUN #######
########################
printf "\n\t########################\n\t####### Brightxf #######\n\t########################\n\n\tStarting Brightxf install.................\n\n" \
    && check_path && bright_clone && check_script_dir && setup_mod && setup_service && sudo rm -rf "${bright_dir}" \
    && printf "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n \nCleaning up install folder...............................................\n_________________________________________________________________________\n \nIf Errors were printed, double check that all steps completed properly...\n_________________________________________________________________________\n \nOtherwise, it should be working now.......................................\n________________________________________________________________________\n \nScript Completed.........................................................\n_________________________________________________________________________\n \nTerminal Commands are:\n---------------------\n\tbrmx\tmax\n\tbrcur\tcurrent\n\tbrup\tup\n\tbrwn\tdown\n---------------------\n"
