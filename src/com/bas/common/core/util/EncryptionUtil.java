/**
 * 
 */
package com.bas.common.core.util;

import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.apache.catalina.util.Base64;
import org.apache.tomcat.util.buf.ByteChunk;

/**
 * @author Sandy
 *
 */
public class EncryptionUtil {

		private static final String UNICODE_FORMAT = "UTF8";
	    public static final String DES_ENCRYPTION_SCHEME = "DES";
	    private KeySpec myKeySpec;
	    private SecretKeyFactory mySecretKeyFactory;
	    private Cipher cipher;
	    byte[] keyAsBytes;
	    private String myEncryptionKey;
	    private String myEncryptionScheme;
	    SecretKey key;
	 
	    public EncryptionUtil() throws Exception
	    {
	        myEncryptionKey = "SahaaysEncryptionKeyUdyamSiriusInc";
	        myEncryptionScheme = DES_ENCRYPTION_SCHEME;
	        keyAsBytes = myEncryptionKey.getBytes(UNICODE_FORMAT);
	        myKeySpec = new DESKeySpec(keyAsBytes);
	        mySecretKeyFactory = SecretKeyFactory.getInstance(myEncryptionScheme);
	        cipher = Cipher.getInstance(myEncryptionScheme);
	        key = mySecretKeyFactory.generateSecret(myKeySpec);
	    }
	 
	    /**
	     * Method To Encrypt The String
	     */
	    public String encrypt(String unencryptedString) {
	        String encryptedString = null;
	        try {
	            cipher.init(Cipher.ENCRYPT_MODE, key);
	            byte[] plainText = unencryptedString.getBytes(UNICODE_FORMAT);
	            byte[] encryptedText = cipher.doFinal(plainText);
	            encryptedString = Base64.encode(encryptedText);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return encryptedString;
	    }
	    /**
	     * Method To Decrypt An Ecrypted String
	     */
	    public String decrypt(String encryptedString) {
	        String decryptedText=null;
	        try {
	            cipher.init(Cipher.DECRYPT_MODE, key);
	            ByteChunk encrypted = new ByteChunk();
	            encrypted.setBytes(encryptedString.getBytes(), 0, encryptedString.getBytes().length);
	            ByteChunk encryptedBytes = new ByteChunk();
	            Base64.decode(encrypted, encryptedBytes);
	            byte[] encryptedText = encryptedBytes.getBytes();
	            byte[] plainText = cipher.doFinal(encryptedText);
	            decryptedText= bytes2String(plainText);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return decryptedText;
	    }
	    /**
	     * Returns String From An Array Of Bytes
	     */
	    private static String bytes2String(byte[] bytes) {
	        StringBuffer stringBuffer = new StringBuffer();
	        for (int i = 0; i < bytes.length; i++) {
	            stringBuffer.append((char) bytes[i]);
	        }
	        return stringBuffer.toString();
	    }
	    
	    public static void main(String args []) throws Exception
	       {
	           EncryptionUtil myEncryptor= new EncryptionUtil();
	    
	           String stringToEncrypt="kisan.pr@gmail.com";
	           String encrypted=myEncryptor.encrypt(stringToEncrypt);
	           String decrypted=myEncryptor.decrypt(encrypted);
	    
	           System.out.println("String To Encrypt: "+stringToEncrypt);
	           System.out.println("Encrypted Value :" + encrypted);
	           System.out.println("Decrypted Value :"+decrypted);
	    
	       } 
}
