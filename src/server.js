const express = require('express')
const cookieParser = require('cookie-parser');
var cors = require('cors');
const app = express()
const port = 3000
const connection = require('./database')

const debug = true
const authException = ['/api/leaderboard', '/api/questions', '/api/options']

// Hits CORS on the head with a blunt object to make it work
app.use(cors());

// Cookie parsing middleware
app.use(cookieParser());

// JSON middleware
// All POST requests to the api will contain a json body
app.use(express.json())

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
app.use((req, res, next) => {
    if (authException.includes(req.url)) {
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


app.get('/api/questions', (req, res) => {
    questions = connection.query('SELECT * FROM questions', (error, results) => {
        if (error) {
            console.error(error)
            return
        }

        res.json({
            questions: results
        })
    })    
});

app.post('/api/options', (req, res) => {
    const body = req.body
    const questionId = body.questionId

    options = connection.query('SELECT * FROM answers WHERE related_question = ?', [questionId], (error, results) => {
        if (error) {
            console.error(error)
            return
        }

        res.json({
            options: results
        })
    })
});

app.get('/api/leaderboard', (req, res) => {
    res.json({
        leaderboard: [
            {
                team: 'Team 1',
                points: 10
            },
            {
                team: 'Team 2',
                points: 5
            },
            {
                team: 'Team 3',
                points: 2
            },
            {
                team: 'Team 4',
                points: 2
            },
            {
                team: 'Team 5',
                points: 20
            },
            {
                team: 'Team 6',
                points: 1
            }
        ]
    })
});

app.post('/')

app.listen(port, () => {
  console.log(`[Startup] Kyselysivu API is running on port ${port}`)
})
