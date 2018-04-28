import os

def loadCountryCodes(map):
    file = open('countryCodes.txt', 'r')
    sqlFile = open('countries.sql', 'w')

    file.readline()
    while True:
        str = file.readline()

        if len(str) == 0:
            break

        print(str)
        value, key = str.split(',')
        print(key + "=>" + value)
        map[key] = value
        sqlFile.write("INSERT INTO country(name) VALUES('" + value + "');\n")

    sqlFile.close()
    file.close()




def countryPopulate():
    code2country = {}
    loadCountryCodes(code2country)

    for keys,values in code2country.items():
        print(keys)
        print(values)
    return


countryPopulate()
