# cfosdb

# API script
## Start api service
Run the nodejs file: [api.js](https://github.com/wenjie1991/cfosdb/blob/master/server/api.js)

## API
```
localhost:8080?behavior=<behavior_list>&brain_code=<brain_area_list>&gender=<gender>&species=<species>
behavor_list: the list of behavior, seperated by comma.
brain_area_list: the brain area list, seperated by comma.
gender: "male", "female", or "%" for both.
species: "rat" or "mouse"
```
Exp.
```
localhost:8080?behavior=pain,aggression&brain_code=R5,R7,R37&gender=%&species=rat
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
  long text, 
  abbr text, 
  species text 
)
```

**brain_area_behavior**:
```sql
CREATE TABLE brain_area_behavior ( 
  brain_code text, 
  behavior text, 
  strain text, 
  gender text, 
  doi text, 
  condition text, 
  figure text, 
  cell_type text 
)
```
## Other json files
[mouse_joint_matrix.json](https://github.com/wenjie1991/cfosdb/blob/master/data/mouse_joint_matrix.json) descirb the overlap brain area of two behaviors for mouse. And the file [rat_join_matrix.json](https://github.com/wenjie1991/cfosdb/blob/master/data/rat_joint_matrix.json) is dedicated to Rat.

The brain area annotation file [clean_brain_area_annotation.json](https://github.com/wenjie1991/cfosdb/blob/master/data/clean_brain_area_annotation.json) contains the `coding` and the name of brain area.
