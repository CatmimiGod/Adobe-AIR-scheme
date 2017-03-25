package 
{
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class BaseAirScheme extends MovieClip
	{
		
		protected var textDebug:TextField;
		
		public function BaseAirScheme() 
		{
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
			
			textDebug = this.getChildByName("text_debug") as TextField;
			textDebug.text = "";
			
			this.addEventListener(MouseEvent.CLICK , onClickHandler);
		}
		
		/**
		 * 鼠标点击
		 * @param	e
		 */
		protected function onClickHandler(e:MouseEvent):void
		{
			var btnName:String = e.target.name;
			switch(btnName)
			{
				case "btn_switch":
					getSchemeAndCall();
					break;
			}
		}
		
		/**
		 * 获取到scheme然后发送
		 */
		protected function getSchemeAndCall():void
		{
			var scheme:TextField = this.getChildByName("text_scheme") as TextField;
			var args:TextField = this.getChildByName("text_args") as TextField;
			
			callScheme(scheme.text, args.text);
		}
		
		/**
		 * 在调用应用程序时调度
		 * @param	e
		 */
		protected function onInvoke(e:InvokeEvent):void
		{
			if(e.arguments.length > 0)
				traceDebug(String(e.arguments));
		}
		
		/**
		 * 调度scheme
		 * @param	scheme
		 * @param	args
		 */
		protected function callScheme(scheme:String, args:String):void
		{
			navigateToURL(new URLRequest(scheme + "://" + args));
		}
		
		/**
		 * 输出debug
		 * @param	debug
		 */
		protected function traceDebug(debug:String):void
		{
			textDebug.appendText(textDebug.numLines + ")" + debug + "\n");
			
			if (textDebug.numLines > 10)
			{
				textDebug.scrollV = textDebug.numLines;
			}
		}
		
	}

}