---
title: "Global Entry Appointment Scrapper"
date: 2025-08-12
draft: false
tags: ["Python", "GitHub Actions"]
summary: "I forked a bot to beat the Global Entry Appointment hell"
showToc: true
params:
  context: "personal"
  projectURL: "https://github.com/YashashGaurav/global-entry-scraper"
  status: "completed"
---

# Forked a bot to beat the Global Entry Appointment hell

Global Entry appointments are impossible to get right now - some locations have zero availability for months, and when slots pop up, they're gone in minutes. Third-party services charge $29/month just to send you alerts [Global Entry appointment scraper](https://jamescalixto.com/global-entry-scraper/), which felt like highway robbery for something so simple.


## My Solution - Forked and improved on an Appointment Scrapper.

Built a Python scraper that:
- Fetches Global Entry Appointments on a Schedule for location(s) of interest
- Pings Discord when appointments open up
- Runs automatically via GitHub Actions every 4 hours
- Filters by date so you only get relevant alerts

## Tech Stack

Python + UV package manager + Discord webhooks + GitHub Actions. Nothing fancy.

## Results

Got my appointment in the week I finished coding it. Turns out CBP drops new slots every first Monday at 9am, plus random cancellations throughout the month ref: [The Points Guy, Thrifty Traveler](https://thriftytraveler.com/guides/global-entry-interview-tips/)

## The Catch

Everyone's building these now, so appointments are getting snatched up even faster. It's an arms race, but at least it's a more democratized arms race.

- Code: [github.com/YashashGaurav/global-entry-scraper](https://github.com/YashashGaurav/global-entry-scraper)
- Disclaimer: Use responsibly, don't spam the CBP API, etc.
