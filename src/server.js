var path = require('path');
var process = require('process');
const express = require('express')
const cookieParser = require('cookie-parser');
var cors = require('cors');
const app = express()
const port = 3000
const connection = require('./database')

const debug = true
const authException = ['/api/start', '/api/questions', '/api/options', '/api/leaderboard']

// Hits CORS on the head with a blunt object to make it work
app.use(cors({
    origin: 'http://localhost:5173',
    credentials: true
}))

// Serve frontend
app.use(express.static(path.join(__dirname, '../build')));

// Cookie parsing middleware
app.use(cookieParser());

// JSON middleware
// All POST requests to the api will contain a json body
app.use(express.json())

let allPoints = {}
let times = {}
let groupNames = {}

// Logging middleware
// For some debugging purposes
app.use((req, res, next) => {
    console.log(`[${req.method}] [${req.ip}] [${req.headers['user-agent']}] ${req.url}`)

    if (debug) {
        console.log('Request body:')
        console.log(req.body)
    }

    next()
})

// 'Authorization' middleware
// This middleware checks if the request contains a 'team' cookie.
// The cookie contains the team name.
/*
app.use((req, res, next) => {
    if (authException.find((element) => {
        if (req.url.includes(element)) {
            return true
        }
    })) {
        next()
        return
    }

    if (req.cookies.team) {
        next()
    } else {
        res.status(401).json({
            error: 'Hups! Tiimisi ei ole määritetty. Siirtyisitkö takaisin aloitussivulle ja valitsisit tiiminimesi?'
        })
    }
})
*/

app.post('/api/start', async (req, res) => {
    const body = req.body

    // Apply a set cookie header to the response
    connection.query('SELECT id FROM questions', (error, results) => {
        if (error) {
            console.error(error)
            return
        }

        // add a random digit identifier to the team name
        const teamName = body.team_name + Math.floor(Math.random() * 10000)

        res.cookie('team', teamName), {
            path: '/',
            sameSite: 'None',  // Allows cross-origin cookies
            secure: false,     // Should be true in production with HTTPS
            httpOnly: false    // Allows access from JavaScript
        };
        
        times[teamName] = Date.now()

        res.json({
            "questions": results.map((question) => {
                return question.id
            }),
            "time_limit": 60 * 12
        })
    })
})

app.post('/api/answer', async (req, res) => {
    const body = req.body;

    // Verify questionId
    if (isNaN(body.question_id)) {
        res.status(400).json({
            error: 'Invalid question ID'
        });
        return;
    }

    // Verify request contains array of answers
    if (!Array.isArray(body.answers)) {
        res.status(400).json({
            error: 'Invalid answer array'
        });
        return;
    }

    connection.query('SELECT * FROM answers WHERE related_question = ?', [body.question_id], (error, results) => {
        if (error) {
            console.error(error);
            res.status(500).json({ error: 'Database query error' });
            return;
        }

        const totalOptions = results.length;
        const correctAnswers = results.filter(answer => answer.is_correct === 1);
        const incorrectAnswers = results.filter(answer => answer.is_correct === 0);
        const basePoints = 100;
        const pointsPerCorrect = basePoints / correctAnswers.length;
        const penaltyPerIncorrect = basePoints / totalOptions;

        let points = 0;

        correctAnswers.forEach(answer => {
            if (body.answers.includes(answer.id)) {
                points += pointsPerCorrect;
            }
        });

        incorrectAnswers.forEach(answer => {
            if (body.answers.includes(answer.id)) {
                points -= penaltyPerIncorrect;
            }
        });

        if (!allPoints[req.cookies.team]) {
            allPoints[req.cookies.team] = 0;
        }

        if (points > 0) {
            allPoints[req.cookies.team] += points;
        }

        res.json({
            correct: correctAnswers.map(answer => answer.id),
            incorrect: incorrectAnswers.map(answer => answer.id),
            total_points: allPoints[req.cookies.team]
        });
    });
});
app.get('/api/questions/:questionId', async (req, res) => {
    const questionId = req.params.questionId

    // Verify questionId
    if (isNaN(questionId)) {
        res.status(400).json({
            error: 'Invalid question ID'
        })
        return
    }

    connection.query('SELECT * FROM questions WHERE id = ?', [questionId], (error, results) => {
        if (error) {
            console.error(error)
            return
        }

        if (results.length === 0) {
            res.status(404).json({
                error: 'Question not found'
            })
            return
        }

        let firstQuestion = results[0]

        let answers = connection.query('SELECT * FROM answers WHERE related_question = ?', [questionId], (error, results) => {
            if (error) {
                console.error(error)
                return
            }

            firstQuestion.answers = results.map((answer) => {
                return {
                    id: answer.id,
                    answer: answer.answer_title,
                }
            })

            res.json(firstQuestion)
        })
    })
})

app.get('/api/leaderboard', async (req, res) => {
    connection.query('SELECT group_name, score, time FROM scores ORDER BY score DESC', (error, results) => {
        if (error) {
            console.error(error)
            return
        }

        res.json({
            leaderboard: results
        })
    })
});

app.post('/api/end', async (req, res) => {
    console.log(allPoints)
    console.log(req.cookies.team)
    console.log(allPoints[req.cookies.team])
    console.log(times[req.cookies.team])
    console.log(Date.now() - times[req.cookies.team])
    console.log(req.cookies)

    connection.query('INSERT INTO scores (group_name, score, time) VALUES (?, ?, ?)', [req.cookies.team, allPoints[req.cookies.team], Date.now() - times[req.cookies.team]], (error, results) => {
        if (error) {
            console.error(error)
            return
        }

        res.json({
            "score": allPoints[req.cookies.team],
            "time": Date.now() - times[req.cookies.team]
        })
    })
})

app.post('/')

app.listen(port, () => {
    console.log(`[Startup] Kyselysivu API is running on port ${port}`)
})

app.get('/*', function(req,res) {
    res.sendFile(path.join(process.cwd(), '/build/index.html'));
});
