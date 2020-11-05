# Mr. Heckles - Backend Engineer Challenge #

Challenge proposed by Trustvox staff to evaluate backend skills. The problem definition and instructions can be found [here](#problem).

*NOTE: This project was originally developed in [this](https://gitlab.com/guustavov/mr-heckles) GitLab repository. If you're interested in more details about CI/CD setup or the development flow itself (issues, merge requests, tasks descriptions, etc) it's strongly recommended to check the project at [gitlab.com/guustavov/mr-heckles](https://gitlab.com/guustavov/mr-heckles).*

## Setup ##

This project has some pipeline instructions configured to run on Gitlab CI/CD. One of those instructions deploys to Gigalixir, which makes the API available at https://mr-heckles.gigalixirapp.com/api/v1/ when a merge request is accepted for branch `master`. Once it's a free trial environment, it may be **expired and unavailable** in the future.

In order to easily try some features, there is also available a dump of a Postman collection with some HTTP request suggestions. This `.json` file can be found in the root of this repository.


### Running locally ###

#### With docker ####

Make sure you have `docker` and `docker-compose` running and go to this repository root. Then you can run the following command (`-d` to run in detached mode - it's optional):

```sh
$ docker-compose up -d
```

This will build and run both the application and the Postgres container. After this, the API might be available at http://localhost:4000/api/v1/.

#### Without docker ####

Install the following dependencies:

- Erlang 23.0.3
- Elixir 1.10.4

You can install it manually or via `asdf` by running the following command at the root directory:

```sh
$ asdf install
```

To install elixir dependencies and setup database, run the commands below. Before, make sure you have a Postgres server running locally on default port (5432) and acessible with default credentials ('postgres' as user and password), or change `config/dev.exs` as needed.

```sh
$ mix deps.get
$ mix ecto.setup
```

Finally, make the API available at http://localhost:4000/api/v1/ by running:

```sh
$ mix phx.server
```

## Problem ##

We need to research about locales where consumer complains are made. That complains should have at least the attributes described bellow:

 - Title
 - Description
 - Locale
 - Company

Can you provide some services to ingest complains and get some data about its geolocation? For example, to find how many complains a specific company has in specific city?


### Recommendations ###
 - Use Restful instead Rest
 - Use microservice design if possible
 - Use a NoSql Database (if you use a database in your purpose)
 - We need to scale your services, decouple your modules if possible
 - Use devops mindset
 - Use Ruby or Elixir language and patterns

### Definition Of Done ###
 - A repository with read access to :
     - michel@reclameaqui.com.br
     - cleyton.messias@reclameaqui.com.br
     - laercio.filho@reclameaqui.com.br
     - cristiano.carvalho@reclameaqui.com.br
     - willian.miranda@reclameaqui.com.br
     - bruno.casali@reclameaqui.com.br
 - Documented, clean and testable/tested code
 - Documented strategy to deploy and run your code ( on cloud if possible )

### Questions? ###
 - Email me : cleyton.messias@reclameaqui.com.br

