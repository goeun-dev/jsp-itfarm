package com.itfarm.controller.action.admin;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.itfarm.dto.ExperienceVO;

public class ExperienceList implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String urla = "admin/experience/experienceList.jsp";
		String pageNo = request.getParameter("pageNo");
		String searchSidoCode = request.getParameter("searchSidoCode");
		
		try {
			if (pageNo == null) {
				pageNo = "1";
			} else {
				pageNo = request.getParameter("pageNo");
			}
			if (searchSidoCode == null) {
				searchSidoCode = "6290000";
			} else {
				searchSidoCode = request.getParameter("searchSidoCode");
			}
			
			StringBuilder urlBuilder = new StringBuilder(
					"");
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8")
					+ "");
			urlBuilder.append(
					"&" + URLEncoder.encode("searchSidoCode", "UTF-8") + "=" + URLEncoder.encode(searchSidoCode, "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8"));
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

			// 읽어온 xml 문자열을 메모리에 펼치기, 실제 변경될 가능성이 없는 부분, data 자리만 xml 문자열 변수로 바꿔주면 된다.
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder document = factory.newDocumentBuilder();
			InputStream is = new ByteArrayInputStream(data.getBytes());
			Document doc = document.parse(is);

			// 최상위 노드를 찾아온다.
			Element element = doc.getDocumentElement();
			/* List<ExperienceVO> elist = new ArrayList<ExperienceVO>(); */

			ArrayList<ExperienceVO> exlist = new ArrayList<ExperienceVO>();

			// 찾고자 하는 태그 값 가져오기
			//NodeList list = element.getElementsByTagName("GetFmlgExprnListVO");

			NodeList title = element.getElementsByTagName("title");
			NodeList adultPrice = element.getElementsByTagName("adultPrice");
			NodeList childPrice = element.getElementsByTagName("childPrice");
			NodeList imgPath = element.getElementsByTagName("imgPath");
			NodeList prodCode = element.getElementsByTagName("prodCode");
			NodeList sidoCode = element.getElementsByTagName("sidoCode");
			NodeList sidoName = element.getElementsByTagName("sidoName");
			NodeList villageName = element.getElementsByTagName("villageName");
			
			
			
			NodeList totalCount = element.getElementsByTagName("totalCount");
			System.out.println(totalCount.item(0).getFirstChild().getNodeValue());
			request.setAttribute("exLength", totalCount.item(0).getFirstChild().getNodeValue());
			if (title.getLength() == 0) {
				request.setAttribute("lengthZero", "총 0개의 상품이 있습니다.");
			}
			for (int i = 0; i < title.getLength(); i++) {
				ExperienceVO eVo = new ExperienceVO();
				eVo.setTitle(title.item(i).getFirstChild().getNodeValue());
				eVo.setAdultPrice(adultPrice.item(i).getFirstChild().getNodeValue());
				eVo.setChildPrice(childPrice.item(i).getFirstChild().getNodeValue());
				try {
					eVo.setImgPath(imgPath.item(i).getFirstChild().getNodeValue());
				} catch (NullPointerException e) {
					eVo.setImgPath("none.png");
				}
				eVo.setProdCode(prodCode.item(i).getFirstChild().getNodeValue());
				eVo.setSidoCode(sidoCode.item(i).getFirstChild().getNodeValue());
				eVo.setSidoName(sidoName.item(i).getFirstChild().getNodeValue());
				eVo.setVillageName(villageName.item(i).getFirstChild().getNodeValue());

				request.setAttribute("sdName", sidoName.item(i).getFirstChild().getNodeValue());

				exlist.add(eVo);
			}
			
			int pageCounter = Integer.parseInt(totalCount.item(0).getFirstChild().getNodeValue())/9;
			ArrayList<Integer> pageCount = new ArrayList<Integer>();
			for (int i = 1; i <= pageCounter+1; i++) {
				pageCount.add(i);
			}
			request.setAttribute("pageCount", pageCount);
			request.setAttribute("exList", exlist);
			request.setAttribute("searchSidoCode", searchSidoCode);
			request.setAttribute("pageNo", pageNo);
			/*System.out.println(pageCounter);
			System.out.println(pageCount);*/
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
