# Explore API Command

Test and document the real behavior of external APIs from: $ARGUMENTS

## Objective
Test the API endpoints in practice, discover actual vs documented behavior, then create accurate documentation and tests based on reality.

## Process

1. **Parse** - Extract endpoints, methods, and expected behaviors from docs
2. **Test** - Run each endpoint with normal, error, edge, and boundary cases
3. **Discover** - Note differences between docs and reality (undocumented fields, actual error codes, hidden limits)
4. **Schema** - Analyze and document complete data schemas for SQL database integration
5. **Document** - Create enhanced docs with real behaviors, gotchas, and examples
6. **Generate** - Build test suite based on actual responses
7. **Archive** - Save all raw API responses to `/Users/sonph36/dev/demo/NghiaNQ/claude-code-learning/output/raw_response` for review and future data reference

## Output
- `api-exploration-results.md` - Findings and discrepancies
- `api-enhanced-docs.md` - Accurate documentation
- `api-schemas.md` - Complete data schemas for SQL database design
- `/Users/sonph36/dev/demo/NghiaNQ/claude-code-learning/output/raw_response/` - Raw API responses for review and reference
- Test suite with real-world scenarios
- Mock data from actual responses

## Focus
Document how the API actually works versus what the docs claim - even "normal" usage often differs from documentation. Capture real response structures, actual required parameters, true error formats, and all the undocumented quirks.

## Notes
**Key Discoveries from Initial Testing:**

- **Error Handling**: vnstock uses RetryError wrapper for failed API calls, masking the original error details
- **Data Source Validation**: Some symbols (bonds, futures) trigger "Không phải là mã chứng khoán" warnings but still return data
- **Symbol Compatibility**: Different data sources (VCI, TCBS) have varying support for asset types
- **Rate Limiting**: Some API calls appear to have retry mechanisms built-in (observed 4+ second delays on failures)
- **Data Structure**: All successful responses return pandas DataFrames with rich metadata (name, category attributes)
- **Real-time vs Historical**: Intraday and price_depth APIs work for stocks but may not be available for all asset types
- **Schema Consistency**: Column names and data types vary between similar endpoints from different sources
- **Performance**: API response times range from ~200ms for simple calls to 4+ seconds for complex/failed requests