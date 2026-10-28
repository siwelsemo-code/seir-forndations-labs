# SEIR Foundations — Module 1, Lab 0.5
## Basics Continued: Catch Up, Find Your Team, Prove Your Work

**Student:** YourNameHere
**Course:** SEIR Foundations
**Lab:** Module 1 / Lab 0.5 — Basics, Continued
**Lab instructions:** [Lab 0.5 README](https://github.com/BalericaAI/SEIR-Foundations/blob/main/module1/lab0_basics/lab0.5_README.md)

---

## Submission Summary

| Requirement | Evidence | Status |
|---|---|---|
| Group formed + group file submitted (all values filled in) | [`group_emonie_lewis.txt`](./group_emonie_lewis.txt) | ✅ |
| Lab repo follows Theo's format and naming convention | This repo | ✅ |
| Maarek Section 5 quiz completed | [`screenshots/Maarek_Section5_quiz.jpg`](./screenshots/Maarek_Section5_quiz.jpg) | ✅ |
| Maarek Section 6 quiz completed | [`screenshots/Maarek_Section6_quiz.jpg`](./screenshots/Maarek_Section6_quiz.jpg) | ✅ |

---

## 1. Group Verification (Required)

> ⚠️ A missing `group_emonie_lewis.txt`, or one with empty values, is an automatic failure for the week.

My group file is uploaded as [`group_emonie_lewis.txt`](./group_emonie_lewis.txt) with all three values completed:

```
Spotter = Carlos Eduardo
Teammates = Siwel_Louis, Tim Wolliston, Koffi_aleki, Carlos Eduardo
Days + Times when your team meets = M,W,F @ 8-11PM EST
```

| Role | Name |
|---|---|
| Spotter | Carlos Eduardo |
| Teammates | Siwel Louis, Tim Wolliston, Koffi Aleki, Carlos Eduardo |
| Meeting schedule | Monday, Wednesday, Friday · 8:00–11:00 PM EST |

- [x] Spotter filled in
- [x] Teammates filled in
- [x] Meeting days + times filled in

---

## 2. Udemy — Stéphane Maarek

Section videos were completed previously where applicable; quizzes were taken and screenshotted below.

| Section | Deliverable | File |
|---|---|---|
| Section 5 | Completed quiz screenshot | `Maarek_Section5_quiz.jpg` |
| Section 6 | Completed quiz screenshot | `Maarek_Section6_quiz.jpg` |

### Section 5 Quiz
![Maarek Section 5 Quiz](./screenshots/Maarek_Section5_quiz.jpg)

### Section 6 Quiz
![Maarek Section 6 Quiz](./screenshots/Maarek_Section6_quiz.jpg)

---

## 3. Other Assignments

**Reading**
- [ ] Bahga — pages 25–53 and 69–80
- [ ] SAA Exam Guide — chapters 1 and 4
- [ ] AWS Developer — chapters 2 and 5

**Videos**
- [ ] Maarek Section 3 (no quiz)
- [ ] [EC2 Instance Types | Your Ultimate Guide for AWS Certification!](https://youtu.be/NLcWdF3x0mw?si=9LXVWc3Q1ZwiijXp)
- [ ] [Git Bash, Bash Basics](https://www.youtube.com/watch?v=oQc-2gsjgDg)
- [ ] [Git Tutorial for Beginners: Learn Git in 1 Hour](https://www.youtube.com/watch?v=8JJ101D3knE)

---

## 4. "Be A Man" (BAM) Extra Credit

| Item | Requirement | Screenshot | Done? |
|---|---|---|---|
| BAM_1.1 | SSH from my own machine (not EC2 Instance Connect); `whoami` + `date` visible | [`screenshots/BAM_1.1.jpg`](./screenshots/BAM_1.1.jpg) | ✅ Yes |
| BAM_1.2 | Custom EC2 web page: thank-you line, dollar line, destination picture | [`screenshots/BAM_1.2.jpg`](./screenshots/BAM_1.2.jpg) | Yes / No |
| BAM_1.3 | Local SSH; `user_data` script displayed with `cat` | [`screenshots/BAM_1.3.jpg`](./screenshots/BAM_1.3.jpg) | Yes / No |

### BAM_1.1 — SSH from my own machine ✅

Connected to my EC2 instance from my own computer using Git Bash and a local SSH client (not EC2 Instance Connect).

```bash
ssh -i "my_bank.pem" ec2-user@ec2-98-89-40-87.compute-1.amazonaws.com
```

| Detail | Value |
|---|---|
| OS | Amazon Linux 2023 |
| Instance type | t3.small |
| AWS zone | us-east-1c |
| `whoami` output | `ec2-user` |
| `date` output | `Wed Oct 28 04:42:26 UTC 2026` |

![BAM 1.1](./screenshots/BAM_1.1.jpg)

### BAM_1.2 — Customized EC2 web page
![BAM 1.2](./screenshots/BAM_1.2.jpg)

### BAM_1.3 — User Data script
![BAM 1.3](./screenshots/BAM_1.3.jpg)

> No private keys, passwords, AWS access keys, or tokens are visible in any screenshot.

---

## 5. Repo Structure

```
seir-foundations-lab/
└── module1/
    ├── lab0_basics/
    └── lab0.5_basics_contd/
        ├── README.md
        ├── group_emonie_lewis.txt
        └── screenshots/
            ├── Maarek_Section5_quiz.jpg
            ├── Maarek_Section6_quiz.jpg
            ├── BAM_1.1.jpg      (extra credit)
            ├── BAM_1.2.jpg      (extra credit)
            └── BAM_1.3.jpg      (extra credit)
```

---

## Definition of Done

- [x] Found a spotter and formed a group
- [x] Uploaded `group_emonie_lewis.txt` with Spotter, Teammates, and meeting Days + Times filled in
- [ ] Repo follows Theo's format; earlier homework moved into it
- [ ] Uploaded `Maarek_Section5_quiz.jpg` and `Maarek_Section6_quiz.jpg`
- [ ] Completed readings and videos
- [ ] Committed and pushed everything to GitHub

**Extra credit**
- [x] `BAM_1.1.jpg` — local SSH session showing `whoami` and `date`
- [ ] `BAM_1.2.jpg` — customized EC2 web page
- [ ] `BAM_1.3.jpg` — `user_data` script displayed over local SSH
- [ ] Terminated unused EC2 instances and checked for leftover billable resources
