#!/bin/bash

set -e

user=$(whoami)

if [[ $user != root ]]; then
  echo "Not ran as sudo. Please use: sudo ./projgen.sh"
  exit 1
fi


me=`basename "$0"`
pushd `dirname $0` > /dev/null
actuallocation="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
popd > /dev/null

  if [[ ! -e /bin/projgen ]]; then
    echo "Do you want a copy of this file in /bin folder?"
    echo "If yes, then next time you need to run this script,"
    echo "it'll be enough if you type \"projgen\" in the terminal"
    echo "1) Yes!"
    echo "2) No, thank you!"
    read -p "#? " case;
    case $case in
    1)
      cp -u $actuallocation/projgen.sh /bin/projgen
      cp -u $actuallocation/DefaultLaravelConfig /bin/DefaultLaravelConfig
      chmod +x /bin/projgen
      echo ""
      echo "######################################################################"
      echo "### I have copied the script and the DefaultLaravelConfig to /bin. ###"
      echo "###            You can even delete this file if you wish.          ###" 
      echo "### Type \"sudo projgen\" in the terminal it run the script          ###"
      echo "######################################################################"
      echo ""
      exit 0;;
    2)
      echo ""
      echo "Next time you need to run this script, start this file in terminal."
      echo "";;
    *) 
      echo "Wrong answer. Quitting...."
      exit 0;;
    esac
  elif [ $actuallocation != "/bin" ]; then

################################
## Beginning of version check ##
################################

      actuallocation=`pwd -P`
      installedver=$(tail -c 3 /bin/projgen)
      installedmainver=$(tail -c 3 /bin/projgen | head -c 1)
      installedsubver=$(tail -c 3 /bin/projgen | tail -c 1)
      currentver=$(tail -c 3 $actuallocation/projgen.sh)
      currentmainver=$(tail -c 3 $actuallocation/projgen.sh | head -c 1)
      currentsubver=$(tail -c 3 $actuallocation/projgen.sh | tail -c 1)

        if [[ $installedsubver -lt $currentsubver || $installedmainver -lt $currentmainver ]]; then
          echo ""
          echo ""
          echo "Installed version: v"$installedmainver"."$installedsubver
          echo "Running version: v"$currentmainver"."$currentsubver
          echo "This file is newer than the file installed. should I overwrite it?"
          echo "1) Yes"
          echo "2) No"
          echo ""
          read -p "#? " case;
          case $case in
            1)
              cp -u $actuallocation/projgen.sh /bin/projgen
              chmod +x /bin/projgen
              echo ""
              echo ""
              echo "#################################################"
              echo "###                                           ###"
              echo "###               Update successfull          ###" 
              echo "###        Run \"sudo projgen\" in terminal     ###"
              echo "#################################################"
              echo ""
              echo ""
              exit 0;;
            2)
              echo ""
              echo ""
              echo "Running..."
              echo "";;
            *) 
              echo "Wrong answer. Quitting...."
              exit 0;;
          esac
        elif [[ $installedsubver -eq $currentsubver && $installedmainver -eq $currentmainver ]]; then
            echo ""
            echo ""
            echo "This version is the same as the one installed."
            echo ""
            echo "Installed version: v"$installedmainver"."$installedsubver
            echo "Running version: v"$currentmainver"."$currentsubver
            echo "Do you still want to run this file?"
            echo "1) Yes"
            echo "2) No"
            echo ""
            read -p "#? " case;
            case $case in
              1)
                break;;
              2)
                echo ""
                echo ""
                echo "I recommend running the script with \"sudo projgen\" command."
                exit 0;;
              *) 
                echo "Wrong answer. Quitting...."
                exit 0;;
            esac
        else
            echo ""
            echo ""
            echo "Installed version: v"$installedmainver"."$installedsubver
            echo "Running version: v"$currentmainver"."$currentsubver
            echo "Do you still want to run this file?"
            echo "1) Yes"
            echo "2) No"
            read -p "#? " case;
            case $case in
              1)
                break;;
              2)
                echo "Quitting!"
                exit 0;;
              *) 
                echo "Wrong answer. Quitting...."
                exit 0;;
            esac
        fi
      fi


