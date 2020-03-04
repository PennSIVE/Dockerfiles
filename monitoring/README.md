# Monitoring

Monitoring and logging help you stay informed of performance.


### Prometheus
What actually monitors and records performance. Run with `./prometheus/run.sh` to start on port 1112. To capture docker metrics, you must copy `./prometheus/daemon.js` into `/etc/docker/daemon.json` on linux or on macOS via the Docker GUI > Preferences > Daemon > Advanced and restart Docker.

### Grafana
Visualization software for time series data that plugs into Prometheus and many other backends. Run with `./grafana/run.sh` to start on port 1111.