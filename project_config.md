Project Configuration
Last-Updated: 2025-06-21

Project Goal
The "Sanctuary" app is designed as a direct user-to-user platform facilitating pet rescue and adoption. It aims to efficiently connect individual pet owners/rescuers directly with potential adopters, fostering a community dedicated to animal welfare.

Design: Focus on a minimal and clean design inspired by apple glassmorphism 

Tech Stack
Language(s): Dart (for Flutter frontend), JavaScript/TypeScript (for Firebase Cloud Functions)

Framework(s): Flutter (frontend), Firebase (Backend as a Service), Express.js (for Cloud Functions where needed, implicitly)

Build / Tooling: Flutter SDK, Firebase CLI, npm/yarn (for Cloud Functions dependencies)

Critical Patterns & Conventions
Coding Standards: Clean, modular, and well-commented Flutter code.

Architectural Patterns: Reactive programming paradigm for Flutter UI, MVVM or BLoC patterns for state management in Flutter.

Data Modeling: Firebase Firestore's NoSQL document-oriented approach with strategic denormalization for optimized read patterns.

Backend Logic: Serverless functions (Firebase Cloud Functions) for event-driven backend tasks and data processing.

Security Rules: Strict Firebase Firestore Security Rules for robust access control based on user identity and data ownership.

UI/UX: Intuitive and easy-to-navigate user interface, responsive design across mobile device sizes, clear feedback for user actions.

Error Handling: Robust error handling in both frontend and backend.

Accessibility: Adherence to accessibility best practices (semantic widgets, contrast, text scaling).

Constraints
Performance / Latency Budgets: Fast loading times for pet listings and profiles; real-time updates for chat messages and application statuses. Minimal delay in media processing post-upload.

Security Requirements: Robust user authentication and authorization; secure storage of user-uploaded media; protection against common web/mobile vulnerabilities.

External APIs with Rate Limits or Cost Ceilings: Firebase Cloud Functions costs need careful monitoring, especially for extensive media processing. Firestore read/write operations must be optimized to manage costs.

Tokenization Settings
Estimated chars-per-token: 3.5

Max tokens per message: 8 000

Plan for summary when workflow_state.md exceeds ~12 K chars.

Sanctuary App: Product Requirements Document (PRD)
Document Version: 1.0
Date: June 18, 2025
Project Name: Sanctuary

1. Introduction
1.1 Project Overview
The "Sanctuary" app is designed as a direct user-to-user platform facilitating pet rescue and adoption. Inspired by the OLX model, it connects individual pet owners/rescuers (posters) directly with potential adopters, streamlining the process of finding loving homes for pets in need. This platform will operate without physical shelters or dedicated staff roles, empowering individuals to manage their pet listings and adoption inquiries.

1.2 Vision
To create a compassionate and efficient digital marketplace where pets can find their forever homes directly from individual rescuers or owners to verified adopters, fostering a community dedicated to animal welfare.

1.3 Goals
Maximize Adoptions: Increase the number of successful pet adoptions by directly connecting individuals.

User Empowerment: Provide intuitive tools for users to list pets, manage applications, and communicate effectively.

Safety & Trust: Implement features and backend processes to ensure a safe and trustworthy environment for pet transactions.

Accessibility: Make pet adoption and rescue accessible to a broader audience via mobile platforms.

2. User Roles & Personas
2.1 User Role: Unified User
In the "Sanctuary" app, there is a single, unified user role. Any registered user can perform actions related to both adopting pets and posting pets for adoption.

2.2 Personas
"The Responsible Adopter" (Aisha):

Goal: Find a new pet that fits her lifestyle and family, specifically looking for a medium-sized dog good with kids.

Needs: Easy search/filter, detailed pet profiles, direct communication with the poster, secure application process.

Pain Points: Sifting through irrelevant listings, slow communication, unclear adoption requirements.

"The Caring Rescuer" (Ben):

Goal: Find a good home for a stray cat he rescued or his family's pet that needs rehoming due to unforeseen circumstances.

Needs: Simple pet listing creation, clear photo/video upload, ability to screen applicants, direct messaging, easy status updates.

Pain Points: Difficultly reaching interested adopters, managing multiple inquiries, ensuring the pet goes to a safe home.

3. Key Features (Detailed)
3.1 User Management
User Registration & Login (Firebase Authentication):

Email/Password registration and login.

