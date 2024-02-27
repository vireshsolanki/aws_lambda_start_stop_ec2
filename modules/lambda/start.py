import boto3

def lambda_handler(event, context):
    instance_id = event['instance_id']
    
    # Create EC2 client
    ec2 = boto3.client('ec2')
    
    # Start the instance
    ec2.start_instances(InstanceIds=[instance_id])
    
    print(f'Started EC2 instance with ID: {instance_id}')
