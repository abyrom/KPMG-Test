import json

from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient

def get_azure_instance_metadata():
    metadata = {}
    credential = DefaultAzureCredential()
    subscription_id = 'your_subscription_id'
    compute_client = ComputeManagementClient(credential, subscription_id)
    vm_list = compute_client.virtual_machines.list_all()

    for vm in vm_list:
        metadata['resource_group'] = vm.id.split('/')[4]
        metadata['vm_name'] = vm.name
        metadata['vm_size'] = vm.hardware_profile.vm_size
        # Add more metadata as needed
        break  # Assuming there's only one VM
    
    return metadata