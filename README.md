# Kubernetes

Kubernetes, also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications. It groups containers that make up an application into logical units for easy management and discovery

Containers are a good way to bundle and run your applications. In a production environment, you need to manage the containers that run the applications and ensure that there is no downtime. 

Kubernetes provides you with a framework to run distributed systems resiliently. It takes care of scaling and failover for your application, provides deployment patterns, and more.

Kubernetes provides you with:

* Service discovery and load balancing Kubernetes can expose a container using the DNS name or using their own IP address. If traffic to a container is high, Kubernetes is able to load balance and distribute the network traffic so that the deployment is stable.

* Storage orchestration Kubernetes allows you to automatically mount a storage system of your choice, such as local storages, public cloud providers, and more.

* Automated rollouts and rollbacks You can describe the desired state for your deployed containers using Kubernetes, and it can change the actual state to the desired state at a controlled rate. For example, you can automate Kubernetes to create new containers for your deployment, remove existing containers and adopt all their resources to the new container.

* Automatic bin packing You provide Kubernetes with a cluster of nodes that it can use to run containerized tasks. You tell Kubernetes how much CPU and memory (RAM) each container needs. Kubernetes can fit containers onto your nodes to make the best use of your resources.

* Self-healing Kubernetes restarts containers that fail, replaces containers, kills containers that don't respond to your user-defined health check, and doesn't advertise them to clients until they are ready to serve.

* Secret and configuration management Kubernetes lets you store and manage sensitive information, such as passwords, OAuth tokens, and SSH keys. You can deploy and update secrets and application configuration without rebuilding your container images, and without exposing secrets in your stack configuration.

* Batch execution In addition to services, Kubernetes can manage your batch and CI workloads, replacing containers that fail, if desired.

* Horizontal scaling Scale your application up and down with a simple command, with a UI, or automatically based on CPU usage.

* IPv4/IPv6 dual-stack Allocation of IPv4 and IPv6 addresses to Pods and Services

* Designed for extensibility Add features to your Kubernetes cluster without changing upstream source code.

- Kubernetes is basically a Cluster in nature.
- A Cluster is a group of Nodes, consists of Master<>Node architecture.
- Kubernetes helps to solve some of the basic problems in other containers applications, such as single host, auto-scaling, auto-healing and enterprise level support.

# K8s Architecture:

A node is a representation of a single machine in a cluster (we can simply view these machines as a set of CPU and RAM). A node can be a virtual machine, a physical machine in a data center hosted on a cloud provider like Azure/AWS.

What are the components present in Master node of K8s.

This is Controlplane is the one which controlling the actions.

* API server - It is the central management entity that receives all REST requests for modifications to pods, services, replication sets/controllers and others, serving as frontend to the cluster. 
* Scheduler - Helps schedule the pods on the various nodes based on resource utilization.
* etcd - Distributed key value storage, which used to store K8s cluster data such as number of pods, their state, namespace, etc. It is only accessible from API server for security reasons. 
* Controller manager - Runs a number of distinct controller processes in the background to regulate the shared state of the cluster and perform routine tasks. When a change in a service configuration occurs, the controller spots the change and starts working towards the new desired state.
* Cloud controller manager - Responsible for managing controller processed with dependencies on the underlying cloud provider. 

What are the components present in Worker node of K8s.

This a Dataplane is the one which executing the actions.

* Kubelet -  Manage containers and maintain service availability
* Kube-proxy - Maintains network rules for forwarding connections for endpoints associated with services.
* Container run-time - such as Containerd, cri-o, dockershim, etc..

