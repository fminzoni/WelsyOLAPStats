package org.welsy.olapstats
{
	public class MongoConfig
	{
		
		public var dbHost : String = "argon.homelinux.net";
		public var dbPort : uint = 27017;
		public var dbName : String = "welsy";
		public var dbCollection : String = "one";
		
		public var crossdomainPolicyURL : String = "xmlsocket://argon.homelinux.net:843";
		public var crossdomainPolicyOLD : String = "http://argon.homelinux.net:80/crossdomain.xml";
	}
}