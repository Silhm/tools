#!/bin/bash
# ----------------------------------------------------------------------------
# [Author]      Simon Florentin (mail@simon-florentin.fr)
# [Description]  


# [Licence] Creative Commons CCBY

# Dependency:
#     http://shflags.googlecode.com/svn/trunk/source/1.0/src/shflags
# ----------------------------------------------------------------------------
VERSION=0.1.0

# --- Display usage if no parameters given -----------------------------------
usage(){
	echo "Usage: $SCRIPT_NAME [options] [arguments]

	Options:
		-y, --yes	 answer yes to all questions
		-h, --help   display this help and exit
	Arguments: 
		path		 provide the path where you want to create the project
	"  
}

if [[ -z "$@" ]]; then
	usage
	exit
fi

# --- Text color variables ---------------------------------------------------
txtred='\e[0;31m'       # red
txtgrn='\e[0;32m'       # green
txtylw='\e[0;33m'       # yellow
txtblu='\e[0;34m'       # blue
txtpur='\e[0;35m'       # purple
txtcyn='\e[0;36m'       # cyan
txtwht='\e[0;37m'       # white
bldred='\e[1;31m'       # red    - Bold
bldgrn='\e[1;32m'       # green
bldylw='\e[1;33m'       # yellow
bldblu='\e[1;34m'       # blue
bldpur='\e[1;35m'       # purple
bldcyn='\e[1;36m'       # cyan
bldwht='\e[1;37m'       # white
txtrst='\e[0m'          # Text reset

# Feedback indicators
info=${bldwht}*${txtrst}
pass=${bldblu}*${txtrst}
warn=${bldred}!${txtrst}

# Indicator usage
echo -e "${info} "
echo -e "${pass} "
echo -e "${warn} "


# --- Script vars -------------------------------------------------------------
#FOLDER="/home/simonf/web/scripts"
FOLDER=$1
TMP_FOLDER="/tmp/starter_web"
WGET="/usr/bin/wget -P"		# Wget executable

# --- Script Starts -----------------------------------------------------------

echo -e ${bldwht}"** This script generate a web project with all library needed **"${txtrst}

echo ""
read -p "Give a name to that project: " name

TMP_FOLDER=${TMP_FOLDER}_$(date +"%Y%m%d%H%M")
mkdir ${TMP_FOLDER}

mkdir ${FOLDER}/${name}
cd ${FOLDER}/${name}

mkdir -p web/assets/
mkdir web/js/
mkdir web/css/
mkdir web/images/

mkdir templates
mkdir scripts
mkdir lib
mkdir config 

use_bootstrap(){
	wget -P ${TMP_FOLDER}/ http://getbootstrap.com/bs-v3.0.0-rc1-dist.zip
	unzip -d ${TMP_FOLDER}/ ${TMP_FOLDER}/bs-v3.0.0-rc1-dist.zip 
    mkdir -p ${FOLDER}/${name}/web/assets/bootstrap/js
    mkdir -p ${FOLDER}/${name}/web/assets/bootstrap/css

	cp ${TMP_FOLDER}/dist/css/bootstrap* ${FOLDER}/${name}/web/assets/bootstrap/css/
	cp ${TMP_FOLDER}/dist/js/bootstrap* ${FOLDER}/${name}/web/assets/bootstrap/js/
}
use_fontawesome(){
	wget -P ${TMP_FOLDER}/ http://fortawesome.github.io/Font-Awesome/assets/font-awesome.zip
	unzip -d ${FOLDER}/${name}/web/assets/  ${TMP_FOLDER}/font-awesome.zip
}
use_less(){
	mkdir ${FOLDER}/${name}/web/assets/less
	wget -P ${FOLDER}/${name}/web/assets/less/ https://raw.github.com/less/less.js/master/dist/less-1.4.1.min.js
}
gen_html_base(){
	wget -P ${FOLDER}/${name}/web/ https://raw.github.com/twbs/bootstrap-examples/master/starter-template/index.html
}
gen_seo(){
	wget -P ${FOLDER}/${name}/web/ https://raw.github.com/h5bp/html5-boilerplate/master/humans.txt
	wget -P ${FOLDER}/${name}/web/ https://github.com/h5bp/html5-boilerplate/blob/master/robots.txt
	wget -P ${FOLDER}/${name}/web/ https://raw.github.com/h5bp/html5-boilerplate/master/404.html
	mkdir ${FOLDER}/${name}/web/assets/jquery/
    wget -P ${FOLDER}/${name}/web/assets/jquery http://code.jquery.com/jquery-1.10.2.js
	wget -P ${FOLDER}/${name}/web/assets/jquery http://code.jquery.com/jquery-1.10.2.min.js
}

# Bootstrap
while true; do
	read -p " * Do you wish to use Bootstrap? [y/n] " yn
	case $yn in
		[Yy]* ) 	
			use_bootstrap
			echo -e ${bldblu}"Done: Bootstrap added!\n"${txtrst}
			break;;
		[Nn]* ) break;; 
		* ) echo -e ${bldred}"Please answer yes or no." ${txtrst};;
	esac
done

# HTML Base
while true; do
	read -p " * Do you wish to create Html base?? [y/n] " yn
	case $yn in
		[Yy]* ) 	
			gen_html_base
			echo -e ${bldblu}"Done: html base written!\n"${txtrst}
			break;;
		[Nn]* ) exit;;
		* ) echo -e ${bldred}"Please answer yes or no." ${txtrst};;
	esac
done

# Font awesome
while true; do
	read -p " * Do you wish to use Font Awesome?? [y/n] " yn
	case $yn in
		[Yy]* ) 	
			use_fontawesome
			echo -e ${bldblu}"Done: html base written!\n"${txtrst}
			break;;
		[Nn]* ) exit;;
		* ) echo -e ${bldred}"Please answer yes or no." ${txtrst};;
	esac
done

# LESS
while true; do
	read -p " * Do you wish to use LESS?? [y/n] " yn
	case $yn in
		[Yy]* ) 	
			use_less
			echo -e ${bldblu}"Done: LESS added to the project!\n"${txtrst}
			break;;
		[Nn]* ) exit;;
		* ) echo -e ${bldred}"Please answer yes or no." ${txtrst};;
	esac
done

gen_seo

rm -r ${TMP_FOLDER}
#-- end script
