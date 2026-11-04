# Lab 1 Notes — Balerica Legacy Bank on EC2

## Run 1 — i-00192094d353bb0b3

- **What changed:** First run. Launched by hand, ran the installer, started uvicorn.
- **Errors and fixes:** My first screenshot didn't have the ID line, so I stopped uvicorn, ran the ID line, and restarted it. I also tried to upgrade pip with `opt/balerica-bank/...` (no leading `/`), so bash looked for a relative path and failed. Pip needed to be upgraded before the run command would start the bank, so I ran `/opt/balerica-bank/venv/bin/python3 -m pip install --upgrade pip` and then `uvicorn app.main:app --host 0.0.0.0 --port 8000`.
- **What I newly understood:** A path starting with `/` is absolute (from the root); without it, it's relative to the folder I'm in.
- **Exact output line (this run only):**
  ```
  -bash: opt/balerica-bank/venv/bin/python3: No such file or directory
  INFO:     Started server process [39039]
  ```

## Run 2 — i-013b43ebbf98ca97f

- **What changed:** Second fresh instance, same day.
- **Errors and fixes:** I ran `./cobol/bin/payment_post` from my home folder (`~`) and bash couldn't find it. Fixed with `cd /opt/balerica-bank`. Pip needed to be upgraded before the run command would start the bank, so I ran `/opt/balerica-bank/venv/bin/python3 -m pip install --upgrade pip` and then `uvicorn app.main:app --host 0.0.0.0 --port 8000`.
- **What I newly understood:** `./` means "start from the folder I'm in now", so commands that begin with `./` only work from the right folder.
- **Exact output line (this run only):**
  ```
  -bash: ./cobol/bin/payment_post: No such file or directory
  INFO:     Started server process [37948]
  ```

## Run 3 — i-00008bb9a35643a45

- **What changed:** Third run of the day. Significant changes: the run instance ID and the PID updated.
- **Errors and fixes:** Pip needed to be upgraded before the run command would start the bank, so I ran `/opt/balerica-bank/venv/bin/python3 -m pip install --upgrade pip` and then `uvicorn app.main:app --host 0.0.0.0 --port 8000`.
- **What I newly understood:** The server clock is UTC. My 10:32 PM CDT screenshot was already Nov 1 in UTC, so the boot time looks like "tomorrow".
- **Exact output line (this run only):**
  ```
  INFO:     Started server process [35462]
  ```

## Run 4 — i-08326b4d50e2dbc7d

- **What changed:** First run on Nov 1. Daylight saving time ended overnight, so `date` now shows CST (UTC−6) instead of CDT (UTC−5).
- **Errors and fixes:** I ran uvicorn before activating the venv, so bash couldn't find it. Fixed with `source venv/bin/activate`. The pip upgrade worked this time because I used the full `/opt/...` path. Pip needed to be upgraded before the run command would start the bank, so I ran `/opt/balerica-bank/venv/bin/python3 -m pip install --upgrade pip` and then `uvicorn app.main:app --host 0.0.0.0 --port 8000`.
- **What I newly understood:** uvicorn lives inside the virtual environment; `(venv)` in the prompt shows it's active.
- **Exact output line (this run only):**
  ```
  -bash: uvicorn: command not found
  Successfully installed pip-26.0.1
  INFO:     Started server process [35465]
  ```
- **Git:** Cloned my HW repo over HTTPS and listed `module1` (`git_clone.jpg`). My first try used the placeholder URL, and GitHub asked for credentials, so I stopped. Clone only, no push, no token on the server.
  ```
  Receiving objects: 100% (62/62), 5.78 MiB | 50.57 MiB/s, done.
  ```

## Run 5 — i-004ecf6f15c83114a

- **What changed:** I used this instance for all the COBOL practice.
- **Errors and fixes:** I cloned the repo a second time into the same folder and git refused. To update an existing clone you `git pull` instead. Pip needed to be upgraded before the run command would start the bank, so I ran `/opt/balerica-bank/venv/bin/python3 -m pip install --upgrade pip` and then `uvicorn app.main:app --host 0.0.0.0 --port 8000`.
- **What I newly understood:** Ensure the command line is correct.
- **Exact output line (this run only):**
  ```
  fatal: destination path 'seir-forndations-labs' already exists and is not an empty directory.
  INFO:     Started server process [35693]
  ```

## Run 6 — i-05fce1159dfefc2e1

- **What changed:** Third run on Nov 1. The pip upgrade (with the full `/opt/...` path) and the COBOL lookup both worked on the first try.
- **Errors and fixes:** Pip needed to be upgraded before the run command would start the bank, so I ran `/opt/balerica-bank/venv/bin/python3 -m pip install --upgrade pip` and then `uvicorn app.main:app --host 0.0.0.0 --port 8000`.
- **What I newly understood:** Only lab-run screenshots count toward the 3-per-day limit. Launching an instance doesn't count by itself, and restarting uvicorn on the same instance is still the same run.
- **Exact output line (this run only):**
  ```
  INFO:     Started server process [46679]
  ```

## Run 7 — i-04d9233af4b7abe58

