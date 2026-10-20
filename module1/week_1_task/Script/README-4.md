# SEIR Foundations: Module 1, Lab 0 Homework

**Student:** YOUR NAME
**Submitted:** DATE
**AWS Region used:** us-east-1 (N. Virginia)
**Availability Zone:** us-east-1c (all three deployments)
**Instance type used:** t3.micro
**AMI:** Amazon Linux 2023

---

## 1. Evidence Table

| Deployment | Public IPv4 address | Connection method | Screenshot | Instance terminated? |
|---|---|---|---|---|
| 1 | `34.233.124.132` | SSH client (ec2-user) | `screenshots/deployment-1.png`; `screenshots/deployment-1b.png` | Yes |
| 2 | `54.90.129.188` | EC2 Instance Connect (browser) | `screenshots/deployment-2.png` | Yes |
| 3 | `50.19.157.55` | EC2 Instance Connect (browser) | `screenshots/deployment-3.png` | Yes |

| Deployment | Instance ID | Private hostname |
|---|---|---|
| 1 | `i-093bbf4e1a8e3ab4c` | `ip-172-31-30-250.ec2.internal` |
| 2 | `i-02a43ba7101c8fd75` | `ip-172-31-18-11.ec2.internal` |
| 3 | `i-0c6bb5bbf245e7d67` | `ip-172-31-19-13.ec2.internal` |

**Distinct IP check:** All three public IPv4 addresses are different: **YES**.

Deployment 1's public IP is taken from its public DNS name (`ec2-34-233-124-132.compute-1.amazonaws.com`) used in the SSH command. Deployments 2 and 3 show the public IP in the AWS Console footer of the screenshot.

CONSOLE SCREENSHOT FOR DEPLOYMENT 1 (optional): `screenshots/deployment-1-console.png`

---

## 2. Deployment Descriptions

### Deployment 1
I launched a t3.micro Amazon Linux 2023 instance in us-east-1c from my saved launch template. After it passed its status checks I connected from my Windows machine using Git Bash and the SSH client method, with the command `ssh -i "PVkey-1.pem" ec2-user@ec2-34-233-124-132.compute-1.amazonaws.com`. The login showed the Amazon Linux 2023 banner and the SEIR Chewbacca Operations Center dashboard. It reported uptime of 45 minutes, 0% CPU busy on 2 vCPUs, a load average of 0.00 for all three intervals, 156Mi of 913Mi memory used, and 1.6G of 8.0G root disk used (20% full). The instance ID was `i-093bbf4e1a8e3ab4c`.

![Deployment 1 banner and top of dashboard](screenshots/deployment-1.png)
![Deployment 1 instance details](screenshots/deployment-1b.png)

### Deployment 2
I launched a second t3.micro instance from the same template and connected through the browser-based EC2 Instance Connect option as `ec2-user`. The dashboard showed uptime of 19 minutes, 0% CPU busy on 2 vCPUs, a load average of 0.00, 160Mi of 913Mi memory used, and 1.6G of 8.0G disk used (20% full). The console footer confirmed instance `i-02a43ba7101c8fd75` with public IP `54.90.129.188` and private IP `172.31.18.11`.

![Deployment 2](screenshots/deployment-2.png)

### Deployment 3
I launched a third t3.micro instance from the template and again connected with EC2 Instance Connect. The dashboard showed uptime of 31 minutes, 0% CPU busy on 2 vCPUs, a load average of 0.00, 150Mi of 913Mi memory used, and 1.6G of 8.0G disk used (20% full). The console footer confirmed instance `i-0c6bb5bbf245e7d67` with public IP `50.19.157.55` and private IP `172.31.19.13`.

![Deployment 3](screenshots/deployment-3.png)

---

## 3. What the Dashboard Tells Me

- **CPU:** All three instances showed about 0% busy because nothing was running except the login. The dashboard samples `/proc/stat` over 0.2 seconds, so it is an approximate snapshot, not an average.
- **vCPUs:** Each t3.micro has 2 virtual CPUs.
- **Memory:** Each instance had 913Mi total, with 150 to 160Mi used by the operating system and background services, so most RAM was free.
- **Disk:** The 8.0G root volume was 20% full (1.6G used), which is the base Amazon Linux 2023 install.
- **Uptime:** It reads in minutes because these were newly launched instances, and it counts time since boot, not time since I logged in.
- **Load average:** It was 0.00 at 1, 5, and 15 minutes. This measures how many processes were waiting to run, which is a different measure from CPU percentage.

---

## 4. What Got Easier

YOUR ANSWER (one concrete thing, from your own experience across the three launches)

---

## 5. Errors and Fixes

| Error / symptom | What I tried | How it was fixed |
|---|---|---|
| YOUR ENTRY, or write "None" | | |

Note: My SSH session in Deployment 1 displayed a warning that the connection was not using a post-quantum key exchange algorithm. It is an informational notice from my local SSH client about the server's key exchange settings, and the connection still succeeded.

---

## 6. Cleanup Confirmation

- [ ] All three instances show **Terminated**
- [ ] No leftover volumes or Elastic IPs that I created
- [ ] Launch template `seir-foundations-lab0` is still saved
- [ ] No private keys, passwords, or tokens appear in screenshots or this README

CLEANUP SCREENSHOT (optional): `screenshots/cleanup-instances-terminated.png`

---

## 7. Notes on AI Use

YOUR NOTE (for example: "I used an AI assistant to help organize my README and explain the dashboard metrics. I performed all three launches and connections myself.")
