package com.itfarm.controller.action.admin;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class ExperienceDetail implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String urla = "admin/experience/experienceDetail.jsp";
		String prodCode = request.getParameter("prodCode");
		//ExperienceDAO eDao = ExperienceDAO.getInstance();
		//List<ReservationVO> reservationList = eDao.reservstionNum(prodCode);
		//request.setAttribute("reservationList", reservationList);
		
		try {
			
			String imgPath = request.getParameter("imgPath");
			// 데이터를 가져올 주소
			StringBuilder urlBuilder = new StringBuilder(
					"="); /* URL */
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8")
					+ ""); // servicekey
			urlBuilder.append("&" + URLEncoder.encode("prodCode", "UTF-8") + "=" + URLEncoder.encode(prodCode, "UTF-8"));
			
			// 웹 주소를 URL을 변경
			URL url = new URL(urlBuilder.toString());
			// URL connection 만들기
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			// 데이터를 읽어올 스트림 생성
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			// 데이터 읽어서 출력
			String data = "";
			while (true) {
				String line = br.readLine();
				if (line == null) {
					break;
				}
				data += line;
			}

			// 읽어온 xml 문자열을 메모리에 펼치기
			// 실제 변경될 가능성이 없는 부분
			// data 자리만 xml 문자열 변수로 바꿔주면 된다.
			// 대부분의 프로그래밍 언어가 파싱할 때 이 부분만 다르다.
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder document = factory.newDocumentBuilder();
			InputStream is = new ByteArrayInputStream(data.getBytes());
			Document doc = document.parse(is);

			// 최상위 노드를 찾아온다.
			Element element = doc.getDocumentElement();

			// 찾고자 하는 태그 값 가져오기
			NodeList list = element.getElementsByTagName("item");

			NodeList title = element.getElementsByTagName("title");
			NodeList detail = element.getElementsByTagName("detail");
			NodeList addr = element.getElementsByTagName("addr");
			NodeList adultPrice = element.getElementsByTagName("adultPrice");
			NodeList childPrice = element.getElementsByTagName("childPrice");
			NodeList nProdCode = element.getElementsByTagName("prodCode");
			
			NodeList ceoName = element.getElementsByTagName("ceoName");
			NodeList villageName = element.getElementsByTagName("villageName");
			NodeList telNo = element.getElementsByTagName("telNo");
			NodeList limitStatus = element.getElementsByTagName("limitStatus");
			NodeList stdCnt = element.getElementsByTagName("stdCnt");
			NodeList grpAduitPrice = element.getElementsByTagName("grpAduitPrice");
			NodeList grpChildPrice = element.getElementsByTagName("grpChildPrice");
			
			for (int i = 0; i < list.getLength(); i++) {
				request.setAttribute("title", title.item(i).getFirstChild().getNodeValue());
				request.setAttribute("addr", addr.item(i).getFirstChild().getNodeValue());
				request.setAttribute("adultPrice", adultPrice.item(i).getFirstChild().getNodeValue());
				request.setAttribute("prodCode", nProdCode.item(i).getFirstChild().getNodeValue());
				request.setAttribute("detail", detail.item(i).getFirstChild().getNodeValue());
				request.setAttribute("childPrice", childPrice.item(i).getFirstChild().getNodeValue());
				request.setAttribute("img", imgPath);
				
				request.setAttribute("ceoName", ceoName.item(i).getFirstChild().getNodeValue());
				request.setAttribute("villageName", villageName.item(i).getFirstChild().getNodeValue());
				request.setAttribute("telNo", telNo.item(i).getFirstChild().getNodeValue());
				request.setAttribute("limitStatus", limitStatus.item(i).getFirstChild().getNodeValue());
				request.setAttribute("stdCnt", stdCnt.item(i).getFirstChild().getNodeValue());
				try {
					request.setAttribute("grpAduitPrice", grpAduitPrice.item(i).getFirstChild().getNodeValue());
					request.setAttribute("grpChildPrice", grpChildPrice.item(i).getFirstChild().getNodeValue());
				} catch (NullPointerException e) {
					request.setAttribute("grpAduitPrice", adultPrice.item(i).getFirstChild().getNodeValue());
					request.setAttribute("grpChildPrice", childPrice.item(i).getFirstChild().getNodeValue());
				}				
				
			}

			br.close();
			con.disconnect();

		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(urla);
		dispatcher.forward(request, response);
	}

}
