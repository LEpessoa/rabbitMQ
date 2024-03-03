imageName = rabbitmq:lp

imageSHA = sha256:df526e3ab6de6230d69ac204daf13fa72c0268a564d147a85778423df0a0aa45
containerName = rabbit_lp

spinContainer: getRabbit tagImage runRabbit
	@echo Container Spinned

getRabbit:
	docker pull rabbitmq@$(imageSHA)

tagImage:
	docker images | grep rabbit | awk '{ print $$3 }' | xargs -I {} docker image tag {} $(imageName)

runRabbit:
	docker 	run -d --name $(containerName) -p 5672:5672 $(imageName)

removeImage:
	docker images | grep rabbit | awk '{print $$3}' | xargs -I {} docker image rm -f {}

removeContainer:
	docker rm -f $(containerName)