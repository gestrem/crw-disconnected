UPSTREAM=registry.redhat.io

crw_images="
    server-operator-rhel8:2.0
    server-rhel8:2.0
    pluginregistry-rhel8:2.0
    devfileregistry-rhel8:2.0
    pluginbroker-rhel8:2.0
    pluginbrokerinit-rhel8:2.0
    jwtproxy-rhel8:2.0
    machineexec-rhel8:2.0
    theia-rhel8:2.0
    theia-endpoint-rhel8:2.0
"
for image in $crw_images; do

sudo skopeo copy --dest-tls-verify=false   --src-creds $RH_TOKEN --dest-creds $OCP_TOKEN docker://$UPSTREAM/codeready-workspaces/$image docker://$OCP_REGISTRY/openshift/$image
   
done


sudo skopeo copy --dest-tls-verify=false   --src-creds $RH_TOKEN   --dest-creds $OCP_TOKEN docker://$UPSTREAM/rhscl/postgresql-96-rhel7:1-47 docker://$OCP_REGISTRY/openshift/postgresql-96-rhel7:1-47

sudo skopeo copy --dest-tls-verify=false   --src-creds $RH_TOKEN   --dest-creds $OCP_TOKEN docker://$UPSTREAM/redhat-sso-7/sso73-openshift:1.0-15 docker://$OCP_REGISTRY/openshift/sso73-openshift:1.0-15

sudo skopeo copy --dest-tls-verify=false   --src-creds $RH_TOKEN  --dest-creds $OCP_TOKEN docker://$UPSTREAM/ubi8-minimal:8.0-213 docker://$OCP_REGISTRY/openshift/ubi8-minimal:8.0-213
