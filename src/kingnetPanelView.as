package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	import gs.TweenLite;
	
	[SWF(width = "550",height = "570")]
	public class kingnetPanelView extends Sprite
	{
		private var rewardList:Array;
		private var view:PanelView;
		public function kingnetPanelView()
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			rewardList = [];
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest('rewardName.txt'));
			urlLoader.addEventListener(Event.COMPLETE,txtHandler);
		}
		private function txtHandler(e:Event):void{
			var str:String = e.target.data;
			var arr:Array = str.replace(/\n\r/g,"\n").split("\n");
			for (var i:int = 0; i < arr.length; i++) 
			{
				decode(arr[i]);
			}
			view = new PanelView();
			view.rewardList = rewardList;
			addChild(view);
		}
		private function decode(input:String):void{
			if(input.indexOf(":") >0){
				var key:String = input.substring(0,input.indexOf(":"));
				rewardList.push( input.substring(input.indexOf(":")+1,input.length));
			}
		}

	}
}