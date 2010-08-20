
import java.io.*;
import java.net.*;

public class CrossdomainServer {

	public static void main(String args[]) {
	
		try {
			ServerSocket server = new ServerSocket(843);
			System.out.println("server waiting for connections");
			
			while(true) {
				Socket client = server.accept();
				System.out.println("\naccepted connection from " + client.getInetAddress().toString());
				
				System.out.println("client says:");
				InputStream input = client.getInputStream();
				int read;
				while((read = input.read()) != -1 && read != 0) {
					System.out.print((char)read);
				}
				System.out.println();
				
				OutputStreamWriter output = new OutputStreamWriter(client.getOutputStream());
				String policy =
					"<?xml version=\"1.0\"?><cross-domain-policy>" +
					"<site-control permitted-cross-domain-policies=\"all\"/>" +
					"<allow-access-from domain=\"*\" to-ports=\"*\" />" +
					"</cross-domain-policy>\0";
				output.write(policy, 0, policy.length());
				output.flush();
				System.out.println("crossdomain policy sent");
				
				output.close();
				input.close();
				client.close();
			}
		} catch(IOException e) {
			System.out.println("an exception occurred");
			System.out.println(e);
		}
	
	}

}
