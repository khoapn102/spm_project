/* 
 * Copyright (C) 2016 Kppc
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package controller;

//import org.apache.tomcat.util.codec.binary.Base64;

import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;


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
    
    public static void main(String[] args) {
        try {
            String pass = "b";
            //System.out.println(PasswordProtection.encrypt(pass));

            System.out.println(PasswordProtection.decrypt("Yg=="));
        } catch (Base64DecodingException ex) {
            Logger.getLogger(PasswordProtection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
