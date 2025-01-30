![MOCBOT_API](https://user-images.githubusercontent.com/38149391/206867071-92e9e181-6c16-41ae-9c98-476919729782.png)

This repo will deploy into Kubernetes through CI/CD.

## Running Locally

If you would like to run locally:

1. Create a `.local-secrets` directory in the root of the project.
2. Populate the directory with the following file(s):
   | Filename | Description |
   |--------------------|------------------------------------|
   | `db-password` | The password to create a user with |
   | `db-root-password` | The root password for the database |
3. Run the application with

```
docker compose up -d --build
```

## Running Tests

To run tests, you can use the following command:

```
./run-tests.sh
```

This will spin up a local test database to run the tests against.

If you wish to clear the test database, you can use the following command:

```
./run-tests.sh clean
```

## API Documentation

You may find the MOCBOT API docs [here](https://api.masterofcubesau.com/).
