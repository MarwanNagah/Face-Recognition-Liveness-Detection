import face_recognition

known_image = face_recognition.load_image_file('UsersImages/Messi.jpg')
known_image_encoding=face_recognition.face_encodings(known_image)[0]

unknown_image= known_image = face_recognition.load_image_file('UsersImages/Mohamed.jpeg')
unknown_image_encoding = face_recognition.face_encodings(unknown_image)[0]

results = face_recognition.compare_faces([known_image_encoding],unknown_image_encoding)

if results[0]:
    print('Known face')
else:
    print('Unknown face')