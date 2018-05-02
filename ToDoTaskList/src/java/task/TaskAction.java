/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package task;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ryu
 */
public class TaskAction extends HttpServlet {

    int i, sid;
    String title, desc, page, SqlQuery, sql;
    ResultSet rs;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection con;
        PreparedStatement ps;
        con = Connect.makeConnection();
        HttpSession session = request.getSession(true);
        title = request.getParameter("title");
        desc = request.getParameter("desc");
        page = request.getParameter("page");
        if (page.equals("AddTask")) {
            try {
                if (title != null) {
                    sql = "select * from task where title ='" + title + "'";
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        session.setAttribute("result", "Duplicate Title. Change to Add task...!");
                        response.sendRedirect("Task.jsp");
                    } else {
                        SqlQuery = "insert into task (title,des) values (?,?)";
                        ps = con.prepareStatement(SqlQuery);
                        ps.setString(1, title);
                        ps.setString(2, desc);
                        i = ps.executeUpdate();
                        if (i > 0) {
                            session.setAttribute("result", "Task Added..!");
                            response.sendRedirect("Task.jsp");
                        } else {
                            session.setAttribute("result", "Error!");
                            response.sendRedirect("Task.jsp");
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (page.equals("EditTask")) {
            try {
                sid = Integer.parseInt(request.getParameter("sid"));
                SqlQuery = "UPDATE task SET title = '" + title + "',des = '" + desc + "' WHERE task_id = " + sid;
                ps = con.prepareStatement(SqlQuery);
                i = ps.executeUpdate();
                if (i > 0) {
                    session.setAttribute("result", "Task Updated..!");
                    response.sendRedirect("Task.jsp");
                } else {
                    session.setAttribute("result", "Error!");
                    response.sendRedirect("Task.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (page.equals("DeleteTask")) {
            try {
                sid = Integer.parseInt(request.getParameter("sid"));
                SqlQuery = "delete from task where task_id = " + sid;
                ps = con.prepareStatement(SqlQuery);
                i = ps.executeUpdate();
                System.out.println("RUnning DelTask" + SqlQuery);
                if (i > 0) {
                    session.setAttribute("result", "Task Removed..!");
                    response.sendRedirect("Task.jsp");
                } else {
                    session.setAttribute("result", "Error!");
                    response.sendRedirect("Task.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
