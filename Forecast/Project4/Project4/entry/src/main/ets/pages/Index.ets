// @ts-nocheck

import router from '@ohos.router'
import { cityView } from '../view/cityView'
import { lifeView } from '../view/lifeView'
import getweatherUtil from "../viewmodel/getWeatherUtil"
import { WeatherModel } from '../viewmodel/WeatherModel'


@Entry
@Component
struct Index {
  @State cityCodeList :number[]=[110000,120000]
  @State citynameList:string[]=[]
  @State cityWeatherList :Array<WeatherModel>= []
  @State cityIndex:number=0
  @State lifeList: string[] = [];
  tabcontroller:TabsController=new TabsController()

  scroller:Scroller = new Scroller()

  @Builder tabBulid(index:number){
    Circle({width:10,height:10})
      .fill(this.cityIndex===index?Color.White:Color.Gray)
      .opacity(0.4)
  }

  onPageShow(){
    let params=router.getParams()
    if(params){
      this.cityCodeList=params["codes"]
      this.cityWeatherList=[]
      this.citynameList=[]
      this.initDate()
    }
  }
  //获取数据
  aboutToAppear(){
    this.initDate()
  }

  //初始化方法
  async initDate(){
    let result :Array<WeatherModel> =await getweatherUtil.getWeathers(this.cityCodeList)
    for(let i=0;i<result.length;i++){
      let ACityWeather=new WeatherModel()
      ACityWeather=result[i]
      this.cityWeatherList.push(ACityWeather)

      let cityName=result[i].forecasts[0].city
      this.citynameList.push(cityName)

    }

  }

  //数据展示
  build(){
    Column(){
        Row(){
          Button("添加")
            .fontSize(25)
            .fontColor(Color.Gray)
            .opacity(0.7)
            .backgroundColor("#ff87c8eb")
            .margin({bottom:15})
            .onClick(()=>{
              router.pushUrl({
                url:"pages/AddCity",
                params:{
                  codes:this.cityCodeList,
                  names:this.citynameList
                }
              })
            })
        Text(this.citynameList[this.cityIndex])
          .fontSize(40)
          .fontColor(Color.Black)
          Button("删除")
            .fontSize(25)
            .fontColor(Color.Red)
            .opacity(0.7)
            .backgroundColor("#FF87D7EB")
            .margin({bottom:15})
            .onClick(()=>{
              AlertDialog.show({
                title:"删除",
                message:`你确定要删除${this.citynameList[this.cityIndex]}吗`,
                confirm:{
                  value:"确定",
                  action:()=>{
                    this.citynameList=
                    this.citynameList.filter(item=>item!==this.citynameList[this.cityIndex])
                    this.cityCodeList=
                    this.cityCodeList.filter(item=>item!==this.cityCodeList[this.cityIndex])
                    this.cityWeatherList=
                    this.cityWeatherList.filter(item=>item!==this.cityWeatherList[this.cityIndex])
                  }
                }

              })
            })
        }.width("100%")
         .height("10%")
         .justifyContent(FlexAlign.SpaceBetween)

      Tabs({barPosition:BarPosition.Start,controller:this.tabcontroller}){

        ForEach(this.cityWeatherList,(cityWeather:WeatherModel)=>{
          TabContent(){
            Scroll(this.scroller){
              Column(){
                cityView({casts:cityWeather.forecasts[0].casts})
                lifeView({casts:cityWeather.forecasts[0].casts})
                Text("生活建议")
                  .fontSize(40)
                  .fontColor(Color.Black)
              }
            }
          }.tabBar(this.tabBulid(this.cityWeatherList.findIndex(obj=>obj===cityWeather)))
        })
      }.barWidth(30)
      .barHeight(40)//40
      .onChange((index:number)=>{
        this.cityIndex=index
      })

    }
      .width('100%')
      .height('auto')
      .backgroundImage($r('app.media.B1'))
      .backgroundImageSize(ImageSize.Cover)
      .opacity(0.8)
  }

}
