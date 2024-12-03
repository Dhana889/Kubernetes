- export dr='--dry-run=client -o yaml'
- k run pod --image=nginx $dr

- export now='--grace-period=0 --force'
- k run pod --image=nginx -- sleep 1d
- k delete po pod $now

# CKA Question 1.
![image](https://github.com/user-attachments/assets/c9747cd3-ec14-4c35-895b-25f8d7fd68db)

Part 1:
- kubectl config get-contexts
- kubectl config get-contexts -o name
- kubectl config get-contexts -o name > /opt/course/1/contexts
- cat /opt/course/1/contexts

Part 2:
- kubectl config current-contexts
- echo "kubectl config current-contexts" > /opt/course/1/context_default_kubectl.sh 
- sh /opt/course/1/context_default_kubectl.sh

Part 3:
- cat ~/.kube/config
- cat ~/.kube/config | grep -i current-context | sed 's/current-context: //'
- echo "cat ~/.kube/config | grep -i current-context | sed 's/current-context: //'" > /opt/course/1/context_default_no_kubectl.sh
- sh /opt/course/1/context_default_no_kubectl.sh

# CKA Question 2.

![image](https://github.com/user-attachments/assets/766842e9-6dd6-4876-81ae-df851036a289)

- kubectl config get-contexts
- kubectl config use-context k8s-c1-H
- k run -n default pod1 --image=httpd:2.4.41-alpine --dry-run=client -o yaml > 2.yaml
- Edit the 2.yaml file and update the container name to pod1-container and add nodeName: cluster1-master
- k create -f 2.yaml
- Run k get pods and describe pod to see details

# CKA Question 3.

![image](https://github.com/user-attachments/assets/0e135e53-f54d-4c5e-820a-438643f2a974)

- kubectl config use-context k8s-c1-H
- kubectl get all -n project-c13 -o wide
- kubectl scale statefulset -n project-c13 o3db --replicas=1
- kubectl get statefulset.apps -n project-c13

# CKA Question 4.

![image](https://github.com/user-attachments/assets/38d9ef8c-60f2-4aaa-b6fa-8cb8dfe13e7a)

- kubectl config use-context k8s-c1-H
- ready-if-service-ready
- kubectl run ready-if-service-ready -n default --image=nginx:1.16.1-alpine --dry-run=client -o yaml > 4.yaml
- edit 4.yaml

  ![image](https://github.com/user-attachments/assets/071c4784-16d6-4d86-9aef-d416238a1c83)

Part 1:
- k create -f 4.yaml
- k get pods -n default ready-if-service-ready
- k describe pods -n default ready-if-service-ready

Part 2:
- k get svc -n default service-am-i-ready
- k get ep -n default
- k run am-i-ready -n default --image=nginx:1.16.1-alpine --label="id=cross-server-ready"
- k get pods -n default am-i-ready
- k get svc -n default service-am-i-ready
- k get ep -n default
- k get pods -n default am-i-ready -o wide
- k get pods -n default ready-if-service-ready -o wide

# CKA Question 5.

![image](https://github.com/user-attachments/assets/cd675337-8883-443b-bf04-91669300a620)

Part 1:
- kubectl get pods -A --sort-by=metadata.creationTimestamp
- echo "kubectl get pods -A --sort-by=metadata.creationTimestamp" > /opt/course/1/find_pods.sh
- cat /opt/course/1/find_pods.sh
- sh /opt/course/1/find_pods.sh

Part 2:
- kubectl get pods -A --sort-by=metadata.uid
- echo "kubectl get pods -A --sort-by=metadata.uid" > /opt/course/1/find_pods_uid.sh
- cat /opt/course/1/find_pods_uid.sh
- sh /opt/course/1/find_pods_uid.sh

# CKA Question 6.

![image](https://github.com/user-attachments/assets/41c839d9-4edc-4923-96c8-fd8fb6ff5ac5)

Part 1:
 ![image](https://github.com/user-attachments/assets/de1595a8-e41f-4f95-a79f-17caec733cbe)
- kubectl create -f 06-pv.yaml
- kubectl get pv

Part 2:
 ![image](https://github.com/user-attachments/assets/be86408a-c0fe-49a6-8b75-5a155cb8cbfa)
- kubectl create -f 06-pvc.yaml
- kubectl get pvc -n project-tiger

Part 3:
 ![image](https://github.com/user-attachments/assets/df336279-cc64-43e1-8463-644f927ba860)
- kubectl create -f 06-deploy.yaml
- kubectl get deploy -n project-tiger

# CKA Question 7.

![image](https://github.com/user-attachments/assets/947d5ce0-55df-40fa-be8c-a5587dc41e91)

Part 1:
- kubectl top node
- echo "kubectl top node" > /opt/course/7/node.sh
- cat /opt/course/7/node.sh
- sh /opt/course/7/node.sh

Part 2:
- kubectl top pods --containers -A
- echo "kubectl top pods --containers -A" > cat /opt/course/7/pod.sh 
- cat /opt/course/7/pod.sh
- sh /opt/course/7/pod.sh

# CKA Question 8.

![image](https://github.com/user-attachments/assets/53014ba3-3f93-46ac-9f7a-09103f67bb76)

- ssh cluster1-controlplane1
- kubectl get all -n kube-system | grep -i dns
- kubectl get all -n kube-system | grep -i etcd
- ls /etc/kubernetes/manifests | grep -i etch = to check for yaml manifests which confirms etch is a static pod
- kubectl get all -n kube-system | grep -i kube-controller-manager
- kubectl get all -n kube-system | grep -i kube-scheduler
- kubectl get all -n kube-system | grep -i kube-apiserver
- ps aux | grep -i kubelet

![image](https://github.com/user-attachments/assets/61129a0c-ca38-40c1-a469-b0f559e9d184)

# CKA Question 9.

![image](https://github.com/user-attachments/assets/0dcb4b85-5e8e-4560-8152-669b640ae497)

Part 1:
- kubectl config use-context k8s-c2-AC
- ssh cluster2-controlplane1
- kubeclt get pods -n kube-system | grep -i kube-scheduler
- cd /etc/kubernetes/manifests
- mv ./kube-scheduler.yaml ../

Part 2:
- kubectl run manual-schedule --image=httpd:2.4-alpine --dry-run=client -o yaml > 9-pod1.yaml
- kubectl create -f 9-pod1.yaml
- kubectl get pods = Pod status should show pending

Part 3:
- Edit 9-pod1.yaml and add nodeName: cluster2-controlplane1
- Apply the changes and make sure the pod manual-schedule is running

Part 4:
- mv kube-scheduler.yaml /etc/kubernetes/manifests/
- kubectl get po -n kube-system | grep -i kube-scheduler = to see scheduler is running
- k run manual-schedule2 --image=httpd:2.4-alpine --dry-run=client -o yaml > 9-pod2.yaml
- Add nodeName: cluster2-node1
- Save and apply changes
- exit

# CKA Question 10.

![image](https://github.com/user-attachments/assets/1932dfd6-3694-458d-807f-ab8414219541)

- kubectl get sa -n project-hamster
- kubectl create sa processor -n project-hamster

- kubectl create role processor -n project-hamster --verb=create --resource=secrets,configmaps
- kubectl create rolebinding processor -n project-hamspter --serviceaccount=project-hamster:processor --role=processor
![image](https://github.com/user-attachments/assets/186dd12e-b064-42ce-9ed2-2bd9c785f64f)

- Create the role and rolebinding from yaml manifests
- To confirm the role for service account, run the following command
- kubectl auth can-i create secret --as=system:serviceaccount:project-hamster:processor -n project-hamster

# CKA Question 11.

![image](https://github.com/user-attachments/assets/8cb8dc63-6b2e-4e04-a343-2a6699b3c0fe)

- kubectl get nodes
- kubectl describe node | grep -i Taints

![image](https://github.com/user-attachments/assets/1bc1c8a9-8b5f-4a32-a498-bceb25969c08)

- Apply the daemonset and check all nodes have 1 copy of pods deployed within them

# CKA Question 12.

![image](https://github.com/user-attachments/assets/96b36ebc-114f-45b0-a3bd-d4c4ab8d5606)

- Apply the below deployment manifests which has pod anti affinity rules
  
![image](https://github.com/user-attachments/assets/88da7946-d335-41b7-aaa4-7445539b8d91)

# CKA Question 13.

![image](https://github.com/user-attachments/assets/1228dc16-423e-4f11-a2a9-f5b269a9d969)

- Apply the pod manifest and confirm deployment
![image](https://github.com/user-attachments/assets/335825c1-7023-4111-9af6-72909093caff)

- kubectl exec -it multi-container-playground -c c1 -- printenv | grep -i MY_NODE_NAME
- kubectl exec -it multi-container-playground -c c2 -- cat /your/vol/path/date.log
- kubectl logs multi-container-playground -n default -c c3

# CKA Question 14.

![image](https://github.com/user-attachments/assets/86c3c62d-51a4-4ea1-a4e6-e722759a3bdc)

![image](https://github.com/user-attachments/assets/045e62e5-0243-4432-afdc-17d80c44c8fe)

# CKA Question 15.

![image](https://github.com/user-attachments/assets/62b145b7-29d9-4a67-9934-90b270460f5a)

Part 1:
- kubectl get events -A --sort-by="metadata.creationTimestamp"
- cat /opt/course/15/cluster_events.sh
- sh /opt/course/15/cluster_events.sh

Part 2:
- kubectl get po -n kube-system -o wide | grep -i kube-proxy
- kubectl delete po kube-proxy-c2s3 -n kube-system
- kubectl get events -n kube-system | grep -i kube-proxy
- copy the output into /opt/course/15/pod_kill.log

Part 3:
- ssh cluster2-node1
- crictl ps
- crictl stop container id
- crictl rm container id
- exit
- kubectl get events -n kube-system --sort-by=metadata.creationTimestamp
- copy the latest events into /opt/course/15/container_kill.log

Do you notice differences in the events both actions caused?

- When killed the pod in part 2, kube-proxy restarted with new name, whereas when killed in crictl containerd, kube-proxy pod name not changed

# CKA Question 16.

![image](https://github.com/user-attachments/assets/f740df1d-a8f6-4ced-804b-d9bd183cb934)

Part 1:
- kubectl get api-resources
- kubectl get api-resources --namespaced -o name > /opt/course/16/resources.txt

Part 2:
- kubectl get ns
- kubectl get roles -n project-c14 --no-headers | wc -l
- write into /opt/course/16/crowded-namespace.txt

# CKA Question 17.

![image](https://github.com/user-attachments/assets/4d213635-168a-46d6-b90f-d7c139a7ad10)

Part 1:

- kubectl run tigers-reunite -n project-tiger --image=httpd:2.4.41-alpine --labels="pod=container,container=pod" --dry-run=client -o yaml
- kubectl get po -n project-tiger tigers-reunite -o wide

Part 2:
- ssh into worker node
- crictl ps | grep -i tigers-reunite
- crictl inspect containerid | grep -i runtimeType
- Write the output to /opt/course/17/pod-container.txt

Part 3:
- ssh cluster1-node2 "crictl logs cad6a7b78abc3" &> /opt/course/17/pod-container.log
- cat /opt/course/17/pod-container.log

# CKA Question 18.
![image](https://github.com/user-attachments/assets/99302d13-c977-41f7-862a-7a9937bcbc7e)

Part 1:
- update the kubelet path into /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
- systemctl daemon-reload && systemctl kubelet restart
- service kubelet status

Part 2:
- Now the node is in ready status, update the /opt/course/18/reason.txt
- Incorrect path '/usr/local/bin/kubelet' set for kubelet in '/usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf'
- Correct path for kubelet '/usr/bin/kubelet' has been set
- Kubelet restarted

# CKA Question 19.

![image](https://github.com/user-attachments/assets/ed767fff-4008-4410-b3d5-41cc682e4007)

![image](https://github.com/user-attachments/assets/764091fb-6fee-40a8-b758-5935ac7c529a)
![image](https://github.com/user-attachments/assets/aee8d3ee-2258-4aa7-8293-fce2a2a4b56d)

- To confirm run > kubeclt exec -it -n secret secret-pod -- printenv

