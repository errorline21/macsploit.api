#!/usr/bin/env python3

import argparse
import secrets
import sys
from datetime import datetime, timezone


APP_NAME = "Macsploit.api"
APP_VERSION = "0.1.0"


def print_banner():
    print()
    print("=" * 42)
    print(f"  {APP_NAME} Agent")
    print(f"  Version {APP_VERSION}")
    print("=" * 42)
    print()


def run_status():
    print(f"Application: {APP_NAME}")
    print(f"Version: {APP_VERSION}")
    print("Status: Ready")
    print("Network: Disabled")
    print("Remote access: Disabled")
    print("Background service: Disabled")


def run_pairing_code():
    code = secrets.token_urlsafe(24)

    print("A temporary pairing code has been generated.")
    print("Use it only for a future, explicitly authorized pairing.")
    print()
    print(f"Pairing code: {code}")
    print()
    print("This prototype does not transmit or validate the code.")
    print("No remote connection has been opened.")


def main():
    if sys.platform != "darwin":
        print("Error: Macsploit.api requires macOS.")
        return 1

    parser = argparse.ArgumentParser(
        description="Macsploit.api local agent prototype"
    )

    parser.add_argument(
        "command",
        choices=("status", "pair"),
        nargs="?",
        default="status",
        help="Run a status check or generate a temporary pairing code",
    )

    args = parser.parse_args()

    print_banner()

    if args.command == "status":
        run_status()
    elif args.command == "pair":
        run_pairing_code()

    print()
    print(
        "Time:",
        datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC"),
    )

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