Support for social logins (Google, Apple) for convenience.

Password reset functionality.

User Profiles (users collection):

Profile Editing: Users can update their name, phoneNumber, address, and preferences.

Verification (Future): Placeholder for potential future verification mechanisms (e.g., phone number verification, ID verification for trusted posters).

3.2 Pet Listing & Management (for All Users)
Add Pet Listing:

Form-based Submission: Intuitive form for entering pet details.

Required Fields: name, species, breed, age, gender, size, description, photoUrls (at least one).

Optional Fields: color, healthStatus, behavioralNotes, videoUrls.

Location Tagging: Automatically or manually tag the pet's approximate location (derived from users.address) for local search.

Adoption Status: Default to "Available" upon creation.

Edit Pet Listing:

Posters can edit all details of their active listings.

Changes should be reflected in real-time for adopters.

Photo/Video Gallery (Firebase Storage):

Upload multiple high-resolution images.

Option to upload a short video (e.g., max 30 seconds).

Image compression and optimization upon upload via Cloud Functions.

Status Updates:

Posters can update adoptionStatus to "Pending" (when an application is being reviewed), "Adopted" (successfully rehomed), or "Withdrawn" (no longer available).

Adopted/Withdrawn pets should be hidden from main browse views but accessible via the poster's profile or direct link.

My Listings View:

A dedicated section for users to view and manage all their posted pets.

3.3 Pet Discovery & Filtering (for Adopters)
Browse Pets (Main Feed):

Display a paginated list of all Available pets, ordered by createdAt (newest first).

Infinite scrolling to load more pets.

Thumbnail image, name, species, and location snippet visible in the list.

Advanced Search & Filters:

Text Search: Search by name, breed, or keywords in description.

Category Filters: Filter by species, breed, age, gender, size, color.

Behavioral Filters: Filter by behavioralNotes (e.g., "Good with kids", "Good with dogs").

Location-Based Filtering: Filter by city/state, or radius around user's location.

Pet Details View:

Full screen view of pet profile including all details, large photo/video gallery, and poster's name.

"Apply for Adoption" button.

"Favorite" button.

"Report Listing" button.

Favorite Pets:

Users can add/remove pets from their personal favorites list.

Dedicated "My Favorites" section in the user profile.

3.4 Adoption Process Management (Purely Peer-to-Peer)
Application Submission (applications collection):

Adopters initiate an application from the pet's detail page.

A customizable application form (e.g., questions about housing, experience, lifestyle). Initial version can be a simple text box or a few key questions.

Submits to the posterId associated with the pet.

Application Review (for Poster):

Posters receive notifications for new applications.

"My Applications" view for posters to see all applications submitted for their pets.

Ability to view application details (applicationText), review adopter's profile (adopterId).

Update application status (e.g., "Under Review," "Approved," "Denied").

Communication (In-App Messaging Subcollection):

Secure, private chat between adopterId and posterId once an application is submitted.

Chat threads are nested under the specific applicationId.

Real-time message sending and receiving.

Meeting Scheduling (Optional):

Initial: Users arrange meetings via in-app chat.

Future: Integrated calendar suggestions or scheduling tools.

3.5 Communication & Notifications
In-App Messaging (applications/{applicationId}/messages):

Real-time chat interface within the app for specific application threads.

Timestamped messages.

Notifications (Firebase Cloud Messaging/Cloud Functions):

New Application: Notify posterId when a new application is submitted for their pet.

Application Status Change: Notify adopterId when their application status is updated.

New Message: Notify both senderId and receiverId of new messages in an application chat.

Matching Pets: (Optional future feature) Notify users when new pets matching their preferences are posted.

3.6 Reporting System (reports collection)
Report Listing Feature:

Users can report a pet listing directly from the pet details page.

Provide predefined reasons for reporting (e.g., "Spam," "Misleading Information," "Animal Cruelty").

Submission creates a new document in the reports collection.

Administrative Review (Out of Scope for User UI):

Backend process (e.g., Cloud Function triggered upon new report, sending to an admin dashboard) to review reported items.

Admin can change isReported status on the pet document and status on the report document.

4. Technical Architecture (High-Level)
Frontend:

Technology: Flutter

Purpose: Develop a single codebase for high-performance, natively compiled applications for both iOS and Android. Offers rich UI components and reactive programming.

Backend:

