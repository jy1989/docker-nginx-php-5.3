.PHONY: build run

build:
	sudo docker build --rm=true -t mazelab/nginx-php-5.3 .

run:
	sudo docker run -tiP --rm=true --name nginx-php-5.3 mazelab/nginx-php-5.3 /bin/bash
