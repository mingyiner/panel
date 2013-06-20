package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import gs.TweenLite;

	public class PanelView extends BaseView
	{
		public var knPanel:MovieClip
		public var alertMc:MovieClip;
		public var rewardList:Array;
		private var rewardIndexList:Array;//奖励索引 列表 
		private var index:int;
		public function PanelView()
		{
			url = "kingnetPanel.swf";
			super();
		}
		override protected function loaderComplete(event:Event):void{
			
			rewardIndexList = [];
			var cls:Class = getDefinitionClass("panel") 
			knPanel = new cls() as MovieClip;
			addChild(knPanel);
			
			cls = getDefinitionClass("AlertMc");
			alertMc = new  cls() as MovieClip;
			alertMc.x = 279;
			alertMc.y = 282;
			alertMc.visible = false;
			addChild(alertMc);
			
			knPanel.playBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			knPanel.playTenBtn.addEventListener(MouseEvent.CLICK,tenCickHandler);
			knPanel.playTwentyBtn.addEventListener(MouseEvent.CLICK,twenClickHandler);
			alertMc.okBtn.addEventListener(MouseEvent.CLICK,function():void{alertMc.visible = false})
		}
		private function clickHandler(e:MouseEvent):void{
			//rewardIndexList = [3];
			rewardIndexList = ExternalInterface.call("playPanel",1);
			run()
		}
		private function twenClickHandler(e:MouseEvent):void{
			rewardIndexList = ExternalInterface.call("playPanel",20);
			//rewardIndexList = [4,2,8,10,4,7,7,8,6,5,6,1,9,3,6,12,5,2,11,6];
			run();
		}
		private function tenCickHandler(e:MouseEvent):void{
			//rewardIndexList = [3,5,8,10,2,6,9,10,11];
			//trace(ExternalInterface.call("aa"));
			
			rewardIndexList = ExternalInterface.call("playPanel",10);
			run();
		}
		
		
		private function run():void{
			if(rewardIndexList.length>0){
				index = rewardIndexList.shift();
				TweenLite.to(knPanel.arrows,1.5,{rotation:360+(index*30)-15,onComplete:alertFunction})
			}
		}
		private function alertFunction():void{
			alertMc.visible = true;
			alertMc.rewardLabel.text = rewardList[index];
			TweenLite.delayedCall(2,function():void{
				alertMc.visible = false;
				run();
			})
		}
	}
}