Technology: Firebase (Google Cloud Platform)

Components:

Firebase Authentication: Handles user registration, login, and session management.

Firestore: NoSQL document database for storing all application data (users, pets, applications, reports, and messages subcollection). Optimized for real-time synchronization.

Firebase Storage: Securely stores all pet photos and videos.

Firebase Cloud Functions: Serverless functions triggered by events (e.g., new pet listing, new application, new message) for:

Image/video processing (resizing, optimization).

Sending push notifications via Firebase Cloud Messaging (FCM).

Data validation.

Basic moderation (e.g., flagging reported items).

Data Flow:

Flutter client interacts directly with Firebase services (Auth, Firestore, Storage).

Firestore security rules enforce access control.

Cloud Functions execute backend logic in response to database changes or explicit client calls.

5. Data Model (Refined)
The core Firestore collections and their fields are as previously defined, with emphasis on the purely user-to-user model:

Core Collections:
users Collection

Purpose: Stores profiles for all users (posters and adopters).

Document ID: Firebase Auth uid.

Fields: name, email, phoneNumber (optional), address (Map), preferences (Map), createdAt, updatedAt.

pets Collection

Purpose: Stores detailed information about each pet posted by individual users.

Document ID: Auto-generated by Firestore.

Fields: name, species, breed, age, gender, size, color, description, healthStatus, behavioralNotes (Array), adoptionStatus, photoUrls (Array), videoUrls (Array, optional), postedByUserId (reference to users), createdAt, updatedAt, isReported (Boolean, default false).

applications Collection

Purpose: Stores adoption applications submitted by adopters to pet posters.

Document ID: Auto-generated by Firestore.

Fields: petId (reference to pets), adopterId (reference to users), posterId (reference to users), applicationText, status, submittedAt, reviewedAt (optional).

reports Collection (Top-Level)

Purpose: To handle reported listings for administrative review.

Document ID: Auto-generated.

Fields: reportedItemId (ID of the pet document), reportedItemType (e.g., "pet_listing"), reporterId (user who made the report), reason, status, reportedAt, reviewedBy (optional, administrative user ID), reviewedAt (optional).

Subcollections & Relationships:
applications/{applicationId}/messages (Subcollection):

Purpose: In-app chat specific to an adoption application.

Fields: senderId, receiverId, message, timestamp, read.

6. Non-Functional Requirements
Performance:

Fast loading times for pet listings and profiles.

Real-time updates for chat messages and application statuses (Firestore's strength).

Efficient image/video loading and display.

Scalability:

The Firebase backend is inherently scalable, handling increasing numbers of users, pets, and applications without significant infrastructure overhead.

Flutter's performance ensures smooth UI even with large datasets.

Security:

Robust Firebase Authentication for user data protection.

Strict Firestore Security Rules to control read/write access based on user identity and data ownership.

Secure storage of user-uploaded media in Firebase Storage.

Protection against common vulnerabilities (e.g., XSS, injection) in application logic.

Usability/UX:

Intuitive and easy-to-navigate user interface (Flutter's material design/cupertino widgets).

Clear calls to action for posting, browsing, and applying.

Responsive design across various mobile device sizes.

Clear feedback for user actions (e.g., loading indicators, success messages).

Accessibility:

Adherence to accessibility best practices (e.g., semantic widgets, sufficient contrast, text scaling).

Maintainability:

Clean, modular, and well-commented Flutter code.

Clear separation of concerns between UI, business logic, and data layers.

Automated testing where appropriate.

7. Future Enhancements (Optional - Phase 2+)
Admin Dashboard: A separate web interface (e.g., React/Next.js) for administrators to review reported listings, manage users, and view platform analytics.

Advanced Search & Matching: Machine learning for "smart matching" pets to adopters based on complex preferences.

Community Features: Forums, success stories, or adoption tips.

Donation/Fundraising: Integration for users to donate to local rescue efforts.

Geo-fencing/Location Alerts: Notify users of new pets within a specific radius.

Video Calls: Direct video call integration within the chat for virtual meetings.

## Changelog

- Implemented comprehensive color scheme redesign with soft teal primary (#4CAF50) and warm orange secondary (#FF8A65) based on psychological design principles for trust, warmth, and nature connection
- Implemented comprehensive dark mode toggle functionality with glassmorphism design, theme persistence, and three-state cycling (System → Light → Dark → System)