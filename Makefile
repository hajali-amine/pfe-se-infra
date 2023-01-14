create-local-cluster:
	@kind create cluster
	@kubectl cluster-info --context kind-kind

delete-local-cluster:
	@kind delete cluster

add-neo4j:
	@helm repo add neo4j https://helm.neo4j.com/neo4j
	@helm repo update
	