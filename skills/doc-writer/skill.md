# API Documentation Writer

Generate comprehensive API documentation from source code.

## Process

1. Scan the project for API routes/endpoints:
   - Express: `router.get()`, `router.post()`, `app.use()`
   - FastAPI: `@app.get()`, `@router.post()`
   - Spring: `@GetMapping`, `@PostMapping`
   - ASP.NET: `[HttpGet]`, `[HttpPost]`
2. For each endpoint, extract:
   - HTTP method and path
   - Request parameters (path, query, body)
   - Response format and status codes
   - Authentication requirements
   - Validation rules
3. Generate documentation in the requested format

## Output Formats

### OpenAPI/Swagger (default)
Generate `openapi.yaml` with complete endpoint specifications.

### Markdown
Generate `API.md` with tables and code examples:

```markdown
## POST /api/users

Create a new user.

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| name | string | Yes | User's full name |
| email | string | Yes | Valid email address |

**Response:** `201 Created`
\`\`\`json
{ "id": 1, "name": "Alice", "email": "alice@example.com" }
\`\`\`

**Errors:**
- `400` — Validation error
- `409` — Email already exists
```

## Rules
- Document what the code actually does, not what you think it should do
- Include real example request/response bodies from the code
- Note any undocumented behavior you discover
