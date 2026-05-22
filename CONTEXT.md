# mp-ds-notes

A single-user note-taking app where users sign in to create, edit, view, and permanently delete plain-text notes. All notes are encrypted on disk via Active Record Encryption. No self-registration; users are provisioned by an operator via `rails console` (or `kamal exec` in production).

## Language

**User**:
A human who signs in with email and password via Devise (`database_authenticatable`, `validatable`, `recoverable`) to access their own notes. No self-registration; provisioned by an operator via `rails console` (or `kamal exec` in production).
_Avoid_: Account, member, person, admin

**Note**:
A plain-text document owned by exactly one **User**. Body-only (first line acts as title in UI). Can be created, read, updated, and permanently destroyed (hard DELETE with confirmation). Body always encrypted at rest via non-deterministic Active Record Encryption.
_Avoid_: Entry, memo, document, page