# FastAPI Testing Command

Create comprehensive API tests for: $ARGUMENTS

## Testing Strategy
Test the following API endpoints and scenarios based on $ARGUMENTS:

1. **Happy Path Testing**:
   - Valid request formats
   - Expected response structures
   - Proper HTTP status codes

2. **Error Handling Testing**:
   - Invalid request payloads
   - Authentication failures
   - Authorization edge cases
   - Validation errors (422)

3. **Edge Cases**:
   - Boundary value testing
   - Large payload handling
   - Concurrent request handling
   - Database constraints

## Test Structure Template
Create tests in `/tests/api/test_{endpoint_name}.py`:

```python
import pytest
from httpx import AsyncClient

class Test{EndpointName}:
    @pytest.mark.asyncio
    async def test_create_{resource}_success(self, client: AsyncClient, auth_headers):
        # Test implementation
        pass
    
    @pytest.mark.asyncio
    async def test_get_{resource}_not_found(self, client: AsyncClient, auth_headers):
        # Test implementation
        pass
    
    @pytest.mark.asyncio
    async def test_update_{resource}_unauthorized(self, client: AsyncClient):
        # Test implementation
        pass
```
