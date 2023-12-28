# ubind-user-domains-input Schema

```txt
http://schema.nethserver.org/cluster/ubind-user-domains-input.json
```

Input schema of the ubind-user-domains action

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                                    |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :-------------------------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [ubind-user-domains-input.json](cluster/ubind-user-domains-input.json "open original schema") |

## ubind-user-domains-input Type

`object` ([ubind-user-domains-input](ubind-user-domains-input.md))

## ubind-user-domains-input Examples

```json
{
  "domains": [
    "mydom.test"
  ]
}
```

# ubind-user-domains-input Properties

| Property            | Type    | Required | Nullable       | Defined by                                                                                                                                                          |
| :------------------ | :------ | :------- | :------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [domains](#domains) | `array` | Required | cannot be null | [ubind-user-domains-input](ubind-user-domains-input-properties-domains.md "http://schema.nethserver.org/cluster/ubind-user-domains-input.json#/properties/domains") |

## domains

One or more domains to ubind from the module calling this action

`domains`

*   is required

*   Type: `string[]`

*   cannot be null

*   defined in: [ubind-user-domains-input](ubind-user-domains-input-properties-domains.md "http://schema.nethserver.org/cluster/ubind-user-domains-input.json#/properties/domains")

### domains Type

`string[]`

### domains Constraints

**minimum number of items**: the minimum number of items for this array is: `1`
