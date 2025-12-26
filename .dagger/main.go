package main

import (
	"context"

	"dagger/mocbot-api/internal/dagger"
)

const (
	nodeJSVersion = "23"
)

type MocbotApi struct {
	// +private
	RepoName string
	// Source code directory
	// +private
	Source *dagger.Directory
	// +private
	InfisicalClientSecret *dagger.Secret
}

func New(
	repoName string,
	// Source code directory
	// +defaultPath="."
	source *dagger.Directory,
	// Infisical client secret
	infisicalClientSecret *dagger.Secret,
) *MocbotApi {
	return &MocbotApi{
		RepoName:              repoName,
		Source:                source,
		InfisicalClientSecret: infisicalClientSecret,
	}
}

// CI runs the complete CI pipeline
func (m *MocbotApi) CI(ctx context.Context) (string, error) {
	// Build MySQL service directly with schema file in our context
	mysqlService := dag.Mysql().
		Base().
		WithFile("/docker-entrypoint-initdb.d/schema.sql", m.Source.File("db/data/init.sql.local")).
		AsService()

	base := dag.NodeCi(m.Source, dagger.NodeCiOpts{
		NodeVersion: nodeJSVersion,
	}).
		Install()

	_, err := base.WithLint().WithExec("tsc").Stdout(ctx)
	if err != nil {
		return "", err
	}

	nodeBase := base.
		Container().
		WithNewFile("./db-password", "root").
		WithEnvVariable("DB_HOST", "db").
		WithEnvVariable("DB_NAME", "test_db").
		WithEnvVariable("DB_USER", "root").
		WithEnvVariable("DB_PASS", "./db-password").
		WithEnvVariable("PORT", "8000").
		WithEnvVariable("API_KEY", "test")

	// Build the API server
	apiServer := nodeBase.
		WithServiceBinding("db", mysqlService).
		WithEnvVariable("HOST", "0.0.0.0").
		WithExec([]string{"npm", "run", "build"}).
		WithExposedPort(8000).
		AsService(
			dagger.ContainerAsServiceOpts{
				Args: []string{"npm", "start"},
			},
		)

	// Run tests
	return nodeBase.
		WithServiceBinding("api", apiServer).
		WithServiceBinding("db", mysqlService).
		WithEnvVariable("HOST", "api").
		WithExec([]string{"npm", "test"}).
		Stdout(ctx)
}

// BuildAndPush builds and pushes the Docker image to the container registry
func (m *MocbotApi) BuildAndPush(
	ctx context.Context,
	// +default="staging"
	env string,
) (string, error) {
	return dag.Docker(m.Source, m.InfisicalClientSecret, m.RepoName, dagger.DockerOpts{
		Environment: env,
	}).Build().Publish(ctx)
}
