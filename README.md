# Cloud Pak for Integration BootCamp

## Prerequisites
> [!IMPORTANT]
> This tools need to be installed in order to execute the workshop
- Ubuntu Linux 22.x or higher
- Internet Browser Firefox or Google Chrome
- SSH Server
```
sudo apt install ssh
```
- GIT Client
```
sudo apt install git
```
- Openshift command line

   You can download it from here [openshift-client](https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/4.14.17/openshift-client-linux-4.14.17.tar.gz).

---

## Components Installation



<details>
<summary>
Get the scripts and resources:
</summary>

1. Clone the repository:
   ```
   git clone https://github.com/fxnaranjo/cp4i-bootcamp
   ```
</details>
&nbsp; 

<details>
<summary>
Set environment variables:
</summary>

1. Set CP4I version:
   ```
   export CP4I_VER=2023.4
   ```
2. Set the OCP type based on the storage classes in your cluster:
   ```
   export OCP_TYPE=ODF
   ```
</details>
&nbsp; 

<details>
<summary>
Set a default storage class for your cluster:
</summary>

1. The OCP cluster was provisioned Tech Zone use the following script to set the proper default storage class:
   ```
   scripts/99-odf-tkz-set-scs.sh
   ```
</details>
&nbsp; 

<details>
<summary>
Openshift Login:
</summary>  

1. Run script:
   ```
   scripts/00b-logging-install.sh
   ```
   Confirm installation completed successfully, you can run the following commands:
   ```
   oc get csv -n openshift-logging
   oc get pods -n openshift-logging
   ```
   You should receive a response like this for each command respectively.
   ```
   NAME                            DISPLAY                            VERSION   REPLACES   PHASE
   cluster-logging.v5.6.1          Red Hat OpenShift Logging          5.6.1                Succeeded
   elasticsearch-operator.v5.6.1   OpenShift Elasticsearch Operator   5.6.1                Succeeded
   ```

   ```
   NAME                                            READY   STATUS      RESTARTS   AGE
   cluster-logging-operator-756b4c48cc-lhkzs       1/1     Running     0          6m41s
   collector-njm62                                 2/2     Running     0          5m36s
   collector-nxpmd                                 2/2     Running     0          5m36s
   collector-xjl96                                 2/2     Running     0          5m36s
   collector-xsv6b                                 2/2     Running     0          5m36s
   collector-z9k9l                                 2/2     Running     0          5m36s
   elasticsearch-cdm-dxgp4gmf-1-577dc997c-sk7kg    2/2     Running     0          5m36s
   elasticsearch-cdm-dxgp4gmf-2-5f5d564466-cgk6x   2/2     Running     0          5m35s
   elasticsearch-cdm-dxgp4gmf-3-8695d6658c-lxblf   2/2     Running     0          5m33s
   elasticsearch-im-app-27947625-m6qd9             0/1     Completed   0          2m58s
   elasticsearch-im-audit-27947625-ht4jj           0/1     Completed   0          2m58s
   elasticsearch-im-infra-27947625-r9j8c           0/1     Completed   0          2m58s
   kibana-746f699cc-72qfk                          2/2     Running     0          5m34s
   ```
</details>