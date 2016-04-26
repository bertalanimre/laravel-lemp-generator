# Staging environment setup for Laravel websites 

TODO: This bash script help you to set up a laravel 5 website on RHEL servers fast and easy.

Features:
* Version check
* Creates nginx config file for standard laravel 5 website and restats nginx if required
* Can create datapase with new user
* Creates the required folders for nginx logging
* Writes domain name in hosts file with 127.0.0.1 address
* Can do a composer install, php artisan migrate:refresh --seed, php artisan key:generate
* Creates the .env file and fills up with correct data
* All the chmod you need
* Wishes you a pleasent worktime. :-)

## Installation

Requirements:
* CentOS-7 / RedHat-7 / Fedora 23
* Git
* NginX
* PHP-FPM
* MariaDB / MySQL

TODO: Download projgen.sh and DefaultLaravelConfig. Then simply run projgen.sh in terminal. If required add +x for the file as sudo

## Usage

TODO: After first run, no need to keep the downloaded files, they are writen in /bin. Run them by typing sudo projgen.

Note: Because of many process, the file has to be run as sudo. Otherwise it won't work.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :-D

## History

It was first an nginx generator. Then became a database creator as well. Later, it got the version checking system for easy update. Etc, etc....

## Credits

I would like to say thank you for StackOverflow and ServerFault community for the many-many answers already there.
Also would like to thank you for Google and myself. :-)

## License

You are all allowed to freely download and customise the script as you wish. Just leave a "thanks" please if you do.
