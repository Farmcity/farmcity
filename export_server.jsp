<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/seguridad/seg.jsp" %>
<%
String content = request.getParameter("content");
String filename  = request.getParameter("filename"); //reportes_listados_rc_saga_11062013_0948
String format = request.getParameter("format"); //xls

byte[] bytes;

bytes = content.getBytes();
//response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); 
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment; filename="+filename+"."+format);
response.setContentLength(bytes.length);
ServletOutputStream ouputStream = response.getOutputStream(); 
ouputStream.write(bytes, 0, bytes.length); 
ouputStream.flush(); 
ouputStream.close(); 
%>