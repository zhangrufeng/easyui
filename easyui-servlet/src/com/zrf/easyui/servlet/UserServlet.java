package com.zrf.easyui.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;








import net.sf.json.JSONObject;

import com.zrf.easyui.model.Users;


@SuppressWarnings("serial")
public class UserServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		 String flag=req.getParameter("flag");
		 if(flag==null){
			 doList(req,resp);
		 }else if("add".equals(flag)){
			 doAdd(req,resp);
		 }else if("updateUI".equals(flag)){
			 doUpdateUI(req,resp);
		 }else if("update".equals(flag)){
			 doUpdate(req,resp);
		 }else if("delete".equals(flag)){
			 doDelete(req,resp);
		 }
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req,resp);
		
	}
	protected void doList(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/easyui", "root", "000000");
			Statement stat=conn.createStatement();
			String sql="select * from users";
			ResultSet rs=stat.executeQuery(sql);
			List<Users>userList=new ArrayList<Users>();
			resp.setContentType("text/html;charset=utf-8");
			while(rs.next()){
				Users users=new Users();
				users.setId(rs.getInt("id"));
				users.setFirstname(rs.getString("firstname"));
				users.setLastname(rs.getString("lastname"));
				users.setPhone(rs.getString("phone"));
				users.setEmail(rs.getString("email"));
				userList.add(users);
			}
			String str="{\"total\":"+userList.size()+" ,\"rows\":"+net.sf.json.JSONArray.fromObject(userList).toString()+"}";
			resp.getWriter().write(str);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	protected void doAdd(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		   String firstname=req.getParameter("firstname");
		   String lastname=req.getParameter("lastname");
		   String phone=req.getParameter("phone");
		   String email=req.getParameter("email");
		   JSONObject json=new JSONObject();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/easyui", "root", "000000");
			String sql="insert into users(firstname,lastname,phone,email)values(?,?,?,?)";
			PreparedStatement pr=conn.prepareStatement(sql);
			pr.setString(1, firstname);
			pr.setString(2, lastname);
			pr.setString(3, phone);
			pr.setString(4, email);
			pr.executeUpdate();
			json.put("success", "true");
			resp.getWriter().write(json.toString());
		} catch (ClassNotFoundException e) {
			json.put("error", "false");
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	protected void doUpdateUI(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		int id=Integer.parseInt(req.getParameter("id"));
		Users users=new Users();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/easyui", "root", "000000");
			Statement stat=conn.createStatement();
			String sql="select * from users where id="+id;
			ResultSet rs=stat.executeQuery(sql);
			while(rs.next()){
				users.setId(rs.getInt("id"));
				users.setFirstname(rs.getString("firstname"));
				users.setLastname(rs.getString("lastname"));
				users.setPhone(rs.getString("phone"));
				users.setEmail(rs.getString("email"));
				req.setAttribute("users", "users");
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}
	protected void doUpdate(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		   String firstname=req.getParameter("firstname");
		   String lastname=req.getParameter("lastname");
		   String phone=req.getParameter("phone");
		   String email=req.getParameter("email");
		   int id=Integer.parseInt(req.getParameter("id"));
		   JSONObject json=new JSONObject();
		   try {
			Class.forName("com.mysql.jdbc.Driver");
			 Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/easyui", "root", "000000");
			 String sql="update users set firstname=?,lastname=?,phone=?,email=? where id=?";
			 PreparedStatement pr=conn.prepareStatement(sql);
			 pr.setString(1, firstname);
			 pr.setString(2, lastname);
			 pr.setString(3, phone);
			 pr.setString(4, email);
			 pr.setInt(5, id);
			 pr.executeUpdate();
		     json.put("success", "true");
		 	resp.getWriter().write(json.toString());
		} catch (ClassNotFoundException e) {
			 json.put("error", "false");
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		int id=Integer.parseInt(req.getParameter("id"));
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/easyui", "root", "000000");
			Statement stat=conn.createStatement();
			String sql="delete from users where id="+id;
			stat.executeUpdate(sql);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		
	}
}
