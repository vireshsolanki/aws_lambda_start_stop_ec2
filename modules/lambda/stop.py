import boto3

def lambda_handler(event, context):
    instance_id = event['instance_id']
    
    # Create EC2 client
    ec2 = boto3.client('ec2')
    
    # Stop the instance
    ec2.stop_instances(InstanceIds=[instance_id])
    
    print(f'Stopped EC2 instance with ID: {instance_id}')