- **What changed:** Last run, on Nov 2. I checked the COBOL lookups (rc 0 and rc 4) before starting uvicorn.
- **Errors and fixes:** Pip needed to be upgraded before the run command would start the bank, so I ran `/opt/balerica-bank/venv/bin/python3 -m pip install --upgrade pip` and then `uvicorn app.main:app --host 0.0.0.0 --port 8000`.
- **What I newly understood:** Ensure the command line is correct.
- **Exact output line (this run only):**
  ```
  INFO:     Started server process [35549]
  ```

---

## COBOL practice

**Run 5, Instance ID `i-004ecf6f15c83114a`, in `/opt/balerica-bank`.**
(rc12 was taken on Run 4, `i-08326b4d50e2dbc7d`.)

### Return code 0 — success (`cobol_rc0.jpg`)
```
$ ./cobol/bin/payment_post TXN-EL-0002 100001 25.00 USD INV-2002; echo $?
STATUS=POSTED
REASON=APPROVED
0
```

### Return code 4 — account not found (`cobol_rc4.jpg`)
```
$ ./cobol/bin/account_lookup 999999; echo $?
ERROR=ACCOUNT NOT FOUND
ACCOUNT=999999
4
```

### Return code 8 — business rejection (`cobol_rc8.jpg`)
```
$ ./cobol/bin/payment_post TXN-EL-0003 100001 0.00 USD INV-2003; echo $?
STATUS=REJECTED
REASON=AMOUNT MUST BE GREATER THAN ZERO
8
```

### Return code 12 — environment failure (`cobol_rc12.jpg`)
Ran from `~` using the full path, so the program started but couldn't find its relative `data/accounts.dat` file.
```
$ /opt/balerica-bank/cobol/bin/account_lookup 100001; echo $?
ERROR=CANNOT OPEN data/accounts.dat
FILE-STATUS=35
12
```
COBOL file status 35 means "file not found".

### Alice's balance, decoded by hand (`cobol_ledger_decode.jpg`)
```
$ grep -i alice data/accounts.dat | cut -c45-56
000000500000
```

| Positions | Field | Alice |
|---|---|---|
| 1–6 | Account | `100001` |
| 7–36 | Name | `Alice Johnson` |
| 37–42 | Status | `ACTIVE` |
| 45–56 | Balance | `000000500000` → **$5,000.00** (last 2 digits are cents) |
| 57–59 | Currency | `USD` |

### Journal lines for my TXN IDs
```
$ grep TXN-EL data/payments.dat
TXN-EL-0001         1000010000000012550US DPOSTED  INV-1001
TXN-EL-0001         1000010000000002500US DPOSTED  INV-2001
TXN-EL-0003         1000010000000000000US DREJECTEDINV-2003
TXN-EL-0002         1000010000000002500US DPOSTED  INV-2002
TXN-EL-0002         1000010000000002500US DPOSTED  INV-2002
TXN-EL-0002         1000010000000002500US DPOSTED  INV-2002
TXN-EL-0003         1000010000000000000US DREJECTEDINV-2003
TXN-EL-0003         1000010000000000000US DREJECTEDINV-2003
```

⚠️ **NEEDS ATTENTION:** Check the `US D` spacing against `cobol_ledger_decode.jpg` or your terminal. Real fixed-width output usually prints `USDPOSTED` with no space, and these lines must be pasted exactly.

Each journal line reads: TXN ID (cols 1–20), account `100001`, amount in cents (`0000000012550` = 125.50), currency, status, invoice.

### Did the balance change? **No.**
```
$ ./cobol/bin/account_lookup 100001
BALANCE=5000.00
```
- Alice still shows $5,000.00 after five approved payments ($125.50 + $25.00 × 4). `payment_post` writes to the journal (`payments.dat`) but doesn't update the ledger (`accounts.dat`). The installer exports the ledger from the database once ("exported 3 account(s) to data/accounts.dat").
- **Rejected payments are journaled too**, with status `REJECTED`.
- **No duplicate check:** the same TXN ID (`TXN-EL-0001`, `TXN-EL-0002`) was posted more than once and approved every time. A real bank would reject a repeated transaction ID.

---

## Mistakes I made

- Left off the leading `/` in `/opt/...`, so bash treated it as a relative path.
- Ran `./cobol/...` from `~` instead of `/opt/balerica-bank`.
- Ran uvicorn before `source venv/bin/activate`.
- Took screenshots without the ID line, or with the ID line in the wrong place.
- Typed placeholder text literally (`YOUR-USERNAME`, `TXN-XX-...`) instead of real values.
- Reused TXN IDs, which made the journal confusing.
- Cut the wrong columns at first (`cut -c31-43` printed `ACTIVE`, not the balance).

## Commands I now know by heart

```bash
whoami && TZ='America/Chicago' date && ec2-metadata -i && uptime -s
cd /opt/balerica-bank
source venv/bin/activate
uvicorn app.main:app --host 0.0.0.0 --port 8000
./cobol/bin/account_lookup 100001; echo $?
./cobol/bin/payment_post TXN-EL-0002 100001 25.00 USD INV-2002; echo $?
grep -i alice data/accounts.dat | cut -c45-56
git clone https://github.com/siwelsemo-code/seir-forndations-labs.git
```
