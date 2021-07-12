# cfosdb

## Prototyping

Full featured prototype: https://www.figma.com/proto/omgiSy8oK0iAFBXoCVWQbJ/cfosdb?node-id=3%3A25&scaling=min-zoom

# API script

## Start api service
Run the nodejs file: [api.js](https://github.com/wenjie1991/cfosdb/blob/master/server/api.js)

## API

```
localhost:8081?behavior=<behavior_list>&brain_code=<brain_area_list>&gender=<gender>&species=<species>
behavor_list: the list of behavior, seperated by comma.
brain_area_list: the brain area list, seperated by comma.
gender: "male", "female", or "%" for both.
species: "Rat" or "Mouse"
```

Exp.
```
localhost:8081?behavior=pain,aggression&brain_code=R5,R7,R37&gender=%&species=Rat
```

# Data

## Database

The SQLite database: [cFosDB.db](https://github.com/wenjie1991/cfosdb/blob/master/data/cFosDB.db)
There are two table in the database.

**brain_area_annotation**:

```sql
CREATE TABLE brain_area_annotation ( 
  brain_code text primary key, 
  main text,
	long_1	text,
	short_1	text,
  long_2	text,
	short_2	text,
  long_3	text,
	short_3	text,
	species text
)
```

**brain_area_behavior**:

```sql
CREATE TABLE brain_area_behavior ( 
  brain_code text, 
  behavior text, 
  species text, 
  gender text, 
  doi text, 
  condition text, 
  figure text, 
  cell_type text 
)
```

## Other json files

The files useful for frontend is in `frontend/src/assets/`.
