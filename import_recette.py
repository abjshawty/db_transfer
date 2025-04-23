import os
path_here = os.path.dirname(__file__)
databases = os.listdir(f"{path_here}/recette_data")
for database in databases:
    collections = os.listdir(f"{path_here}/recette_data/{database}")
    for collection in collections:
        if collection.endswith('.json'):
            with open(f"{path_here}/recette_data/{database}/{collection}", "r") as f:
                data = f.readline().strip("\n")
            if data == "[]":
                print(f"skipped {collection} since it was empty")
                continue
            print(collection)
            os.system(f"mongoimport --host=rs0/localhost:27017 --collection {collection.split('.')[1]} --type json --file {path_here}/recette_data/{database}/{collection} --jsonArray --db {database}")
print("Done.")