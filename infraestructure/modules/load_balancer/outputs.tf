output "alb_dns" {
  value = aws_alb.my_alb.dns_name
}

output "alb_zone_id" {
  value = aws_alb.my_alb.zone_id
}

output "alb_tg_arn" {
  value = aws_lb_target_group.my_alb_tg.arn
}