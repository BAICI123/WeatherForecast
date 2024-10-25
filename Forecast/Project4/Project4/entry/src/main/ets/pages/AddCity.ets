import router from '@ohos.router'
import buffer from '@ohos.buffer'
import {AllCityName} from '../viewmodel/AllCityName'
@Entry
@Component
struct AddCity {

  @State AllCityCodeList :number[] =[]
  @State AllCityNameList :Array<string>=new AllCityName().getAllCityName()
         scroller:Scroller=new Scroller()

  @State cityCodeList :number[]=[]
  @State cityNameList :string[]=[]
  @State searchCity: string=""
  @State isReady:Boolean=false

  public async getJsonCodeData()  {
    let data = await getContext(this).resourceManager.getRawFileContent("cityCode.json");
    let str = buffer.from(data.buffer).toString();
    let jsonData = JSON.parse(str);
    this.AllCityCodeList = jsonData.cityCode.map(code => Number(code)); // 存储到 allCityCode
    return this.AllCityCodeList; // 返回数字数组
  }

  async onPageShow(){
    // @ts-ignore
    this.AllCityCodeList=await this.getJsonCodeData()
    let params=router.getParams()
    if(params){
      this.cityCodeList=params["codes"]
      this.cityNameList=params["names"]
    }
  }


  build() {
    Column(){
      Row(){
        TextInput({
          placeholder:'搜索城市信息'
        }).width('70%')
          .onChange((city:string)=>{
            this.searchCity=city
          })
          .fontSize(25)
        Blank()
        Button("完成")
          .fontSize(26)
          .backgroundColor("")
          .onClick(()=>{
            router.back({
              url:"pages/Index",
              params:{
                codes:this.cityCodeList,
                names:this.cityNameList
              }
            })
          })
      }.height("10%")
        .width("95%")
      Column(){
        if(this.searchCity!=""){
          Row(){
              if(this.AllCityNameList.includes(this.searchCity)){
                if(this.cityNameList.includes(this.searchCity)){
                  Text(this.searchCity)
                    .fontSize(35)
                    .fontColor(Color.White)
                    .width("60%")
                    .margin({top:20,left:30})
                  Blank()
                  Text("已添加")
                    .backgroundColor("")
                    .fontSize("18")
                    .margin({top:5})
                    .opacity(0.8)
                }else{
                  Text(this.searchCity)
                    .fontSize(35)
                    .fontColor(Color.White)
                    .width("60%")
                    .margin({top:20,left:30})
                  Blank()
                  Button("添加")
                    .margin({right:5})
                    .onClick(()=>{
                      //根据name获取所在城市索引
                      let index=this.AllCityNameList.findIndex(obj=>obj===this.searchCity)
                      //根据获得的索引得到对应城市的代码
                      let cityCode :number=this.AllCityCodeList[index]

                      this.cityCodeList.push(cityCode)
                      this.cityNameList.push(this.searchCity)
                    })
                  }
                }
              else{
                Text("未找到该城市，请重新输入！")
                  .fontSize(50)
                  .fontColor(Color.Black)
                  .width('80%')
                  .margin({top:20,left:30})
                  .textAlign(TextAlign.Center)
                }
            }.width("100%")
          Divider().strokeWidth(5)
          }
        else{
          List({scroller:this.scroller}){
            ForEach(this.AllCityNameList,(name)=>{
              ListItem(){
                if(this.cityNameList.includes(name)){
                  Column(){
                    Row(){
                      Text(name)
                        .fontSize(35)
                        .fontColor(Color.White)
                        .width("60%")
                        .margin({top:20,left:30})
                      Blank()
                      Text("已添加")
                        .backgroundColor("")
                        .fontSize("18")
                        .margin({top:5})
                        .opacity(0.8)
                    }.width("100%")
                    Blank()
                    Divider().strokeWidth(5)
                  }.height(90)
                  .width("100%")
                  .margin({top:20})
                  .backgroundColor("#4682b4")
                }else{
                  Column(){
                    Row(){
                      Text(name)
                        .fontSize(35)
                        .fontColor(Color.White)
                        .width("60%")
                        .margin({top:20,left:30})
                      Blank()
                      Button("添加")
                        .margin({right:5})
                        .onClick(()=>{
                          //根据name获取所在城市索引
                          let index=this.AllCityNameList.findIndex(obj=>obj===name)
                          let cityCode :number=this.AllCityCodeList[index]

                          this.cityCodeList.push(cityCode)
                          this.cityNameList.push(name)
                        })
                    }.width("100%")
                    Blank()
                    Divider().strokeWidth(5)
                  }.height(90)
                  .width("100%")
                  .margin({top:20})
                }

              }
            })
          }.scrollBar(BarState.On)
        }
      }
    }.width('100%')
    .height('100%')
    .backgroundColor("#87CEEB")

  }
}