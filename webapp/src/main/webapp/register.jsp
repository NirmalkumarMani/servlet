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
<tr><td><h3>Name*</h3></td><td><input type="text" name="name" required/></td></tr>  
<tr><td><h3>Password</h3></td><td><input type="password" name="password" required/></td></tr>  
<tr><td><h3>Email</h3></td><td><input type="email" name="email" required/></td></tr>  
<tr><td><h3>Phone Number</h3></td><td><input type="text" name="phone_no" required/></td></tr>
<tr><td><h3>Place</h3></td><td><input type="place" name="place" required/> </td></tr>

<tr><td align="center"><input type="submit" value="Register"/></td>

</table>   

</form>  

<br/> 
</body>  
</html> 