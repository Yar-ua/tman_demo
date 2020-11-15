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
```sql
SELECT DISTINCT status FROM tasks ORDER BY status ASC
```

- get the count of all tasks in each project, order by tasks count
descending
```sql
SELECT project_id, COUNT(id) count
FROM tasks
GROUP BY project_id
ORDER BY count DESC
```

- get the count of all tasks in each project, order by projects
names
```sql
SELECT p.name, COUNT(t.id) count_of_tasks
FROM projects p
INNER JOIN tasks t ON p.id = t.project_id
GROUP BY t.project_id
ORDER BY p.name ASC
```

- get the tasks for all projects having the name beginning with
"N" letter
```sql
SELECT *
FROM tasks
WHERE name LIKE 'N%'
```
- get the list of all projects containing the 'a' letter in the middle of
the name, and show the tasks count near each project. Mention
that there can exist projects without tasks and tasks with
project_id = NULL
```sql
SELECT p.*, COUNT(t.id) count_of_tasks
FROM projects p
INNER JOIN tasks t ON p.id = t.project_id
WHERE t.name LIKE '%a%'
GROUP BY t.project_id
```
- get the list of tasks with duplicate names. Order alphabetically
```sql
SELECT * 
FROM tasks 
INNER JOIN(
    SELECT name  
    FROM tasks  
    GROUP BY name  
    HAVING COUNT(name) > 1  
) temp ON tasks.name = temp.name
ORDER BY tasks.name ASC
```
- get list of tasks having several exact matches of both name and
status, from the project 'Garage'. Order by matches count
```sql
SELECT t.name, t.status, COUNT(t.name) c
FROM tasks t
INNER JOIN projects p ON t.project_id = p.id
INNER JOIN (
  SELECT CONCAT(name, status) ns
    FROM tasks
    GROUP BY ns
    HAVING COUNT('ns') > 1
) temp ON CONCAT(t.name, t.status) = temp.ns
WHERE p.name = 'Garage'
GROUP BY t.name, t.status
ORDER BY c ASC
```
- get the list of project names having more than 10 tasks in status
'completed'. Order by project_id
```sql
SELECT p.name
FROM projects p
INNER JOIN (
  SELECT project_id
    FROM tasks
    GROUP BY project_id
    WHERE status = 'completed'
    HAVING COUNT('id') > 10
) t ON t.project_id = p.id
ORDER BY p.id ASC
```