# Replace <MONITORING_ID> with your monitoring ID from the Ddosify Cloud. Change XXXXX with your monitoring ID.
MONITORING_ID=XXXXX
helm repo add ddosify https://ddosify.github.io/ddosify-helm-charts/
helm repo update
kubectl create namespace ddosify
helm upgrade --install --namespace ddosify alaz ddosify/alaz --set monitoringID=$MONITORING_ID