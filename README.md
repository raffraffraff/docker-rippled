# Ripple
This is a work in progress Docker container for [Ripple](https://github.com/google/mysql-ripple), "a server that can serve as a middleman in MySQL replication"

## Status
This Dockerfile builds a 103MB container that lets you kick the tires on Rippled. PRs welcome.

# TODO
* Play with it more, write some usage instructions
* Docker entrypoint script (to accept environment variables, write config start rippled)
* Support liveness, readiness, metrics
* CI/CD
