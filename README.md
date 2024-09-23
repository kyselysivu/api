# Kyselysivu Backend

An API for [Kyselysivu](https://github.com/Finfeny/Kyselysivu-front)

## Running
Install dependencies
`npm install`

Run server
`node src/server.js`

## Protocol

### Starting a game session

1. Client -> `POST /api/start`
   ```json
   {"team_name": "string"}
   ```

   Response headers contain a Set-Cookie session token that the client must use in all subsequent requests.
    ```json
    {
        "questions": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        "time_limit": 720
    }
    ```
### Getting a question

The client is expected to fetch questions based on their ID, in the order that they are given by the server in the response to the `/api/start` request.
1. Client -> `GET /api/question/<id>`

   Response:
    ```json
    {
        "id": 1,
        "question_title": "Example Question!!!!",
        "image_src": "https://example.com/image.jpg",
        "additional_html": "<p>Additional HTML</p>",
        "answers": [{"id": 0, "answer": "string"}, ...],
    }
    ```
   
    "Additional HTML" is an optional workaround to specific types of questions where the implementation
    of a specific type of question would be more trouble than it's worth - for example, questions with Code Blocks.
    We don't have the time to implement all of those question types so we just made it so you can embed whatever you want into the question. Go wild.


### Responding to questions
1. Client -> `POST /api/answer`
   ```json
   {"question_id": 0, "answers": [1, 2]}
   ```

   The server then responds with all the correct & incorrect answers to the question.
    ```json
    {
        "correct": [1, 2, 3],
        "incorrect": [4, 5, 6],
        "time_bonus": 100
    }
    ```


### Ending a game session
The game session should be concluded when there are no more questions left or the time limit has been reached.
The client should immediately follow up with a request to conclude the game session.

1. Client -> `POST /api/end`

   The server responds with the team's final score and time in milliseconds.
    ```json
    {
        "score": 100,
        "time": 10000
    }
    ```


### Fetching the leaderboard
1. Client -> `GET /api/leaderboard`

   The server responds with the top teams and their scores & times in ms. Yes, all of them. Pagination? Hardly know her.
    ```json
    {
        "leaderboard": [
            {"team_name": "string", "score": 100, "time": 10000},
            ...
        ]
    }
    ```

## Scoring
Score calculation formula:

For each correct answer, you get 100 points. For each incorrect answer, you lose 100 points. You can not get
negative points in a single question. If you answer all questions correctly, you get a time bonus that peaks at 20
seconds that peaks at 20 seconds and decreases linearly to 0 at 120 seconds.