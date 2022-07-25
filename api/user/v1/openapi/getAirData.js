// const app = express.Router();
const jkh = require('../../../lib/jkh_function');
const { Q, pool } = require('../../../../db/pg');
const schedule = require('node-schedule');
const axios =require('axios');
//임시로 여기에 저장
const temp = `lWzqmJDInly7GXNU8xW%2BrcHIL0TMsN6uGV1TVFYUu2HnuXlRDTju6gPyG3YoYgFhf7UVdIrySTsVvpqxP1pABg%3D%3D`

const getair = async() =>{

}

const jop = schedule.scheduleJob('* * 1 * * *',getair)
//https://blog.naver.com/PostView.naver?blogId=qbxlvnf11&logNo=222489497378&categoryNo=0&parentCategoryNo=0&viewDate=&currentPage=1&postListTopCurrentPage=1&from=postView
// todo (api load -> db save) 1h loof

module.exports = {

}