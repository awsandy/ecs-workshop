aws ecs describe-container-instances --cluster container-demo  \
                --container-instances $(aws ecs list-container-instances \
                                        --cluster container-demo \
                                        --query 'containerInstanceArns[]' \
                                        --output text) \
                --query 'containerInstances[].{InstanceId: ec2InstanceId, 
                                                CapacityProvider: capacityProviderName, 
                                                RunningTasks: runningTasksCount}' \
                --output table | grep EC2 | sort