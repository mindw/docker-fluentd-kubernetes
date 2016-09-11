# Copyright 2016 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.PHONY:	build login push configmap

IMAGE := fluentd-agent
TAG := 1.17.2
ACCOUNT ?= 580140558762
# ACCOUNT ?= 104059736540
REGION ?= eu-west-1
# REGION ?= us-west-2
AWS_IMAGE := $(ACCOUNT).dkr.ecr.$(REGION).amazonaws.com/platform/$(IMAGE):$(TAG)

build:
	docker build -t $(IMAGE):$(TAG) .

login:
	eval $$(aws ecr get-login --region $(REGION))

push:
	docker tag $(IMAGE):$(TAG) $(AWS_IMAGE)
	docker push $(AWS_IMAGE)
