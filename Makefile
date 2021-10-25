user=$(shell sh -c "echo $$(id -u)")
TEMPLATE_NAME ?= janus

build:
	@docker build -t oshuntica/$(TEMPLATE_NAME) .

build-nocache:
	@docker build --no-cache -t oshuntica/$(TEMPLATE_NAME) .

bash:
	@docker run --net=host -v /home/ubuntu:/ubuntu --name="janus" -it -t oshuntica/$(TEMPLATE_NAME) /bin/bash

attach:
	@docker exec -it janus /bin/bash

rm:
	docker stop janus && docker rm janus

pull
	docker pull oshuntica/$(TEMPLATE_NAME)

run:
	UID=${user} docker run -d --net=host --name="janus" -it -t -v ${PWD}/nginx.conf:/usr/local/nginx/nginx.conf:ro -v ${PWD}/records:/workspace/records -v /var/run/docker.sock:/var/run/docker.sock --user=${UID} oshuntica/$(TEMPLATE_NAME)

run-mac:
	@docker run -p 80:80 -p 8088:8088 -p 8188:8188 --name="janus" -it -t oshuntica/$(TEMPLATE_NAME)

run-hide:
	@docker run --net=host --name="janus" -it -t oshuntica/$(TEMPLATE_NAME) >> /dev/null
