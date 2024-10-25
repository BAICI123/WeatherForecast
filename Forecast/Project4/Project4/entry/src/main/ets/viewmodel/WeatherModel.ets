import {forecasts} from "./forecasts"
export class WeatherModel{
  status:number
  count:number
  infocode:number
  forecasts:Array<forecasts>=[]
}