if [[ ! -e /bin/DefaultLaravelConfig ]]; then
while true;do
  echo "Can't find the NginX config file DefaultLaravelConfig in /bin"
  read -p "Do you want to use a custom config file? (yes/no/quit) " live
  case $live in
    [Yy]*)  echo "Give me the location of the NginX configuration file"
            echo "(Including the filename)"
            read configlocation
            if [ ! -e "$configlocation" ];then
              echo "No such file! Did you write it correctly?"
              echo ""
            fi
            break;;
    [Nn]*)  echo "Give me the location of DefaultLaravelConfig file!"
            echo "(Only folder without the filename)"
            read -e configlocation
            if [ "${configlocation: -1}" == "/" ]; then
                echo $configlocation
            else
                configlocation=$configlocation"/"
                echo $configlocation 
            fi
            if [ ! -e "$configlocation"DefaultLaravelConfig ];then
              echo "Can't find DefaultLaravelConfig file. Did you write it correctly?"
              echo $configlocation
            fi
            configlocation=$configlocation"DefaultLaravelConfig"
            echo $$configlocation"DefaultLaravelConfig"
            break;;
    [Qq]*)  exit 0;;
    *)  echo "Wrong answer!";;
  esac
done
cp $configlocation /bin/DefaultLaravelConfig
configlocation="/bin/DefaultLaravelConfig"
fi

live=true
##########################
## End of version check ##
##########################

#######################
## Program beginning ##
#######################
installedmainver=$(tail -c 3 /bin/projgen | head -c 1)
installedsubver=$(tail -c 3 /bin/projgen | tail -c 1)


echo ""
echo ""
echo "##################################"
echo -e "##          Version: "$installedmainver"."$installedsubver"         ##"
echo "##      Default information     ##"
echo "##################################"
echo "This is a staging site setup for Laravel sites"
echo "on NginX and MySQL environment servers."
echo "Currently I don't recommend it for production sites,"
echo -e "but you can test it out on staging servers. (I'm \u263B)"
echo ""
echo "Make sure NginX and MySQL server (or MariaDB) are installed!"
echo ""
echo "Made on CentOS 7"
echo ""

###################################
## Platform check:               ##
## later patch will include      ##
## MAC and FreeBSD compatibility ##
###################################

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
   echo "Linux platform detected"
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
   echo "FreeBSD platform detected"
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='mac'
   echo "Mac platform detected"
fi

###############
## Variables ##
###############

bold=$(tput bold)
normal=$(tput sgr0)
actuallocation=$(pwd)
conflocation=""
linuxlocation="/etc/nginx/sites-available/"
customlocation=""
dbuser=""
dbpasswd=""
customdbuser=""
customdbpasswd=""
customdbpasswd1="1"
customdbpasswd2="2"
mysqldata="mysql -u "$dbuser" -e 'CREATE SCHEMA \`$project\` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;';"
database="" # 1 = Only database # 2 = Database with custom user and password #
customconf=""
customgit=""
clonelocation=""
docommands=true
createdb=true
configlocation="/bin/DefaultLaravelConfig"

echo "Project name: "
read proj
echo "Username: "
read nev
echo "Git link: "
read git

#############
## Slugify ##
#############

project_name=`echo $proj | iconv -f utf8 -t ascii//TRANSLIT | iconv -c -f utf8 -t ascii`
max_length="${2:-48}"
project="$({
  tr -d \' | tr -d \: |tr '[A-Z]' '[a-z]' | tr -cs '[[:alnum:]]' '-'
} <<< "$project_name")"
project="${project##-}"
project="${project%%-}"
project="${project:0:$max_length}"

name_name=`echo $nev | iconv -f utf8 -t ascii//TRANSLIT | iconv -c -f utf8 -t ascii`
name="$({
  tr -d \' | tr -d \: |tr '[A-Z]' '[a-z]' | tr -cs '[[:alnum:]]' '-'
} <<< "$name_name")"
name="${name##-}"
name="${name%%-}"
name="${name:0:$max_length}"

linuxlog="/var/log/nginx/"$project
linuxerror="/var/log/nginx/"$project"/error.log"
linuxaccess="/var/log/nginx/"$project"/access.log"
gitlocation="/var/www/"
clonelocation=$gitlocation"/com."$project

#########################################
## Settings for saving the config file ##
#########################################

if [ $platform = 'linux' ]; then
    echo ""
    echo "############################"
    echo "## Setting up config file ##"
    echo "############################"
    echo ""
    echo "Default location: "$linuxlocation
    echo "Actual location: "$actuallocation
    echo ""
fi

function confcreate
{
  cp $configlocation $configfile
  sed -i "s/<username>/$name/" $configfile
  sed -i "s/<projectname-slug>/$project/" $configfile
}

function linkcreate
{
  ln -s $configfile /etc/nginx/sites-enabled/$configfile
}

while true;do
read -p "Do you want to put the config file in the default folder? (yes/no/quit) " live
case $live in
  [Yy]*)  configfile=$linuxlocation"com."$project
          break;;
  [Nn]*)  while [ ! -d "$customconf" ];do
          echo "Where do you want to put the file?"
          read -e customconf
          if [ "${customconf: -1}" == "/" ]; then
              echo $customconf
            else
              customconf=$customconf"/"
              echo $customconf
          fi
          if [ ! -d "$customconf" ];then
            echo "No such directory! Did you write it correctly?"
            echo ""
          fi
          configfile=$customconf"com."$project
        done
        break;;
  [Qq]*) exit 0;;
      *) echo "Wrong answer!";;
