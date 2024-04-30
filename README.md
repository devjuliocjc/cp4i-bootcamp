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

   You can download it from here [openshift-client](https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/4.14.21/openshift-client-linux-4.14.21.tar.gz).
- openssl
- [jq](https://stedolan.github.io/jq/)
- [yq](https://github.com/mikefarah/yq/releases/download/v4.43.1/yq_linux_amd64)
- [apic cli](https://github.com/fxnaranjo/cp4i-bootcamp/blob/main/apic/toolkit-linux.tgz)
- keytool
```
sudo apt install openjdk-17-jre-headless
```
You also need an account in the folllowing email service to configure APIC:

- [mailtrap](https://mailtrap.io/)

---

> [!NOTE]
> You will receive the credentials to access the Openshift Cluster in the classroom

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
3. Configure mail server Credentials
   ```
   export MAILTRAP_USER=<my-mailtrap-user>
   export MAILTRAP_PWD=<my-mailtrap-pwd>
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
&nbsp; 

<details>
<summary>
Install Instana and prerequisites:
</summary>

1. Deploy prerequisites runnning script:
   ```
   scripts/01a-tracing-install.sh
   ```
   To confirm the installation completed successfully you can run the following commands:
   ```
   oc get csv -n openshift-distributed-tracing
   oc get jaeger -n openshift-distributed-tracing
   ```
   You should receive a response like this for each command respectively.
   ```
   NAME                               DISPLAY                                                 VERSION    REPLACES                           PHASE
   elasticsearch-operator.v5.6.1      OpenShift Elasticsearch Operator                        5.6.1                                         Succeeded
   jaeger-operator.v1.39.0-3          Red Hat OpenShift distributed tracing platform          1.39.0-3   jaeger-operator.v1.34.1-5          Succeeded
   opentelemetry-operator.v0.63.1-4   Red Hat OpenShift distributed tracing data collection   0.63.1-4   opentelemetry-operator.v0.60.0-2   Succeeded
   ```

   ```
   NAME                         STATUS    VERSION   STRATEGY   STORAGE   AGE
   jaeger-all-in-one-inmemory   Running   1.39.0    allinone   memory    18m
   ```
2. Set environment variables:
   ```
   export ZONE_NAME=BOOTCAMP-ZONE
   export CLUSTER_NAME=<my-cluster-name>
   export INSTANA_APP_KEY=ORiJrirMTj6PiA67APP16g
   export INSTANA_SVC_ENDPOINT=ingress-coral-saas.instana.io
   export INSTANA_SVC_PORT=443
   ```
3. Install Instana running script:
   ```
   scripts/01b-instana-install.sh
   ```
   To confirm the installation completed successfully you can run the following commands:
   ```
   oc get csv -n instana-agent
   oc get pods -n instana-agent
   ```
   You should receive a response like this for each command respectively.
   ```
   NAME                               DISPLAY                                                 VERSION    REPLACES                           PHASE
   cert-manager.v1.11.0               cert-manager                                            1.11.0     cert-manager.v1.10.2               Succeeded
   elasticsearch-operator.v5.6.2      OpenShift Elasticsearch Operator                        5.6.2      elasticsearch-operator.v5.6.1      Succeeded
   instana-agent-operator.v2.0.9      Instana Agent Operator                                  2.0.9      instana-agent-operator.v2.0.8      Succeeded
   jaeger-operator.v1.39.0-3          Red Hat OpenShift distributed tracing platform          1.39.0-3   jaeger-operator.v1.34.1-5          Succeeded
   opentelemetry-operator.v0.63.1-4   Red Hat OpenShift distributed tracing data collection   0.63.1-4   opentelemetry-operator.v0.60.0-2   Succeeded
   ```

   ```
   NAME                  READY   STATUS    RESTARTS   AGE
   instana-agent-75dkm   1/1     Running   0          5m6s 
   instana-agent-8gr46   1/1     Running   0          5m6s
   instana-agent-xpj95   1/1     Running   0          5m6s
   instana-agent-xxncc   1/1     Running   0          5m6s
   instana-agent-zvflw   1/1     Running   0          5m6s
   ```
4. Set environment variable:
   ```
   export CP4I_TRACING=YES
   ```

</details>
&nbsp;

<details>
<summary>
F) Install Common Serviecs and its pre-requisites:
</summary>   

1. Install Cert Manager Operator:
   ```
   oc create -f resources/00-cert-manager-namespace.yaml
   oc create -f resources/00-cert-manager-operatorgroup.yaml
   oc create -f resources/00-cert-manager-subscription.yaml
   ```
   Confirm the subscription has been completed successfully before moving to the next step running the following command:
   ```
   oc get pods -n cert-manager-operator
   ```
   You should get a response like this:
   ```
   NAME                                                        READY   STATUS    RESTARTS   AGE
   cert-manager-operator-controller-manager-7f779b98b4-2f64r   2/2     Running   0          13h
   ```
2. Install Postgress SQL Catalog Source:
   ```
   oc create -f catalog-sources/${CP4I_VER}/01-postgress-sql-catalog-source-4.18.0.yaml
   ```
   Confirm the catalog source has been deployed successfully before moving to the next step running the following command:
   ```
   oc get pods -n openshift-marketplace | grep postgresql
   ```
   You should get a response like this:
   ```
   cloud-native-postgresql-catalog-jsmbk                             1/1     Running     0             14h
   ```
3. Install Common Services Catalog Source:
   ```
   oc create -f catalog-sources/${CP4I_VER}/02-common-services-catalog-source-4.4.0.yaml
   ```
   Confirm the catalog source has been deployed successfully before moving to the next step running the following command:
   ```
   oc get pods -n openshift-marketplace | grep opencloud
   ```
   You should get a response like this:
   ```
   opencloud-operators-fhbfd                                         1/1     Running     0             14h
   ```
4. Create the Common Services namespace:
   ```
   oc create namespace ibm-common-services
   ```
5. Install Common Services Operator:
   ```
   oc create -f subscriptions/${CP4I_VER}/00-common-service-subscription.yaml
   ```
   Confirm the operator has been deployed successfully before moving to the next step running the following command:
   ```
   oc get pods -n openshift-operators | grep ibm-common-service
   ```
   You should get a response like this:
   ```
   ibm-common-service-operator-8c9b944f4-nkkgb                       1/1     Running     0          14h
   ```
</details>
&nbsp; 