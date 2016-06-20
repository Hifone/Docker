# dockerfile for hifone

## how to run

    git clone https://github.com/Hifone/Docker.git
    
    cd Docker
    docker build -t hifone --rm .
    
    # run the container and bind port to 8081 on the host
    docker run -it -p 0.0.0.0:8081:80 hifone

    # inside container,launch the shell to config and launch the app;it could cost a few minutes
    /launch-hifone.sh
    
now you could visit `http://127.0.0.1:8081`(linux) or `http://192.168.99.100:8081`(mac) and see the install page