esac
done

while true;do
read -p "Do you want to link the config file to sites-enabled folder? (yes/no/quit) " live
case $live in
  [Yy]*)  link = true
          break;;
  [Nn]*)  break;;
  [Qq]*)  exit 0;;
      *)  echo "Wrong answer!";;
esac
done

########################
## Setting up cloning ##
########################

if [ $platform = 'linux' ]; then
    echo ""
    echo "########################"
    echo "## Setting up cloning ##"
    echo "########################"
    echo ""
    echo "Default location: "$gitlocation
    echo "Actual location: "$actuallocation
    echo ""
fi

read -p "Do you want to clone the repository to the default folder? (yes/no/quit)" live
case $live in
  [Yy]*)  clonelocation=$gitlocation"com."$project
          break;;
  [Nn]*)  while [ ! -d "$customgit" ];do
            echo "Where do you want to clone the repository to?"
            read -e customgit
            if [ ! -d "$customgit" ];then
              echo "No such directory! Did you write it correctly?"
              echo ""
            fi
            gitlocation=$customgit
            if [ "${gitlocation: -1}" == "/" ]; then
              echo $gitlocation
              break
            else
              gitlocation=$gitlocation"/"
              echo $gitlocation
            fi
            clonelocation=$gitlocation"com."$project
          done
          break;;
  [Qq]*)  exit 0;;
      *) echo "Wrong answer!";;
esac

#######################
## Database settings ##
#######################

echo ""
echo "#######################"
echo "## Database settings ##"
echo "#######################"
echo ""
while true;do
read -p "Do you want to create a database now? (yes/no/quit) " live
case $live in
  [Yy]*)  createdb=true
          echo "Database root username: "
          read dbuser; 
          echo "Password: "
          read -s dbpasswd;
          while true;do
          read -p "Do you want to create a seperate user for the database? (yes/no/quit) " live
          case $live in
            [Yy]*)  echo "Username: "
                    read customdbuser;
                    while [ "$customdbpasswd1" != "$customdbpasswd2"  ]; do
                      echo "Password: "
                      read -s customdbpasswd1; 
                      echo "Repeat password: "
                      read -s customdbpasswd2;
                      if [ "$customdbpasswd1" != "$customdbpasswd2"  ]; then
                        echo "The passwords do not match. Try again!"
                        echo ""
                      fi
                    done
                    customdbpasswd=$customdbpasswd1
                    database=2 # Create database with custom user and password #
                    mysqlcreateuser="mysql -u root -p"$dbpasswd" -e 'GRANT ALL PRIVILEGES ON \`"$project"\`.* TO \""$customdbuser"\"@"localhost" IDENTIFIED BY \""$customdbpasswd"\";'"
                    mysqlcreateusernopassword="mysql -u root -e 'GRANT ALL PRIVILEGES ON \`"$project"\`.* TO \""$customdbuser"\"@"localhost" IDENTIFIED BY \""$customdbpasswd"\";'"
                    databaseusrpass=$customdbuser" / "$customdbpasswd
                    break;;
            [Nn]*)  database=1 # Create only database #
                    mysqlcreateuser="mysql -u root -p"$dbpasswd" -e 'GRANT ALL PRIVILEGES ON \`"$project"\`.* TO \""$dbuser"\"@"localhost" IDENTIFIED BY \""$dbpasswd"\";'"
                    databaseusrpass=$dbuser" / "$dbpasswd
                    break;;
            [Qq]*)  exit 0;;
            *) echo "Wrong answer!";;
          esac
          done
          mysqlcreatedatabase="mysql -u root -p"$dbpasswd" -e 'CREATE SCHEMA \`"$project"\` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;'"
          mysqlcreatedatabasenopassword="mysql -u root -e 'CREATE SCHEMA \`"$project"\` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;'"
          break;;
  [Nn]*)  createdb=false
          break;;
  [Qq]*)  exit 0;;
      *) echo "Wrong answer!";;
esac
done

echo ""
echo "#####################################################"
echo ""
echo -e "mkdir /var/log/nginx/"$project" \ntouch /var/log/nginx/"$project"/error.log \ntouch /var/log/nginx/"$project"/access.log\nchmod -R 777 storage\nchmod -R 777 bootstrap/cache\ncomposer install\ncp .env.example .env\nphp artisan key:generate\nphp artisan migrate --seed"
echo ""
read -p "Do you want to run the upper commands on the cloned repository? (yes/no/quit) " live
case $live in
  [Yy]*)  docommands=true
          break;;
  [Nn]*)  docommands=false
          break;;
  [Qq]*)  exit 0;;
      *) echo "Wrong answer!";;
