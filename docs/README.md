# Notes

## lambda proxy handler

github.com/awslabs/aws-lambda-go-api-proxy

## general logging/tracing/metrics

```go
package main

import (
    "context"
    "github.com/aws/aws-lambda-go/lambda"
    "github.com/aws/aws-lambda-go/events"
    "github.com/aws/aws-xray-sdk-go/xray"
    "go.uber.org/zap"
)

var logger *zap.Logger

func init() {
    logger, _ = zap.NewProduction()
    defer logger.Sync()
}

func handler(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
    // Add X-Ray tracing
    ctx, seg := xray.BeginSegment(ctx, "handler")
    defer seg.Close(nil)

    // Structured logging
    logger.Info("handling request",
        zap.String("path", request.Path),
        zap.String("method", request.HTTPMethod),
    )

    return events.APIGatewayProxyResponse{
        StatusCode: 200,
        Body:       "Hello from Go Lambda!",
    }, nil
}

func main() {
    lambda.Start(handler)
}
```

## For parameter store and secrets:

- look for app config integration without AWS, with Lambda layer, with EKS agent

AWS SDK for Go v2's SSM and Secrets Manager clients

## web server

github.com/gin-gonic/gin

github.com/gorilla/mux with custom middleware