# GitHub Actions and CI/CD Project - YAML

In this mini-project, you will embark on a hands-on journey to master the art of automating your software development workflows using GitHub Actions. By the end of this project, you will have a solid understanding of how to create, configure, and optimize CI/CD pipelines to streamline your development process.

## Why is this Important?

Imagine you are a conductor of an orchestra. Each musician (developer) plays their part and must synchronize with others to create harmonious music (software application). In this scenario, GitHub Actions and CI/CD processes are like your conductor's baton, helping you orchestrate the diverse elements of software development. Just as a conductor ensures that each musician enters at the right time and the music flows smoothly, CI/CD coordinates the various stages of development, testing, and deployment, ensuring that the final product is delivered seamlessly and efficiently. This mini-project is about learning how to conduct your software development orchestra with skill and precision, leading to a symphony of streamlined processes and high-quality outcomes.

## Project Objectives

- Understand YAML syntax for workflows.
- Learn the structure and components of a workflow.

## Prerequisites

1. **GitHub Account:**  
   - Necessary for repository management and access to GitHub Actions.  
   - Sign up at [GitHub](https://github.com/join).

2. **Git Installed:**  
   - Required for version control and repository management.  
   - Download from [Git](https://git-scm.com/downloads).

3. **Basic Knowledge of Git:**  
   - Understanding of basic Git commands (clone, commit, push, pull).  
   - Tutorial: [Git Basics](https://git-scm.com/docs/gittutorial).

4. **Node.js and npm Installed:**  
   - Node.js is the runtime environment for JavaScript, and npm is the package manager.  
   - Download and installation instructions from [Node.js](https://nodejs.org/en/download/).  
   - Verify installations with `node -v` and `npm -v` in the terminal.

5. **Familiarity with JavaScript:**  
   - Basic understanding of JavaScript programming.  
   - Tutorial: [JavaScript Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide)

6. **Text Editor or IDE:**  
   - A code editor such as Visual Studio Code, Atom, or Sublime Text.  
   - Visual Studio Code: [Download VS Code](https://code.visualstudio.com/download)

7. **Access to a Command Line Interface (CLI):**  
   - Terminal on macOS/Linux or Command Prompt/PowerShell on Windows.  
   - Guide: [The Command Line Interface](https://www.codecademy.com/article/command-line-interface).

8. **Basic Understanding of YAML:**  
   - YAML is used for writing GitHub Actions workflows.  
   - Tutorial: [Learn YAML in Y minutes](https://learnxinyminutes.com/yaml/)

9. **Internet Connection:**  
   - Required for accessing GitHub, documentation, and online resources.

## Lesson Details

### 1. YAML Syntax for Workflows

- YAML is a human-readable data serialization standard used for configuration files.
- Key Concepts: Indentation, key-value pairs, lists.
- Example snippet:

    ```yaml
    name: Example Workflow
    on: [push]
    ```

### 2. Workflow Structure and Components

- **Workflow File:** Located in the `.github/workflows` directory, e.g., `main.yml`.
- **Jobs:** Define tasks like building, testing, deploying.
- **Steps:** Individual tasks within a job.
- **Actions:** Reusable units of code within steps.
- **Events:** Triggers for the workflow, e.g., `push`, `pull_request`.
- **Runners:** The server where the job runs, e.g., `ubuntu-latest`.

---

## Building and Testing Code

### Objectives

- Set up build steps in GitHub Actions.
- Run tests as part of the CI process.

#### Setting Up Build Steps

1. **Defining the Build Job**

    - In your GitHub Actions workflow file (e.g., `.github/workflows/main.yml`), start by defining a job named `build`.
    - This job is responsible for building your code.

    ```yaml
    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
        # Steps will be defined next
    ```

2. **Adding Build Steps**

    - Each step in the job performs a specific task.
    - Here, we add three steps: checking out the code, installing dependencies, and running the build script.

    ```yaml
    steps:
      - uses: actions/checkout@v2
        # 'actions/checkout@v2' is a pre-made action that checks out your repository under $GITHUB_WORKSPACE, so your workflow can access it.

      - name: Install dependencies
        run: npm install
        # 'npm install' installs the dependencies defined in your project's 'package.json' file.

      - name: Build
        run: npm run build
        # 'npm run build' runs the build script defined in your 'package.json'. This is typically used for compiling or preparing your code for deployment.
    ```

#### Running Tests in the Workflow

1. **Adding Test Steps**

    - After the build steps, include steps to execute your test scripts.
    - This ensures that your code is not only built but also passes all the tests.

    ```yaml
    - name: Run tests
      run: npm test
      # 'npm test' runs the test script defined in your 'package.json'. It's crucial for ensuring that your code works as expected before deployment.
    ```

### Learning Notes

- The `build` job consists of steps that check out the code, install dependencies, build the project, and run tests.
- The `runs-on: ubuntu-latest` line specifies that the job will run on the latest version of an Ubuntu Linux runner provided by GitHub.
- Using actions like `actions/checkout@v2` helps leverage community-maintained actions to simplify common tasks.
- Commands like `npm install`, `npm run build`, and `npm test` are standard Node.js commands used for managing dependencies, building, and testing Node.js applications.

---

## Additional YAML Concepts in GitHub Actions

### Objectives

- Deepen understanding of advanced YAML features used in GitHub Actions.
- Explore the use of environment variables and secrets in workflows.

### Detailed Steps and Code Explanation

1. **Using Environment Variables**

    - Environment variables can be defined at the workflow, job, or step level.
    - They allow you to dynamically pass configuration and settings.

    ```yaml
    env:
      CUSTOM_VAR: value
    # Define an environment variable 'CUSTOM_VAR' at the workflow level.

    jobs:
      example:
        runs-on: ubuntu-latest
        steps:
          - name: Use environment variable
            run: echo $CUSTOM_VAR
            # Access 'CUSTOM_VAR' in a step.
    ```

2. **Working with Secrets**

    - Secrets are encrypted variables set in your GitHub repository settings.
    - Ideal for storing data like access tokens, passwords, etc.

    ```yaml
    jobs:
      deploy:
        runs-on: ubuntu-latest
        steps:
          - name: Use secret
            run: |
              echo "Access Token: ${{ secrets.ACCESS_TOKEN }}"
            # Use 'ACCESS_TOKEN' secret defined in the repository settings.
    ```

3. **Conditional Execution**

    - You can control when jobs, steps, or workflows run based on conditions:

    ```yaml
    jobs:
      conditional-job:
        runs-on: ubuntu-latest
        if: github.event_name == 'push' && github.ref == 'refs/heads/main'
        # The job runs only for push events to the 'main' branch.
        steps:
          - uses: actions/checkout@v2
    ```

4. **Using Outputs and Inputs Between Steps**

    - Share data between steps in a job using outputs:

    ```yaml
    jobs:
      example:
        runs-on: ubuntu-latest
        steps:
          - id: step-one
            run: echo "::set-output name=value::$(echo hello)"
            # Set an output named 'value' in 'step-one'.
          - id: step-two
            run: |
              echo "Received value from previous step: ${{ steps.step-one.outputs.value }}"
              # Access the output of 'step-one' in 'step-two'.
    ```

### Learning Notes

- Environment variables and secrets are crucial for managing configurations and sensitive data in your CI/CD pipelines.
- Conditional execution helps tailor the workflow based on specific criteria, making your CI/CD process more efficient.
- Sharing data between steps using outputs and inputs allows for more complex workflows where the output of one step can influence or provide data to subsequent steps.
- These advanced features enhance the flexibility and security of your GitHub Action workflows, enabling a more robust CI/CD process.

## Conclusion

By completing this mini-project, you will have gained practical experience in setting up and managing CI/CD pipelines using GitHub Actions. You will be able to create workflows that automate the building, testing, and deployment of your applications, leading to more efficient and reliable software development processes. This knowledge is essential for modern DevOps practices and will significantly enhance your ability to deliver high-quality software quickly and consistently.