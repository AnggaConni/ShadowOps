# International Shadow Ops System (ISO) 🌍

Strategic Operation Map & Daily Activity Tracker

"No more blame games. Just data."

📖 Background (The Problem)

In complex operational units, classic problems often arise:

Manual Reporting Nightmare: Reporting between colleagues within a unit is done manually, partially, and is difficult to track.

Lack of Traceability: It is hard to track the specific daily progress of a large pipeline.

The Blame Game: When targets are missed or budgets overrun, teams tend to blame each other due to a lack of historical data ("Who worked on what, when, and used how much budget?").

Clarification Fatigue: Too much time is wasted on meetings just to clarify job status.

💡 Solution (The Solution)

Shadow Ops System is not just a dashboard. It is a platform that combines:

Pipeline Tracking (Macro): Viewing the big picture of project structure, team hierarchy, and global budget status.

Daily Traceability (Micro): Recording daily work logs per individual tied directly to budget and outcomes.

The Goal: Total transparency. Eliminating the need for repetitive clarifications and creating a data-driven work environment, rather than one based on assumptions.

🚀 Key Features

1. Interactive Hierarchy Map (Workflow View)

Visualization of organizational and project structure in the form of a Tree Diagram.

Zoom & Pan: Easy navigation for large organizational structures.

Status Indicators: Color indicators for projects that are On Track, Delayed, or Critical Issue.

Budget Overview: View fund allocation directly on project nodes.

2. Micro Logging (Activity Tracker)

A feature for staff to record daily work without hassle.

AI Smart Log: Simply type or use voice (Voice Note), AI will automatically categorize logs, detect sentiment, and status.

Manual Entry: Complete form for detailed input (Date, Status, Budget Used, Upload Evidence).

Context Aware: Logs are tied directly to specific activity nodes in the hierarchy map.

3. Macro Dashboard (Strategic View)

For leadership or HQ to view organizational health in real-time.

Budget Absorption: Budget absorption charts per region/division.

Risk Radar: Early detection of problematic projects before they become crises.

KPI Cards: Team performance summary.

4. Google Apps Script (GAS) Integration (Planned)

This application is designed to be serverless using the Google ecosystem:

Database: Google Sheets (as a simple relational database).

API/Backend: Google Apps Script (doGet & doPost) to fetch and push log data.

Authentication: Using Google Workspace login.

🛠️ Tech Stack

Frontend: HTML5, Modern JavaScript (ES6+), Tailwind CSS (via CDN).

Icons: FontAwesome.

Architecture: Single File Application (SFA) for easy initial deployment.

Data Simulation: JSON Object (massiveData) mimicking API response structure.

📂 Installation & Usage

This project is a Single File Application, making it very easy to run.

Clone Repository:

git clone [https://github.com/username/shadow-ops-system.git](https://github.com/username/shadow-ops-system.git)


Open File:
Navigate to the project folder and open International_Shadow_Ops_Mockup.html using a modern browser (Chrome, Edge, Firefox, Safari).

Navigation:

Map Icon: Workflow Hierarchy (Project Map).

Microphone Icon: Daily Log Input.

Chart Icon: Statistical Dashboard.

📅 Development Roadmap

[x] Phase 1: High Fidelity Mockup & UI/UX Design.

[x] Phase 2: Log Data Simulation & Interactive Tree.

[ ] Phase 3: fetch() connection to Google Apps Script.

[ ] Phase 4: Image Upload Feature (to Google Drive via GAS).

[ ] Phase 5: Multi-user Authentication & Role Management.

🤝 Contribution

Contributions are always welcome! Please create a Pull Request or open an Issue to discuss new features or report bugs.

📝 License

Distributed under the MIT License. See LICENSE file for more information.

MIT License

Copyright (c) 2024 International Shadow Ops

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
