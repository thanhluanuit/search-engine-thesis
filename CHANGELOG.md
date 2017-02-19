## 0.1.8 (Sun Feb 19, 2017)
Features:
  - Add query expansion method
  - Add UpdateContent method using nokogiri to crawl data from URL
  - Add update related tags by using flickr api
  - Add Twitter Client Crawler

## 0.1.7 (Sun Feb 12, 2017)
Features:
  - Change analyzer to 'english' in content indexes field.
  - Change boost_mode to 'sum' - that mean is total score = elasticsearch score + my score

## 0.1.6 (Thu Feb 9, 2017)
Features:
  - Update search logic to ElasticSearch: Score by annotations and content

## 0.1.5 (Mon Aug 22, 2016)
Features:
  - Add search function and search page UI

## 0.1.4 (Fri Aug 19, 2016)
Features:
  - Add elasticsearch gem - Using elasticsearch-2.3.5
  - Add Searchable module for Document

## 0.1.3 (Thu Aug 11, 2016)
Features:
  - Build Twitter Crawler: Use Twitter Streamming API
  - Build Graph Data: Documents, Annotations, Users

## 0.1.2 (Wed Aug 10, 2016)
Features:
  - Add an association (n-n) between Document and Annotation
  - Add an association (n-n) between Document and User
  - Add an association (n-n) between Annotation and User

## 0.1.1 (Wed Aug 10, 2016)
Features:
  - Add Tweet model
  - Add Document model
  - Add Annotation model
  - Add User model
