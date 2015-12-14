package saganet.scg;

public class ContentTypes {
    public ContentTypes() {
    }
    
    public static String getMime(String fileName)
    {

        String mime = null;
        String ext = fileName.toLowerCase();

        if (ext.endsWith(".pdf"))
            mime = "application/pdf";
        else if (ext.endsWith(".doc"))
            mime = "application/msword";
        else if (ext.endsWith(".xls"))
            mime = "application/vnd.ms-excel";
        else if (ext.endsWith(".ppt"))
            mime = "application/vnd.ms-powerpoint";
        else if (ext.endsWith(".docx"))
            mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        else if (ext.endsWith(".xlsx"))
            mime = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        else if (ext.endsWith(".pptx"))
            mime = "application/vnd.openxmlformats-officedocument.presentationml.presentation";
        else if (ext.endsWith(".rar"))
            mime = "application/octet-stream";
        else if (ext.endsWith(".zip"))
            mime = "application/zip";
        else if (ext.endsWith(".jpg"))
            mime = "image/jpeg";
        else if (ext.endsWith(".jpeg"))
            mime = "image/jpeg";
        else if (ext.endsWith(".gif"))
            mime = "image/gif";
        else if (ext.endsWith(".png"))
            mime = "image/png";

        return mime;
    }
    
    public static String getExtensionMime(String mime){
        String ext;
        if(mime.equals("application/pdf"))
            ext = "pdf";
        else if(mime.equals("application/msword"))
            ext = "doc";
        else if(mime.equals("application/vnd.ms-excel"))
            ext = "xls";
        else if(mime.equals("application/vnd.ms-powerpoint"))
            ext = "ppt";
        else if(mime.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document"))
            ext = "docx";
        else if(mime.equals("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
            ext = "xlsx";
        else if(mime.equals("application/vnd.openxmlformats-officedocument.presentationml.presentation"))
            ext = "pptx";
        else if(mime.equals("application/octet-stream"))
            ext = "rar";
        else if(mime.equals("application/zip"))
            ext = "zip";
        else if(mime.equals("image/jpeg"))
            ext = "jpg";
        else if(mime.equals("image/gif"))
            ext = "gif";
        else if(mime.equals("image/png"))
            ext = "png";
        else
            ext = "";
        
        return ext;
    }
}
