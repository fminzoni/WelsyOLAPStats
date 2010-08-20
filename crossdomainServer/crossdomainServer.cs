using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace CrossdomainServer
{

	class Server
	{
	
		static void Main()
		{
			
			TcpListener server = new TcpListener(Dns.GetHostEntry("argon.homelinux.net").AddressList[0], 843);
			//TcpListener server = new TcpListener(843);
			server.Start();
			Console.WriteLine("server started");
			
			try
			{
				while(true)
				{
					TcpClient client = server.AcceptTcpClient();
					Console.WriteLine("connection accepted");
					
					NetworkStream stream = client.GetStream();
					byte[] input = new byte[22];
					stream.Read(input, 0, 22);
					Console.WriteLine("client: " + Encoding.ASCII.GetString(input));
					string output = "<?xml version=\"1.0\"?><cross-domain-policy>" + 
					"<site-control permitted-cross-domain-policies=\"all\"/>" +
					"<allow-access-from domain=\"*\" to-ports=\"*\" />" + 
					"</cross-domain-policy>\0";
					Byte[] outputBytes = Encoding.ASCII.GetBytes(output);
					stream.Write(outputBytes, 0, outputBytes.Length);
					stream.Flush();
					Console.WriteLine("server responded");
					client.Close();
				}
			}
			catch(Exception e)
			{
				Console.WriteLine(e.ToString());
			}
			finally
			{
				server.Stop();
				Console.WriteLine("server halted");
			}
		}
	
	}

}