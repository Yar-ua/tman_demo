## README

This is test task-application for RubyGarage course. It's a Task Manager for manage tasks.

Application deployed on Heroku, you can find it by next link:

https://tman-demo.herokuapp.com/

Deployed application already filled by fixtures and created some users.
You can crete new user or use pre-created user with login: '@test.com' and password: '111111'

## Technologies stack

- Docker-container
- Ruby-On-Rails 6 on server side
- Bootstrap & JQuery on client side
- Rails-AJAX for update page without reload
- RSpec for testing


## Functional requirement

- I want to be able to create/update/delete projects - done
- I want to be able to add tasks to my project - done
- I want to be able to update/delete tasks - done
- I want to be able to prioritize tasks into a project - done
- I want to be able to choose deadline for my task - done
- I want to be able to mark a task as 'done' - done

## Technical requirements

- It should be a WEB application - done
- For the client side must be used HTML, CSS (any libs), 
  JavaScript (any libs) - in this application used Bootstrap and JQuery
- For a server side any language as Ruby, PHP, Python, 
  JavaScript, C#, Java - I used Ruby-on-Rails
- It should have a client side and server side validation - done, Bootstrap validation 
  on client side and Rails validation on server side
- It should look like on screens (see attached file 
  "test-task-ruby-courses-view.png”) - generally it looks like on screen

## Additional requirements

- It should work like one page WEB application and should use AJAX
  technology, load and submit data without reloading a page. - done, used AJAX-Rails
- It should have user authentication solution and a user should only
  have access to their own projects and tasks. - done. Authentication realised with gem Devise.
  User can see all tasks and projects, but have access only for his own projects and tasks.
- It should have automated tests for the all functionality - done, used RSpec for testing.


## SQL task

Given tables:

01. tasks (id, name, status, project_id)
02. projects (id, name)

Technical requirements

- get all statuses, not repeating, alphabetically ordered

SELECT DISTINCT status FROM tasks ORDER BY status ASC
