# workflow_state.md
_Last updated: 2025-01-16_

## State
Phase: CONSTRUCT  
Status: RUNNING
CurrentItem: Fix pet details screen not working

## Plan

**PREVIOUS TASK: Implement specified color scheme for Sanctuary app**
✅ Successfully completed - ready for git commit

**CURRENT TASK: Fix pet details screen not working**

**✅ ISSUE IDENTIFIED:**

**Root Cause Analysis:**
- ✅ Navigation works correctly (`context.push('/browse/pet/${pet['id']}')`)
- ✅ Route configuration is correct (`'pet/:petId'` under browse route)
- ✅ Route parameters extracted correctly (`GoRouterState.of(context).pathParameters['petId']`)
- ❌ **Problem**: Pet details screen ignores petId and always shows static "Bella" data

**Specific Issue:**
In `pet_details_screen.dart` line 25:
```dart
final petId = GoRouterState.of(context).pathParameters['petId']; // ✅ Extracted correctly
final pet = _getMockPet(); // ❌ IGNORES petId - always returns "Bella"
```

**Implementation Plan:**
1. Create shared mock data source that both browse and details screens can use
2. Update `_getMockPet()` to accept `petId` parameter and return correct pet
3. Modify pet details screen to use `petId` to fetch specific pet data
4. Handle case where `petId` doesn't match any mock pet (show error/not found)
5. Test navigation between browse → pet details for all mock pets

**Files to Modify:**
- `lib/features/pets/screens/pet_details_screen.dart` - Fix data fetching logic
- Potentially create `lib/shared/models/mock_pets.dart` - Shared mock data (optional improvement)

**Mock Pets Available (from browse screen):**
- ID '1': Buddy (Golden Retriever)
- ID '2': Luna (Persian Cat)  
- ID '3': Charlie (Parrot)
- ID '4': Daisy (Holland Lop Rabbit)

**Current Mock Pet in Details (always shows):**
- ID '1': Bella (Golden Retriever) - ❌ Wrong/inconsistent data

## Rules
> **Keep every major section under an explicit H2 (`##`) heading so the agent can locate them unambiguously.**

### [PHASE: ANALYZE]
1. Read **project_config.md**, relevant code & docs.  
2. Summarize requirements. *No code or planning.*

### [PHASE: BLUEPRINT]
1. Decompose task into ordered steps.  
2. Write pseudocode or file-level diff outline under **## Plan**.  
3. Set `Status = NEEDS_PLAN_APPROVAL` and await user confirmation.

### [PHASE: CONSTRUCT]
1. Follow the approved **## Plan** exactly.  
2. After each atomic change:  
   - run test / linter commands specified in `project_config.md`  
   - capture tool output in **## Log**  
3. On success of all steps, set `Phase = VALIDATE`.

### [PHASE: VALIDATE]
1. Rerun full test suite & any E2E checks.  
2. If clean, set `Status = COMPLETED`.  
3. Trigger **RULE_ITERATE_01** when applicable.
4. Trigger **RULE_GIT_COMMIT_01** to prompt for version control.

---

### RULE_INIT_01
Trigger ▶ `Phase == INIT`  
Action ▶ Ask user for first high-level task → `Phase = ANALYZE, Status = RUNNING`.

### RULE_ITERATE_01
Trigger ▶ `Status == COMPLETED && Items contains unprocessed rows`  
Action ▶  
1. Set `CurrentItem` to next unprocessed row in **## Items**.  
2. Clear **## Log**, reset `Phase = ANALYZE, Status = READY`.

### RULE_LOG_ROTATE_01
Trigger ▶ `length(## Log) > 5 000 chars`  
Action ▶ Summarise the top 5 findings from **## Log** into **## ArchiveLog**, then clear **## Log**.

### RULE_SUMMARY_01
Trigger ▶ `Phase == VALIDATE && Status == COMPLETED`  
Action ▶ 
1. Read `project_config.md`.
2. Construct the new changelog line: `- <One-sentence summary of completed work>`.
3. Find the `## Changelog` heading in `project_config.md`.
4. Insert the new changelog line immediately after the `## Changelog` heading and its following newline (making it the new first item in the list).

---

### Git Workflow
> Rules for interacting with the Git version control system.

#### RULE_GIT_COMMIT_01
Trigger ▶ `Phase == VALIDATE && Status == COMPLETED`  
Action ▶ 
1. Prompt user to commit changes with a generated message (e.g., `Phase X: [brief description]`).
2. Suggest creating a new branch for significant changes (e.g., `git checkout -b feature/new-thing`).
3. Upon user confirmation, execute the `git add .` and `git commit` commands.
4. Retrieve the new commit SHA using `git rev-parse HEAD`.
5. Prepend the SHA and commit message to `## Workflow History`.

#### RULE_GIT_ROLLBACK_01
Trigger ▶ User command like "revert to..." or "rollback to..." followed by a description.
Action ▶ 
1. Search `## Workflow History` for the SHA corresponding to the description.
2. If found, execute `git checkout <SHA>`.
3. If not found, inform the user.

#### RULE_GIT_DIFF_01
Trigger ▶ User command like "diff..." or "compare..." with two descriptions.
Action ▶ 
1. Find the two SHAs from `## Workflow History` based on the descriptions.
2. If found, execute `git diff <SHA1> <SHA2>`.
3. If not found, inform the user.

#### RULE_GIT_GUIDANCE_01
Trigger ▶ User asks for help with Git (e.g., "how do I use git?").
Action ▶ Provide a brief list of common Git commands (`commit`, `branch`, `checkout`, `diff`).

---

## Items
| id | description | status |
|----|-------------|--------|

## Log
**CONSTRUCT Phase - Pet Details Screen Fix Implementation:**

**✅ CHANGES IMPLEMENTED:**

**1. Updated pet details data fetching logic:**
- Changed from static `_getMockPet()` to dynamic `_getMockPetById(petId)`
- Function now accepts `petId` parameter and returns correct pet data
- Added null check for `petId` from route parameters

**2. Added comprehensive mock data:**
- ID '1': Buddy (Golden Retriever) - matches browse screen
- ID '2': Luna (Persian Cat) - matches browse screen  
- ID '3': Charlie (Parrot) - matches browse screen
- ID '4': Daisy (Holland Lop Rabbit) - matches browse screen

**3. Added error handling:**
- Shows "Pet Not Found" screen if `petId` is null or invalid
- Graceful fallback with navigation back button

**4. Fixed data format consistency:**
- Age kept as integer to match browse screen format  
- Added missing fields like 'status' to details data
- Ensured all data types are consistent

**Technical Changes Made:**
- Modified `build()` method to use `_getMockPetById(petId)`
- Added null safety checks for route parameters
- Updated mock data structure to match browse screen
- Added error handling UI for missing pets

**✅ VALIDATION:**
- Static analysis shows no new errors
- Code compiles successfully
- Mock data IDs match between browse and details screens

**❌ USER FEEDBACK:** "did not work"

**DEBUGGING NEEDED:**
- Need specific details about what behavior user is experiencing
- Requires runtime testing to identify actual issue
- May need to run app and test navigation flow manually