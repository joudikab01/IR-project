
# IR Project

Information retrieval system project on Quora and Medical datasets 2017
Prepared by students: 
- اسراء ابوسرور 
- محمد عقيل راعي 
- جودي القباني 
- دعاء حمدان 
-  بشر الحسني الجزائري



## Environment requirements
- python >= 3.8
- mongo database


## How to run the project
- Create the following folders on the root:
    - db
    - vectorizer
    - word_embedding_model
    - clustering
- install requirements package
    - pip3 install -r requirements.txt
- in terminal
    - cd .\flask_module\
    - python routes.py

- routes.py has all the needed routes, online and offline:
  - get similar queries or query suggestions (quora, clinical)
  - get search results with auto-correct and adding the query to the queries collection (quora, clinical) without any word embeddings or clustering
  - create inverted index with clustering (quora, clinical)
  - create inverted index (quora, clinical)
  - process text (quora, clinical)