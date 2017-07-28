import java.io.*;  
import javax.servlet.*;  
import javax.servlet.http.*;  
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Appender;
import org.apache.log4j.FileAppender;
import org.apache.log4j.Layout;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.ConsoleAppender;
@WebServlet("/Wel")
public class Wel extends HttpServlet {  
static Logger l = Logger.getLogger(Wel.class.getName());
 Layout l1 = new PatternLayout();
	  Appender a;
  public void doGet(HttpServletRequest request, HttpServletResponse response)  
        throws ServletException, IOException {  
            try{
                 a=new FileAppender(l1,"1.txt",true);
                l.addAppender(a);
     response.setContentType("text/html");  
    PrintWriter out = response.getWriter();  
      HttpSession session=request.getSession(false);    
   String name=(String)session.getAttribute("hello"); 
    out.print("hello"+name);
     l.warn(name +" is trying to login ......");
    request.getRequestDispatcher("logout.jsp").include(request, response);
    if(name.equals("admin"))
    {
     request.getRequestDispatcher("admin.jsp").include(request, response);
    }
        } 
    catch(Exception e){System.out.println(e);}  
 }
  
}  