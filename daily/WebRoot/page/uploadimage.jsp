<%@ page contentType="text/html;charset=gb2312" language="java"
	import="java.io.*,java.awt.Image,java.awt.image.*,com.sun.image.codec.jpeg.*,java.sql.*,com.jspsmart.upload.*,java.util.*"%>
<%
	SmartUpload mySmartUpload = new SmartUpload();
	long file_size_max = 1024*100;//�����ļ����Ϊ100KB
	String fileName2 = "", ext = "", testvar = "";
	String url = "upload/"; //Ӧ��֤�ڸ�Ŀ¼���д�Ŀ¼�Ĵ��ڣ�Ҳ����˵��Ҫ�Լ�������Ӧ���ļ��У�
	//��ʼ��
	mySmartUpload.initialize(pageContext);
	//ֻ�������ش����ļ�
	try {
		mySmartUpload.setAllowedFilesList("jpg,gif,JPG,GIF,bmp,BMP");//�˴����ļ���ʽ���Ը�����Ҫ�Լ��޸�
		//�����ļ� 
		mySmartUpload.upload();
	} catch (Exception e) {
%>
<SCRIPT language=javascript>
alert("ֻ�����ϴ�.jpg .gif .bmp����ͼƬ�ļ�");
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
alert("����ѡ��Ҫ�ϴ����ļ�");
window.location='upload.htm';
</script>
<%
	} else {
			//String myFileName=myFile.getFileName(); //ȡ�����ص��ļ����ļ���
			ext = myFile.getFileExt(); //ȡ�ú�׺��
			int file_size = myFile.getSize(); //ȡ���ļ��Ĵ�С
			String saveurl = "";
			if (file_size < file_size_max) {
				//�����ļ�����ȡ�õ�ǰ�ϴ�ʱ��ĺ�����ֵ
				Calendar calendar = Calendar.getInstance();
				String filename = String.valueOf(calendar
						.getTimeInMillis());
				saveurl = application.getRealPath("/") + url;
				saveurl += filename + "." + ext; //����·��
				myFile.saveAs(saveurl, SmartUpload.SAVE_PHYSICAL);
				String imageurl = "http://localhost/daily/upload/" + filename + "." + ext;//����ͼƬ�����·��
				String imageName = filename + "." + ext;//ͼƬ����
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
opener.document.getElementById('div1').innerHTML="<a href=\""+url+"\" target=\"_blank\"><img alt=\"����鿴ԭͼ\" width=\"40%\" height=\"40%\" src=\""+url+"\"></a>";
opener.document.getElementById("image").value=name;
alert("�ϴ��ɹ���");
window.close();
</script>
<%
	}
	else{
	%>
<SCRIPT language=javascript>
alert("ͼƬ��С���ܳ���100KB");
window.location='upload.htm';
</script>
<%
	}
		}
	} catch (Exception e) {
		out.print(e.toString());
	}
%>
