# Two-Stage Config Validation Pattern

Procedural pattern for validating configuration files that map to code parameters.

---

**Title:** Two-Stage Config Validation Pattern
**Description:** Test config files with actual class instantiation, not just YAML parsing, to catch parameter name mismatches.

**Content:** When creating configuration files (YAML/JSON) that map to code parameters, validate in two stages:

1. **Stage 1: Syntax Validation** - YAML/JSON parses without errors
2. **Stage 2: Integration Validation** - Instantiate actual class with config values

**Real Bug Caught**: Created `environment.yaml` with parameter `bb_std_dev`, but `BBMeanReversionParams` NamedTuple expected `bb_std`. YAML parsed fine, but got `TypeError: unexpected keyword argument 'bb_std_dev'` on instantiation.

**Why Two-Stage Matters**:
- YAML syntax validation only checks format, not semantics
- Parameter name typos are valid YAML (just wrong keys)
- Bugs surface late (runtime) instead of early (creation time)

**Implementation Pattern**:
```python
# After creating config file, immediately test:
try:
    config = yaml.safe_load(open('config.yaml'))
    params = MyClass(**config['parameters'])  # Instantiate actual class
    print(f"✅ Config validated: {params}")
except TypeError as e:
    print(f"❌ Parameter mismatch: {e}")
    # Fix config now, not after commit
```

**Value Proposition**:
- 5 minutes testing saves 30+ minutes debugging after commit
- Catches typos before they enter git history
- Prevents broken deploys from config-code misalignment
- Especially critical for NamedTuple/dataclass with strict signatures

**Applicability**: Any language with config files mapping to code (Python dataclasses, Java POJOs, TypeScript interfaces, Go structs, etc.)

**Cross-Language Examples**:

**TypeScript:**
```typescript
// After creating config.json, validate:
import { MyConfig } from './types';
const rawConfig = require('./config.json');
const config: MyConfig = plainToClass(MyConfig, rawConfig);
// Will fail if property names mismatch interface
```

**Java:**
```java
// After creating application.yml, validate:
ObjectMapper mapper = new ObjectMapper(new YAMLFactory());
MyConfig config = mapper.readValue(
    new File("config.yml"),
    MyConfig.class
);
// Fails if YAML keys don't match Java field names
```

**Go:**
```go
// After creating config.yaml, validate:
var config MyConfig
yamlFile, _ := ioutil.ReadFile("config.yaml")
err := yaml.Unmarshal(yamlFile, &config)
if err != nil {
    log.Fatalf("Config mismatch: %v", err)
}
```

**Testing Strategy**:
1. Create config file
2. Write simple validation script that instantiates the actual production class
3. Run validation script immediately
4. Only commit if validation passes
5. Include validation script in CI/CD to catch config drift

**Failed Approach**: Relying solely on YAML linters or schema validation without actual class instantiation. Schema validators can check types but miss parameter name typos.

**Tags:** #procedural #config #validation #testing #success #preventive #universal #yaml #json #python #typescript #java #go #dataclass #namedtuple

---
