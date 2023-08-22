#python script for generating the DR plan for BlogApp Application.

from diagrams import Diagram, Cluster
from diagrams.aws.compute import EC2
from diagrams.aws.database import RDS
from diagrams.aws.network import Route53
from diagrams.aws.storage import S3

with Diagram("Disaster Recovery Plan", show=False):
    with Cluster("Tokyo"):
        tokyo = EC2("AWS Datacenter in Tokyo")
        cross_region_replication = EC2("Cross-Region Replication")
        multi_az = EC2("Multi-AZ Deployment")
        automated_backups = RDS("Automated Backups")
        dr_plan = EC2("Disaster Recovery Plan")
        ami = EC2("AMI and Snapshot Replication")
        dns_failover = Route53("DNS Failover")

        tokyo >> cross_region_replication
        tokyo >> multi_az
        tokyo >> automated_backups
        tokyo >> dr_plan
        tokyo >> ami
        tokyo >> dns_failover

    with Cluster("Singapore"):
        singapore = EC2("AWS Datacenter in Singapore")
        cross_region_replication >> singapore
        multi_az >> singapore
        automated_backups >> singapore
        ami >> singapore
        dns_failover >> singapore

    with Cluster("BlogApp"):
        blog_app = EC2("BlogApp Application")
        blog_app >> multi_az

    with Cluster("To`kyo"):
        testing = EC2("ec2 instance")
        dr_plan >> testing