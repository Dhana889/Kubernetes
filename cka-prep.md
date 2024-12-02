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
