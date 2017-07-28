# A website for registration:
** Form to login  .**
```
<html>
      <style>
body {
   
    background-image: url("enter.jpg");
    background-size : 1200px 800px;
}
h1{
    color: blue;
}
</style>
 <body>
 <form action="Login" method="GET" align="center"> 
   <h1>login</h1>   
<table cellspacing=10 cellpadding=10 align="center">  
    <style>
    table{
        background-color:lightblue;
         padding-bottom:5px;
        margin-left: auto;
        margin-right: auto;
}
    </style>
<tr><td>Email</td><td><input type="email" name="email"/></td></tr>  
<tr><td>Password</td><td><input type="password" name="password"/></td></tr>            
<tr><td align="center"><input type="submit" value="login"/></td>
</form>
<form action="register.jsp">
<tr><td align="center"><input type="submit" value="signup"/></tr></td>  
</form> 
</table>
<a href="Login"></a>  
</body>
</html>

```
# A form to signup:
```
<html>  
<head>  
<title>Register</title>  
<style>
</style>
</head>  
<body>
    <style>
    body {
   
     background-image: url("log1.jpg");
      background-size : 1200px 800px;
}  
h3{
    color: #f00;
}
h1{
    color: blue;
}
</style>
<form action="RegisterServlet" method="post" align="center"> 
    <h1>Registration</h1>   
<table cellspacing=10 cellpadding=10 align="center">  
<tr><td><h3>Name*</h3></td><td><input type="text" name="name"/></td></tr>  
<tr><td><h3>Password</h3></td><td><input type="password" name="password"/></td></tr>  
<tr><td><h3>Email</h3></td><td><input type="email" name="email"/></td></tr>  
<tr><td><h3>Phone Number</h3></td><td><input type="text" name="phone_no"/></td></tr>
<tr><td><h3>Place</h3></td><td><input type="place" name="place"/> </td></tr>

<tr><td align="center"><input type="submit" value="Register"/></td>

</table>   

</form>  

<br/> 
</body>  
</html> 

```
# pojoclass 
```
public class Pojo {  
private String name,password,email,phone_no,place;  
public String getName() {  
    return name;  
}  
public void setName(String name) {  
    this.name = name;  
}  
public String getPassword() {  
    return password;  
}  
public void setPassword(String password) {  
    this.password = password;  
}  
public String getEmail() {  
    return email;  
}  
public void setEmail(String email) {  
    this.email = email;  
}  
public String getPhoneno() {  
    return phone_no;  
}  
public void setPhoneno(String phone_no) {  
    this.phone_no = phone_no;  
}  
  public String getPlace() {  
    return place;  
}  
public void setPlace(String place) {  
    this.place = place;  
} 
}  

```
# Register servlet
**  register the details and save in database**
``` 
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String name=request.getParameter("name");
		String password=request.getParameter("password");
		String email=request.getParameter("email");
		String phone_no=request.getParameter("phone_no");
		String place=request.getParameter("place");
		Pojo pojo=new Pojo();

		pojo.setName(name);
		pojo.setPassword(password);
		pojo.setEmail(email);
		pojo.setPhoneno(phone_no);
		pojo.setPlace(place);
		
		int status=StudentDao.save(pojo);
		if(status>0){
			out.print("<h2 style='color:#f00'><b><i>Register Successfully!</i></b></h2>");
			request.getRequestDispatcher("mainservlet").include(request, response);
		}else{
			out.println("Sorry! unable to save record");
		}
		
		out.close();
	}

}


```
# Dao implementation
** Dao for crud operations :**
```
import java.util.*;  
import java.sql.*;  
import java.lang.String;
  
public class StudentDao {  
  
    public static Connection getConnection(){  
        Connection con=null;  
        try{  
           Class.forName("com.mysql.jdbc.Driver");
            con =DriverManager.getConnection("jdbc:mysql://localhost:3306/Registration", "root", "");
 
        }catch(Exception e){System.out.println(e);}  
        return con;  
    }  
    public static int save(Pojo pojo){  
        int status=0;  
        try{  
            Connection con=StudentDao.getConnection();  
            PreparedStatement ps=con.prepareStatement(  
                         "insert into register(Name,password,Email,phoneno,place) values (?,?,?,?,?)");  
            ps.setString(1,pojo.getName());  
            ps.setString(2,pojo.getPassword());  
            ps.setString(3,pojo.getEmail());
            ps.setString(4,pojo.getPhoneno());  
            ps.setString(5,pojo.getPlace());  
              
            status=ps.executeUpdate();  
              
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
          
        return status;  
    }  
    public static int update(Pojo e){  
        int status=0;  
        try{  
            Connection con=StudentDao.getConnection();  
            PreparedStatement ps=con.prepareStatement(  
                         "update register set password=?,email=?,phoneno=?,place=? where name=?");  
            
            ps.setString(1,e.getPassword());  
            ps.setString(2,e.getEmail());  
             ps.setString(3,e.getPhoneno());  
            ps.setString(4,e.getPlace());  
            ps.setString(5,e.getName());  
              
            status=ps.executeUpdate();  
              
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
          
        return status;  
    }  
    public static int delete(String name){  
        int status=0;  
        try{  
            Connection con=StudentDao.getConnection();  
            PreparedStatement ps=con.prepareStatement("delete from register where name=?");  
            ps.setString(1,name);  
            status=ps.executeUpdate();  
              
            con.close();  
        }catch(Exception e){e.printStackTrace();}  
          
        return status;  
    }  
    public static int login(String email,String password){  
        int status=0,userresult=0; 
        String dbemail="",dbpass="",dbname=""; 
        try{  
            Connection con=StudentDao.getConnection();
            PreparedStatement ps=con.prepareStatement("select name,email,password from register where email=?"); 
            ps.setString(1,email);
             
            ResultSet rs=ps.executeQuery();  
            int i=0;
            if (rs.next()) {
                dbname=rs.getString(1);
              dbemail=rs.getString(2);  
                dbpass=rs.getString(3);  
            }   
        }
        catch(Exception e)
        {e.printStackTrace();}
       
        if((password.equals(dbpass))&&(email.equals(dbemail)))
        {
                System.out.println("Success");
                userresult=1;
                return userresult;
            }
            else
            {
                return userresult;
            }
    }
    
    public static Pojo getStudentName(String name){  
        Pojo pojo=new Pojo();  
          
        try{  
            Connection con=StudentDao.getConnection();  
            PreparedStatement ps=con.prepareStatement("select * from register where name=?");  
            ps.setString(1,name);  
            ResultSet rs=ps.executeQuery();  
            if(rs.next()){    
                pojo.setName(rs.getString(1));  
                pojo.setPassword(rs.getString(2));  
                pojo.setEmail(rs.getString(3)); 
                pojo.setPhoneno(rs.getString(4));  
                pojo.setPlace(rs.getString(5));  
            }  
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
          
        return pojo;  
    }  
    public static List<Pojo> getAllStudent(){  
        List<Pojo> list=new ArrayList<Pojo>();  
          
        try{  
            Connection con=StudentDao.getConnection();  
            PreparedStatement ps=con.prepareStatement("select * from register");  
            ResultSet rs=ps.executeQuery();  
            while(rs.next()){  
                Pojo pojo=new Pojo();  
                pojo.setName(rs.getString(1));    
                pojo.setPassword(rs.getString(2));  
                pojo.setEmail(rs.getString(3));
                pojo.setPhoneno(rs.getString(4));  
                pojo.setPlace(rs.getString(5));  
                list.add(pojo);  
            }  
            con.close();  
        }catch(Exception e){e.printStackTrace();}  
          
        return list;  
    }  
}  

```
# crud operation implementation:
** To view the edit page:**
```
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		out.println("<h1>Update Employee</h1>");
		String name=request.getParameter("name");
		
		Pojo pojo=StudentDao.getStudentName(name);
		
		out.print("<form action='EditServlet2' method='post'>");
		out.print("<table>");
		out.print("<tr><td>Name:</td><td><input type='text' name='name' value='"+pojo.getName()+"'/></td></tr>");
		out.print("<tr><td>Password:</td><td><input type='password' name='password' value='"+pojo.getPassword()+"'/></td></tr>");
		out.print("<tr><td>Email:</td><td><input type='email' name='email' value='"+pojo.getEmail()+"'/></td></tr>");
		out.print("<tr><td>Phone No:</td><td><input type='number' name='phone_no' value='"+pojo.getPhoneno()+"'/></td></tr>");
		out.print("<tr><td>Place:</td><td><input type='text' name='place' value='"+pojo.getPlace()+"'/></td></tr>");
        out.print("<tr><td><input type='submit' value='Edit &amp; Save '/></td></tr>");
		out.print("</table>");
		out.print("</form>");
		
		out.close();
}
}

```
# To edit the details and view:
** 
```
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/EditServlet2")
public class EditServlet2 extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String name=request.getParameter("name");
		String password=request.getParameter("password");
		String email=request.getParameter("email");
		String phone_no=request.getParameter("phone_no");
		String place=request.getParameter("place");
		
		Pojo pojo=new Pojo();
		pojo.setName(name);
		pojo.setPassword(password);
		pojo.setEmail(email);
		pojo.setPhoneno(phone_no);
		pojo.setPlace(place);
		
		int status=StudentDao.update(pojo);
		if(status>0){
			response.sendRedirect("RegisterViewServlet");
		}else{
			out.println("Sorry! unable to update");
		}
		
		out.close();
	}

}


```
# To delete the record in the table:
```
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name=request.getParameter("name");
		StudentDao.delete(name);
		response.sendRedirect("RegisterViewServlet");
	}
}


```
# To view the updated details:
```


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/RegisterViewServlet")
public class RegisterViewServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		out.println("<a href='register.jsp'>Add Student</a>");
		out.println("<h1>Student List</h1>");
		
		List<Pojo> list=StudentDao.getAllStudent();
		
		out.print("<table border='1' width='100%'");
		out.print("<tr><th>Name</th><th>Password</th><th>Email</th><th>PhoneNo</th><th>Place</th><th>Edit</th><th>Delete</th></tr>");
		for(Pojo pojo:list){
			out.print("</td><td>"+pojo.getName()+"</td><td>"+pojo.getPassword()+"</td><td>"+pojo.getEmail()+"</td><td>"+pojo.getPhoneno()+"</td><td>"+pojo.getPlace()+"</td><td><a href='EditServlet?name="+pojo.getName()+"'>edit</a></td><td><a href='DeleteServlet?name="+pojo.getName()+"'>delete</a></td></tr>");
		}
		out.print("</table>");
		
		out.close();
	}
}


```
# Session creation
** login and logout **
```
import java.io.*;  
import javax.servlet.*;  
import javax.servlet.http.*;  
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/Login")
public class Login extends HttpServlet {  

public void doGet(HttpServletRequest request, HttpServletResponse response)  
        throws ServletException, IOException {  
            try{
    response.setContentType("text/html");
        PrintWriter out = response.getWriter();  
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        int result=StudentDao.login(email,pass);
        out.println(result);
        if(result==1)
        {
            HttpSession session = request.getSession();
            session.setAttribute("hello",email);
            response.sendRedirect("Wel");
           
            out.close();
        }

    else
    {  
        response.setContentType("text/html");
        out.println("Sorry UserName  Password Error!");  
       
        }  
    } 
   catch(Exception e){System.out.println(e);}  
  
}  
}
```
# logout
```
<html>
        <body>
            <form action="logout" align="right">
       <input type="submit" value="Logout"> 
        
</body>
        </body>
        </html>

```
```
import java.io.*;  
import javax.servlet.*;  
import javax.servlet.http.*;  
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/logout")
public class Logout extends HttpServlet {  

public void doGet(HttpServletRequest request, HttpServletResponse response)  
        throws ServletException, IOException {  
            try{
    response.setContentType("text/html");
        PrintWriter out = response.getWriter();  
         HttpSession session=request.getSession(false); 
        session.invalidate();
        out.println("<h2 style='color:#f00'><b><i>Logout Successfully</i></b></h2>");
        request.getRequestDispatcher("index.jsp").include(request, response);
    } 
   catch(Exception e){System.out.println(e);}  
  
}  
}
```
# admin view
```
<html> 
  <style>
body {
   
    background-image: url("welcome.jpg");
    background-size: 1200 px 800px;
}
</style> 
        <body>
          <form action="RegisterViewServlet" method="GET" align="center"> 

  <a href="RegisterViewServlet">view Registration</a>  
</body>
</html>
```