![image](https://github.com/user-attachments/assets/18aa8aec-9990-4b01-840c-95ab7f9269d9)

kubectl command is a line tool that interacts with kube-apiserver and send commands to the master node. Each command is converted into an API call.

# Kubernetes Concepts

Making use of Kubernetes requires understanding the different abstractions it uses to represent the state of the system, such as services, pods, volumes, namespaces, and deployments.

* Pod – generally refers to one or more containers that should be controlled as a single application. A pod encapsulates application containers, storage resources, a unique network ID and other configuration on how to run the containers.

* Service – pods are volatile, that is Kubernetes does not guarantee a given physical pod will be kept alive (for instance, the replication controller might kill and start a new set of pods). Instead, a service represents a logical set of pods and acts as a gateway, allowing (client) pods to send requests to the service without needing to keep track of which physical pods actually make up the service.

* Volume – similar to a container volume in Docker, but a Kubernetes volume applies to a whole pod and is mounted on all containers in the pod. Kubernetes guarantees data is preserved across container restarts. The volume will be removed only when the pod gets destroyed. Also, a pod can have multiple volumes (possibly of different types) associated.

* Namespace – a virtual cluster (a single physical cluster can run multiple virtual ones) intended for environments with many users spread across multiple teams or projects, for isolation of concerns. Resources inside a namespace must be unique and cannot access resources in a different namespace. Also, a namespace can be allocated a resource quota to avoid consuming more than its share of the physical cluster’s overall resources.

* Deployment – describes the desired state of a pod or a replica set, in a yaml file. The deployment controller then gradually updates the environment (for example, creating or deleting replicas) until the current state matches the desired state specified in the deployment file. For example, if the yaml file defines 2 replicas for a pod but only one is currently running, an extra one will get created. Note that replicas managed via a deployment should not be manipulated directly, only via new deployments.

$ kubectl get nodes

$ vi pod.yaml

```bash
apiVersion: v1
kind: Pod
metadata:
   name: nginx
spec:
   containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
    	- containerPort: 80
```

$ kubectl create -f pod.yaml		// to create a pod

$ kubectl get pods 			// to see pods info

$ kubectl get pods -o wide		// to see pods ip address as well

$ curl <pod ip address>			// This command will show nginx welcome page on html version

$ kubectl delete pod nginx 		// to delete a pod using NAME

$ kubectl logs nginx			// to view logs of a pod

$ kubectl describe pod nginx		// to debug a pod

$ kubectl get pods			// to list all pods

$ kubectl get deploy			// to list all deployments

$ kubectl get rs			// to list all replica sets

$ kubectl get all			// to list all resources

$ kubectl get all -A			// to list all resources in all the namespace

$ kubectl get pods -w			// to watch the pods in live

# Difference between Container - Pod - Deployment:

- Containers are a packaging system that allows developers to store everything they need to run an application, like runtimes, binary codes, and runtimes, in a single place.
- Pods in DevOps refer to the smallest deployable units of computing that can be created and managed in Kubernetes. They are a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers.
- A Deployment provides declarative updates for Pods and ReplicaSets.

# Network Policies:

Kubernetes provides NetworkPolicy API for managing network policies in the cluster. This resource is applied to selected namespaces and may contain rules for limiting access of one application to another. It also provides means for configuring accessibility of specific pods, environments (namespaces), or IP-address blocks.

You can use the Calico plug-in as a stand-alone tool or with Flannel (via Canal subproject) to implement network connectivity features and to manage accessibility.

Advantages of using the built-in Kubernetes features together with the Calico APIs.

Here is the list of NetworkPolicy’s features:

* policies are limited to an environment;
* policies are applied to pods marked with labels;
* you can apply rules to pods, environments or subnets;
* the rules may contain protocols, numerical or named ports.

And here is how Calico extends these features:

* policies can be applied to any object: pod, container, virtual machine or interface;
* the rules can contain the specific action (restriction, permission, logging);
* you can use ports, port ranges, protocols, HTTP/ICMP attributes, IPs or subnets (v4 and v6), any selectors (selectors for nodes, hosts, environments) as a source or a target of the rules;
* also, you can control traffic flows via DNAT settings and policies for traffic forwarding.

Kubernetes IP address ranges: 

Kubernetes clusters require to allocate non-overlapping IP addresses for Pods, Services and Nodes, from a range of available addresses configured in the following components:

* The network plug-in is configured to assign IP addresses to Pods.
* The kube-apiserver is configured to assign IP addresses to Services.
* The kubelet or the cloud-controller-manager is configured to assign IP addresses to Nodes.

![image](https://github.com/user-attachments/assets/d4523b38-f351-4135-bb0e-c820523cfbc9)

# Kubernetes Service:
	
In Kubernetes, a Service is a method for exposing a network application that is running as one or more Pods in your cluster.

A key aim of Services in Kubernetes is that you don't need to modify your existing application to use an unfamiliar service discovery mechanism. You use a Service (svc) to make that set of Pods available on the network so that clients can interact with it.

K8s Service solves problems such as Load balancing, Service discovery and Exposing the application to the world.

Service type:

For some parts of your application (for example, frontends) you may want to expose a Service onto an external IP address, one that's accessible from outside of your cluster.

Kubernetes Service types allow you to specify what kind of Service you want.

The available type values and their behaviors are:

* ClusterIP - Exposes the Service on a cluster-internal IP. Choosing this value makes the Service only reachable from within the cluster. This is the default that is used if you don't explicitly specify a type for a Service. You can expose the Service to the public internet using an Ingress or a Gateway.

* NodePort - Exposes the Service on each Node's IP at a static port (the NodePort). To make the node port available, Kubernetes sets up a cluster IP address, the same as if you had requested a Service of type: ClusterIP.

* LoadBalancer - Exposes the Service externally using an external load balancer. Kubernetes does not directly offer a load balancing component; you must provide one, or you can integrate your Kubernetes cluster with a cloud provider.

* ExternalName - Maps the Service to the contents of the externalName field (for example, to the hostname api.foo.bar.example). The mapping configures your cluster's DNS server to return a CNAME record with that external hostname value. No proxying of any kind is set up.

The type field in the Service API is designed as nested functionality - each level adds to the previous. However there is an exception to this nested design. You can define a LoadBalancer Service by disabling the load balancer NodePort allocation.

Ingress:

An API object that manages external access to the services in a cluster, typically HTTP. Ingress may provide load balancing, SSL termination and name-based virtual hosting.

Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.


![image](https://github.com/user-attachments/assets/1069dea8-0afa-40aa-bfdc-18ce95f5343c)


In order for the Ingress resource to work, the cluster must have an ingress controller running. Kubernetes as a project supports and maintains AWS, GCE, and nginx ingress controllers.

Namespaces:

In Kubernetes, namespaces provide a mechanism for isolating groups of resources within a single cluster. Namespaces are intended for use in environments with many users spread across multiple teams, or projects. 

$ kubectl get namespace

ConfigMaps:

A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

A ConfigMap allows you to decouple environment-specific configuration from your container images, so that your applications are easily portable.

Secrets:

A Secret is an object that contains a small amount of sensitive data such as a password, a token, or a key. Such information might otherwise be put in a Pod specification or in a container image. Using a Secret means that you don't need to include confidential data in your application code.

Secrets are similar to ConfigMaps but are specifically intended to hold confidential data.

RBAC:

Kubernetes RBAC is a key security control to ensure that cluster users and workloads have only the access to resources required to execute their roles. It is important to ensure that, when designing permissions for cluster users, the cluster administrator understands the areas where privilege escalation could occur, to reduce the risk of excessive access leading to security incidents.

RoleBinding and ClusterRoleBinding:

A role binding grants the permissions defined in a role to a user or set of users. It holds a list of subjects (users, groups, or service accounts), and a reference to the role being granted. A RoleBinding grants permissions within a specific namespace whereas a ClusterRoleBinding grants that access cluster-wide.
