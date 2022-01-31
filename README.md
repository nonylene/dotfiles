# Deploy

```bash
$ ./deploy.sh
```

## Re-init git repositories

```sh
for p in $(ghq list -p); do pushd $p && git init && popd; done
```

# License

See [LICENSE](./LICENSE).
