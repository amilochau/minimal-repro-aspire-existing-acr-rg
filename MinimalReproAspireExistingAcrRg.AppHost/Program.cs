var builder = DistributedApplication.CreateBuilder(args);

var containerRegistryName = builder.AddParameter("containerRegistryName");
var containerRegistryResourceGroupName = builder.AddParameter("containerRegistryResourceGroupName");

var containerRegistry = builder.AddAzureContainerRegistry("containerRegistry")
    .AsExisting(containerRegistryName, containerRegistryResourceGroupName);

builder.AddAzureContainerAppEnvironment("containerAppEnvironment")
    .WithAzureContainerRegistry(containerRegistry);

builder.Build().Run();
