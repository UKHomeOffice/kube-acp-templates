.PHONY: install
install:
	/usr/bin/ruby -e $$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
	brew install caskroom/cask/brew-cask
	brew cask install virtualbox
	brew cask install kubectl
	brew install minikube
	brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve
	sudo chown root:wheel $$(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
	sudo chmod u+s $$(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
	docker-machine create default --driver xhyve --xhyve-experimental-nfs-share
	@eval $$(docker-machine env default)

.PHONY: create
create:
	minikube start
	minikube addons enable ingress
	minikube addons enable heapster
	@eval $$(minikube docker-env) ;\
	docker image build -t recognition:latest -f Dockerfile .
	kubectl config use-context minikube
	./kube/secrets/acp-notprod-create-secrets.sh
	kubectl create -f kube/local/minikube-recognition-deploy.yaml

.PHONY: update
update:
	@eval $$(minikube docker-env) ;\
	docker image build -t recognition:latest -f Dockerfile .
	kubectl config use-context minikube
	kubectl delete deploy recognition
	kubectl create -f kube/local/minikube-recognition-deploy.yaml

.PHONY: start
start:
	@eval $$(minikube docker-env) ;\
	minikube start

.PHONY: stop
stop:
	@eval $$(minikube docker-env) ;\
	minikube stop

.PHONY: delete
delete:
	@eval $$(minikube docker-env) ;\
	minikube delete
