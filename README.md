# STX-SourceCapital - Open Source Project Funding Contract

## Overview
This contract allows users to create, fund, and manage open source projects on the blockchain. It supports various operations such as:

- **Creating a new open source project**
- **Adding milestones to projects**
- **Contributing funds to projects**
- **Marking milestones as completed**
- **Tracking project and milestone statuses**
- **Accessing project and milestone details**

The contract ensures that only the project creator can add milestones, and only contributors can fund projects. It also includes checks for project and milestone completion, and it allows users to verify if a project has reached its funding target.

---

## Key Features

### 1. **Create an Open Source Project**
Users can create a new open source project by specifying:
- Project title
- Project description
- Target funding amount

This project can then be funded by other users.

### 2. **Add Milestones to a Project**
Once a project is created, the project creator can add milestones. Each milestone includes:
- Milestone title
- Milestone description
- Milestone completion deadline
- Milestone funding amount

### 3. **Contribute Funds to a Project**
Users can contribute funds to a project if the project is active and has not already met its funding goal. Contributions are stored, and the user's contributions are tracked.

### 4. **Complete Milestones**
Milestones can be marked as "completed" by the project creator once the milestone's completion deadline has passed.

### 5. **Get Project and Milestone Details**
Users can retrieve details about a specific project or milestone, including:
- Project creator
- Project funding status
- Milestone completion status

### 6. **Check Funding Status**
The contract allows users to check whether a project is fully funded or if a milestone has been completed.

---

## Error Codes
The contract defines the following error codes for various failure scenarios:

- **ERR-UNAUTHORIZED-ACCESS (u1)**: User is not authorized to perform the action (e.g., non-creator attempting to add a milestone).
- **ERR-PROJECT-DOES-NOT-EXIST (u2)**: The specified project does not exist.
- **ERR-PROJECT-ALREADY-FUNDED (u3)**: The project has already reached its funding goal.
- **ERR-INSUFFICIENT-BALANCE (u4)**: The user has insufficient funds to contribute.
- **ERR-INVALID-FUNDING-AMOUNT (u5)**: The funding amount is invalid (e.g., zero or negative).
- **ERR-MILESTONE-DOES-NOT-EXIST (u6)**: The specified milestone does not exist.
- **ERR-MILESTONE-INCOMPLETE (u7)**: The milestone is incomplete (cannot be marked as complete before the deadline).
- **ERR-INVALID-PROJECT-TITLE (u8)**: The project title is invalid (empty or too short).
- **ERR-INVALID-PROJECT-DESCRIPTION (u9)**: The project description is invalid (empty or too short).
- **ERR-INVALID-MILESTONE-TITLE (u10)**: The milestone title is invalid.
- **ERR-INVALID-MILESTONE-DESCRIPTION (u11)**: The milestone description is invalid.
- **ERR-INVALID-DEADLINE (u12)**: The milestone deadline is invalid (in the past).
- **ERR-INVALID-PROJECT-ID (u13)**: The project ID is invalid.
- **ERR-INVALID-MILESTONE-ID (u14)**: The milestone ID is invalid.

---

## Contract Structure

### Data Variables
- **contract-administrator**: The principal address of the contract administrator (typically the creator of the contract).
- **open-source-projects**: A map that stores open-source project details indexed by a project identifier.
- **project-development-milestones**: A map that stores milestone details for projects indexed by a combination of project identifier and milestone identifier.
- **project-funding-contributors**: A map that tracks the contributors and their funding amounts for each project.
- **next-project-identifier**: A counter for generating unique project identifiers.

### Helper Functions
The contract includes private helper functions to validate:
- **Project ID**
- **Milestone ID**
- **Deadline**
- **Strings**

### Public Functions

#### `initialize-contract`
- **Purpose**: Initializes the contract, ensuring that only the contract administrator can initialize it.

#### `create-open-source-project`
- **Purpose**: Allows a user to create a new open-source project.
- **Parameters**:
  - `project-title`: The title of the project.
  - `project-description`: A description of the project.
  - `target-funding-amount`: The target funding goal for the project.

#### `add-project-milestone`
- **Purpose**: Adds a new milestone to an existing project.
- **Parameters**:
  - `project-identifier`: The identifier of the project.
  - `milestone-title`: The title of the milestone.
  - `milestone-description`: The description of the milestone.
  - `milestone-deadline`: The deadline for milestone completion.
  - `milestone-funding-amount`: The funding required to complete the milestone.

#### `contribute-project-funding`
- **Purpose**: Allows users to contribute funds to a project.
- **Parameters**:
  - `project-identifier`: The identifier of the project.
  - `funding-amount`: The amount of funds to contribute.

#### `complete-project-milestone`
- **Purpose**: Allows the project creator to mark a milestone as completed once the deadline has passed.
- **Parameters**:
  - `project-identifier`: The identifier of the project.
  - `milestone-identifier`: The identifier of the milestone.

#### `get-project-details`
- **Purpose**: Retrieves details of a specific project.
- **Parameters**:
  - `project-identifier`: The identifier of the project.

#### `get-milestone-details`
- **Purpose**: Retrieves details of a specific milestone.
- **Parameters**:
  - `project-identifier`: The identifier of the project.
  - `milestone-identifier`: The identifier of the milestone.

#### `get-total-projects`
- **Purpose**: Retrieves the total number of projects created.

#### `get-contributor-funding-amount`
- **Purpose**: Retrieves the total amount contributed by a specific user to a project.
- **Parameters**:
  - `project-identifier`: The identifier of the project.
  - `funding-contributor`: The principal address of the contributor.

#### `is-project-fully-funded`
- **Purpose**: Checks if a project has reached its funding goal.
- **Parameters**:
  - `project-identifier`: The identifier of the project.

#### `is-milestone-completed`
- **Purpose**: Checks if a specific milestone has been completed.
- **Parameters**:
  - `project-identifier`: The identifier of the project.
  - `milestone-identifier`: The identifier of the milestone.

---

## Usage

### Deploying the Contract
To deploy the contract, the administrator must initialize it using the `initialize-contract` function. This function ensures that only the contract administrator can perform the initialization.

### Creating a Project
Use the `create-open-source-project` function to create a new project. Specify the project title, description, and target funding amount.

### Adding Milestones
After creating a project, use the `add-project-milestone` function to add milestones to the project. Each milestone can have a title, description, deadline, and required funding amount.

### Funding a Project
Users can contribute funds to an active project using the `contribute-project-funding` function. The contribution is added to the total funds raised for the project, and contributors are tracked.

### Completing Milestones
Once a milestone’s deadline has passed, the project creator can use the `complete-project-milestone` function to mark the milestone as completed. The corresponding milestone funding amount will be transferred to the project creator.

---

## Security and Access Control

- Only the project creator can add milestones and mark them as completed.
- Contributors can only fund projects and milestones, but they cannot alter project details.
- The contract uses basic validation checks to ensure all inputs (such as funding amounts, project IDs, and milestone deadlines) are valid.

---
