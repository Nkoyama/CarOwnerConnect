import os

bind = '160.16.217.34:' + str(os.getenv('PORT', 80))
proc_name = 'Infrastructure-Practice-Flask'
reload = True
workers = 1

