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