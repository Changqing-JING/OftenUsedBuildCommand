# ADB Connection via HTTP Proxy

## Problem

Connect to a remote ADB server through an HTTP proxy when direct connection is not available.

## Solution: Using socat as a TCP tunnel

### Prerequisites

```bash
sudo apt install socat
```

### Step 1: Create the tunnel

```bash
socat TCP-LISTEN:5555,fork,reuseaddr PROXY:<proxy_host>:<remote_adb_host>:<remote_adb_port>,proxyport=<proxy_port> &
```

**Example:**

```bash
socat TCP-LISTEN:5555,fork,reuseaddr PROXY:127.0.0.1:adb.sdv-lab-prod.eu-central-1.aws.cloud.bmw:2052,proxyport=8080 &
```

### Step 2: Connect ADB to the local tunnel

```bash
adb connect 127.0.0.1:5555
```

### Step 3: Use ADB normally

```bash
adb devices
adb shell
```

### To stop the tunnel

```bash
pkill -f "socat TCP-LISTEN:5555"
```

---

## Why proxychains didn't work

HTTP proxies use the CONNECT method which can interfere with ADB's binary protocol handshake. Socat handles raw TCP tunneling more reliably through HTTP CONNECT proxies.

## Quick Reference

| Parameter  | Value                                            |
| ---------- | ------------------------------------------------ |
| Local port | 5555                                             |
| Proxy host | 127.0.0.1                                    |
| Proxy port | 8080                                             |
| Remote ADB | adb.sdv-lab-prod.eu-central-1.aws.cloud.bmw:2052 |

## One-liner

```bash
# Start tunnel and connect
socat TCP-LISTEN:5555,fork,reuseaddr PROXY:127.0.0.1:adb.sdv-lab-prod.eu-central-1.aws.cloud.bmw:2052,proxyport=8080 & sleep 1 && adb connect 127.0.0.1:5555
```
