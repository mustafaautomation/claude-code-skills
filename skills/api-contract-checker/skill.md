# API Contract Checker

Verify API endpoints match their OpenAPI/Swagger specification. Detect breaking changes before they reach production.

## Process

1. Locate the OpenAPI spec file (`openapi.yml`, `openapi.json`, `swagger.yml`, or `swagger.json`)
2. Identify all API routes in the codebase (Express routes, FastAPI endpoints, Spring controllers)
3. Cross-reference each route handler against the spec:
   - **Missing endpoints**: Routes in code but not in spec (or vice versa)
   - **Schema mismatches**: Response body doesn't match declared schema
   - **Status code gaps**: Code returns status codes not documented in spec
   - **Parameter drift**: Required params in spec not validated in handler
   - **Type mismatches**: Field types in code differ from spec (e.g., string vs number)
4. Check for breaking changes against the previous version of the spec (if git history available)

## Output Format

```markdown
## API Contract Check

### Status: [PASS / DRIFT DETECTED]

### Coverage
- Endpoints in spec: X
- Endpoints in code: Y
- Matched: Z

### Drift Findings

#### [BREAKING] POST /api/users — Missing required field
- **Spec says**: `email` is required in request body
- **Code does**: No validation for `email` field
- **Impact**: Clients sending valid requests may get 500 instead of proper validation error
- **Fix**: Add request validation middleware

#### [WARNING] GET /api/products — Undocumented query parameter
- **Spec says**: Only `limit` and `offset` params
- **Code accepts**: Additional `category` filter param
- **Impact**: Consumers don't know about useful filtering capability
- **Fix**: Add `category` parameter to OpenAPI spec
```

## Best Practices

- Run on every PR that touches API routes or the OpenAPI spec
- Flag breaking changes as critical (removed endpoints, changed required fields)
- Flag additions as warnings (new undocumented endpoints/params)
- Suggest spec updates alongside code fixes
- Check both request and response schemas
