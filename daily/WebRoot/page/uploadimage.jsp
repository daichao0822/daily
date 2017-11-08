<%@ page contentType="text/html;charset=gb2312" language="java"
	import="java.io.*,java.awt.Image,java.awt.image.*,com.sun.image.codec.jpeg.*,java.sql.*,com.jspsmart.upload.*,java.util.*"%>
<%
	SmartUpload mySmartUpload = new SmartUpload();
	long file_size_max = 1024*100;//设置文件最大为100KB
	String fileName2 = "", ext = "", testvar = "";
	String url = "upload/"; //应保证在根目录中有此目录的存在（也就是说需要自己建立相应的文件夹）
	//初始化
	mySmartUpload.initialize(pageContext);
	//只允许上载此类文件
	try {
		mySmartUpload.setAllowedFilesList("jpg,gif,JPG,GIF,bmp,BMP");//此处的文件格式可以根据需要自己修改
		//上载文件 
		mySmartUpload.upload();
	} catch (Exception e) {
%>
<SCRIPT language=javascript>
alert("只允许上传.jpg .gif .bmp类型图片文件");
window.location='upload.htm';
</script>
<%
	}
	try {
		com.jspsmart.upload.File myFile = mySmartUpload.getFiles()
				.getFile(0);
		if (myFile.isMissing()) {
%>
<SCRIPT language=javascript>
alert("请先选择要上传的文件");
window.location='upload.htm';
</script>
<%
	} else {
			//String myFileName=myFile.getFileName(); //取得上载的文件的文件名
			ext = myFile.getFileExt(); //取得后缀名
			int file_size = myFile.getSize(); //取得文件的大小
			String saveurl = "";
			if (file_size < file_size_max) {
				//更改文件名，取得当前上传时间的毫秒数值
				Calendar calendar = Calendar.getInstance();
				String filename = String.valueOf(calendar
						.getTimeInMillis());
				saveurl = application.getRealPath("/") + url;
				saveurl += filename + "." + ext; //保存路径
				myFile.saveAs(saveurl, SmartUpload.SAVE_PHYSICAL);
				String imageurl = "http://localhost/daily/upload/" + filename + "." + ext;//保存图片的相对路径
				String imageName = filename + "." + ext;//图片名称
%>
<table>
	<tr>
		<td>
			<input type="hidden" name="imageUrl" id="imageUrl"
				value="<%=imageurl%>" />
			<input type="hidden" name="imgName" id="imgName"
				value="<%=imageName%>" />
		</td>
	</tr>
</table>
<SCRIPT language=javascript>
var url=document.getElementById("imageUrl").value;
var name=document.getElementById("imgName").value;
opener.document.getElementById('div1').innerHTML="<a href=\""+url+"\" target=\"_blank\"><img alt=\"点击查看原图\" width=\"40%\" height=\"40%\" src=\""+url+"\"></a>";
opener.document.getElementById("image").value=name;
alert("上传成功！");
window.close();
</script>
<%
	}
	else{
	%>
<SCRIPT language=javascript>
alert("图片大小不能超过100KB");
window.location='upload.htm';
</script>
<%
	}
		}
	} catch (Exception e) {
		out.print(e.toString());
	}
%>
