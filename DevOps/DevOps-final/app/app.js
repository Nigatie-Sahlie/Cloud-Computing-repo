// app.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
res.json({
message: 'Hello from ECS Fargate - app version-5!',
containerId: process.env.HOSTNAME,
timestamp: new Date().toISOString()
});
});
app.get('/health', (req, res) => {
res.status(200).send('OK');
});
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
console.log(`Server running on port ${PORT}`);
});