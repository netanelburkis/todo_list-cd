resource "aws_lb" "alb" {
    name               = var.alb_name
    load_balancer_type = "application"
    security_groups    = aws_security_group.alb_security_group.id
    subnets            = var.subnet_ids
}

resource "aws_lb_listener" "lb_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            message_body  = "404 Not Found"
            status_code   = 404
        }
    }
}

resource "aws_lb_listener_rule" "alb_listener_rule" {
    listener_arn = aws_lb_listener.lb_listener.arn
    priority     = 100

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.alb_target_group.arn
    }

    condition {
        path_pattern {
            values = ["/*"]
        }
    }
}

resource "aws_lb_target_group" "alb_target_group" {
    name     = "${var.alb_name}-target-group"
    port     = 5000
    protocol = "HTTP"
    vpc_id   = var.vpc_id

    health_check {
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold  = 2
        unhealthy_threshold = 2
    }
}

resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
    count              = length(var.instance_id)
    target_group_arn   = aws_lb_target_group.alb_target_group.arn
    target_id          = var.instance_id[count.index]
    port               = 5000

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_security_group" "alb_security_group" {
    name        = "${var.alb_name}-sg"
    vpc_id     = var.vpc_id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}