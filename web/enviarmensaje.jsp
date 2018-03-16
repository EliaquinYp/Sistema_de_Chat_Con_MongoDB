<%@ page session="true" %>

<%
    String usuario = "";
    String haySesion = "";
    HttpSession sesionOk = request.getSession();
    if (sesionOk.getAttribute("usuario") == null) {
%>

<jsp:forward page="index.jsp">
    <jsp:param name="error" value="Es obligatorio identificarse"/>
</jsp:forward>

<%    } else {
        usuario = (String) sesionOk.getAttribute("usuario");
        haySesion =  (String)sesionOk.getAttribute("haySesion");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.gridfs.model.GridFSUploadOptions"%>
<%@page import="com.mongodb.client.gridfs.GridFSBuckets"%>
<%@page import="com.mongodb.client.gridfs.GridFSBucket"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="org.apache.tomcat.util.http.fileupload.util.Streams"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItemStream"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItemIterator"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
<%@page import="com.mongodb.*"%>

<%
            ServletFileUpload Data = new ServletFileUpload();
            FileItemIterator iter = Data.getItemIterator(request);
            FileItemStream item =iter.next();
            InputStream stream = item.openStream();
            String UsuarioD = Streams.asString(stream);
            while (iter.hasNext()) {
                item = iter.next();
                stream = item.openStream();
                
                if (item.isFormField()) {
                    String Mensaje = Streams.asString(stream);
                   
                    if(Mensaje.compareTo("") != 0){
                        MongoClient mCliente = new MongoClient("127.0.0.1",27017);
                        DB db = mCliente.getDB("yptBD");
                        DBCollection coleccion = db.getCollection("Mensajes");
                        BasicDBObject documento = new BasicDBObject();
                        documento.put("visit", usuario);
                        documento.put("host",UsuarioD);
                        documento.put("mensaje", Mensaje);
                        documento.put("fecha", "Enero 2018");
			documento.put("tipo", 0);
                        documento.put("estado", 0);
                        coleccion.insert(documento);
                        %>
                        <jsp:useBean id="miLogin" class="Autentication.cLogin" scope="session">
            
                        </jsp:useBean>
                        <%
                        miLogin.setaUsuario(usuario);
                        miLogin.ContarMensajeEnvi();
                        %>
                        <jsp:useBean id="miLogin1" class="Autentication.cLogin" scope="session">
            
                        </jsp:useBean>
                        <%
                        miLogin1.setaUsuario(UsuarioD);
                        miLogin1.ContarMensajeReciv();
                        
                    }
                }
                else
                    {
                       String nombreArch = item.getName();
                       out.print(nombreArch);
                       if(nombreArch.compareTo("") != 0)
                        {
                            MongoClient mCliente = new MongoClient("127.0.0.1",27017);
                            DB db = mCliente.getDB("yptBD");
                            DBCollection coleccion = db.getCollection("Mensajes");
                            BasicDBObject documento = new BasicDBObject();
                            documento.put("visit", usuario);
                            documento.put("host",UsuarioD);
                            documento.put("mensaje", nombreArch); 
                            documento.put("fecha", "Enero 2018");
                            documento.put("tipo", 1); 
                            documento.put("estado", 0);
                            coleccion.insert(documento);
                            %>
                        <jsp:useBean id="miLogin2" class="Autentication.cLogin" scope="session">
            
                        </jsp:useBean>
                        <%
                        miLogin2.setaUsuario(usuario);
                        miLogin2.ContarMensajeEnvi();
                        %>
                        <jsp:useBean id="miLogin14" class="Autentication.cLogin" scope="session">
            
                        </jsp:useBean>
                        <%
                        miLogin14.setaUsuario(UsuarioD);
                        miLogin14.ContarMensajeReciv();

                            MongoClient miCliente = new MongoClient("127.0.0.1", 27017);
                            MongoDatabase baseDatos = miCliente.getDatabase("yptBD");
                            GridFSBucket gridFSBucket = GridFSBuckets.create(baseDatos, "misArchivos");
                            GridFSUploadOptions opciones = new GridFSUploadOptions()
                            .chunkSizeBytes(1024);
                            ObjectId fileId = gridFSBucket.uploadFromStream(nombreArch, stream, opciones);
                        }
                          
                    }
            }
%>
<jsp:forward page="Mensajes.jsp">
       <jsp:param name = "UsuarioD" value="<%=UsuarioD%>"/> 
</jsp:forward> 



