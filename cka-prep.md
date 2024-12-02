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
- ![image](https://github.com/user-attachments/assets/de1595a8-e41f-4f95-a79f-17caec733cbe)
- kubectl create -f 06-pv.yaml
- kubectl get pv

Part 2:
- ![image](https://github.com/user-attachments/assets/be86408a-c0fe-49a6-8b75-5a155cb8cbfa)
- kubectl create -f 06-pvc.yaml
- kubectl get pvc -n project-tiger

Part 3:
- ![image](https://github.com/user-attachments/assets/df336279-cc64-43e1-8463-644f927ba860)
- kubectl create -f 06-deploy.yaml
- kubectl get deploy -n project-tiger

