using System;
using NMock;
using NUnit.Framework;
using ThoughtWorks.CruiseControl.Core;
using ThoughtWorks.CruiseControl.Core.Sourcecontrol;
using ThoughtWorks.CruiseControl.Core.Util;

namespace ThoughtWorks.CruiseControl.UnitTests.Core.SourceControl
{
	[TestFixture]
	public class QuietPeriodTest
	{
		private Modification[] mods;
		private DateTime from;
		private DateTime to;
		private IMock mockSourceControl;
		private IMock mockDateTimeProvider;
		private QuietPeriod quietPeriod;

		[SetUp]
		protected void SetUpFixtureData()
		{
			from = new DateTime(2004, 12, 1, 12, 1, 0);
			to = new DateTime(2004, 12, 1, 12, 2, 0);

			mods = new Modification[1];
			mods[0] = new Modification();
			mods[0].ModifiedTime = new DateTime(2004, 12, 1, 12, 1, 30);			

			mockSourceControl = new DynamicMock(typeof(ISourceControl));
			mockDateTimeProvider = new DynamicMock(typeof(DateTimeProvider));
			quietPeriod = new QuietPeriod((DateTimeProvider)mockDateTimeProvider.MockInstance);
		}

		[TearDown]
		protected void VerifyMock()
		{
			mockSourceControl.Verify();	
			mockDateTimeProvider.Verify();
		}

		[Test]
		public void ShouldCheckModificationsAndReturnIfDelayIsZero()
		{
			mockSourceControl.ExpectAndReturn("GetModifications", mods, from, to);
			mockDateTimeProvider.ExpectNoCall("Sleep", typeof(int));

			quietPeriod.ModificationDelaySeconds = 0;
			Modification[] actualMods = quietPeriod.GetModifications((ISourceControl) mockSourceControl.MockInstance, from, to);

			Assert.AreEqual(mods, actualMods);
		}

		[Test]
		public void ShouldCheckModificationsUntilThereAreNoModsInModificationDelay()
		{
			Modification[] newMods = new Modification[2];
			newMods[0] = mods[0];
			newMods[1] = new Modification();
			newMods[1].ModifiedTime = new DateTime(2004, 12, 1, 12, 2, 10);

			mockSourceControl.ExpectAndReturn("GetModifications", mods, from, to);
			mockDateTimeProvider.Expect("Sleep", 30000);
			mockSourceControl.ExpectAndReturn("GetModifications", newMods, from, to.AddSeconds(30));
			mockDateTimeProvider.Expect("Sleep", 40000);
			mockSourceControl.ExpectAndReturn("GetModifications", newMods, from, to.AddSeconds(70));

			quietPeriod.ModificationDelaySeconds = 60;
			Modification[] actualMods = quietPeriod.GetModifications((ISourceControl) mockSourceControl.MockInstance, from, to);

			Assert.AreEqual(newMods, actualMods);
		}

		[Test]
		public void ShouldHandleIfNoModificationsAreReturned()
		{
			mockSourceControl.ExpectAndReturn("GetModifications", null, from, to);
			mockDateTimeProvider.ExpectNoCall("Sleep", typeof(int));

			quietPeriod.ModificationDelaySeconds = 60;
			Modification[] actualMods = quietPeriod.GetModifications((ISourceControl) mockSourceControl.MockInstance, from, to);

			Assert.AreEqual(new Modification[0], actualMods);
		}
	}
}