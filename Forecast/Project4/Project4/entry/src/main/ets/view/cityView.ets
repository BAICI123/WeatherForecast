import {casts} from "../viewmodel/casts"
@Component
export struct cityView{
  //获取数据

  //城市天气数据
  casts:Array<casts> =[]
 @Builder weatherImage(weather:string){

     if(weather==="晴"){
       Image($r('app.media.Sun'))
         .width(30)
     }
     if(weather==="阴"){
       Image($r('app.media.Dark'))
         .width(30)
     }
     if(weather==="多云"){
       Image($r('app.media.Cloudy'))
         .width(30)
     }
     if(weather==="小雨"){
       Image($r('app.media.LRain'))
         .width(30)
     }
     if(weather==="中雨"){
       Image($r('app.media.MRain'))
         .width(30)
     }
     if(weather==="大雨"){
       Image($r('app.media.HRain'))
         .width(30)
     }
     if(weather=="雷阵雨"){
       Image($r('app.media.SRain'))
         .width(30)
     }

 }

  //展示数据
  build(){
      Column(){
        ForEach(this.casts,(cast:casts)=>{
          if(this.casts[0]===cast){
              //图片
            Row(){
             if(cast.dayweather==="晴"){
               Image($r('app.media.Sun'))
                 .width(260)
             }
              if(cast.dayweather==="阴"){
                Image($r('app.media.Dark'))
                  .width(260)
              }
              if(cast.dayweather==="多云"){
                Image($r('app.media.Cloudy'))
                  .width(260)
              }
              if(cast.dayweather==="小雨"){
                Image($r('app.media.LRain'))
                  .width(260)
              }
              if(cast.dayweather==="中雨"){
                Image($r('app.media.MRain'))
                  .width(260)
              }
              if(cast.dayweather==="大雨"){
                Image($r('app.media.HRain'))
                  .width(260)
              }
              if(cast.dayweather==="雷阵雨"){
                Image($r('app.media.SRain'))
                  .width(260)
              }
            }.height("35%")

            Column(){
              //温度
              Row(){
                Text(cast.dayweather)
                  .fontSize(30)
                  .fontColor(FontWeight.Bold)

                Text(" "+cast.nighttemp+"°~"+cast.daytemp+"°")
                  .fontSize(30)
                  .fontColor(Color.White)
                  .fontWeight(FontWeight.Bold)
              }

              Row(){
                Text(cast.daywind+"风")
                  .fontSize(30)
                Text(cast.daypower+"级")
                  .fontSize(30)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
              }
            }.margin({top:10})
          }

        })

        Column(){
          Text("近期天气查询")
            .fontSize("26")
            .margin({top:30})
          Row(){
            ForEach(this.casts,(cast:casts)=>{
              Column(){
                Text(cast.date.substring(5))
                this.weatherImage(cast.dayweather)
                Text(cast.dayweather)
                Text(cast.daytemp.toString()+"°")
                Line()
                  .width(20)
                  .height(80)
                  .startPoint([10,0])
                  .endPoint([10,70])
                  .stroke(Color.Black)
                  .strokeWidth(3)
                  .strokeDashArray([10,3])
                Text(cast.nightweather)
                Text(cast.nighttemp.toString()+"°")
                this.weatherImage(cast.nightweather)
              }.width("20%")
              .height("100%")
            })
          }
        }
      }.width("100%")
       .height("90%")
  }

}