
SHELL := /bin/bash

ifndef ARGS
ARGS:=up -d
endif

stack-vote:
	@echo -e "$(BLUE)Stack Vote$(NORMAL)"
	@if [ ! -d ~/example-voting-app ] ; then cd ~/ && git clone https://github.com/sebmoule/example-voting-app.git ; fi

	cd ~/example-voting-app ; \
	eval $$(docker-machine env --swarm ${MACHINE_MASTER_NAME}1) ; \
	export LOGSTASH_IP=$$(docker-machine ip ${MACHINE_MASTER_NAME}1) ; \
	docker-compose -p vote -f docker-compose.yml  -f docker-compose-networks.yml -f docker-compose-logs.yml $(ARGS) ; \
	docker-compose -p vote ps
	@echo -e "$(BLUE)Voting-app: $(VERT)https://vote.${PROXY_DNS}$(NORMAL)"
	@echo -e "$(BLUE)Voting Result: $(VERT)https://vote-result.${PROXY_DNS}$(NORMAL)"

	@echo -e "$(CYAN)If not all components are up, then try again$(N)"
