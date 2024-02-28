import boto3

# Initialize Boto3 EC2 client
ec2_client = boto3.client('ec2')

def lambda_handler(event, context):
    # Check if the 'instanceId' key is present in the event object
    if 'instanceId' in event:
        # Extract the instance ID from the event
        instance_id = event['instanceId']
        
        # Check if the 'time' key is present in the event object
        if 'time' in event:
            # Extract the hour from the timestamp
            timestamp = event['time']
            current_hour = int(timestamp.split('T')[1].split(':')[0])
            
            # Perform the action based on the current hour
            if current_hour == 12:  # Increase instance type at 12:00 PM
                stop_instance(instance_id)
                increase_instance_type(instance_id)
                start_instance(instance_id)
            elif current_hour <= 20:  # Decrease instance type at 8:00 PM
                stop_instance(instance_id)
                decrease_instance_type(instance_id)
                start_instance(instance_id)
            else:
                print("No action needed at this time.")
        else:
            print("No 'time' key found in the event.")
    else:
        print("No 'instanceId' key found in the event.")

def stop_instance(instance_id):
    # Stop the instance
    response = ec2_client.stop_instances(InstanceIds=[instance_id])
    print(f"Instance {instance_id} stopped.")

def start_instance(instance_id):
    # Start the instance
    response = ec2_client.start_instances(InstanceIds=[instance_id])
    print(f"Instance {instance_id} started.")

def increase_instance_type(instance_id):
    # Define the new instance type for increase
    new_instance_type = 't2.large'  # Change this to the desired instance type
    
    # Modify the instance type
    response = ec2_client.modify_instance_attribute(
        InstanceId=instance_id,
        InstanceType={
            'Value': new_instance_type
        }
    )
    print(f"Instance type of {instance_id} increased to {new_instance_type}")

def decrease_instance_type(instance_id):
    # Define the new instance type for decrease
    new_instance_type = 't2.micro'  # Change this to the desired smaller instance type
    
    # Modify the instance type
    response = ec2_client.modify_instance_attribute(
        InstanceId=instance_id,
        InstanceType={
            'Value': new_instance_type
        }
    )
    print(f"Instance type of {instance_id} decreased to {new_instance_type}")
