<!--
SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>

SPDX-License-Identifier: MIT
-->

# An netboot installer example

This is an netboot installer example, using [snowboot](https://git.mbosch.me/linus/snowboot) and inspired from [snowboot-lab](https://git.mbosch.me/linus/snowboot-lab). 
A big thanks to [Linus Heckemann](http://github.com/lheckemann) for the inspiration.

You can use this setup for two purposes:

- development
- mass installation via a central provisioning node

## Requirements for the server

The central node that serves the netboot payloads needs to have:

- `udp/67`, `udp/69` open
- `tcp/8000` open
- a valid source IPv4 on the LAN segment

## Requirements for the client

This setup has been successfully tested on:

- a ThinkPad X280 with a modern iPXE with cdc-ncm drivers (i.e. USB-A<->USB-C adapter for Ethernet), the modern iPXE was booted from another USB stick.

## Quick start

- `sudo nixos-firewall-tool udp/67`
- `sudo nixos-firewall-tool udp/69`
- `sudo nixos-firewall-tool tcp/8000`
- `sudo hivemind`
- Ensure that you have a DHCP running or find your own DHCP.
