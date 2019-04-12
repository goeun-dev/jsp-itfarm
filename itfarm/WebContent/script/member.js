/* --------------------------------------로그인 체크--------------------------------------*/
function loginCheck() {
	if (document.frm.userid.value.length == 0) {
		alert("아이디를 입력하세요.");
		frm.userid.focus();
		return false;
	}
	if (document.frm.pwd.value == "") {
		alert("비밀번호를 입력하세요.");
		frm.pwd.focus();
		return false;
	}
	return true;
}

/* --------------------------------------비밀번호 재입력 체크--------------------------------------*/
function passCheck2(event) {
	event = event || window.event;
	var pwd = document.frm.pwd.value;
	var pwd_check = document.frm.pwd_check.value;
	var keyID = (event.which) ? event.which : event.keyCode;
	if(pwd_check.length == 0 || pwd_check == null)
	{
		document.getElementById("keyinfo3").innerHTML = "비밀번호를 다시 입력해주세요.";
	} else if (pwd != pwd_check) {
		document.getElementById("keyinfo3").innerHTML = "비밀번호가 다릅니다.";
	}
	else
	{
		document.getElementById("keyinfo3").innerHTML = " 비밀번호가 일치합니다. ";
	}
}

/* --------------------------------------비밀번호 정규화 체크--------------------------------------*/
function passRgex(event) {
	event = event || window.event;
	var passExp =  /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]|.*[0-9]).{4,16}$/;
	
	var keyID = (event.which) ? event.which : event.keyCode;
	if(!document.frm.pwd.value.match(passExp))
	{
		document.getElementById("keyinfo1").innerHTML = "4~16자 / 영문대소문자, 숫자, 특수문자 중 두개이상의 문자를 포함해야합니다.";
	}
	else
	{
		document.getElementById("keyinfo1").innerHTML = " ";
	}
}

/* --------------------------------------아이디 중복 체크--------------------------------------*/
function idCheck(w, h, name, option) {
	var userid = document.frm.userid.value;
	var idExp =  /^[a-z0-9]{4,16}/g;
	
	if (document.frm.userid.value == "") {
		alert('아이디를 입력하여 주십시오.');
		document.frm.userid.focus();
		return;
	} else if (!document.frm.userid.value.match(idExp)) {
		document.frm.idchk.value = "4~16자 / 영문소문자, 숫자의 조합만 사용가능합니다.";
		document.frm.userid.focus();
		return;
	}
	
	var url = "Member?command=member_idcheck&userid=" + document.frm.userid.value;
	var pozX, pozY;
    var sw = screen.availWidth;
    var sh = screen.availHeight;
    var scroll = 0;
    if (option == 'scroll') {
        scroll = 1;
    }
    pozX = (sw - w) / 2;
    pozY = (sh - h) / 2;
    window.open(url, name, "location=0,status=0,scrollbars=" + scroll + ",resizable=1,width=" + w + ",height=" + h + 
    ",left=" + pozX + ",top=" + pozY);
}

/* --------------------------------------아이디 체크--------------------------------------*/
function joinidCheck() {
	var userid = document.frm.userid.value;
	var idExp = /^[a-z0-9]{4,16}/g;
	
	if (userid.length == 0 || userid == null) {
		document.frm.idchk.value = "아이디를 입력하세요.";
	} else if (!document.frm.userid.value.match(idExp)) {
		document.frm.idchk.value = "4~16자 / 영문소문자, 숫자의 조합만 사용가능합니다.";
	} else {
		document.frm.idchk.value = "";
	}
	return;
}

/* --------------------------------------아이디 체크--------------------------------------*/
function idok(userid) {
	opener.frm.userid.value = document.frm.userid.value;
	opener.frm.reid.value = document.frm.userid.value;
	self.close();
}

/* --------------------------------------회원가입 체크--------------------------------------*/
function joinCheck() {
	var passExp =  /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]|.*[0-9]).{4,16}$/;
	if (!document.frm.pwd.value.match(passExp)) {
		alert("비밀번호는 4~16자 / 영문대소문자, 숫자, 특수문자 중 두개이상의 문자를 포함해야합니다.");
		document.frm.pwd.value = "";
		frm.pwd.focus();
		return false;
	}
	if (document.frm.name.value.length == 0) {
		alert("이름을 써주세요.");
		frm.name.focus();
		return false;
	}
	if (document.frm.userid.value.length == 0) {
		alert("아이디를 써주세요");
		frm.userid.focus();
		return false;
	}
	if (document.frm.userid.value.length < 4) {
		alert("아이디는 4~16자 / 영문소문자, 숫자의 조합만 사용가능합니다.");
		document.frm.userid.value = "";
		frm.userid.focus();
		return false;
	}
	if (document.frm.reid.value.length == 0) {
		alert("중복 체크를 하지 않았습니다.");
		document.frm.userid.value = "";
		frm.userid.focus();
		return false;
	}
	if (document.frm.pwd.value == "") {
		alert("암호는 반드시 입력해야 합니다.");
		frm.pwd.focus();
		return false;
	}
	if (document.frm.pwd.value != document.frm.pwd_check.value) {
		alert("암호가 일치하지 않습니다.");
		document.frm.pwd.value = "";
		document.frm.pwd_check.value = "";
		frm.pwd.focus();
		return false;
	}
	if (document.frm.zipNo.value == "") {
		alert("주소를 입력해주세요.");
		document.frm.addrDetail.value = "";
		frm.zipNo.focus();
		return false;
	}
	
	return true;
}
