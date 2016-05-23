# dkrenv
A quick and dirty virtualenv like configuration manager for Docker  

Uses directory local `.dkrenv` files to launch project specific docker instances, so you don't have to remember what instance goes where.

## Usage
Run `dkrenv.sh` from any directory containing a `.dkrenv` file to launch the docker instance.  

## Configration
`.dkrenv` files support the following configuration options:  

`DKR_IMAGE` - docker base image  
`DKR_CMD` - command, defaults to /bin/bash  
`DKR_PORTS` - ports to bind, in the form address:port:port (ie. 127.0.0.1:9001:9001)  
`DKR_VOLUMES` - volumes to bind, in the form of local:remote (ie. /home/ryan/Downloads:/opt/downloads)  

Note that multiple DKR_PORTS and DKR_VOLUMES may be specified as a space separated string, ie. DKR_VOLUMES="/home/ryan:/opt/ryan /media/usb:/opt/usb".  

