const express = require("express");
const path = require('path');
const morgan = require("morgan");
const passport = require('passport');
const cors = require('cors');
const static = require('serve-static');
const compression = require('compression');

const jkh_f = require('./api/lib/jkh_function');
require('./api/lib/express_group');
const app = express();
app.disable('x-powered-by'); // x-powered-by 헤더 비활성화
app.use(cors({
    exposedHeaders: ['Content-Disposition'], // 다운로드 시 파일명 첨부 허용
})); // CORS 해제
app.options('*', cors()); // CORS Pre-Flight 활성화
app.use(express.json());
app.use(express.urlencoded({ extends: true }));
app.use(passport.initialize());//passport 실행
app.use(compression());
app.use('/web',static(path.join(__dirname,'views')));
app.get('/', (req, res) => {
    return res.status(302).redirect('/web/index.html');
})
app.use(morgan('combined', { stream: jkh_f.logstream }))//로그파일로 관리 함 1일단위
app.all('*', (req, res, next) => {
    console.info(`req:${req.ip}  ${req.method} ${req.originalUrl}`);
    return next();
});
app.use('/api/user/v1', require('./api/user/v1')); //사용자
// app.use('/api/admin/v1', require(`./api/admin/v1`)); //admin 
app.listen(3000, () => {
    console.log(`[${jkh_f.getDate.toLocaleString()}}] http://localhost:3000`);
    console.info()
});
//ip관련 처리 해줄것
