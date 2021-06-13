import os
import cv2
import face_recognition
import numpy as np

path = 'UsersImages'
images=[] # Read all images
imagesName=[] # Read only image name
imagesPaths=os.listdir(path) # Read the paths of the images
print(imagesPaths)

for cl in imagesPaths:
    currentImage=cv2.imread(f'{path}/{cl}')
    images.append(currentImage)
    imagesName.append(os.path.splitext(cl)[0])
print(imagesName)

def findEncodings(images):
    encodedImagesList=[]
    for img in images:
        img=cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        encode = face_recognition.face_encodings(img)[0]
        encodedImagesList.append(encode)
    return encodedImagesList


encodeTest=findEncodings(images)
print('All images encoded successfully.')

cam = cv2.VideoCapture(0)

while True:
    success, img=cam.read()
    imgS=cv2.resize(img,(0,0),None,0.25,0.25)
    imgS = cv2.cvtColor(imgS, cv2.COLOR_BGR2RGB)

    facesCurrFrame=face_recognition.face_locations(imgS)
    encodesCurrFrame = face_recognition.face_encodings(imgS,facesCurrFrame)

    for encodeFace, faceLoc in zip(encodesCurrFrame, facesCurrFrame):
        matches = face_recognition.compare_faces(encodeTest, encodeFace)
        faceDis = face_recognition.face_distance(encodeTest, encodeFace)
        print(faceDis)

        matchIndex = np.argmin(faceDis)
        if matches[matchIndex]:
            name = imagesName[matchIndex].capitalize()
            print(name)
            y1, x2, y2, x1 = faceLoc
            y1, x2, y2, x1 = y1 * 4, x2 * 4, y2 * 4, x1 * 4
            cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 1)
            cv2.putText(img, name, (x1 + 6, y2 - 6), cv2.FONT_HERSHEY_COMPLEX, 1, (0, 0, 0), 2)

    k = cv2.waitKey(10) & 0xff
    if k == 27:
        break

    cv2.imshow('Webcam', img)
    cv2.waitKey(1)