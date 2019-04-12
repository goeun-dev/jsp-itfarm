package com.itfarm.controller;

import com.itfarm.controller.action.admin.AdminAction;
import com.itfarm.controller.action.admin.AdminIndex;
import com.itfarm.controller.action.admin.Board2Delete;
import com.itfarm.controller.action.admin.Board2DeleteForm;
import com.itfarm.controller.action.admin.Board2List;
import com.itfarm.controller.action.admin.BoardDelete;
import com.itfarm.controller.action.admin.BoardDeleteForm;
import com.itfarm.controller.action.admin.BoardList;
import com.itfarm.controller.action.admin.DeliveryUpdate;
import com.itfarm.controller.action.admin.DeliveryUpdateForm;
import com.itfarm.controller.action.admin.ExperienceDetail;
import com.itfarm.controller.action.admin.ExperienceList;
import com.itfarm.controller.action.admin.MemberDelete;
import com.itfarm.controller.action.admin.MemberDetail;
import com.itfarm.controller.action.admin.MemberList;
import com.itfarm.controller.action.admin.OrderCheckDelete;
import com.itfarm.controller.action.admin.OrderDelete;
import com.itfarm.controller.action.admin.OrderDeleteForm;
import com.itfarm.controller.action.admin.OrderList;
import com.itfarm.controller.action.admin.OrderTotal;
import com.itfarm.controller.action.admin.OrderTotal2;
import com.itfarm.controller.action.admin.OrderUpdate;
import com.itfarm.controller.action.admin.OrderUpdateForm;
import com.itfarm.controller.action.admin.ProductCheckDelete;
import com.itfarm.controller.action.admin.ProductDelete;
import com.itfarm.controller.action.admin.ProductDeleteForm;
import com.itfarm.controller.action.admin.ProductList;
import com.itfarm.controller.action.admin.ProductReturnForm;
import com.itfarm.controller.action.admin.ProductSearch;
import com.itfarm.controller.action.admin.ReservationCheckDelete;
import com.itfarm.controller.action.admin.ReservationDelete;
import com.itfarm.controller.action.admin.ReservationDeleteForm;
import com.itfarm.controller.action.admin.ReservationList;
import com.itfarm.controller.action.admin.ReservationSearch;
import com.itfarm.controller.action.admin.ReservationUpdate;
import com.itfarm.controller.action.admin.ReservationUpdateForm;
import com.itfarm.controller.action.admin.StatExpRank;
import com.itfarm.controller.action.admin.StatMemberAddr;
import com.itfarm.controller.action.admin.StatMemberDay;
import com.itfarm.controller.action.admin.StatMemberMonth;
import com.itfarm.controller.action.admin.StatMemberWeek;
import com.itfarm.controller.action.admin.StatOrderDay;
import com.itfarm.controller.action.admin.StatOrderMonth;
import com.itfarm.controller.action.admin.StatOrderPayment;
import com.itfarm.controller.action.admin.StatOrderWeek;
import com.itfarm.controller.action.admin.StatReservDay;
import com.itfarm.controller.action.admin.StatReservMonth;
import com.itfarm.controller.action.admin.StatReservPayment;
import com.itfarm.controller.action.admin.StatReservWeek;

public class AdminActionFactory {
	private static AdminActionFactory instance = new AdminActionFactory();

	private AdminActionFactory() {
		super();
	}

	public static AdminActionFactory getInstance() {
		return instance;
	}

