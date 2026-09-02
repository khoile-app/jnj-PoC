# J&J Applitools PoC — Workshop Exercise

This repo is the starting point for a 1-hour hands-on working session with Johnson & Johnson,
using Robot Framework, Applitools Eyes, and an AI coding assistant (PyCharm / VS Code Copilot)
to build a visual test and wire it into Jenkins.

## Session goals (1 hour)

- Use PyCharm / VS Code Copilot to create a test case from a user flow
- Have Copilot use the Applitools MCP server to add visual testing to the test
- Run the test locally and review the test results in the Applitools dashboard
- Add the test to a Jenkins pipeline

## Prerequisites

Before the session, each participant should have:

- Access to Applitools (a team lead should create a team specific to this PoC and add members to it)
- Access to Jenkins and PyCharm or VS Code
- Privileges to install `eyes-robotframework` and the Applitools MCP Server
- Robot Framework installed (or the ability to install it — see Setup below)
- Python 3.9+ installed
- The user flow / use case to build the test from (confirm whether the target application is publicly accessible)

## Documentation

- [Applitools MCP Server](https://applitools.com/docs/eyes/integrations/mcp-servers/applitools-mcp)
- [Applitools Jenkins Integration](https://applitools.com/docs/eyes/integrations/ci-cd/jenkins)
- [Applitools Robot Framework SDK](https://applitools.com/docs/eyes/sdks/robot)

## Setup

```bash
# from this project folder
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Set your Applitools API key (get it from the Applitools dashboard under your team's account settings):

```bash
export APPLITOOLS_API_KEY=<your-api-key>
```

Or copy `.env.example` to `.env` and fill in your key — it's already excluded from git via `.gitignore`.

## Run the tests

```bash
robot --outputdir results tests/
```

Open `results/report.html` in a browser to see the local run results, then check the
[Applitools dashboard](https://eyes.applitools.com) for the visual test results.

## Project layout

- `tests/example.robot` — sample test suite (visits the homepage and checks header navigation)
- `resources/common.resource` — shared keywords/variables used across suites
- `applitools.yaml` — Eyes configuration (viewports, browsers, batching, etc.)
- `requirements.txt` — Python packages needed (Robot Framework, SeleniumLibrary, eyes-robotframework)
- `.vscode/settings.json` — points VS Code / the Robot Framework extension at the project's virtual environment

## During the workshop

1. Pick a user flow on the target application and describe it to your AI assistant.
2. Ask the assistant to generate a Robot Framework test case for that flow (add it under `tests/`).
3. Ask the assistant to use the Applitools MCP server to add visual checkpoints (`Eyes Open`,
   `Eyes Check Window`, `Eyes Close`) to the new test.
4. Run the test locally with `robot --outputdir results tests/` and review both the local
   report and the Applitools dashboard.
5. Add a stage to the Jenkins pipeline that installs dependencies and runs `robot` against this
   project, using the [Jenkins integration guide](https://applitools.com/docs/eyes/integrations/ci-cd/jenkins).
