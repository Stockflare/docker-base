# stockflare/base

This Docker container can be located [here]() on the Docker Registry.

Includes the following `ONBUILD` triggers:

```
# Add current working directory in child builds
ONBUILD ADD ./ /bruw

# Bundle install child working directory
ONBUILD RUN bundle install
```

Note: No binary Database dependencies are installed. Ie. `mysql-client`
