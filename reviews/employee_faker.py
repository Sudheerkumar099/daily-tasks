from faker import Faker
fake = Faker(locale="en_IN")
n = 200
emp_data = dict()
for i in range(1, n+1):
    emp_details = dict()
    emp_id = i #fake.random_int(min = 1, max = 200)
    department = fake.random_element(elements = ["IT","HR","Accounts","Sales","Marketing"])
    salary = fake.random_int(min = 10000, max = 90000, step=1000)
    experience_years = fake.random_int(min = 0, max = 20)
    performance_score = fake.random_int(min = 35 ,max = 100 )

    emp_details["emp_id"] = emp_id
    emp_details["department"] = department
    emp_details["salary"] = salary
    emp_details["experience_years"] = experience_years
    emp_details["performance_score"] = performance_score

    emp_data[i] = emp_details

with open("employee_data.csv", "w") as f:
    f.write("Emp_Id,Department,Experience_Years,Salary,Performance_Score\n")
    for i in range(1, n+1):
        f.write(f"{emp_data[i]['emp_id']},{emp_data[i]['department']},{emp_data[i]['experience_years']},{emp_data[i]['salary']},{emp_data[i]['performance_score']}\n")