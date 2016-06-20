# dockerfile for hifone

## how to run

### step 1: build the image

    git clone https://github.com/Hifone/Docker.git
    
    cd Docker
    docker build -t hifone --rm .
    
### step 2: run the container

    # run the container and bind port to 8081 on the host
    docker run -it --rm -p 0.0.0.0:8081:80 hifone

### step 3: launch the service
    /run.sh
    
now you could visit `http://127.0.0.1:8081`(linux) or `http://192.168.99.100:8081`(mac) and see the install page