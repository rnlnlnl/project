package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/emailCert.do")
public class MemberController extends HttpServlet{
	MemberDAO mDAO;
	
	@Override
	public void init() throws ServletException{
		mDAO = new MemberDAO();
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doIt(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doIt(request, response);
	}
	
	public void doIt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String nextPage = null;
		boolean isRedirect = false;
		
		//String path = request.getPathInfo();
		String path = "emailCert.do";
		System.out.println("member 요청 주소 path :"+path);
		
		MemberService service = new MemberService();
		HttpSession session = request.getSession();
		
		PrintWriter out = response.getWriter();
		
		if(path.equals("emailCert.do")){
			String email = request.getParameter("email");
			String certNum = service.createCertNum();
			boolean result = service.emailCertSend(email, certNum);
			request.setAttribute("result", result);
			request.setAttribute("certNum", certNum);

			nextPage = "./pwEmail.jsp";
		}
		
		if (nextPage != null) {
			if (isRedirect) {
				System.out.println("리다이렉트 방식");
				response.sendRedirect(nextPage);
			}else{
				System.out.println("리다이렉트 방식");
				RequestDispatcher dis = request.getRequestDispatcher(nextPage);
				dis.forward(request, response);
			}
		}
		
		
	}
	
}
