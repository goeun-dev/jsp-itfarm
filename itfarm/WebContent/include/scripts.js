//----------------------- 한글만 입력되는 함수
function Korean() {
	if(event.crtlKey || event.shiftKey || event.shiftLeft || event.altKey) {
		event.returnValue = false;
		return false;
	}
	
	if((event.keyCode == 8
	|| event.keyCode == 9
	|| event.keyCode == 35
	|| event.keyCode == 36
	|| event.keyCode == 37
	|| event.keyCode == 39
	|| event.keyCode == 46))
	{
		event.returnValue = true;
		return;
	}
	
	if ((eventKeyCode < 12592 || event.keyCode > 12687)) {
		event.returnValue = false;
		return false;
	}
}