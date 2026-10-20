# SEIR Foundations: Module 1, Lab 0 Homework

**Student:** YOUR NAME
**Submitted:** DATE
**Due:** Tuesday, October 20, 2026, 12:00 PM Central
**AWS Region:** us-east-1 (N. Virginia)
**Availability Zone:** us-east-1c (all three deployments)
**Instance type:** t3.micro
**AMI:** Amazon Linux 2023

---

## 1. Current Status

| Item | Status |
|---|---|
| Three separate EC2 launches | Done |
| Three distinct public IPv4 addresses | Done |
| Connected to each instance (SSH / EC2 Instance Connect) | Done |
| SEIR dashboard screenshot for each deployment | Done |
| All three instances terminated | Done |
| README completed and screenshots pushed to GitHub | In progress |
| Repository link submitted to instructor | Not yet |
| Extra: EC2 website User Data script (see Section 7) | Script written, live test pending |

---

## 2. Evidence Table

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

---

## 3. Deployment Descriptions

### Deployment 1
I launched a t3.micro Amazon Linux 2023 instance in us-east-1c from my saved launch template. After it passed its status checks I connected from my Windows machine using Git Bash and the SSH client method: `ssh -i "PVkey-1.pem" ec2-user@ec2-34-233-124-132.compute-1.amazonaws.com`. The login showed the Amazon Linux 2023 banner and the SEIR Chewbacca Operations Center dashboard: uptime 45 minutes, 0% CPU busy on 2 vCPUs, load average 0.00, 156Mi of 913Mi memory used, and 1.6G of 8.0G root disk used (20% full). Instance ID: `i-093bbf4e1a8e3ab4c`.

![Deployment 1 banner and top of dashboard](screenshots/deployment-1.png)
![Deployment 1 instance details](screenshots/deployment-1b.png)

### Deployment 2
I launched a second t3.micro instance from the same template and connected through browser-based EC2 Instance Connect as `ec2-user`. The dashboard showed uptime 19 minutes, 0% CPU busy on 2 vCPUs, load average 0.00, 160Mi of 913Mi memory used, and 1.6G of 8.0G disk used (20% full). The console footer confirmed instance `i-02a43ba7101c8fd75`, public IP `54.90.129.188`, private IP `172.31.18.11`.

![Deployment 2](screenshots/deployment-2.png)

### Deployment 3
I launched a third t3.micro instance from the template and again connected with EC2 Instance Connect. The dashboard showed uptime 31 minutes, 0% CPU busy on 2 vCPUs, load average 0.00, 150Mi of 913Mi memory used, and 1.6G of 8.0G disk used (20% full). The console footer confirmed instance `i-0c6bb5bbf245e7d67`, public IP `50.19.157.55`, private IP `172.31.19.13`.

![Deployment 3](screenshots/deployment-3.png)

---

## 4. What the Dashboard Tells Me

- **CPU:** All three instances showed about 0% busy because nothing was running except the login. The dashboard samples `/proc/stat` over 0.2 seconds, so it is an approximate snapshot.
- **vCPUs:** Each t3.micro has 2 virtual CPUs.
- **Memory:** Each instance had 913Mi total, with 150 to 160Mi used by the operating system and services, so most RAM was free.
- **Disk:** The 8.0G root volume was 20% full (1.6G used), the base Amazon Linux 2023 install.
- **Uptime:** It reads in minutes because these were newly launched instances; it counts time since boot, not since login.
- **Load average:** 0.00 at 1, 5, and 15 minutes. This measures processes waiting to run, which is different from CPU percentage.

---

## 5. What Got Easier

Building an instance became easier as I came to understand what AWS and Bash are doing on the back end of the operating system. Errors were also easier to find, because the most common problem was making sure the IPv4 setting was configured correctly.

---

## 6. Errors and Fixes

Connection problems were the most common errors. These are the checks I worked through:

1. Make sure the correct security group is selected for the instance being launched.
2. Verify the IP version is IPv4.
3. Verify the inbound rule is SSH.
4. When copying and pasting the instance IP address and the existing `.pem` key name, watch for erroneous characters added after the paste.
5. Verify the key pair on the instance, in case it was not added to the launch template previously.
6. Before running the SSH connect command, verify I am in the correct directory and folder.

Note: My SSH session in Deployment 1 displayed a warning that the connection was not using a post-quantum key exchange algorithm. It is an informational notice from my local SSH client, and the connection still succeeded.

Note: The console labels on two instances ("hmwrk temp 3" and "LAUNCH3") are just names I gave them. The deployment numbers in the evidence table, which follow the IP addresses and connection methods, are what count.

---

## 7. Extra Work: EC2 Custom Website (Apache + PHP)

Beyond the lab, I wrote a User Data script, `website_userdata.sh`, that builds a three-page website on first boot.

| Page | File | Type | What it does |
|---|---|---|---|
| Home | `index.html` | Static | Shows the instance ID and Availability Zone |
| About | `about.html` | Static | Describes the stack; explains static vs. dynamic |
| Calculator | `calculator.php` | Dynamic | PHP computes + - x / on the server, with input validation and divide-by-zero handling |

- The script installs Apache and PHP, reads instance metadata through IMDSv2, writes the site files into `/var/www/html`, and logs to `/var/log/website-userdata.log`.
- The pages share `style.css`, using an Air Force-inspired color scheme (Air Force blue, dark navy, gold accents, silver and white).
- To view the site, the security group needs an inbound **HTTP (TCP 80)** rule, and the URL must start with `http://`.
- **Status:** the script passes a syntax check but has not yet been tested on a live instance. Add screenshots of each page here once it has been.

Details are in `README_website.md`.

---

## 8. Cleanup Confirmation

- [x] All three instances show **Terminated**
- [ ] No leftover volumes or Elastic IPs that I created
- [ ] Launch template `seir-foundations-lab0` is still saved
- [ ] No private keys, passwords, or tokens appear in screenshots or this README
- [ ] AWS account ID and IAM username cropped from console screenshots

---

## 9. Repository Layout

```text
module1/lab0_basics/
├── README.md
├── README_website.md
├── website_userdata.sh
├── lab0_evidence_table.xlsx
└── screenshots/
    ├── deployment-1.png
    ├── deployment-1b.png
    ├── deployment-2.png
    └── deployment-3.png
```

Do not commit `PVkey-1.pem` or any other `.pem` file. Add `*.pem` to a `.gitignore` file.

---

## 10. Notes on AI Use

I used AI to help organize this README. It also helped with the website pages described in Section 7: the Home page is the welcome page and displays the Instance ID and Availability Zone, and the About page displays the web server, the language, the operating system, and the AWS product used to deliver the site.
