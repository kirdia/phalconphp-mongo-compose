<img align="right" width="175px" src="http://i.imgur.com/mdZ8Ktf.png" />

# Phalconphp with Mongo Compose

[![Phalcon v3.0.4](https://img.shields.io/badge/phalcon-3.0.4-blue.svg)][:phalcon:]


## Documentation

1. To use it copy docker-compose.override.yml.example to docker-compose.override.yml 
```bash
cp docker-compose.override.yml.example docker-compose.override.yml
```
and set the plalcon project directory and the path to two private ssh keys. jenkey2 should point to a private ssh key that is configured to pull from github/gitlab/bitbucket etc.

2. Copy variables.env.example to variables.env 
```bash
cp variables.env.example variables.env
```


[:status:]:    https://travis-ci.org/phalcon/phalcon-compose
[:phalcon:]:   https://github.com/phalcon/cphalcon
[:downloads:]: https://packagist.org/phalcon/compose
[:docker:]:    https://www.docker.com
[:license:]:   https://github.com/phalcon/phalcon-compose/blob/master/LICENSE.txt
