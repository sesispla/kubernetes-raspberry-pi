## Ansible 2.0 Playbook for Kubernetes on Raspberry Pi 3
Create an Kubernetes cluster with Raspberry Pi 3 (Also work with 1/2) and set it up in 20 minutes using Ansible and kubeadm.

Based on [Roland Huß](https://github.com/Project31/ansible-kubernetes-openshift-pi3)'s job and originally inspired by the post [Creating a Raspberry Pi cluster running Kubernetes](http://blog.kubernetes.io/2015/11/creating-a-Raspberry-Pi-cluster-running-Kubernetes-the-shopping-list-Part-1.html) by Arjen Wassink and Ray Tsang.

This project automates all the configuration steps described in the [Kubernetes documentation](http://kubernetes.io/docs/getting-started-guides/kubeadm/) + some basic setup for all nodes.

## Project goals
* Create a demo cluster to show Kubernetes capabilities
* Learn more about Kubernetes installation and configuration
* Learn the basics of Ansible

## HW List

Here is the hardware you will need to complete the project:

| Amount | Part | Price |
| ------ | ---- | ----- |
| 5 | [Raspberry Pi 3](http://amzn.eu/0Gxy4ku) | 5 * 39 EUR |
| 5 | [Micro SD Card 32 GB](http://amzn.eu/5IMqzRx) | 5 * 11 EUR |
| 1 | [WLAN Router](http://amzn.eu/3Zzxmpt) | 24 EUR |
| 1 | [100 MB Switch](http://amzn.eu/ixBjdx3) | 12 EUR |
| 5 |  Micro-USB wires | 5 * 1 EUR |
| 1 | [Power Supply](https://www.modmypi.com/raspberry-pi/accessories/usb-hubs/anidees-6-port-smart-ic-usb-charger-50-watt/) | 43 EUR |
| 3 | [Multi stackable case](https://www.modmypi.com/raspberry-pi/cases/multi-pi-stacker/multi-pi-stackable-raspberry-pi-case/) | 3 * 16 EUR |
| 1 | [Bolt pack](https://www.modmypi.com/raspberry-pi/cases/multi-pi-stacker/multi-pi-stackable-raspberry-pi-case-bolt-pack/) | 6 EUR | 

## SW List

Here is the software you will need to complete the project:

| Name | Origin | URL |
| ------ | ---- | ----- |
| HypriotOS | GitHub | [hypriot/rpi-image-builder](https://github.com/hypriot/image-builder-rpi/releases/) |
| flash | GitHub | [hypriot/flash](https://github.com/hypriot/flash) |
| Ansible | Website | [Ansible installation guide](http://docs.ansible.com/ansible/intro_installation.html)

## Quick start

1. Download the latest HypriotOS image from the hypriot/rpi-image-builder [release page](https://github.com/hypriot/image-builder-rpi/releases/)
2. For each SD card, flash the image (v.1.1.3 in this case).:

``` $ flash hypriotos-rpi-v1.1.3.img ```

3. Put the SD card in all the Pis.
4. RECOMMENDED: For each Pi, turn it on, find out its MAC address (e.g. using your router), set a static IP from them and reboot them to get the new IP.
5. Copy "hosts.example" to "hosts" and edit the file. 
* Describe in "Pis" all your Raspberry Pi devices' IP (or hostname) (both master and nodes). Don't forget to set the "name" in order to rename each node during setup
* Describe in "Master" ONE of your Raspberry Pi devices that will act as cluster master
* Describe in "Nodes" the rest of Raspberry Pi devices that will act as cluster nodes (Please, do not include here the master!)

6. Apply the base configuration for all Pi:

``` $ ansible-playbook -k -i hosts setup.yml ```

IMPORTANT: Amongs others, the setup copies your public SSH key to all Pis and associates it to the user "Pi". Is important to check that the key exists at "~/.ssh/id_rsa.pub". 
You can create a new key using the command: 

```ssh-keygen -t rsa -b 4096 ```

You set another path in /roles/base/defaults/main.yml.

7. Copy config.example.yml to config.yml
* Put a random Kubernetes token (<6 character string>.<16 character string>) into the "token" parameter. This token will be used for both master and nodes creation
* Put your master hostname or IP address in the "master" variable
8. Create the Kubernetes cluster:

``` $ ansible-playbook -i hosts master.yml ```

9. Join the nodes to the cluster:

```$ ansible-playbook -i hosts nodes.yml ```

10. OPTIONAL: The "master.yml" file has copied for you the admin.config file from the master. This file is required to use kubectl from your computer. 
* Move the file to ${HOME}/.kube/config or use the flag --kubeconfig when calling to kubectl from your computer [More info](http://kubernetes.io/docs/user-guide/kubectl/kubectl_config/)
* Alternativelly, you can connect to the cluster master and execute kubectl from there.