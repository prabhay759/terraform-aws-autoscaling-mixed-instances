variable "create_lt" {
  description = "Whether to create launch template"
  type        = bool
  default     = true
}

variable "create_asg" {
  description = "Whether to create autoscaling group"
  type        = bool
  default     = true
}

variable "create_asg_with_initial_lifecycle_hook" {
  description = "Create an ASG with initial lifecycle hook"
  type        = bool
  default     = false
}

variable "initial_lifecycle_hook_name" {
  description = "The name of initial lifecycle hook"
  type        = string
  default     = ""
}

variable "initial_lifecycle_hook_lifecycle_transition" {
  description = "The instance state to which you want to attach the initial lifecycle hook"
  type        = string
  default     = ""
}

variable "initial_lifecycle_hook_default_result" {
  description = "Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON"
  type        = string
  default     = "ABANDON"
}

variable "initial_lifecycle_hook_notification_metadata" {
  description = "Contains additional information that you want to include any time Auto Scaling sends a message to the notification target"
  type        = string
  default     = ""
}

variable "initial_lifecycle_hook_heartbeat_timeout" {
  description = "Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter"
  type        = string
  default     = "60"
}

variable "initial_lifecycle_hook_notification_target_arn" {
  description = "The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic"
  type        = string
  default     = ""
}

variable "initial_lifecycle_hook_role_arn" {
  description = "The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target"
  type        = string
  default     = ""
}

variable "recreate_asg_when_lt_changes" {
  description = "Whether to recreate an autoscaling group when launch template changes"
  type        = bool
  default     = false
}

variable "name" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
}

variable "lt_name" {
  description = "Creates a unique name for launch template beginning with the specified prefix"
  type        = string
  default     = ""
}

variable "asg_name" {
  description = "Creates a unique name for autoscaling group beginning with the specified prefix"
  type        = string
  default     = ""
}

variable "launch_template" {
  description = "The name of the launch template to use (if it is created outside of this module)"
  type        = string
  default     = ""
}

# Launch template
variable "image_id" {
  description = "The EC2 image ID to launch"
  type        = string
  default     = ""
}

variable "instance_types" {
  description = "Instance types to launch, minimum 2 types must be specified. List of Map of 'instance_type'(required) and 'weighted_capacity'(optional)."
  type        = list(map(any))
  default     = [{}]
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to associate with launched instances"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  type        = string
  default     = ""
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the launch template"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = " "
}

variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring. This is enabled by default."
  type        = bool
  default     = true
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "block_device_mappings" {
  description = "Mappings of block devices, see https://www.terraform.io/docs/providers/aws/r/launch_template.html#block-devices"
  type        = list(any)
  default     = [{}]
}

variable "placement_tenancy" {
  description = "The tenancy of the instance. Valid values are 'default' or 'dedicated'"
  type        = string
  default     = "default"
}

# Autoscaling group
variable "max_size" {
  description = "The maximum size of the auto scale group"
  type        = number
}

variable "min_size" {
  description = "The minimum size of the auto scale group"
  type        = number
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = number
}

variable "ignore_desired_capacity_changes" {
  description = "Ignores any changes to `desired_capacity` parameter after apply. Note updating this value will destroy the existing service and recreate it."
  default     = false
  type        = bool
}

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  type        = number
  default     = 300
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "health_check_type" {
  description = "Controls how health checking is done. Values are - EC2 and ELB"
  type        = string
}

variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  type        = bool
  default     = false
}

variable "load_balancers" {
  description = "A list of elastic load balancer names to add to the autoscaling group names"
  type        = list(string)
  default     = []
}

variable "target_group_arns" {
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  type        = list(string)
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  type        = list(string)
  default     = ["Default"]
}

variable "suspended_processes" {
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = list(map(any))
  default     = []
}

variable "tags_as_map" {
  description = "A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires."
  type        = map(any)
  default     = {}
}

variable "placement_group" {
  description = "The name of the placement group into which you'll launch your instances, if any"
  type        = string
  default     = ""
}

variable "metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  type        = string
  default     = "1Minute"
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = "10m"
}

variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  type        = number
  default     = 0
}

variable "wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
  type        = number
  default     = null
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events."
  type        = bool
  default     = false
}

variable "service_linked_role_arn" {
  description = "The ARN of the service-linked role that the ASG will use to call other AWS services"
  type        = string
  default     = ""
}

variable "on_demand_base_capacity" {
  description = "Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances"
  type        = number
  default     = 0
}

variable "on_demand_percentage_above_base_capacity" {
  description = "Percentage split between on-demand and Spot instances above the base on-demand capacity."
  type        = number
  default     = 100
}

variable "spot_allocation_strategy" {
  description = "How to allocate capacity across the Spot pools. Valid values: 'lowest-price', 'capacity-optimized'."
  type        = string
  default     = "capacity-optimized"
}

variable "spot_instance_pools" {
  description = "Number of Spot pools per availability zone to allocate capacity. EC2 Auto Scaling selects the cheapest Spot pools and evenly allocates Spot capacity across the number of Spot pools that you specify. Diversifies your Spot capacity across multiple instance types to find the best pricing."
  type        = number
  default     = 2
}

variable "spot_price" {
  description = "The price to use for reserving spot instances"
  type        = string
  default     = ""
}

variable "max_instance_lifetime" {
  description = "The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds"
  type        = number
  default     = null
}

variable "capacity_rebalance" {
  description = "Indicates whether capacity rebalance is enabled."
  type        = bool
  default     = null
}

# ASG instance refresh variables
variable "asg_instance_refresh_strategy" {
  description = "The strategy to use for instance refresh. The only allowed value is `Rolling`."
  type        = string
  default     = null
}

variable "asg_instance_refresh_warmup" {
  description = "The number of seconds until a newly launched instance is configured and ready to use."
  type        = number
  default     = null
}

variable "asg_instance_refresh_healthy_percentage" {
  description = "The amount of capacity in the Auto Scaling group that must remain healthy during an instance refresh to allow the operation to continue, as a percentage of the desired capacity of the Auto Scaling group."
  type        = number
  default     = null
}

variable "asg_instance_refresh_additional_triggers" {
  description = "Set of additional property names that will trigger an Instance Refresh. A refresh will always be triggered by a change in any of launch_configuration, launch_template, or mixed_instances_policy."
  type        = list(string)
  default     = null
}
