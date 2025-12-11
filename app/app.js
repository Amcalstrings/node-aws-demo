const express = require('express');
const client = require('prom-client');
const app = express();

client.collectDefaultMetrics();

const counter = new client.Counter({
    name: 'http_requests_total',
    help: 'Total number of Http Requests'
})

app.get('/', (req, res) =>{
    counter.inc();
    res.send('Hello from DevOps Class')
});

app.get('/health', (req, res) =>res.send('ok'));
app.get('/metrics', async(req, res)=>{
    res.set('Content-Type', client.register);
    res.end(await client.register.metrics());
})

app.listen(3000, () => console.log('Listening 3000'))
