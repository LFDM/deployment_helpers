These deployment helper scripts where originally created to help with
the deployment process of
[Arethusa](http://github.com/latin-language-toolkit/arethusa) on
[Perseids](http://perseids.org) servers.

The idea is to easily reference a production and a staging build with
the ability to roll back and forth between them and having access to
several versioned builds of the software.

Let's say we have a folder hierarchy which we use to store versioned
builds of our application.

```
app/
  v1/
  v2/
  v3/
```

and another folder called `server`, which contains files that are
exposed to the internet.

We first export an environmental variable, so that the helper scripts
know where to work.

```
export DEPLOYMENT_HELPER_TARGET="server"
```

We launch the `setup` script to build up the initial set of links we
need in future steps. The first argument of the script is the name of
the application, we go for `app` in this example.

```
depl-help-setup app
```

This will create a couple of files in the `server` folder

```
server/
  app -> app-prod-1
  app-staging -> app-dev-1
  app-prod-1
  app-prod-2
  app-prod-3
  app-dev-1
  app-dev-2
  app-dev-3
```

`app` links to `app-prod-1`, `app-staging` links to `app-dev-1`.
The other files will be used to link to the actual directories that
contain our builds.

```
depl-help-deploy app app/v1 dev
```
will create a link from `app-dev-1` to the `app/v1` folder. Remember
that the tip of the `dev` link hierarchy is also referenced by `app-staging`.

Let's repeat the process and add a reference to `app/v2`, also in the
`dev` environment.

```
depl-help-deploy app app/v2 dev
```

`app-dev-1` now links to `app/v2`. The former reference of `app-dev-1`
was pushed down the link chain and can now be found in `app-dev-2`,
which will then lead to `app/v1`.

If we are happy with our staged version, we can declare it as our most
recent production version.

```
depl-help-release app
```

The reference in `app-dev-1` will be copied to `app-prod-1`, which is
also accessible through the pure `app` link.

We can also deploy a new version directly to the production link
hierarchy.

```
depl-help-deploy app app/v3 prod
```

`app-prod-1` will now link to `app/v3`, `app-prod-2` will contain a
reference to the former production version sitting in `app/v1`.

If we encounter problems with the most current version, which users
might access through a route that goes to our `app` link, we can easily
roll back to an older version.

```
depl-help-rollback app prod
```

This will set back `app-prod-1` to what `app-prod-2` linked to - in our
case this means that `app-prod-1` - and therefore `app` itself - will
link to `app/v1` again.

  
  
  
