package com.itfarm.controller;

import com.itfarm.controller.action.Action;
import com.itfarm.controller.action.CartAdd;
import com.itfarm.controller.action.CartCheckDelete;
import com.itfarm.controller.action.CartDelete;
import com.itfarm.controller.action.CartDeleteOne;
import com.itfarm.controller.action.CartList;
import com.itfarm.controller.action.CartUpdate;
import com.itfarm.controller.action.CartUpdateForm;
import com.itfarm.controller.action.DeliveryNo;
import com.itfarm.controller.action.ExperienceCalendar;
import com.itfarm.controller.action.ExperienceDetail;
import com.itfarm.controller.action.ExperienceList;
import com.itfarm.controller.action.ExperienceSelectDate;
import com.itfarm.controller.action.MemberDelete;
import com.itfarm.controller.action.MemberDeleteForm;
import com.itfarm.controller.action.MemberFindId;
import com.itfarm.controller.action.MemberFindPwd;
import com.itfarm.controller.action.MemberIdCheck;
import com.itfarm.controller.action.MemberJoin;
import com.itfarm.controller.action.MemberJoinForm;
import com.itfarm.controller.action.MemberLogin;
import com.itfarm.controller.action.MemberLoginForm;
import com.itfarm.controller.action.MemberLogout;
import com.itfarm.controller.action.MemberPassCheck;
import com.itfarm.controller.action.MemberPassUpdate;
import com.itfarm.controller.action.MemberPassUpdateForm;
import com.itfarm.controller.action.MemberTerm;
import com.itfarm.controller.action.MemberUpdate;
import com.itfarm.controller.action.MemberUpdateForm;
import com.itfarm.controller.action.Mypage;
import com.itfarm.controller.action.OrderDetail;
import com.itfarm.controller.action.OrderList;
import com.itfarm.controller.action.ProductBuy;
import com.itfarm.controller.action.ProductBuyForm;
import com.itfarm.controller.action.ProductCartBuyForm;
import com.itfarm.controller.action.ProductDetail;
import com.itfarm.controller.action.ProductList;
import com.itfarm.controller.action.ProductRefund;
import com.itfarm.controller.action.ProductRefundForm;
import com.itfarm.controller.action.ProductReturn;
import com.itfarm.controller.action.ProductReturnForm;
import com.itfarm.controller.action.ReservationDetail;
import com.itfarm.controller.action.ReservationForm;
import com.itfarm.controller.action.ReservationList;
import com.itfarm.controller.action.ReservationOk;
import com.itfarm.controller.action.ReservationRefund;
import com.itfarm.controller.action.ReservationRefundForm;

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();

	private ActionFactory() {
		super();
	}

	public static ActionFactory getInstance() {
		return instance;
	}
	
	public Action getAction(String command) {
		Action action = null;
		System.out.println("ActionFactory :" + command);

		/* -------------------------회원 부분------------------------------ */
		if (command.equals("member_delete")) {
			action = new MemberDelete();
		} else if (command.equals("member_deleteform")) {
			action = new MemberDeleteForm();
		} else if (command.equals("member_findid")) {
			action = new MemberFindId();
		} else if (command.equals("member_findpwd")) {
			action = new MemberFindPwd();
		} else if (command.equals("member_idcheck")) {
			action = new MemberIdCheck();
		} else if (command.equals("member_join")) {
			action = new MemberJoin();
		} else if (command.equals("member_joinform")) {
			action = new MemberJoinForm();
		} else if (command.equals("member_login")) {
			action = new MemberLogin();
		} else if (command.equals("member_loginform")) {
			action = new MemberLoginForm();
		} else if (command.equals("member_logout")) {
			action = new MemberLogout();
		} else if (command.equals("member_passcheck")) {
			action = new MemberPassCheck();
		} else if (command.equals("member_passupdate")) {
			action = new MemberPassUpdate();
		} else if (command.equals("member_passupdateform")) {
			action = new MemberPassUpdateForm();
		} else if (command.equals("member_term")) {
			action = new MemberTerm();
		} else if (command.equals("member_update")) {
			action = new MemberUpdate();
		} else if (command.equals("member_updateform")) {
			action = new MemberUpdateForm();
		} else if (command.equals("member_mypage")) {
			action = new Mypage();
		}
		/* -------------------------제품구매 부분------------------------------ */
		else if (command.equals("product_list")) {
			action = new ProductList();
		} else if (command.equals("product_detail")) {
			action = new ProductDetail();
		} else if (command.equals("product_buyform")) {
			action = new ProductBuyForm();
		} else if (command.equals("product_cartbuyform")) {
			action = new ProductCartBuyForm();
		} else if (command.equals("product_buy")) {
			action = new ProductBuy();
		} else if (command.equals("cart_list")) {
			action = new CartList();
		} else if (command.equals("cart_add")) {
			action = new CartAdd();
		} else if (command.equals("cart_delete")) {
			action = new CartDelete();
		} else if (command.equals("cart_deleteone")) {
			action = new CartDeleteOne();
		} else if (command.equals("cart_deletecheck")) {
			action = new CartCheckDelete();
		} else if (command.equals("cart_update")) {
			action = new CartUpdate();
		} else if (command.equals("cart_updateform")) {
			action = new CartUpdateForm();
		} else if (command.equals("order_list")) {
			action = new OrderList();
		} else if (command.equals("order_detail")) {
			action = new OrderDetail();
		}else if (command.equals("order_refundform")) {
			action = new ProductRefundForm();
		}else if (command.equals("order_refund")) {
			action = new ProductRefund();
		}else if (command.equals("order_returnform")) {
			action = new ProductReturnForm();
		}else if (command.equals("order_return")) {
			action = new ProductReturn();
		}else if (command.equals("delivery_no")) {
			action = new DeliveryNo();
		}
		/* -------------------------농업체험 부분------------------------------ */
		else if (command.equals("experience_list")) {
			action = new ExperienceList();
		} else if (command.equals("experience_detail")) {
			action = new ExperienceDetail();
		} else if (command.equals("experience_calendar")) {
			action = new ExperienceCalendar();
		}else if (command.equals("experience_selectdate")) {
			action = new ExperienceSelectDate();
		} else if (command.equals("reservation_list")) {
			action = new ReservationList();
		} else if (command.equals("reservation_detail")) {
			action = new ReservationDetail();
		} else if (command.equals("reservation_ok")) {
			action = new ReservationOk();
		} else if (command.equals("reservation_form")) {
			action = new ReservationForm();
		}else if (command.equals("reservation_refundform")) {
			action = new ReservationRefundForm();
		}else if (command.equals("reservation_refund")) {
			action = new ReservationRefund();
		}

		return action;
	}
}
