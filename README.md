# Install CodeReady Workspaces in disconnected environment

This tutorial shows the whole procedure to install a CodeReady Workspaces 2.0 

## Prerequisites:

1. OC CLI : https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/)
2. Skopeo : https://github.com/nmasse-itix/OpenShift-Examples/tree/master/Using-Skopeo



## Set a registry to store all images needed to install CRW


On your MacOS terminal:

To use internal registry OpenShift, expose the registry service as followed  :

	oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge

More info here : https://docs.openshift.com/container-platform/4.2/registry/securing-exposing-registry.html

## Set OpenShift internal registry hostname env variable

    export OCP_REGISTRY=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')


## Feed internal registry with Skopeo 

Pull images from Red Hat registry registry.redhat.io and copy them to the internal registry with skopeo and podman

Set access token for registry.redhat.io with a service account https://access.redhat.com/terms-based-registry/#/create

    export RH_TOKEN="user_name|my_token"

Set access token for OpenShift

    export OCP_TOKEN=$(oc whoami)\|$(oc whoami -t)

Run the script feed_registry.sh

    . feed_registry.sh

## Run CodeReady Workspaces installation

Download CodeReady Workspaces CLI to run the disconnected installation from your laptop:

    curl https://developers.redhat.com/products/codeready-workspaces/download --output crw.tar.gz

Uncompress it 

    tar -xvf crw.tar.gz

Move it a dedicated folder. For instance

    mv crwctl $HOME

Add it to your PATH

    export PATH="$HOME/crwctl/bin:$PATH"

Make sure you are logged in OpenShift

    oc login -u my_user -p password https://api_hostname:6443 

Run the following crwctl command 

    crwctl server:start   --che-operator-image=image-registry.openshift-image-registry.svc:5000/openshift/server-operator-rhel8:2.0   --che-operator-cr-yaml=org_v1_che_cr.yaml

[logo]: https://github.com/gestrem/crw-disconnected/blob/master/crw_installation.png

More info about CodeReady Workspaces Disconnected can be found here : https://access.redhat.com/documentation/en-us/red_hat_codeready_workspaces/2.0/html/installation_guide/installing-codeready-workspaces-in-a-restricted-environment






