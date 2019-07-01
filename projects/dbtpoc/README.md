# DBTPOC 

### Description
This describes all steps required for booting up this testing environment.

### Requirements:

* Python3.5+
* docker and docker-compose


### Steps to create testing environment:

1. Create a virtualenv and install the requirements.txt file (from root directory of repo):
    ```virtualenv -p python3 venv; source venv/bin/activate; pip install -r requirements.txt```
2. Then install this version of dbt (from root directory of repo):
    ```python setup.py install```
3. Now boot up the dockerized vertica (from root directory): 
    ```cd docker/ ; docker-compose up -d```
4. Copy the profiles.yml to ~/.dbt/profiles.yml
    ```mkdir ~/.dbt ; cp profiles.yml ~/.dbt/profiles.yml```
5. Create the test data in vertica container:
    ```cd ../data ; vsql -h localhost -U dbadmin -f load_test_table1.sql```
6. Source the environment details for vertica (sets creds for container the dbt expects):
    ```source local_env.sh```
7. Run dbt to create new dbt_test.:
    ```dbt run```
8. Check results:
    ```vsql -h localhost -U dbadmin -c "select * from dbt_test.test_table_1_etl ;"```
9. Update the main table with new data:
    ```vsql -h localhost -U dbadmin -f ../data/load_test_table1_new_data.sql```
10. Rerun:
    ```dbt run```
11. Check results:
    ```vsql -h localhost -U dbadmin -c "select * from dbt_test.test_table_1_etl ;"```