esac

###############
## Execution ##
###############

cd $gitlocation
su $name -c "git clone "$git" "$gitlocation"com."$project
confcreate
if [[ link = true ]]; then
  linkcreate
fi
if [[ $docommands = true ]]; then
  cd $gitlocation"com."$project
  composer config -g github-oauth.github.com b80022a0ff12117458c46bdf8ad7a3ae3abd96c3
  if [[ ! -e storage ]]; then
    mkdir storage || true
  fi
  if [[ ! -e bootstrap/cache ]]; then
    mkdir -p bootstrap/cache || true
  fi
  chmod -R 777 storage
  chmod -R 777 bootstrap/cache
  mkdir /var/log/nginx/"$project" || true
  touch /var/log/nginx/"$project"/error.log || true
  touch /var/log/nginx/"$project"/access.log || true
  cp .env.example .env
  sed -i "s/<projectname-slug>/$project/" .env
  sed -i "s/<projectname>/$proj/" .env
  sed -i "s/<username>/$name/" .env
  if [[ $createdb = true && $customdbuser = "" ]]; then
    sed -i "s/<dbuser>/$dbuser/" .env
    sed -i "s/<secret>/$dbpasswd/" .env
    if [[ ! -z $dbpasswd ]]; then
      eval $mysqlcreatedatabasenopassword
    else
      eval $mysqlcreatedatabase
    fi
  else
    sed -i "s/<dbuser>/$customdbuser/" .env
    sed -i "s/<secret>/$customdbpasswd/" .env
    eval $mysqlcreatedatabase 
    if [[ ! -z $dbpasswd ]]; then
      eval $mysqlcreateuser
    else
      eval $mysqlcreateusernopassword
    fi
  fi
  composer install --no-scripts
  if [[ $createdb = true ]];then
    php artisan migrate --seed
  fi
fi
if  [[ $docommands = false ]]; then
  if [[ $createdb = true && $customdbuser = "" ]]; then
    eval $mysqlcreatedatabase
  else
    eval $mysqlcreatedatabase 
    eval $mysqlcreateuser
fi

fi

read -p "Do you want to write domain name to hosts file? (yes/no/quit)" live
case $live in
  [Yy]*)  echo -e '127.0.0.1\t\t\t'$project'-'$name'.com' >> /etc/hosts
          if [[ $? -ne 0 ]]; then
            echo "Couldn't write to hosts file"
            echo "Add manually the following line to your hosts file:"
            echo "127.0.0.0.1     "$project"-"$name".com"
          fi
          break;;
  [Nn]*)  break;;
  [Qq]*)  exit 0;;
      *) echo "Wrong answer!";;
esac

echo -e '127.0.0.1\t\t\t'$project'-'$name'.bap' >> /etc/hosts
if [[ $? -ne 0 ]]; then
  echo "Couldn't write to hosts file"
  echo "Add manually the following line to your hosts file:"
  echo "127.0.0.0.1     "$project"-"$name".com"
fi

if [[ -e $clonelocation/.env ]]; then
  echo "What should be in APP_ENV variable?"
  echo "1) local"
  echo "2) development"
  echo "3) staging"
  echo "4) production"
  read -p "#? " case;
  case $case in
  1)  sed -i "s/<app-env>/local/" .env
      break;;
  2)  sed -i "s/<app-env>/development/" .env
      break;;
  3)  sed -i "s/<app-env>/staging/" .env
      break;;
  4)  sed -i "s/<app-env>/production/" .env
      break;;
  *)  sed -i "s/<app-env>/development/" .env
      break;;
  esac
fi

if [[ link = true ]]; then
  systemctl restart nginx
fi

echo ""
echo "#############################################"
echo "#################  SUMMARY  #################"
echo "#############################################"
echo -e ${bold}"URL: \t\t\t\t| "${normal}$project"-"$name".com"
echo -e ${bold}"Config file: \t\t\t| "${normal}$conflocation
echo -e ${bold}"Error file: \t\t\t| "${normal}$linuxerror
echo -e ${bold}"Access file: \t\t\t| "${normal}$linuxaccess
if [[ $createdb = true ]]; then
  echo -e ${bold}"Database name: \t\t\t| "${normal}$project "\t <<< Not in .env file!!!"
  echo -e ${bold}"Database user: / passwd: \t| "${normal}$databaseusrpass "\t <<< Not in .env file!!!"
else
  echo -e ${bold}"Database name: \t\t\t| "${normal}$project
  echo -e ${bold}"Database user / passwd: \t| "${normal}$databaseusrpass
fi
echo ""
echo -e "All done!\nHave a pleasent worktime!"  

#Version: 3.0