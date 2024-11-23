# ImagePullBackOff error on while creating a pod

Answer: Above error might appear while a pulling a container image during deployments.

Possible Reasons for the errors are:
- Invalid container image/tag or non-existent image
- Private images without authorization

# CrashLoopBackOff error on while creating a pod

Answer: If the Pod is crashing multiple times in a loop.

Possible Reasons for the errors are:
- Misconfigurations of Pod
- Errors in Liveness Probe
- Memory limits are too low
- Wrong command line arguments
- Bugs and Exceptions

# CreateContainerConfigError error on while creating a pod

Answer: This error appears as a result of a missing Secret or ConfigMap objects, which are typically used to hold configuration details or secrets for multiple pods.
  
# Recently created Pod status is showing Pending, how to resolve it?

Answer: Run the Kubectl describe pod pod_name command. Describe command provides detailed information about the pod, such as its current state, labels, conditions and related events
Somme common reasons for Pod status showing as Pending:-
* Insufficient resources: If the cluster doesn’t have enough resources (CPU, memory, etc.) to meet the pod’s requirements, the pod will remain in a pending state until the conditions are met.
* Node readiness: If any nodes are not in a Ready state, pods cannot be scheduled on those nodes, causing them to remain in a pending state.
* Incorrect resource requests: If the requested resources are too high, Kubernetes might not be able to find a suitable node to schedule the pod.
  
To troubleshoot pending pods, it’s essential to:

* Check the pod’s status and events using kubectl describe pod.
* Verify node readiness and resource availability using kubectl get nodes and kubectl top.
* Review pod specifications, including resource requests and limits.
* Adjust resource requests and limits as needed.

# Recently created web server Pod deployed successfully, but the web page is not accessible, how to resolve it?

Answer: Make sure no issues with the pod by using kubectl describe pod
* Debug the service using kubectl describe svc service_name and verify IPs and Port numbers.
* Try to curl the ip and port number. 
* kubectl logs service_pod and cat into default configuration file inside the pod
* kubectl exec pod_name -- cat /etc/nginx/conf.d/default.conf
* Verify the port number listening by the webserver for client requests.
* Update the port and target port accordingly by editing the svc manifest
* Run the curl command again to verify pod access
  
# What is the difference between port and target port

Answer:
* port is the external port exposed by the Service for client access.
* targetPort is the internal port on the container where the application listens for incoming traffic.

To illustrate this:

* A Service exposes port 80 (e.g., port: 80) to clients.
* The Service forwards incoming traffic on port 80 to the targetPort (e.g., targetPort: 8080) on the container, where the application is running.

# The Pod created was crashed and the config file (like index.html) was deleted. How to avoid similar events in future?

Answer: By making the volume persistent, any configurations or metadata will be retained when pods are destroyed. 

# Kubernetes Node not ready

Answer:
- Lack of resources: Insufficient memory, disk space, or processing power can cause a node to become NotReady.
- Network issues: Problems with network configuration or connectivity can prevent a node from communicating with the rest of the cluster, leading to a NotReady state.

To debug:
- kubectl describe nodes - Look for conditions, capacity and allocatable:
- Check the node’s logs for errors or warnings.
- Observe kubelet logs to see if it reports anything. Like certificate erros, authentication errors etc.

Kubernetes does not automatically create a new node when a node fails. Instead, it attempts to recover the failed node or schedules new pods on available nodes in the same node pool. Persistent node failures require manual intervention to recreate or replace the node.

# Need to provision big data app pods on Big Data Nodes only, and no other application pods should be deployed on this nodes, how to achieve it?

Answer: Node Affinity and Taints/Toleration.

* NodeAffinity is a property of Pods that attracts them to a set of nodes as a requirement
* It is conceptually similar to NodeSelector, allowing to constrain which nodes your Pod can be scheduled on based on node labels.
* Taints allow a node to repel a set of pods and Tolerations allow the scheduler to deploy pods with matching taints

# What are Sidecar containers and their purpose?

Answer: Additional containers that runs along with the main containers that extend and enhance the main container. Common use cases are for network proxies and log collection etc.

