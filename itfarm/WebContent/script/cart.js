function allCheckFunc(obj) {
	$("[name=checkOne]").prop("checked", $(obj).prop("checked"));
}

/* 체크박스 체크시 전체선택 체크 여부 */
function oneCheckFunc(obj) {
	var allObj = $("[name=checkAll]");
	var objName = $(obj).attr("name");

	if ($(obj).prop("checked")) {
		checkBoxLength = $("[name=" + objName + "]").length;
		checkedLength = $("[name=" + objName + "]:checked").length;

		if (checkBoxLength == checkedLength) {
			allObj.prop("checked", true);
		} else {
			allObj.prop("checked", false);
		}
	} else {
		allObj.prop("checked", false);
	}
}

$(function() {
	$("[name=checkAll]").click(function() {
		allCheckFunc(this);
	});
	$("[name=checkOne]").each(function() {
		$(this).click(function() {
			oneCheckFunc($(this));
		});
	});
});
function checkDel() {
	var chkFirList = document.getElementsByName('checkOne');
	var arrFir = new Array();
	var cnt = 0;
	for (var idx = chkFirList.length - 1; 0 <= idx; idx--) {
		if (chkFirList[idx].checked) {
			arrFir[cnt] = chkFirList[idx].value;
			cnt++;
		}
	}

	if (arrFir.length != 0) {
		// document.form1.submit();
		document.form1.action = 'Product?command=cart_deletecheck';
	} else {
		alert('삭제할 상품을 선택하세요.');
		return;
	}
	document.form1.submit();
}

function buy() {
	var chkFirList = document.getElementsByName('checkOne');
	var arrFir = new Array();
	var cnt = 0;
	for (var idx = chkFirList.length - 1; 0 <= idx; idx--) {
		arrFir[cnt] = chkFirList[idx].value;
		cnt++;
	}

	if (arrFir.length != 0) {
		document.form1.action = 'Product?command=product_cartbuyform';
	} else {
		alert('구매할 상품을 선택하세요.');
		return;
	}
	document.form1.submit();
}

function buy2(chk) {
	document.getElementById(chk).checked = true;
	buy();
}

function pay() {
	var chkFirList = document.getElementsByName('checkOne');
	var arrFir = new Array();
	var cnt = 0;
	for (var idx = chkFirList.length - 1; 0 <= idx; idx--) {
		arrFir[cnt] = chkFirList[idx].value;
		cnt++;
	}

	if (arrFir.length != 0) {
		document.form1.submit();
	} else {
		alert('구매할 상품을 선택하세요.');
		return;
	}
	
}

function my_total(f) {
	f.total.value = eval(f.price.value) + eval(f.num.value);
}

// 폼 제출
function mySubmit(index) {
	if (index == 1) {
		document.myForm.action = 'Product?command=cart_add';
	}
	if (index == 2) {
		document.myForm.action = 'Product?command=product_cartbuyform';
	}
	document.myForm.submit();
}
