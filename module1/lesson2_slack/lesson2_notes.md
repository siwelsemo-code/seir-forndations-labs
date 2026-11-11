# Lesson 2 Notes — Seven Alerts, Seven Wins (Balerica AI → Slack)

**Name:** Emonie Lewis
**Workspace:** https://siwelsemo.slack.com · **Channel:** `#balerica-alerts` · **App:** Balerica
**Instance (homework runs):** `i-03c666c65ca33381e` · **Instance (experiments):** `i-0c776df996650a270` (GRP_bnk_6, us-west-2)

> Lines marked ✍️ are for me to fill in or rewrite in my own words.

---

## Evidence

| Screenshot | Shows |
|---|---|
| `slack_alerts.jpg` | `#balerica-alerts` with alerts from hw1–hw6 (HW-001 to HW-005, DRILL) |
| `hw7_morning_report.jpg` | ID line + `python hw7_morning_report.py` → `Delivered!` |
| `experiments.jpg` | Experiments 1–4 on `i-0c776df996650a270`: CRITICAL filter, kill switch, threshold 20, settings restored |

---

## Script answers ("In your notes:" questions)

### hw1 — hello Slack (HW-001)
- Sent: "Hello from Emonie Lewis! I sent this alert myself, from my own EC2 instance."
- ✍️ What I learned:

### hw2 — severity tour (HW-002)
- **Q: Which severities arrived, and WHY those?**
- ✍️ Answer: All four (INFO, WARNING, ERROR, CRITICAL) arrived because `SLACK_ALERT_SEVERITY=INFO` is the lowest level, and the filter only skips alerts below the threshold.

### hw3 — server time (HW-003)
- Output: `Thursday November 05, 2026 at 19:46:43 UTC`
- **Q: How many hours apart are server time and YOUR wall clock?**
- ✍️ Answer: 6 hours. My ID line showed 14:01 CST while the server said 20:01 UTC. Servers use UTC so logs from every region line up.

### hw4 — disk watch (HW-004)
- Output: `Disk is 25.3% used -> severity INFO` (5.9 GB free)
- **Q: Why is a quiet INFO here GOOD design, not a failure?**
- ✍️ Answer:

### hw5 — load check (HW-005)
- Output: `Load: 0.09 / 0.03 / 0.01 on 2 CPU(s) -> INFO`
- **Q: What would make this number spike on the Balerica bank?**
- ✍️ Answer:

### hw6 — incident drill (DRILL-5072, DRILL-9079)
- Drew: `DRILL-5072 [ERROR] payment_post returned code 8` and `DRILL-9079 [INFO] Nightly ledger backup completed`
- **Q: Which of these fake incidents deserves to wake a human at 3 AM?**
- ✍️ Answer:

### hw7 — morning report (HW-007)
- Disk 25.3% used, load 0.00, Python 3.9.25, `Status: all checks ran.` → `Delivered!`
- ✍️ What I learned:

---

## Experiments

### Experiment 1 — `SLACK_ALERT_SEVERITY=CRITICAL`, rerun hw2
- **Prediction (written before running):** 3 of the 4 alerts will arrive in Slack.
- **Result:** 1 of 4 arrived (only CRITICAL). Terminal: `INFO -> skipped`, `WARNING -> skipped`, `ERROR -> skipped`, `CRITICAL -> DELIVERED to Slack`.
- ✍️ **Was my prediction right? Why / why not:**

### Experiment 2 — `SLACK_ALERTS_ENABLED=false`, run hw1
- **Prediction:** ✍️
- **What happened:** `Skipped. Check .env: SLACK_ALERTS_ENABLED must be true and SLACK_ALERT_SEVERITY=INFO (see homework README).` Nothing new arrived in Slack.
- ✍️ **Why a kill switch is useful during maintenance windows:**

### Experiment 3 — hw4 WARNING threshold 75 → 20, rerun hw4
- My disk usage: 25.4%
- **Prediction:** ✍️
- **Result:** `Disk is 25.4% used -> severity WARNING.` `Delivered!` The severity changed from INFO to WARNING with no change to the disk.
- ✍️ **Why:**

### Experiment 4 — put everything back
- [x] `SLACK_ALERT_SEVERITY=INFO`
- [x] `SLACK_ALERTS_ENABLED=true`
- [x] hw4 threshold back to 75 (`>= 90` ERROR, `>= 75` WARNING)
- ✍️ What this showed me (configuration changes behavior without touching code):

---

## Mistakes I made
- Pasted the webhook into the nano command, so nano used it as the file name.
- A screenshot showed my real webhook → I revoked it and created a new one (rotation).
- The webhook was pasted twice on one line, and later lost the `h` in `https`.
- Ran commands from the wrong folder / before the bank was installed on a new instance.
- Ran the homework setup as `root`, so `~/SEIR-Foundations` pointed at `/root`.
- ✍️

## Commands I now know by heart
```bash
cd /opt/balerica-bank && source venv/bin/activate
python slack.py --test
python hw2_severity_tour.py
sed -i 's/^SLACK_ALERT_SEVERITY=.*/SLACK_ALERT_SEVERITY=CRITICAL/' .env
grep -E "ENABLED|SEVERITY" .env
whoami && TZ='America/Chicago' date && ec2-metadata -i
```
