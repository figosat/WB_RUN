/**
	* @author ALK
	* @desc Case Traitments
	* @date 09/03/2016
 */

@isTest
private class CaseAP01Test {
	
	@isTest static void test_method_isDcsEmpty_insert() {
		User u = TestFactory.newAdminLight();
		insert u;

		System.runAs(u) {
			Account a = TestFactory.newProspect();
			insert a;

			Case c = TestFactory.newCaseEchange();
			c.AccountId = a.Id;
			c.ContactId = a.PersonContactId;

			Test.startTest();
			try {
				insert c;
			} catch(DmlException e) {
				Boolean expectedExceptionThrown =  e.getMessage().contains(System.Label.MSG_DCS_REQUIRED) ? true : false;
				System.AssertEquals(expectedExceptionThrown, true);
			}
			Test.stopTest();
		}
	}

	@isTest static void test_method_isDcsEmpty_update() {
		User u = TestFactory.newAdminLight();
		insert u;

		System.runAs(u) {
			Account a = TestFactory.newProspect();
			insert a;

			Case c = TestFactory.newCaseEchange();
			c.AccountId = a.Id;
			c.ContactId = a.PersonContactId;
			c.RCMotif__c = 'Demande de prolongation';
			insert c;

			Test.startTest();
			try {
				c.RCMotif__c  = 'Suivi de prolongation';
				update c;
			} catch(DmlException e) {
				Boolean expectedExceptionThrown =  e.getMessage().contains(System.Label.MSG_DCS_REQUIRED) ? true : false;
				System.AssertEquals(expectedExceptionThrown, true);
			}
			Test.stopTest();
		}
	}

	/*@isTest static void test_method_setClosedById() {
		User u = TestFactory.newAdminLight();
		insert u;

		System.runAs(u) {
			Account a = TestFactory.newProspect();
			insert a;

			Case c = TestFactory.newCaseEchange();
			c.AccountId = a.Id;
			c.ContactId = a.PersonContactId;
			c.RCMotif__c = 'Demande de prolongation';
			insert c;

			Test.startTest();
			
			c.Status = 'Clôturé';
		    update c;

		    Case c1 = [SELECT ClosedById__c FROM Case WHERE Id = :c.Id];
			System.AssertEquals(c1.ClosedById__c, u.Id);
			Test.stopTest();
		}
	}*/

	/*@isTest static void test_method_createRCTasks() {
		User u = TestFactory.newAdminLight();
		insert u;

		System.runAs(u) {
			Account a                           = TestFactory.newAcheteur();
			Account p                           = TestFactory.newPartenaire();
			List<Account> accounts              = new List<Account>{a,p};
			p.NB_CONTACT_BILLING_DEFINED__c     = 1;
			p.NB_CONTACT_LEGAL_DEFINED__c       = 1;
			p.NB_CONTACT_MAIN_DEFINED__c        = 1;
			p.NB_CONTACT_RESERVATION_DEFINED__c = 1;
			p.ALLOW_PARTNER__c                  = true;
			insert accounts;

			Contact ctact = TestFactory.newContact();
			ctact.AccountId = p.Id;
			insert ctact;

			Case c = TestFactory.newCaseReclamation();
			c.AccountId = a.Id;
			insert c;

			c.partnerCase__c = true;
			c.Partenaire_Reclamation__c = a.Id;
			update c;

			Case caseRC = [Select PartnerCaseID__c from Case where Id = :c.Id];

			Test.startTest();
			Case caseRP = [Select Id, Status from Case where Id = :caseRC.PartnerCaseID__c];
			caseRP.Status              = System.Label.RECLAMATION_RP_LIST_STATUS.split(';')[1];
			caseRP.BeneficiaryName__c  = a.FirstName + ' ' + a.LastName;
			caseRP.BeneficiaryEmail__c = a.PersonEmail;
			caseRP.PrestationDate__c   = Date.today();
			caseRP.Description = 'Et quoniam apud eos ut in capite mundi morborum acerbitates celsius dominantur, ad quos vel sedandos omnis professio medendi torpescit, excogitatum est adminiculum sospitale nequi amicum perferentem similia videat, additumque est cautionibus paucis remedium aliud satis validum, ut famulos percontatum missos quem ad modum valeant noti hac aegritudine colligati, non ante recipiant domum quam lavacro purgaverint corpus. ita etiam alienis oculis visa metuitur labes.';
			update caseRP;

			c.Status         = 'Clôturée résolue';
			c.PartnerCase__c = false;
			update c;
			Test.stopTest();

			List<Task> tasks = [Select Id, Status from Task where WhatId = :c.Id];

			System.assert(!tasks.isEmpty() && tasks[0].Status == System.Label.FINISHED, 'No task created/updated');
		}
	}*/

	@isTest static void test_closeRCTasks() {
		User u = TestFactory.newAdminLight();
		insert u;

		System.runAs(u) {
			Account a = TestFactory.newAcheteur();
			insert a;

			Case c = TestFactory.newCaseReclamation();
			c.AccountId = a.Id;
			insert c;

			Task t           = new task();
			t.WhoId          = c.ContactId;
			t.WhatId         = c.Id;
			t.Subject        = String.format(System.Label.CASE_RP_FIXED, new String[]{c.CaseNumber});
			t.ActivityDate   = Date.today();
			t.IsReminderSet  = false;
			insert t;

			Test.startTest();
			CaseAP01.closeRCTasks(new List<Case>{c});
			Test.stopTest();

			Task updatedTask = [Select Status from Task where Id = :t.Id];

			System.assert(updatedTask.Status == System.Label.FINISHED, 'No task updated');

		}
	}
	
}