<%-- 
    Document   : take_test.jsp
    Created on : 9 Dec, 2020, 3:17:05 PM
    Author     : gagan
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            
                    Connection con = null;
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/learningspacedb","root","");
                        System.out.println(con);
                    }catch(Exception e){
                        System.out.println(e.getMessage());
                    }
                   
            HttpSession ses = request.getSession(false);
            if(ses.getAttribute("email")==null){
                String testid = request.getParameter("testId");
                int qno = Integer.parseInt(request.getParameter("qno"));
               
                
                PreparedStatement ps = con.prepareStatement("select * from question where testid='"+testid+"' and Qno="+qno);
                ResultSet rs = ps.executeQuery();
                
                if(rs.next()){
%>
            <div id="question">
                <%
                    out.print(rs.getString("question"));
                %>
            </div>
            <form>
               
            <div id="op1">
                <%  
                    String t;
                    t = rs.getString("option1");
                      out.print("<input type='radio' name='answer' value="+t+">"+t);
                %>
            </div>
            <div id="op2">
                <%  
                    t = rs.getString("option2");
                      out.print("<input type='radio' name='answer' value="+t+">"+t);
                %>
            </div>
            <div id="op3">
                <%  
                    t = rs.getString("option3");
                      out.print("<input type='radio' name='answer' value="+t+">"+t);
                %>
            </div>
            <div id="op4">
                <%  
                    t = rs.getString("option4");
                      out.print("<input type='radio' name='answer' value="+t+">"+t);
                %>
            </div> 
            </form>
            <div id="next">
                <%
                    out.print("<button value='next' onclick=window.location.href='http://localhost:8083/LearnSpace/take_test.jsp?testId=JAVA101&qno="+(qno+1)+"'>Next</button>"); 
                %>
            </div>
            
            
            <%
                }
                }
            else{
                response.sendRedirect("login.html");
            }
            %>
    </body>
</html>
