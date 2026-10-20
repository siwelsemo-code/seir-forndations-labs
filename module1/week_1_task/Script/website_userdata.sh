#!/bin/bash
# EC2 User Data: Apache + PHP website with 3 pages (Amazon Linux 2023)
#   index.html      - static home page, shows Instance ID and Availability Zone
#   about.html      - static about page
#   calculator.php  - dynamic page, PHP does + - * / on the server
# Paste this entire file into EC2 > Advanced details > User data.

exec > /var/log/website-userdata.log 2>&1   # log everything for troubleshooting
set -x

# 1. Install and start Apache + PHP
dnf install -y httpd php
systemctl enable --now php-fpm
systemctl enable --now httpd

# 2. Look up instance ID and AZ (IMDSv2), retrying while the network comes up
TOKEN=""
for i in 1 2 3 4 5; do
  TOKEN=$(curl -fsS -X PUT "http://169.254.169.254/latest/api/token" \
    -H "X-aws-ec2-metadata-token-ttl-seconds: 300") && break
  sleep 2
done
meta() { curl -fsS -H "X-aws-ec2-metadata-token: $TOKEN" \
  "http://169.254.169.254/latest/meta-data/$1" 2>/dev/null || echo "unavailable"; }
INSTANCE_ID=$(meta instance-id)
AZ=$(meta placement/availability-zone)

cd /var/www/html

