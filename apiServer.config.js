module.exports = {
    apps:[{
        name:'red',
        script:'./app.js',
        instances: 2,//코어 수 0은 제한 없음 
        exec_mode:'cluster',
        merge_logs:true,
        autorestart:true,
        watch:process.env.NODE_ENV === 'development'
    }]
}