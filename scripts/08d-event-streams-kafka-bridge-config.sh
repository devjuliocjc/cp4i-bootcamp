#!/bin/bash
if [ ! command -v oc &> /dev/null ]; then echo "oc could not be found"; exit 1; fi;
echo "Configuring Kafka Bridge..."
###################
# INPUT VARIABLES #
###################
ES_INST_NAME='es-demo'
ES_NAMESPACE='tools'
################################
# INITIAL EVENT STREAMS CONFIG #
################################
#ES_BOOTSTRAP_SERVER=$(oc get eventstreams ${ES_INST_NAME} -n ${ES_NAMESPACE} -o=jsonpath='{range .status.kafkaListeners[*]}{.type} {.bootstrapServers}{"\n"}{end}' | awk '$1=="external" {print $2}')
ES_BOOTSTRAP_SERVER=$(oc get eventstreams ${ES_INST_NAME} -n ${ES_NAMESPACE} -o=jsonpath='{range .status.kafkaListeners[*]}{.name} {.bootstrapServers}{"\n"}{end}' | awk '$1=="external" {print $2}')
echo $ES_BOOTSTRAP_SERVER
( echo "cat <<EOF" ; cat templates/template-es-kafka-bridge.yaml ;) | \
    ES_BOOTSTRAP_SERVER=${ES_BOOTSTRAP_SERVER} \
    sh > es-kafka-bridge.yaml
echo "Creating Kafka Bridge instance..."
oc apply -f es-kafka-bridge.yaml
echo "Creating Route for Kafka Bridge instance..."
oc apply -f resources/02d-es-kafka-bridge-route.yaml
echo "Cleaning up temp files..."
rm -f es-kafka-bridge.yaml
echo "Kafka Bridge has been configured."