#!/usr/bin/env bash
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
###### COLORS ######
####################
bold=`echo -en "\e[1m"`
underline=`echo -en "\e[4m"`
dim=`echo -en "\e[2m"`
strickthrough=`echo -en "\e[9m"`
blink=`echo -en "\e[5m"`
reverse=`echo -en "\e[7m"`
hidden=`echo -en "\e[8m"`
normal=`echo -en "\e[0m"`
black=`echo -en "\e[30m"`
red=`echo -en "\e[31m"`
green=`echo -en "\e[32m"`

####################
####### VARS #######
####################
## clean up real quick
sudo rm -rf /tmp/brightxf

bright_dir="/tmp/brightxf"
shell_config=${HOME}"/.$(echo "${SHELL}rc" | cut -d "/" -f 3)"
script_dir=${HOME}"/bin"
mod_dir="/etc/startup"
service_dir="/etc/systemd/system"
user_scripts=("brightxf" "brmx" "brcur" "brup" "brwn")

##########################
####### USER SETUP #######
##########################
check_path() {
    echo -e "export PATH=${PATH}:$HOME/bin" >> "${shell_config}" \

        && mkdir -p "${script_dir}" \
        && printf "${normal}${bold}${green}${underline}PATH ${normal}${green}is setup correctly!${normal}\n"
}

bright_clone() {
    printf "${normal}${green}Cloning Repo ${bold}%s${blink}.....${normal}\n" "${bright_dir}"\
        && git clone https://github.com/jb-williams/brightxf.git "${bright_dir}" \
        && printf "${normal}${bold}${green}%s is setup correctly.${normal}\n" "${bright_dir}"
}

check_script_dir() {
    if [ -d "${script_dir}" ]; then
            setup_user_files
    else
        printf "${normal}${bold}${blink}${red}%s ${normal}does not exit${blink}...\n\t${normal}${orange}Attempting to make directory and retrying user file setup${blink}...${normal}${orange}\n\tMay need to check if the rest of the script ran properly.${normal}\n" "${script_dir}" \
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
                printf "${normal}${bold}${green}${underline}${blink}Successfully ${normal}${green}copied user script: ${bold}%s/%s to %s/%s ${normal}${green}${blink}.......\n" "${bright_dir}" "${sc}" "${script_dir}" "${sc}"
            else
                printf "${normal}${bold}${underline}${blink}${red}Failed ${normal}${red}to copying user script: ${bold}%s/%s ${normal}${red}to ${bold}%s/%s ${normal}${red}${blink}.......\n" "${bright_dir}" "${sc}" "${script_dir}" "${sc}"
            fi
        else
            printf "${normal}${red}Could not find: ${bold}%s ${blink}.......${normal}\n" "${bright_dir}"
        fi
    done
}

############################
####### SYSTEM SETUP #######    
############################
setup_mod() {
    if [ -d "${mod_dir}" ]; then
        printf "${normal}${green}Setting Up Mod Script at: ${bold}%s${blink}.......${normal}\n" "${mod_dir}"
        sudo chown root:adm "${bright_dir}"/brightness_mod.sh \
        && sudo chmod 550 "${bright_dir}"/brightness_mod.sh \
        && sudo cp "${bright_dir}"/brightness_mod.sh "${mod_dir}"/brightness_mod.sh
    else
        printf "${normal}${green}Making Directory and Setting Up Mod Script at: ${bold}%s ${normal}${blink}${green}.......${normal}\n" "${mod_dir}"
        sudo mkdir -p /etc/startup \
        && sudo chown root:adm "${bright_dir}"/brightness_mod.sh \
        && sudo chmod 550 "${bright_dir}"/brightness_mod.sh \
        && sudo cp "${bright_dir}"/brightness_mod.sh "${mod_dir}"/brightness_mod.sh
    fi 
}

setup_service() {
    if [ -d "${service_dir}" ]; then
        printf "${normal}${green}Setting Up Service at: ${bold}%s ${normal}${blink}${green}.......\n" "${service_dir}"
        sudo chown root:adm "${bright_dir}"/brightness_mod.service \
        && sudo chmod 444 "${bright_dir}"/brightness_mod.service \
        && sudo cp "${bright_dir}"/brightness_mod.service "${service_dir}"/brightness_mod.service \
        && sudo systemctl enable brightness_mod.service \
        && sudo systemctl daemon-reload
    else
        printf "${bold}${underlined}${red}Failed ${normal}${red}at copying or starting Service Mod to: ${bold}%s ${normal}${blink}${red}.......${normal}\n" "${service_dir}"
    fi
}

########################
####### MAIN RUN #######
########################
printf "${normal}${bold}${purple}\n\t########################\n\t####### ${normal}${bold}${green}Brightxf ${normal}${bold}${purple}#######\n\t########################\n\n\t${normal}${bold}${green}Starting Brightxf install .................${normal}\n\n" \
    && check_path && bright_clone && check_script_dir && setup_mod && setup_service && sudo rm -rf "${bright_dir}" \
    && printf "${normal}${bold}${purple}\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n \n${normal}${bold}${green}Cleaning up install folder...............................................\n${normal}${bold}${purple}_________________________________________________________________________\n \n${normal}${bold}${green}If Errors were printed, double check that all steps completed properly${normal}${green}...\n${normal}${bold}${purple}_________________________________________________________________________\n \n${normal}${bold}${green}Otherwise, it should be working now${normal}${green}.......................................\n${normal}${bold}${purple}________________________________________________________________________\n \n${normal}${bold}${green}Script Completed${normal}${green}.........................................................\n${normal}${bold}${purple}_________________________________________________________________________\n \n${normal}${bold}${green}Terminal Commands are:\n${normal}${bold}${purple}-------------------------\n\t${normal}${bold}${green}brmx\t${normal}max\n\t${bold}${green}brcur\t${normal}current\n\t${bold}${green}brup\t${normal}up\n\t${bold}${green}brwn\t${normal}down\n${bold}${purple}-------------------------\n${normal}${bold}${purple}+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n${normal}\n\n"
