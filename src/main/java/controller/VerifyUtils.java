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

/**
 *
 * @author HungPhanN53SV
 */
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.net.ssl.HttpsURLConnection;

public class VerifyUtils {

    public static final String SITE_KEY = "6LewuwwUAAAAAKvnR3GcLNj7D9dCOrSKsu9NByaO";
    public static final String SECRET_KEY = "6LewuwwUAAAAACsGls04omG-qpYz2H6gqcNRuWrz";
    public static final String SITE_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

    public static boolean verify(String gRecaptchaResponse) {
        if (gRecaptchaResponse == null || gRecaptchaResponse.length() == 0) {
            return false;
        }

        try {
            URL verifyUrl = new URL(SITE_VERIFY_URL);

            // Mở kết nối (Connection) tới URL trên.
            HttpsURLConnection conn = (HttpsURLConnection) verifyUrl.openConnection();

           // Thêm các thông tin Header vào Request chuẩn bị gửi tới server.
            // Add Request Header
            conn.setRequestMethod("POST");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");
            conn.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

            // Dữ liệu sẽ gửi tới server.
            String postParams = "secret=" + SECRET_KEY + "&response=" + gRecaptchaResponse;

            // Send Request
            conn.setDoOutput(true);

           // Lấy luồng đầu ra của kết nối tới server.
            // Ghi dữ liệu vào luồng này, có nghĩa là gửi thông tin đến Server.
            OutputStream outStream = conn.getOutputStream();
            outStream.write(postParams.getBytes());

            outStream.flush();
            outStream.close();

            // Mã trả lời trả về từ Server.
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode=" + responseCode);

            // Lấy InputStream từ Connection để đọc dữ liệu gửi về từ Server.
            InputStream is = conn.getInputStream();

            JsonReader jsonReader = Json.createReader(is);
            JsonObject jsonObject = jsonReader.readObject();
            jsonReader.close();

            // ==> {"success": true}
            System.out.println("Response: " + jsonObject);

            boolean success = jsonObject.getBoolean("success");
            return success;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