![image](https://github.com/user-attachments/assets/3c09c050-03a1-43a4-88f7-97d00f2f89f7)

# What are Services, explain different types of services in Kubernetes?

Answer: Kubernetes Services enables communication between the Pods from within or outside.

* ClusterIP: Facilitates internal communication between the pods within the cluster
* NodePort: Open a specific port on the node and forward the traffic to pod via service. Ports to choose 30000-32767
* LoadBalancer: Route the traffic from external to the service. Standard way to expose the application to the internet

# How do we monitor Kubernetes cluster resources?

Answer: Node level metrics, Performance level metrics and Pod level metrics

# How to debug specific container logs? Consider there are 2 containers running inside a single Pod.

Answer: Standard ways to check pod logs is kubectl logs -f pod_name. But if two containers are running inside the same pod, need to specify container_name

* kubectl logs -f pod_name container_name

# What are the different deployment strategies in Kubernetes?

Answer: 

* Rolling update deployment, which is a default deployment strategy in K8, it replaces the pods one by one with the newer version of apps without any cluster downtime.

```
spec:
  replicas: 3
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
```
- maxSurge: maxSurge specifies the maximum number (or percentage) of additional pods that can be created above the desired replica count during an update.
- maxUnavailable: maxUnavailable specifies the maximum number (or percentage) of pods that can be unavailable during an update. 

* Recreate deployment, we can fully scale down the existing application version before we scale up the new application version

# What is DaemonSet, explain use cases of DaemonSet?

Answer: DaemonSet ensures that all Nodes run a copy of a Pod. As nodes to the cluster are added to the cluster, Pods will be added to them.

Use Cases:
* Running logs collection such as Fluentd and Logstash
* Node monitoring daemon such as Prometheus, Node exporter
* Running a cluster storage daemon such as glusterd, ceph

# Node Selector and Node Affinity

Answer: Node Selectors are defined as a key-value pair in the pod’s specification (PodSpec) and are used to filter nodes based on their labels. The pod will only be scheduled on nodes that have all the specified label-value pairs.

- kubectl label nodes <node_name> <key>=<value>  // Adding labels from command line
- kubectl edit node <node_name>   // Adding labels by editing node yaml manifest

Node Affinity: Node affinity is a set of rules that the Kubernetes scheduler uses to determine where a pod can be placed. It is similar to the nodeSelector parameter but offers more flexibility and functionality.

- requiredDuringSchedulingIgnoredDuringExecution
- preferredDuringSchedulingIgnoredDuringExecution

# Kubernetes Network Policy

Answer: A fundamental security feature in Kubernetes that enable fine-grained control over network traffic between pods and other network endpoints within a cluster.

- Network Policies use selectors to identify the pods or namespaces that the policy applies to. Selectors can be based on labels, namespace, or IP addresses.
```
ingress:
  - from:
    - ipBlock:
        cidr: 172.17.0.0/16
        except:
        - 172.17.1.0/24
    - namespaceSelector:
        matchLabels:
          project: myproject
    - podSelector:
        matchLabels:
          role: frontend
```
# Resource Sharing

Answer: Use the combiination of Resource Quotas and Requests/limits to put constraints on resource usage.

- Resource quotas in Kubernetes are a way to limit the amount of resources that can be consumed by a namespace or a set of resources. They provide constraints that limit aggregate resource consumption per namespace, ensuring fair and efficient resource utilization among multiple users or teams.

- Resource Requests and Limits are used to control the allocation of resources such as CPU and memory to containers.

# How to diagnose OOMKilled Pods

Answer: A thread dump and Heap dump can help diagnose efficiency issues in a Java application. it’s used to analyze the OutOfMemoryError errors in Java.

- The thread dump contains the snapshot of all threads in a running Java program at a specific instant. A thread is the smallest part of a process that helps a program to operate efficiently by running multiple tasks concurrently.

- Heap Dump: During runtime, the JVM creates the heap, which contains references to objects in use in a running Java application. The heap dump contains a saved copy of the current state of all objects in use at runtimne

# Cluster Upgrades

Answer: It is always recommended to test the behaviour of your application against new the Kubernetes version in a non-prod environment, before updating your production environment.

Steps to upgrade the cluster as well as migration of applications to worker node from v1.14 to v1.15.

* Upgrade Control Plane
* Upgrade kube-proxy version
* Upgrade CoreDns version
* Upgrade Amazon VPC CNI version
* Upgrade Cluster AutoScaler version
* Apply pod disruptions budget (pdb)
* Edit Deployment for application

To update the EKS worker node, new Auto-scaling Group(ASG) with v1.15 of worker nodes needs to be created with a lifecycle=1.15 label. After creating a new worker node, we need to apply Pod Disruption Budget (PDB) to all our applications which will help 100 percent availability of our pod in case any disruption. We are using NodeSelector to migrate the application from version 1.14 to 1.15. Once the application is migrated to v1.15, because of cluster autoscaler, worker nodes based on version 1.14 will automatically be scaled down. When all the applications are migrated to v1.15 nodes, v1.14 worker nodes will be reduced to the minimum node count provided in the autoscaling configuration. 

# Pod Distribution Budget

A Pod Disruption Budget (PDB) is a Kubernetes resource that defines the minimum number of replicas of a Deployment that must be available at any given time. It ensures that a certain number of pods remain available and running even during voluntary disruptions, such as:

* Node upgrades or maintenance
* Rolling updates or rollbacks
* Scaling changes
* Pod restarts or failures

By defining a PDB, you can ensure that your applications remain available and resilient during planned or unplanned disruptions, and Kubernetes will automatically manage pod availability to meet the specified threshold.

# Pod Security Admission:

Answer: Pod Security Admission (PSA) is a built-in admission controller in Kubernetes that enforces Pod Security Standards (PSS) at the admission phase, before pods are scheduled or run on a cluster. Its primary purpose is to minimize the potential attack surface within a Kubernetes cluster by enforcing best practices and security standards for pod creation and deployment.

PSA evaluates pod creation and update requests against predefined PSS security profiles, which define the security requirements for pods. These profiles are categorized into three levels:

* Privileged: allows for known privilege escalation and is the “least secure” of the three.
* Baseline: provides a balanced combination of security and functionality.
* Restricted: enforces strict security requirements, such as disallowing privilege escalation, and is the “most secure” of the three.

PSA can operate in three modes:

* Enforce: denies pod creation or update requests that violate the configured PSS profile.
* Audit: logs pod creation or update requests that violate the configured PSS profile, but allows them to proceed.
* Warn: generates a warning for pod creation or update requests that violate the configured PSS profile, but allows them to proceed.

```
apiVersion: v1
kind: Namespace
metadata:
  name: test-ns
  labels:
    pod-security.kubernetes.io/enforce: baseline
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

PSA can be configured at the namespace level using labels, allowing for granular control over pod security policies. Exemptions can also be defined to allow specific pods or workloads to bypass the PSS enforcement.

# Applying cluster-wide policy using AdmissionConfiguration resource

Answer: In addition to applying labels to namespaces to configure policy you can also configure cluster-wide policies and exemptions using the AdmissionConfiguration resource. Using this resource, policy definitions are applied cluster-wide by default and any policy that is applied via namespace labels will take precedence. 
