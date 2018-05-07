# Makefile

IMAGE_NAME ?= xczh/ss-libev
CONTAINER_NAME ?= ss-libev
VER ?= $(shell git ls-remote -t https://github.com/shadowsocks/shadowsocks-libev | awk -F/ '$$3 ~ /^v[0-9](\.[0-9])+$$/ {print substr($$3,2)}' | sort -Vr | head -n 1)

PASSWORD ?= hello_ss
SERVER_PORT ?= 6011
DNS_ADDR ?= 119.29.29.29

# target

build_image: remove_image
	sudo docker build -t ${IMAGE_NAME}:${VER} --build-arg SS_VER=${VER} .

run: stop_container
	sudo docker run -d --restart=always \
	                   --name ${CONTAINER_NAME} \
	                   -p ${SERVER_PORT}:${SERVER_PORT} \
	                   -p ${SERVER_PORT}:${SERVER_PORT}/udp \
	                   -e SERVER_PORT=${SERVER_PORT} \
	                   -e PASSWORD=${PASSWORD} \
	                   -e DNS_ADDR=${DNS_ADDR} \
	                   ${IMAGE_NAME}:${VER}

remove_image:
	-sudo docker rmi ${IMAGE_NAME}:${VER} > /dev/null 2>&1

stop_container:
	-sudo docker stop ${CONTAINER_NAME} > /dev/null 2>&1 && sudo docker rm ${CONTAINER_NAME}
