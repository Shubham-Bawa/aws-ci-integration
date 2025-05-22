graph TD
    A[Start] --> B{Application code Files}
    B -- "In case client has CI & CD, build process to be shared" --> D
    B -- Yes --> C{Build application code along with pip-dependencies}
    C -- Success --> D{Authenticate with aws_code_artifact Manager}
    D -- Authenticated --> E{Upload ZIP to aws_code_artifact Manager}
    E -- Success --> F{Notify Client using email / webhook / socket}
    F -- "webhook_call (optional)" --> G{Auto-Trigger client pipeline in case of CD}
    E --> L[End]
    B -- No --> H[Handle Error / No Files]
    C -- Failure --> I[Handle Compression Error]
    D -- Failed --> J[Handle Authentication Error]
    E -- Failure --> K[Handle Upload Error]
    H --> L
    I --> L
    J --> L
    K --> L
