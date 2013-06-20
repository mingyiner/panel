package 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osmf.events.LoadEvent;
	import org.osmf.events.LoaderEvent;
	
	public class BaseView extends Sprite
	{
		public var url:String;
		public var request:URLRequest;
		public var loader:Loader;
		public var assetClass:Object;
		public var bodyContainer:MovieClip;
		public function BaseView()
		{
			loader = new Loader();
			request = new URLRequest(url);
			loader.load(request);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderComplete);
			loader.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			super();
		}
		
		protected function progressHandler(event:Event):void
		{
			
		}
		
		protected function loaderComplete(event:Event):void
		{
			createChild();
		}
		protected function createChild():void{
			if(assetClass){
				initPanel(assetClass)
			}
		}
		
		protected function initPanel(asset:Object):void
		{
			if(bodyContainer == null && asset!=null){
				
				if(asset is Class){
					bodyContainer = new asset() as MovieClip;
				}
				if(asset is MovieClip){
					bodyContainer = asset as MovieClip;
					x = bodyContainer.x;
					y = bodyContainer.y;
					
					if(bodyContainer.parent){
						bodyContainer.parent.removeChild(bodyContainer);
					}
				}
				addChild(bodyContainer);
				bodyContainer.x = 0;
				bodyContainer.y = 0;
				changeParam();
			}
		}
		
		private function changeParam():void
		{
			if(bodyContainer){
				var num:int = bodyContainer.numChildren;
				var childName:String;
				var child:Object;
				for (var i:int = 0; i < num; i++) 
				{
					child = bodyContainer.getChildAt(i);
					childName = child.name;
					if(this.hasOwnProperty(childName)){
						this[childName] = child;
					}
				}
			}
		}
		
		public function getDefinitionClass(str:String):Class{
			if(loader.contentLoaderInfo.applicationDomain.hasDefinition(str)){
				return loader.contentLoaderInfo.applicationDomain.getDefinition(str) as Class;
			}
			return null;
		}
	}
}