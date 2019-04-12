function productCheck() {
	if (document.frm.adultNum.value.length == 0) {
		alert("성인 인원을 선택해주세요.");
		frm.adultNum.focus();
		return false;
	}
	if (document.frm.childNum.value.length == 0) {
		alert("어린이 인원을 선택해주세요.");
		frm.childNum.focus();
		return false;
	}
	if (isNaN(document.eDate.price.value)) {
		alert("체험일자를 선택해 주세요");
		frm.eDate.focus();
		return false;
	}
	if (document.frm.price.value.length == 0) {
		alert("가격을 써주세요");
		frm.price.focus();
		return false;
	}
	return true;
}