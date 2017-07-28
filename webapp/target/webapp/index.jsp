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
<tr><td>Email</td><td><input type="email" name="email" required/></td></tr>  
<tr><td>Password</td><td><input type="password" name="password" required/></td></tr>            
<tr><td align="center"><input type="submit" value="login"/></td>
</form>
<form action="register.jsp">
<tr><td align="center"><input type="submit" value="signup"/></tr></td>  
</form> 
</table>
<a href="Login"></a>  
</body>
</html>