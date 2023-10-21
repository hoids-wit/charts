sudo mount -t nfs 192.168.86.196:/mnt/user/matrix /mnt/matrix/data
sudo docker run -it --rm -v /mnt/matrix/data:/data -e SYNAPSE_SERVER_NAME=matrix.petecca.com -e SYNAPSE_REPORT_STATS=no matrixdotorg/synapse:latest generate

sudo microk8s helm repo add ananace-charts https://ananace.gitlab.io/charts
sudo microk8s helm install matrix-synapse ananace-charts/matrix-synapse --set serverName=matrix.petecca.com --set wellknown.enabled=true

export POD_NAME=$(sudo microk8s kubectl get pods --namespace default -l "app.kubernetes.io/name=matrix-synapse,app.kubernetes.io/instance=matrix-synapse,app.kubernetes.io/component=synapse" -o jsonpath="{.items[0].metadata.name}")
    sudo microk8s kubectl exec --namespace default $POD_NAME -- register_new_matrix_user -c /synapse/config/homeserver.yaml -c /synapse/config/conf.d/secrets.yaml -u matrixaadmin -p gravelporkballsnailskin --admin http://localhost:8008 