# 3. Shared stylesheet
cat > style.css <<'CSS'
/* Air Force-inspired palette: USAF blue, dark navy, silver, white, gold accent */
:root { --af-blue:#00308F; --af-navy:#001A4D; --af-silver:#C5CBD3; --af-light:#EEF1F5; --af-gold:#FFC72C; }
body { font-family: Arial, Helvetica, sans-serif; margin: 0; background: var(--af-light); color: #1a1a1a; }
nav { background: var(--af-navy); padding: 14px 24px; border-bottom: 4px solid var(--af-gold); }
nav a { color: #fff; text-decoration: none; margin-right: 22px; font-weight: bold; text-transform: uppercase; letter-spacing: .5px; font-size: 14px; }
nav a:hover { color: var(--af-gold); }
main { max-width: 720px; margin: 32px auto; background: #fff; padding: 28px 32px;
       border-top: 6px solid var(--af-blue); box-shadow: 0 1px 4px rgba(0,0,0,.25); }
h1 { margin-top: 0; color: var(--af-blue); text-transform: uppercase; letter-spacing: 1px; }
a { color: var(--af-blue); }
table { border-collapse: collapse; margin: 16px 0; }
td, th { border: 1px solid var(--af-silver); padding: 8px 14px; text-align: left; }
th { background: var(--af-blue); color: #fff; }
input, select, button { font-size: 16px; padding: 8px; margin: 4px 2px; border: 1px solid var(--af-silver); }
button { background: var(--af-blue); color: #fff; border: 0; cursor: pointer; text-transform: uppercase; font-weight: bold; }
button:hover { background: var(--af-navy); color: var(--af-gold); }
.result { font-size: 20px; margin-top: 18px; padding: 12px; background: #e6ecf7; border-left: 5px solid var(--af-blue); }
.error { background: #fdecea; border-left-color: #b00020; }
footer { text-align: center; color: #fff; background: var(--af-navy); font-size: 13px; padding: 14px; border-top: 4px solid var(--af-gold); }
CSS

# 4. Home page (static HTML; values are written in once, at boot)
cat > index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head><meta charset="utf-8"><title>Home | My EC2 Website</title>
<link rel="stylesheet" href="style.css"></head>
<body>
<nav><a href="index.html">Home</a><a href="about.html">About</a><a href="calculator.php">Calculator</a></nav>
<main>
  <h1>Welcome to my EC2 website</h1>
  <p>This page is served by Apache running on an Amazon EC2 instance, built entirely from a User Data script.</p>
  <table>
    <tr><th>Instance ID</th><td>${INSTANCE_ID}</td></tr>
    <tr><th>Availability Zone</th><td>${AZ}</td></tr>
  </table>
  <p>Try the <a href="calculator.php">calculator</a> to see a dynamic PHP page.</p>
</main>
<footer>SEIR Foundations</footer>
</body>
</html>
EOF

# 5. About page (static HTML)
cat > about.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="utf-8"><title>About | My EC2 Website</title>
<link rel="stylesheet" href="style.css"></head>
<body>
<nav><a href="index.html">Home</a><a href="about.html">About</a><a href="calculator.php">Calculator</a></nav>
<main>
  <h1>About this site</h1>
  <p>This small website was deployed automatically when the EC2 instance first booted.</p>
  <ul>
    <li><strong>Web server:</strong> Apache (httpd)</li>
    <li><strong>Language:</strong> PHP, for the calculator page</li>
    <li><strong>OS:</strong> Amazon Linux 2023</li>
    <li><strong>Deployed with:</strong> an EC2 User Data script</li>
  </ul>
  <p><strong>Static vs. dynamic:</strong> the Home and About pages are plain HTML files, so the server sends them
     exactly as stored. The Calculator page is PHP, so the server runs code and builds a new answer for each request.</p>
</main>
<footer>SEIR Foundations</footer>
</body>
</html>
EOF

# 6. Calculator page (dynamic PHP)
cat > calculator.php <<'EOF'
<?php
$result = null;
$error  = null;
$a = $_POST['a'] ?? '';
$b = $_POST['b'] ?? '';
$op = $_POST['op'] ?? 'add';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!is_numeric($a) || !is_numeric($b)) {
        $error = 'Please enter two valid numbers.';
    } else {
        $x = (float)$a;
        $y = (float)$b;
        switch ($op) {
            case 'add': $result = $x + $y; $sym = '+'; break;
            case 'sub': $result = $x - $y; $sym = '-'; break;
            case 'mul': $result = $x * $y; $sym = '&times;'; break;
            case 'div':
                $sym = '&divide;';
                if ($y == 0) { $error = 'Cannot divide by zero.'; }
                else         { $result = $x / $y; }
                break;
            default: $error = 'Unknown operation.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="utf-8"><title>Calculator | My EC2 Website</title>
<link rel="stylesheet" href="style.css"></head>
<body>
<nav><a href="index.html">Home</a><a href="about.html">About</a><a href="calculator.php">Calculator</a></nav>
<main>
  <h1>PHP Calculator</h1>
  <p>The math below is computed by PHP on the server, not in your browser.</p>
  <form method="post" action="calculator.php">
    <input type="text" name="a" value="<?= htmlspecialchars($a) ?>" placeholder="First number" required>
    <select name="op">
      <option value="add" <?= $op === 'add' ? 'selected' : '' ?>>+ add</option>
      <option value="sub" <?= $op === 'sub' ? 'selected' : '' ?>>- subtract</option>
      <option value="mul" <?= $op === 'mul' ? 'selected' : '' ?>>&times; multiply</option>
      <option value="div" <?= $op === 'div' ? 'selected' : '' ?>>&divide; divide</option>
    </select>
    <input type="text" name="b" value="<?= htmlspecialchars($b) ?>" placeholder="Second number" required>
    <button type="submit">Calculate</button>
  </form>

  <?php if ($error): ?>
    <div class="result error"><?= htmlspecialchars($error) ?></div>
  <?php elseif ($result !== null): ?>
    <div class="result"><?= htmlspecialchars((string)(float)$a) ?> <?= $sym ?> <?= htmlspecialchars((string)(float)$b) ?> = <strong><?= htmlspecialchars((string)round($result, 10)) ?></strong></div>
  <?php endif; ?>
  <p><small>Server time: <?= date('Y-m-d H:i:s T') ?></small></p>
</main>
<footer>SEIR Foundations</footer>
</body>
</html>
EOF

# 7. Permissions and restart
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html
systemctl restart php-fpm httpd

echo "Website deployed."
