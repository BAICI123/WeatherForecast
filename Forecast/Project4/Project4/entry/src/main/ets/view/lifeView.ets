import {casts} from "../viewmodel/casts"
@Component
export struct lifeView{
  //获取数据

  //城市天气数据
  casts:Array<casts> =[]
  @Builder weatherAdvice(weather:string,temp:number){

  }

  //展示数据
  build(){
    Column() {
      Text("生活建议")
        .fontSize(40)
        .fontColor(Color.Black)
      ForEach(this.casts, (cast: casts) => {
        if (this.casts[0] === cast) {
          //图片
          Row() {
            if (cast.daytemp >=30) {
              Text("适宜短袖：天气热，注意防暑降温")
                .fontSize(20)
                .fontColor(Color.Black)
            }
            else if(cast.daytemp >= 24){
              Text("适宜长袖：天气较热，注意防暑降温")
                .fontSize(20)
                .fontColor(Color.Black)
            }
            else if(cast.daytemp >= 18){
              Text("适宜长袖：天气舒适，冷暖宜人")
                .fontSize(20)
                .fontColor(Color.Black)
            }
            else if(cast.daytemp >= 10){
              Text("适宜薄外套：天气舒适，冷暖宜人")
                .fontSize(20)
                .fontColor(Color.Black)
            }
            else if(cast.daytemp >= 0){
              Text("适宜外套：天气较冷，注意防寒保暖")
                .fontSize(20)
                .fontColor(Color.Black)
            }
            else {
              Text("适宜棉袄：天气冷，注意防寒保暖")
                .fontSize(20)
                .fontColor(Color.Black)
            }
          }.height("5%")

          Row(){
            if (cast.dayweather === "晴" || cast.dayweather === "多云"|| cast.dayweather === "阴") {
              Text("不用带伞：天气无雨，可以户外活动")
                .fontSize(20)
                .fontColor(Color.Black)
            }
            else if(cast.dayweather === "小雨" || cast.dayweather === "中雨" || cast.dayweather === "大雨" || cast.dayweather === "雷阵雨"){
              Text("建议带伞：天气有雨，注意带伞避雨")
                .fontSize(20)
                .fontColor(Color.Black)

            }
          }.height("5%")
          Row(){

          }.height("10%")
        }

      })

    }
  }
}