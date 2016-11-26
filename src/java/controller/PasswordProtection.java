/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

//import org.apache.tomcat.util.codec.binary.Base64;

import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;


/**
 *
 * @author KhoaAlienware
 */
public class PasswordProtection {
    public static String encrypt(String pass){
        String encrypted = Base64.encode(pass.getBytes());
        return encrypted;
    }
    public static String decrypt(String encrypt) throws Base64DecodingException{
        String decrypt = new String(Base64.decode(encrypt.getBytes()));
        return decrypt;
    }
}
