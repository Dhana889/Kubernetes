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
Debug the service using kubectl describe svc service_name and verify IPs and Port numbers.
Try to curl the ip and port number. 
kubectl logs service_pod and cat into default configuration file inside the pod
kubectl exec pod_name -- cat /etc/nginx/conf.d/default.conf
Look the port number listening by the webserver for client requests.
Update the port and target port accordingly by editing the svc manifest

# What is the difference between port and target port

* port is the external port exposed by the Service for client access.
* targetPort is the internal port on the container where the application listens for incoming traffic.

To illustrate this:

* A Service exposes port 80 (e.g., port: 80) to clients.
* The Service forwards incoming traffic on port 80 to the targetPort (e.g., targetPort: 8080) on the container, where the application is running.

