from flask import Flask, render_template, request, jsonify
from db import save_calculation

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/calculate", methods=["POST"])
def calculate():

    data = request.get_json()

    num1 = float(data["num1"])
    num2 = float(data["num2"])
    operation = data["operation"]

    if operation == "+":
        result = num1 + num2
    elif operation == "-":
        result = num1 - num2
    elif operation == "*":
        result = num1 * num2
    elif operation == "/":
        result = num1 / num2
    else:
        return jsonify({"error":"Invalid operation"})

    save_calculation(num1, num2, operation, result)

    return jsonify({"result":result})

if __name__ == "__main__":
    app.run(debug=True)