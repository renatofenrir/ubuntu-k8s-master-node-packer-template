# ubuntu-k8s-master-node-packer-template

Use this template to provision a Kubernetes master node already shipped with the following dependencies:

- Helm 3 (latest release) 
- Rke 1.4.1
- Kubectl (latest release)
- Docker (docker-ce="5:19.03.6~3-0~ubuntu-bionic" - by the time I came up with this template, it was the best build, feel free to PR)
- Cloud-init (latest release)


It also comes with a .gitlab-ci.yml pipeline definition file, so that you can build this template straight from a 
gitlab runner. (Please note that you must install the Packer binary on the gitlab runner for this to work)
