/*****************************************************
 *  
 *  Copyright 2011 Adobe Systems Incorporated.  All Rights Reserved.
 *  
 *****************************************************
 *  The contents of this file are subject to the Mozilla Public License
 *  Version 1.1 (the "License"); you may not use this file except in
 *  compliance with the License. You may obtain a copy of the License at
 *  http://www.mozilla.org/MPL/
 *   
 *  Software distributed under the License is distributed on an "AS IS"
 *  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 *  License for the specific language governing rights and limitations
 *  under the License.
 *   
 *  
 *  The Initial Developer of the Original Code is Adobe Systems Incorporated.
 *  Portions created by Adobe Systems Incorporated are Copyright (C) 2011 Adobe Systems 
 *  Incorporated. All Rights Reserved. 
 *  
 *****************************************************/
package org.osmf.net.metrics
{
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import flashx.textLayout.debug.assert;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.osmf.events.QoSInfoEvent;
	import org.osmf.net.qos.FragmentDetails;
	import org.osmf.net.qos.QoSInfo;
	import org.osmf.net.qos.QoSInfoHistory;
	import org.osmf.net.qos.QualityLevel;
	
	public class TestFPSMetric
	{		
		[Before]
		public function setUp():void
		{
			var conn:NetConnection = new NetConnection();
			conn.connect(null);
			netStream = new NetStream(conn);
			qosInfoHistory = new QoSInfoHistory(netStream, 4);
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testMetricGetType():void
		{
			metric=new FPSMetric(qosInfoHistory);
			
			//check first response when history is empty
			var metricValue:MetricValue;
			metricValue = metric.value;
			assertEquals(MetricType.FPS, metric.type);
			assertEquals(false, metricValue.valid);
			assertEquals(undefined, metricValue.value);

			//check response for NaN
			addQoSInfo(generateQoSInfo(1111, NaN));			
			metricValue = metric.value;
			assertEquals(MetricType.FPS, metric.type);
			assertEquals(false, metricValue.valid);
			assertEquals(undefined, metricValue.value);
			
			//check response for 0
			addQoSInfo(generateQoSInfo(2222, 0));			
			metricValue = metric.value;
			assertEquals(MetricType.FPS, metric.type);
			assertEquals(false, metricValue.valid);
			assertEquals(undefined, metricValue.value);
			
			//check response for valid value
			addQoSInfo(generateQoSInfo(3333, 23.9));			
			metricValue = metric.value;
			assertEquals(MetricType.FPS, metric.type);
			assertEquals(true, metricValue.valid);
			assertEquals(23.9, metricValue.value);
			
			//check that it gets the latest
			addQoSInfo(generateQoSInfo(4444, 25.1));			
			metricValue = metric.value;
			assertEquals(MetricType.FPS, metric.type);
			assertEquals(true, metricValue.valid);
			assertEquals(25.1, metricValue.value);
			
		}

		
		//helper different from qosinfo tests functions
		
		private function generateQoSInfo(timestamp:Number, fps:Number):QoSInfo
		{
			var v:Vector.<QualityLevel> = new Vector.<QualityLevel>();
			for(var i:uint=0; i< 3; i++)
			{
				v[i] = new QualityLevel( i, 150+ 100*i, "test" + (150+ 100*i) );
			}
			return (new QoSInfo(timestamp, 5678, v,1, 2, new FragmentDetails(400000, 4, 3, 0, "test"), fps ));
		}
		
		//helper identical to qosinfo tests functions
		private function addQoSInfo(qos:QoSInfo):void
		{			
			netStream.dispatchEvent(new QoSInfoEvent(QoSInfoEvent.QOS_UPDATE, false, false, qos));	
		}
		
		
		private var metric:FPSMetric;
		private var qosInfoHistory:QoSInfoHistory;
		private var netStream:NetStream;
	}
}