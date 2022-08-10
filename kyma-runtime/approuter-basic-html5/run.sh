#!/bin/sh

#set default values
NAMESPACE=development
IMAGENAME=abdulbasitg/approuter-basic-html5:latest
SAP_CLOUD_SERVICE=ag.samples
PREFIX=approuter-basic-html5

dockerbuild() {
    docker build app --tag ${IMAGENAME}
}

dockerpush() {
    docker push ${IMAGENAME}
}

deploy() {
    IMAGENAME_ESCAPED=`echo $IMAGENAME|sed 's/\//\\\\\//g'`
    sed "s/{{IMAGE_NAME}}/${IMAGENAME_ESCAPED}/g;s/{{SAP_CLOUD_SERVICE}}/${SAP_CLOUD_SERVICE}/g;s/{{PREFIX}}/${PREFIX}/g" deployment.yaml | kubectl -n ${NAMESPACE} apply -f -
}

delete() {
    kubectl -n ${NAMESPACE} delete deployments.v1.apps ${PREFIX}
    kubectl -n ${NAMESPACE} delete ServiceBinding ${PREFIX}-destination-binding
    kubectl -n ${NAMESPACE} delete ServiceBinding ${PREFIX}-host-binding
    kubectl -n ${NAMESPACE} delete ServiceBinding ${PREFIX}-xsuaa-binding
    kubectl -n ${NAMESPACE} delete ServiceInstance ${PREFIX}-destination-instance
    kubectl -n ${NAMESPACE} delete ServiceInstance ${PREFIX}-host-instance
    kubectl -n ${NAMESPACE} delete ServiceInstance ${PREFIX}-xsuaa-instance    
}

reset() {
    delete
    deploy
}
if [ -z "$1" ]
then
    echo "usage: run <deploy|delete|reset|dockerbuild|dockerpush>"
else
    case $1 in
        deploy)
            deploy
            ;;
        delete)
            delete
            ;;
        reset)
            reset
            ;;
        dockerbuild)
            dockerbuild
            ;;
        dockerpush)
            dockerpush
            ;;
        *)
            echo "invalid argument. "

    esac
fi
