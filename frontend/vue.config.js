module.exports = {
  "transpileDependencies": [
    "vuetify",
    "vue-echarts",
    "resize-detector"
  ],
  chainWebpack: config => {
    config
      .plugin('html')
      .tap(args => {
        args[0].title = 'cFos-ANAB'
        return args
      })
  }
}