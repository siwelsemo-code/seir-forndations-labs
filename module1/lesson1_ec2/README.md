# Lesson 1 — EC2 (Balerica Legacy Bank)

Lesson 1 lab (Steps 0–4) completed seven times, each on a brand-new EC2 instance built by hand.
Every screenshot shows the ID line run right before starting uvicorn:

```bash
whoami && TZ='America/Chicago' date && ec2-metadata -i && uptime -s
```

## Lab runs

| Run | Date | Time zone | Instance ID | Boot time (UTC) | Public IPv4 DNS | Screenshot | Terminated? |
|---|---|---|---|---|---|---|---|
| 1 | 2026-10-31 | America/Chicago | i-00192094d353bb0b3 | 2026-11-01 00:41:01 | ec2-98-94-91-210.compute-1.amazonaws.com | [lab1_run1.jpg](lab1_run1.jpg) | Yes |
| 2 | 2026-10-31 | America/Chicago | i-013b43ebbf98ca97f | 2026-11-01 02:10:59 | ec2-54-82-37-189.compute-1.amazonaws.com | [lab1_run2.jpg](lab1_run2.jpg) | Yes |
| 3 | 2026-10-31 | America/Chicago | i-00008bb9a35643a45 | 2026-11-01 03:20:57 | ec2-3-85-134-239.compute-1.amazonaws.com | [lab1_run3.jpg](lab1_run3.jpg) | Yes |
| 4 | 2026-11-01 | America/Chicago | i-08326b4d50e2dbc7d | 2026-11-01 11:50:08 | ec2-107-23-170-128.compute-1.amazonaws.com | [lab1_run4.jpg](lab1_run4.jpg) | Yes |
| 5 | 2026-11-01 | America/Chicago | i-004ecf6f15c83114a | 2026-11-01 13:15:03 | ec2-3-92-21-22.compute-1.amazonaws.com | [lab1_run5.jpg](lab1_run5.jpg) | Yes |
| 6 | 2026-11-01 | America/Chicago | i-05fce1159dfefc2e1 | 2026-11-01 14:21:27 | ec2-52-23-239-157.compute-1.amazonaws.com | [lab1_run6.jpg](lab1_run6.jpg) | Yes |
| 7 | 2026-11-02 | America/Chicago | i-04d9233af4b7abe58 | 2026-11-02 21:37:25 | ec2-18-234-51-91.compute-1.amazonaws.com | [lab1_run7.jpg](lab1_run7.jpg) | Yes |

## Notes

- [lab1_notes.md](lab1_notes.md) — per-run notes, COBOL practice, mistakes, commands I know by heart

## COBOL practice

| Return code | Meaning | Screenshot |
|---|---|---|
| 0 | Success | [cobol_rc0.jpg](cobol_rc0.jpg) |
| 4 | Account not found | [cobol_rc4.jpg](cobol_rc4.jpg) |
| 8 | Business rejection (zero-amount payment) | [cobol_rc8.jpg](cobol_rc8.jpg) |
| 12 | Environment failure (wrong folder) | [cobol_rc12.jpg](cobol_rc12.jpg) |
| — | Ledger decoded by hand with `cut -c` | [cobol_ledger_decode.jpg](cobol_ledger_decode.jpg) |

## Git

- [git_clone.jpg](git_clone.jpg) — HW repo cloned onto EC2 and `module1` listed (clone only, no push, no token on the server)

## Written work

- [ai_review_EmonieLewis.txt](ai_review_EmonieLewis.txt)
- [spotter_EmonieLewis.txt](spotter_EmonieLewis.txt)
- [AI_enabled_study_lab1.0.txt](AI_enabled_study_lab1.0.txt)

## Udemy (Maarek)

- [Maarek_Section21_quiz.jpg](Maarek_Section21_quiz.jpg)
- [Maarek_Section23_quiz.jpg](Maarek_Section23_quiz.jpg)
- [Maarek_Section25_quiz.jpg](Maarek_Section25_quiz.jpg)
