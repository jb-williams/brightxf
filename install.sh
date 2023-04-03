#!/usr/bin/env bash
##################################
####### SETUP FOR BRIGHTXF #######
##################################

##### RUN AT OWN RISK #####
##### TESTED Debian Testing. ###########
# Reqs:
    # systemd
    # sudo
 
# Install Script Expects:
    # `/tmp/brightxf`(added by initial curl install script)
    # `~/.local/bin`
    # `/etc/startup`(addded by initial curl install script)

# To Run:
#   curl https://raw.githubusercontent.com/jb-williams/brightxf/master/install.sh | bash

####################
###### COLORS ######
####################
bold="\e[1m"
underline="\e[4m"
blink="\e[5m"
normal="\e[0m"
red="\e[31m"
green="\e[32m"
purple="\e[35m"

####################
####### VARS #######
####################

bright_dir="/tmp/brightxf"
shell_config="${HOME}""/.$(echo "${SHELL}rc" | cut -d "/" -f 3)"
script_dir="${HOME}""/.local/bin"
mod_dir="/etc/startup"
service_dir="/etc/systemd/system"
user_scripts=("brightxf" "brmx" "brcur" "brup" "brwn")
## clean up real quick
if [[ -d "${bright_dir}" ]];then
    sudo rm -rf "${bright_dir}"
fi

##########################
####### USER SETUP #######
##########################
check_path() {
    if ! echo "$PATH" | grep -q "${script_dir}"; then
    #if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
        echo -e "export PATH=${PATH}:${script_dir}" >> "${shell_config}"
    fi
    if [[ ! -d "${script_dir}" ]]; then
        mkdir -p "${script_dir}" \
            && printf "%b%s %b%s%b\n" "${normal}${bold}${green}${underline}" "PATH" "${normal}${green}" "is setup correctly!" "${normal}"
    else
        printf "%b%s %b%s%b\n" "${normal}${bold}${green}${underline}" "PATH" "${normal}${green}" "is setup correctly!" "${normal}"
    fi
}

bright_clone() {
    printf "%b%s %b%s%b\n" "${normal}${green}" "Cloning Repo" "${bold}${blink}" "${bright_dir} ....." "${normal}" \
        && git clone https://github.com/jb-williams/brightxf.git "${bright_dir}" \
        && printf "%b%s%b\n" "${normal}${bold}${green}" "${bright_dir} is setup correctly." "${normal}"
}

check_script_dir() {
    if [[ -d "${script_dir}" ]]; then
            setup_user_files
    else
        check_path \
            && setup_user_files
    fi
}

setup_user_files() {
    for sc in "${user_scripts[@]}"; 
    do
        if [[ -f "${bright_dir}/${sc}" ]]; then
            chown "${USER}":"${USER}" "${bright_dir}/${sc}" \
            && chmod 555 "${bright_dir}/${sc}" \
            && cp "${bright_dir}/${sc}" "${script_dir}/${sc}" 
            if [[ -f "${script_dir}/${sc}" ]]; then
                printf "%b%s %b%s %b%s%b%s%b\n" "${normal}${bold}${green}${underline}${blink}" "Successfully" "${normal}${green}" "copied user script:" "${bold}" "${bright_dir} ${sc} to ${script_dir} ${sc}" "${normal}${green}${blink}" "......." "${normal}" 
            else
                printf "%b%s %b%s %b%s%b%s%b\n" "${normal}${bold}${green}${underline}${blink}" "Successfully" "${normal}${green}" "copied user script:" "${bold}" "${bright_dir} ${sc} to ${script_dir} ${sc}" "${normal}${green}${blink}" "......." "${normal}" 
            fi
        else
            printf "%b%s %b%s%b%s%b\n" "${normal}${red}" "Could not find:" "${bold}" "${bright_dir}" "${blink}" "......." "${normal}" 
        fi
    done
}

