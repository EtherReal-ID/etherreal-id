# configure

#### ubuntu
sudo apt-get install build-essential checkinstall
sudo apt-get install nodejs
sudo apt-get install npm

- npm install jspm -g
- npm install sails -g
- cd etherreal-id.git/src
- npm install sails-hook-typescript
- npm install
- jspm init

            sometimes the node binary lands in /usr/bin/nodejs. 
            if on "jspm init" you get something like this...

            "   
                user@PC:~/path/to/yourcod$ jspm init
                >/usr/bin/env: ‘node’: No such file or directory   
            "
            
            you can fix it with

            sudo ln -s /usr/bin/nodejs /usr/bin/node
            


- jspm install -y


# run
- sails lift
