from flask import Flask, request, jsonify
import werkzeug
import string
from azure.cognitiveservices.vision.computervision import ComputerVisionClient
from msrest.authentication import CognitiveServicesCredentials
from azure.cognitiveservices.vision.computervision.models import OperationStatusCodes
import time
from dotenv import load_dotenv
import os
import docx

app = Flask(__name__)

def get_text(image_file,computervision_client):
    # Open local image file
    
    with open(image_file, "rb") as image:
        # Call the API
        read_response = computervision_client.read_in_stream(image, raw=True)

    # Get the operation location (URL with an ID at the end)
    read_operation_location = read_response.headers["Operation-Location"]
    # Grab the ID from the URL
    operation_id = read_operation_location.split("/")[-1]

    # Retrieve the results 
    while True:
        read_result = computervision_client.get_read_result(operation_id)
        if read_result.status.lower() not in ['notstarted', 'running']:
            break
        time.sleep(1)
    
    with open(image_file + '.txt', 'w') as f:
    # Get the detected text
        if read_result.status == OperationStatusCodes.succeeded:
            for page in read_result.analyze_result.read_results:
                for line in page.lines:
                    # Print line
                    f.write(line.text + "\n")

def get_doc(image_file, computervision_client):
    get_text(image_file, computervision_client)
    doc = docx.Document()
    with open(image_file + ".txt", 'r', encoding='utf-8') as openfile:
        line = openfile.read()
        doc.add_paragraph(line)
        doc.save(image_file + ".docx")

@app.route('/upload', methods=["POST"])
def uploa():
    if(request.method == "POST"):
        imageFile = request.files['image']
        filename = werkzeug.utils.secure_filename(imageFile.filename)
        imageFile.save("./images/" + filename)
        return jsonify({
            "message": "Upload successfull"
        })

if __name__ == "__main__":
    app.run(debug=True, port=4000)