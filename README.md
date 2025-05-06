# Lock Shields - DB Scripts


## Run compose

```
docker compose up --build -d
```
## Copy pg dump to container

```
kubectl exec -n <namespace> <pod-name> -- psql -U postgres -c 'SELECT version();'
```

```
kubectl exec -n default postgres-db-1 -- psql -U postgres -c 'SELECT version();'
```