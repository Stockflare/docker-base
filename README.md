# stockflare/base:node

This Docker container can be located [here]() on the Docker Registry.

Includes the following `ONBUILD` triggers:

```
# Add current working directory in child builds
ONBUILD ADD ./ /stockflare
ONBUILD RUN sudo chown -R nuser:nuser .

# Bundle child working directory
ONBUILD RUN /bin/bash -l -c "npm install"
```

Note: No binary Database dependencies are installed. Ie. `mysql-client`