	public AdminAction getAdminAction(String command) {
		AdminAction action = null;
		System.out.println("AdminActionFactory :" + command);
		/* --------------------------------메인페이지------------------------------ */
		if (command.equals("index")) {
			action = new AdminIndex();
		}
		/* -------------------------------회원 부분------------------------------ */
		else if (command.equals("member_list")) {
			action = new MemberList();
		} else if (command.equals("member_delete")) {
			action = new MemberDelete();
		} else if (command.equals("member_detail")) {
			action = new MemberDetail();
		} else if (command.equals("member_month")) {
			action = new StatMemberMonth();
		} else if (command.equals("member_week")) {
			action = new StatMemberWeek();
		} else if (command.equals("member_day")) {
			action = new StatMemberDay();
		} else if (command.equals("member_addr")) {
			action = new StatMemberAddr();
		}
		/* -------------------------------제품 부분------------------------------ */
		else if (command.equals("product_list")) {
			action = new ProductList();
		} else if (command.equals("product_search")) {
			action = new ProductSearch();
		} else if (command.equals("product_deleteform")) {
			action = new ProductDeleteForm();
		} else if (command.equals("product_delete")) {
			action = new ProductDelete();
		} else if (command.equals("product_chkdelete")) {
			action = new ProductCheckDelete();
		} else if (command.equals("product_returnform")) {
			action = new ProductReturnForm();
		}
		/* --------------------------------주문 부분------------------------------ */
		else if (command.equals("order_list")) {
			action = new OrderList();
		} else if (command.equals("order_updateform")) {
			action = new OrderUpdateForm();
		} else if (command.equals("order_update")) {
			action = new OrderUpdate();
		} else if (command.equals("order_deleteform")) {
			action = new OrderDeleteForm();
		} else if (command.equals("order_delete")) {
			action = new OrderDelete();
		} else if (command.equals("order_chkdelete")) {
			action = new OrderCheckDelete();
		} else if (command.equals("order_total")) {
			action = new OrderTotal();
		} else if (command.equals("delivery_form")) {
			action = new DeliveryUpdateForm();
		} else if (command.equals("delivery_update")) {
			action = new DeliveryUpdate();
		} else if (command.equals("order_returnform")) {
			action = new ProductReturnForm();
		}
		/* --------------------------------체험 부분------------------------------ */
		else if (command.equals("experience_list")) {
			action = new ExperienceList();
		} else if (command.equals("experience_detail")) {
			action = new ExperienceDetail();
		}
		/* --------------------------------예약 부분------------------------------ */
		else if (command.equals("reservation_list")) {
			action = new ReservationList();
		} else if (command.equals("reservation_updateform")) {
			action = new ReservationUpdateForm();
		} else if (command.equals("reservation_update")) {
			action = new ReservationUpdate();
		} else if (command.equals("reservation_deleteform")) {
			action = new ReservationDeleteForm();
		} else if (command.equals("reservation_delete")) {
			action = new ReservationDelete();
		} else if (command.equals("reservation_chkdelete")) {
			action = new ReservationCheckDelete();
		} else if (command.equals("reservation_search")) {
			action = new ReservationSearch();
		}
		/* --------------------------------체험게시판 부분------------------------------ */
		else if (command.equals("board_list")) {
			action = new BoardList();
		} else if (command.equals("board_delete")) {
			action = new BoardDelete();
		} else if (command.equals("board_deleteform")) {
			action = new BoardDeleteForm();
		}
		/* --------------------------------Qna 부분------------------------------ */
		else if (command.equals("board2_list")) {
			action = new Board2List();
		} else if (command.equals("board2_delete")) {
			action = new Board2Delete();
		} else if (command.equals("board2_deleteform")) {
			action = new Board2DeleteForm();
		}
		/* --------------------------------통계 부분------------------------------ */
		if (command.equals("order_total")) {
			action = new OrderTotal2();
		} else if (command.equals("order_month")) {
			action = new StatOrderMonth();
		} else if (command.equals("order_week")) {
			action = new StatOrderWeek();
		} else if (command.equals("order_day")) {
			action = new StatOrderDay();
		} else if (command.equals("order_payment")) {
			action = new StatOrderPayment();
		} else if (command.equals("reserv_month")) {
			action = new StatReservMonth();
		} else if (command.equals("reserv_week")) {
			action = new StatReservWeek();
		} else if (command.equals("reserv_day")) {
			action = new StatReservDay();
		} else if (command.equals("reserv_payment")) {
			action = new StatReservPayment();
		} else if (command.equals("exp_stats")) {
			action = new StatExpRank();
		}

		return action;
	}
}
