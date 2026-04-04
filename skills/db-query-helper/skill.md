# Database Query Helper

Help write, optimize, and explain SQL queries by reading the project's schema.

## Process

1. Look for database schema in the project:
   - Prisma: `prisma/schema.prisma`
   - Drizzle: `drizzle/schema.ts`
   - TypeORM: entity files with `@Entity()` decorators
   - Django: `models.py`
   - Rails: `db/schema.rb`
   - Raw SQL: `migrations/` directory
2. Parse the schema to understand tables, columns, relationships
3. Help the user with their query needs:
   - **Write** — Generate SQL from natural language description
   - **Optimize** — Analyze slow queries, suggest indexes, rewrite for performance
   - **Explain** — Break down complex queries into plain English
   - **Debug** — Fix queries that return wrong results

## Query Writing Rules
- Always use parameterized queries (never string concatenation)
- Prefer explicit JOINs over subqueries when possible
- Include appropriate WHERE clauses to prevent full table scans
- Use LIMIT for queries that might return large result sets
- Add comments explaining non-obvious logic

## Optimization Checklist
When asked to optimize a query:
1. Check for missing indexes on WHERE/JOIN/ORDER BY columns
2. Look for N+1 patterns (loop of queries instead of JOIN)
3. Check if SELECT * can be narrowed to specific columns
4. Identify unnecessary subqueries that can be rewritten as JOINs
5. Check for implicit type conversions that prevent index usage
6. Suggest EXPLAIN ANALYZE output for verification

## Rules
- Read the actual schema before writing queries — don't assume table/column names
- Respect the project's ORM — suggest Prisma/Drizzle queries when appropriate, not just raw SQL
- Always warn about potentially destructive operations (DELETE, UPDATE without WHERE)
