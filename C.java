public class C
{
   public static void main(String args[])throws Exception
   {
      Class.forName("B");
     // B b=new B();
   } 

}
 class B
{
static
{
    System.out.println("static block");
}
{
System.out.println("instance");
}    
}