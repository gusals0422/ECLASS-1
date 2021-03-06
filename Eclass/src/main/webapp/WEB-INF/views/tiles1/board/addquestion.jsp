<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>

	#container{
		background-color: #e0e0eb;
	}
	
	#wholeNotice{
		width: 1080px;
		margin: 0 auto;
		border: solid 1px black;
		background-color: #5E5E5E;
	}
	
	tr,th,td{
		border: solid 1px black;
		border-collapse: collapse;
		padding: 20px;
	}
</style>

<div id="container">
	<div id="wholeNotice">
		<div style="text-align: center;">
			<h3 style="color: white; font-weight: bold;">Q&A</h3>
		</div>	
		<br>
			
		<div>
			<table style="margin: 0 auto; width: 1000px; background-color: white;">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" size="40"/>&nbsp;
						<input type="checkbox" />&nbsp;비밀글
					</td>
				</tr>
				
				<tr>
					<th>작성자</th>
					<td><input type="text"/></td>
				</tr>
				
				<tr>
					<th>첨부파일</th>
					<td><input type="file"/></td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td><textarea rows="15" cols="110"></textarea> </td>
				</tr>
				
				<tr>
					<th>암호</th>
					<td><input type="text"/></td>
				</tr>
				
			</table>
		</div>
		
		<br>
		<div style="margin: 0 auto; width: 300px;">
			<button type="button" style="width: 140px;">작성</button>
			<button type="reset" style="width: 140px;">취소</button>
		</div>	
		<br>
			
	</div>
</div>