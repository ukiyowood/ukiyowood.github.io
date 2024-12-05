1. 可以先确认部署方式 本地部署 & docker compose部署（一般用这个，方便管理）
    
    1. 本地部署安装包获取redis_exporter https://github.com/oliver006/redis_exporter
        
2. 确认要部署redis_exporter服务实例的机器，一般有两种策略：
    
    1. redis_exporter和redis实例部署在一起1:1配备
        
    2. 单独在运维主机节点上部署exporter，根据redis服务地址远程获取数据。
        
3. 通过docker compose启动redis_exporter节点
    
    ```YAML
    # docker-compose.yaml for redis_exporter
    version: '3'
    services:
      redis_exporter-9121:
        image: oliver006/redis_exporter
        container_name: redis_exporter-9121
        restart: always
        ports:
          - "9121:9121"
        environment:
          - REDIS_ADDR=127.0.0.1:7001
          - REDIS_PASSWORD=1234
      redis_exporter-9122:
        image: oliver006/redis_exporter
        container_name: redis_exporter-9122
        restart: always
        ports:
          - "9122:9121"
        environment:
          - REDIS_ADDR=127.0.0.1:7002
          - REDIS_PASSWORD=1234
      redis_exporter-9123:
        image: oliver006/redis_exporter
        container_name: redis_exporter-9123
        restart: always
        ports:
          - "9123:9121"
        environment:
          - REDIS_ADDR=127.0.0.1:7003
          - REDIS_PASSWORD=1234
    networks:
      default:
        external:
          name: prometheus_default
    ```
    

> - 配置中注意各节点的环境变量REDIS_ADDR中定义redis各节点地址；
>     
> - network定义如果和prometheus放在同一台主机上时可以使用同一个网络空间，然后prometheus.yaml中定义targets时可以直接使用容器名来查找地址
>     

```Bash
docker-compose run -d    # 后台启动定义的docker实例
```

4. 在prometheus服务的配置文件prometheus.yaml中添加redis_exporter相关定义
    

```YAML
# prometheus.yaml
scrape_configs:
- job_name: "redis-stage"
    static_configs:
      - targets: ["redis_exporter-9121:9121","redis_exporter-9122:9121","redis_exporter-9123:9121"]
```

```Bash
docker-compose restart prometheus    # 修改完配置后需要重启prometheus实例
```

> - 这一步是向prometheus中注册redis_exporter服务信息供其抓去数据；
>     
> - 风控生产环境的prometheus监控的targets节点服务的获取是通过consul服务来动态获取的，这就需要像node_exporter一样启动服务后通过web接口来动态注册服务信息 - 具体的操作步骤后面测试过后再进行补充
>     

5. 到grafana中添加对应的dashboard，一般可以通过id直接线上导入，`Redis Dashboard for Prometheus Redis Exporter 1.x`的dashboard id为 `763`