# welcome page
```
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
@WebServlet("/Wel")
public class Wel extends HttpServlet {  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
        throws ServletException, IOException {  
            try{
       response.setContentType("text/html");  
    PrintWriter out = response.getWriter();  
      HttpSession session=request.getSession(false);    
   String name=(String)session.getAttribute("hello"); 
    out.print("hello"+name);
    request.getRequestDispatcher("logout.jsp").include(request, response);
    if(name.equals("admin@kg.com"))
    {
     request.getRequestDispatcher("admin.jsp").include(request, response);
    }
        } 
    catch(Exception e){System.out.println(e);}  
 }
  
}    
```
# Email
```
import java.io.IOException; 
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.*;
import java.net.Authenticator;
import java.util.*; 
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


@WebServlet("/mainservlet")

public class mainservlet extends HttpServlet {
   mainservlet javaEmail=null;
 public void init() throws ServletException {}
     public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException
       {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
           String toMail = request.getParameter("email");
          final String username = "nirmalkumar.m@kggroup.com";
final String password = "Thangaraj#123";
Properties props = new Properties();
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.starttls.enable", "false");
props.put("mail.smtp.host", "webmail.kggroup.com");
props.put("mail.smtp.port", "25");
Session session = Session.getInstance(props,
new javax.mail.Authenticator() {
protected PasswordAuthentication getPasswordAuthentication() {
return new PasswordAuthentication(username, password);
}
});
try {
Message message = new MimeMessage(session);
message.setFrom(new InternetAddress("nirmalkumar.m@kggroup.com"));
message.setRecipients(Message.RecipientType.TO,
InternetAddress.parse(toMail));
message.setSubject("A testing mail header !!!");
message.setText("registerd successfully!");
Transport.send(message);
System.out.println("Done");
request.getRequestDispatcher("index.jsp").include(request, response);

}
catch(Exception e)
{
    e.printStackTrace();
}

        } 
         
    }

```