############################
####### SYSTEM SETUP #######    
############################
setup_mod() {
    if [[ -d "${mod_dir}" ]]; then
        printf "%b%s %b%s%b%s%b\n" "${normal}${green}" "Setting Up Mod Script at:" "${bold}" "${mod_dir}" "${blink}" "......." "${normal}"
        sudo chown root:adm "${bright_dir}"/brightness_mod.sh \
            && sudo chmod 550 "${bright_dir}"/brightness_mod.sh \
            && sudo cp "${bright_dir}"/brightness_mod.sh "${mod_dir}"/brightness_mod.sh
    else
        printf "%b%s %b%s %b%s%b\n" "${normal}${green}" "Making Directory and Setting Up Mod Script at:" "${bold}" "${mod_dir}" "${normal}${blink}${green}" "......." "${normal}" 
        sudo mkdir -p /etc/startup \
            && sudo chown root:adm "${bright_dir}"/brightness_mod.sh \
            && sudo chmod 550 "${bright_dir}"/brightness_mod.sh \
            && sudo cp "${bright_dir}"/brightness_mod.sh "${mod_dir}"/brightness_mod.sh
    fi 
}

setup_service() {
    if [[ -d "${service_dir}" ]]; then
        printf "%b%s %b%s%b%s%b\n" "${normal}${green}" "Setting Up Service at:" "${bold}" "${service_dir}" "${normal}${blink}${green}" "......." "${normal}"
        sudo chown root:adm "${bright_dir}"/brightness_mod.service \
            && sudo chmod 444 "${bright_dir}"/brightness_mod.service \
            && sudo cp "${bright_dir}"/brightness_mod.service "${service_dir}"/brightness_mod.service \
            && sudo systemctl enable brightness_mod.service \
            && sudo systemctl daemon-reload
    else
        printf "%b%s %b%s %b%s %b%s%b\n" "${bold}${red}" "Failed" "${normal}${red}" "at copying or starting Service Mod to:" "${bold}" "${service_dir}" "${normal}${blink}${red}" "......." "${normal}"
    fi
}

########################
####### MAIN RUN #######
########################
printf "%b\n\t%s\n\t%s%b%s%b%s\n\t%s\n\n\t%b%s%b\n\n" "${normal}${bold}${purple}" "########################" "#######" "${normal}${bold}${green}" "Brightxf" "${normal}${bold}${purple}" "#######" "########################" "${normal}${bold}${green}" "Starting Brightxf install ................." "${normal}" \
    && check_path && bright_clone && check_script_dir && setup_mod && setup_service && sudo rm -rf "${bright_dir}" \
    && printf "%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n%b%s\n\t%b%s\t%b%s\n\t%b%s\t%b%s\n\t%b%s\t%b%s\n\t%b%s\t%b%s\n%b%s\n%b%s\n%b" "${normal}${bold}${purple}" "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" "${normal}${bold}${green}" "Cleaning up install folder..............................................." "${normal}${bold}${purple}" "_________________________________________________________________________" "${normal}${bold}${green}" "If Errors were printed, double check that all steps completed properly" "${normal}${green}" "..." "${normal}${bold}${purple}" "_________________________________________________________________________" "${normal}${bold}${green}" "Otherwise, it should be working now" "${normal}${green}" "......................................." "${normal}${bold}${purple}" "________________________________________________________________________" "${normal}${bold}${green}" "Script Completed" "${normal}${green}" "........................................................." "${normal}${bold}${purple}" "_________________________________________________________________________" "${normal}${bold}${green}" "Terminal Commands are:" "${normal}${bold}${purple}" "-------------------------" "${normal}${bold}${green}" "brmx" "${normal}" "max" "${bold}${green}" "brcur" "${normal}" "current" "${bold}${green}" "brup" "${normal}" "up" "${bold}${green}" "brwn" "${normal}" "down" "${bold}${purple}" "-------------------------" "${normal}${bold}${purple}" "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" "${normal}"
