/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import javax.servlet.http.*;
import javax.servlet.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

/**
 *
 * @author HungPhanN53SV
 */
public class MailDAO {

    private Properties props;
    private Session mailsession;
    private Transport transport;
    private MimeMessage message;
    private String host = "smtp.gmail.com";
    private String from;
    private String pass;
    private String to;

    public MailDAO(String senderAddr, String pwd) {
        from = senderAddr;
        pass = pwd;
        props = System.getProperties();
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.user", from);
        props.put("mail.smtp.password", pass);
        props.put("mail.smtp.port", "587");     //try 465, 25, 587
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.timeout", "25000");

        // Get the default Session object.
        mailsession = Session.getDefaultInstance(props);
    }

    public boolean sendToPerson(String rcvAddr, String subject, String content) {
        try {
            InternetAddress emailAddr = new InternetAddress(rcvAddr);
            emailAddr.validate();
        } catch (AddressException ex) {
            return false;
        }
        
        to = rcvAddr;
        try {
            // Create a default MimeMessage object.
            message = new MimeMessage(mailsession);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Set Subject: header field
            message.setSubject(subject, "UTF-8");

            // Now set the actual message
            //message.setText(content);
            message.setContent(content, "text/html; charset=UTF-8" );
            
            //  if you want to send HTML page use  setContent(msg, "text/html");
            // message.setContent("<h1>This is actual message</h1>", "text/html" );
            
            // Send message
            transport = mailsession.getTransport("smtp");
            transport.connect(host, from, pass);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
            
            //result = "Sent message successfully....";
            return true;
        } catch (MessagingException mex) {
            mex.printStackTrace();
            //result = "Error: unable to send message....";
            return false;
        }
    }
    
    public boolean sendToPeople(List<String> rcvAddr, String subject, String content) {
        for(int i=0;i<rcvAddr.size();i++){
            to = rcvAddr.get(i);
            try {
                // Create a default MimeMessage object.
                message = new MimeMessage(mailsession);
                message.setFrom(new InternetAddress(from));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

                // Set Subject: header field
                message.setSubject(subject, "UTF-8");

                // Now set the actual message
                //message.setText(content);
                message.setContent(content, "text/html; charset=UTF-8" );

                //  if you want to send HTML page use  setContent(msg, "text/html");
                // message.setContent("<h1>This is actual message</h1>", "text/html" );

                // Send message
                transport = mailsession.getTransport("smtp");
                transport.connect(host, from, pass);
                transport.sendMessage(message, message.getAllRecipients());
                transport.close();
                //result = "Sent message successfully....";
                return true;
            } catch (MessagingException mex) {
                mex.printStackTrace();
                //result = "Error: unable to send message....";
                return false;
            }
        }
        return false;
    }
    
    public static void main(String args[]){
        MailDAO md = new MailDAO("woodshop.online@gmail.com", "woodshop123");
        System.out.println(md.sendToPerson("woodshop.online@gmail.com", "test", "xasdxx"));
    }
}
