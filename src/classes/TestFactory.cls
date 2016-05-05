/**
* @author : aleibek
* @Date : 08/07/2015
 */ 
@isTest
public class TestFactory {
    
    //User    
    public static User newUser(String firstName, String lastName, String profileName) {
        Profile profile = [SELECT Id FROM Profile Where Name = :profileName];
        UserRole role = [Select u.Id From UserRole u where u.Name = 'France'];
        User user = new User(FirstName=firstName, LastName=lastName, UserRoleId = role.Id, userName = firstName + '.'+ lastName + String.valueOf(datetime.now().getTime())+ '@wonderbox.fr', 
                                profileId = profile.Id, Alias='test', Email='test.apex'+String.valueOf(datetime.now().getTime())+'@wonderbox.fr',  TimeZoneSidKey='Europe/Paris', LocaleSidKey='en_GB', 
                                EmailEncodingKey='ISO-8859-1', LanguageLocaleKey='en_US', UserPermissionsMobileUser=false, Country='France');
        return user;
    }
    
    public static User newUser(String firstName, String lastName) {
        return newUser(firstName, lastName, 'Standard User');
    }
    
    public static User newUser(String profileName) {
        return newUser('John' + String.valueOf(datetime.now().getTime()), 'Doe' + String.valueOf(datetime.now().getTime()), profileName);
    }
        
    public static User newUser() {
        return newUser('John' + String.valueOf(datetime.now().getTime()), 'Doe' + String.valueOf(datetime.now().getTime()));
    }

    public static User newSourceur() {
        return newUser('AAA Sourcing');
    }

    public static User newAdmin() {
        return newUser('System Administrator');
    }

    public static User newAdminLight() {
        return newUser('Admin Light');
    }
    
    public static Datetime getLocalDateTime(Datetime dt) {
        Datetime local = dt.Date();
        local = local.addHours(dt.hour());
        local = local.addMinutes(dt.minute());
        local = local.addSeconds(dt.second());
        
        return local;
    }

    //ALk - Create an account of type 'Partenaire'
    public static Account newPartenaire() {
        Id rtId = Utils.getAccountRecordTypeIdFromName(System.Label.Partenaire);
        Account a = new Account(Name='Account' + String.valueOf(datetime.now().getTime()), LegalName__c='Account' + String.valueOf(datetime.now().getTime()),CurrencyIsoCode='EUR', SourcingCountry__c = 'FR', 
                                    Type = 'Partenaire', Phone='0142424242', BookingPhone__c='0142424242', Email_confirme__c='contact'+String.valueOf(datetime.now().getTime())+'@wonderbox.fr', 
                                    BookingEmail__c='contact'+String.valueOf(datetime.now().getTime())+'@wonderbox.fr', RecordTypeId = rtId, PaymentMode__c='CHECK', SIRET__c='80284628700018',
                                    BillingStreet='9, rue de Paris', BillingPostalCode='75002', BillingState='Paris',BillingCountry='France', BillingCity='Paris', VAT__c='FR64802846287', RCS__c='802846287',
                                    ShippingStreet='9, rue de Paris', ShippingPostalCode='75002', ShippingState='Paris',ShippingCountry='France', ShippingCity='Paris', ERP_Company__c='FR',login__c='1');
        return a;
    }

    public static Account newAcheteur() {
        Id rtId = Utils.getAccountRecordTypeIdFromName(System.Label.ACHETEUR);
        return new Account(RecordTypeId=rtId, FirstName='Gareth', Lastname='Bale11' + String.valueOf(datetime.now().getTime()), Phone='0142424242', PersonBirthdate=Date.today(),
            PersonEmail='contact'+String.valueOf(datetime.now().getTime())+'@wonderbox.fr', PersonHomePhone='0142424242', PersonMobilePhone='0642424242', 
            BillingStreet='9, rue de Paris', BillingPostalCode='75002', BillingState='Paris',BillingCountry='France', BillingCity='Paris', Magento_ID__pc='16198317', 
            ShippingStreet='9, rue de Paris', ShippingPostalCode='75002', ShippingState='Paris',ShippingCountry='France', ShippingCity='Paris', Store_ID__c='1', Website_ID__c='1');
    }

    public static Account newProspect() {
        Id rtId = Utils.getAccountRecordTypeIdFromName(System.Label.PROSPECT);
        return new Account(RecordTypeId=rtId, FirstName='Gareth', Lastname='Bale11' + String.valueOf(datetime.now().getTime()));
    }

    public static Account newRPProspect() {
        Id rtId = Utils.getAccountRecordTypeIdFromName(System.Label.Partenaire);
        return new Account(RecordTypeId=rtId, Name = 'Hotel' + String.valueOf(datetime.now().getTime()), CurrencyIsoCode='EUR', Type='Prospect', SourcingCountry__c='FR');
    }

    public static Contact newContact() {
        Contact c = new Contact(FirstName='James' + String.valueOf(datetime.now().getTime()), Lastname='Mc Allen' + String.valueOf(datetime.now().getTime()), CurrencyIsoCode='EUR', 
                                    Email='jmcallen@me.fr' + String.valueOf(datetime.now().getTime()), InvoiceSendingMode__c='EMAIL', IsBillingContact__c=true);
        return c;
    }

    public static Contact newContactReservation() {
        Contact c = new Contact(FirstName='James' + String.valueOf(datetime.now().getTime()), Lastname='Mc Allen' + String.valueOf(datetime.now().getTime()), CurrencyIsoCode='EUR', 
                                    Email='jmcallen@me.fr' + String.valueOf(datetime.now().getTime()), InvoiceSendingMode__c='EMAIL', isContactReservation__c=true);
        return c;
    }

    public static Contact newContactFacturation() {
        Contact c = new Contact(FirstName='James' + String.valueOf(datetime.now().getTime()), Lastname='Mc Allen' + String.valueOf(datetime.now().getTime()), CurrencyIsoCode='EUR', 
                                    Email='jmcallen@me.fr' + String.valueOf(datetime.now().getTime()), InvoiceSendingMode__c='EMAIL', IsBillingContact__c=true);
        return c;
    }

    public static Contact newContactLegal() {
        Contact c = new Contact(FirstName='James' + String.valueOf(datetime.now().getTime()), Lastname='Mc Allen' + String.valueOf(datetime.now().getTime()), CurrencyIsoCode='EUR', 
                                    Email='jmcallen@me.fr' + String.valueOf(datetime.now().getTime()), InvoiceSendingMode__c='EMAIL', IsBillingContact__c=true, IsLegalContact__c=true);
        return c;
    }

    public static Contact newContactPrincipal() {
        Contact c = new Contact(FirstName='James' + String.valueOf(datetime.now().getTime()), Lastname='Mc Allen' + String.valueOf(datetime.now().getTime()), CurrencyIsoCode='EUR', 
                                    Email='jmcallen@me.fr' + String.valueOf(datetime.now().getTime()), InvoiceSendingMode__c='EMAIL', IsBillingContact__c=true, IsMainContact__c=true);
        return c;
    }

    public static Contact newContactMandatory() {
        Contact c = new Contact(FirstName='James' + String.valueOf(datetime.now().getTime()), Lastname='Mc Allen' + String.valueOf(datetime.now().getTime()), CurrencyIsoCode='EUR', 
                                    Email='jmcallen@me.fr' + String.valueOf(datetime.now().getTime()), InvoiceSendingMode__c='EMAIL', IsBillingContact__c=true, IsMainContact__c=true,
                                    IsLegalContact__c=true, isContactReservation__c=true);
        return c;
    }

    public static Case newCase(Id recordTypeId) {
        return new Case(RecordTypeId=recordTypeId, status='En cours', Origin='Téléphone', Type='Paiement', Reason='Autres', Priority='Moyen');
    }

    public static Case newCaseSAV() {
        Id rtId = Utils.getCaseRecordTypeIdFromName(System.Label.SAV);
        return newCase(rtId);
    }

    public static Case newCaseReclamation() {
        Id rtId       = Utils.getCaseRecordTypeIdFromName(System.Label.RECLAMATION_NAME);
        Case c        = newCase(rtId);
        c.RCMotif__c  = 'Prestation décevante';
        c.RCRaison__c = 'Prestation non conforme';
        c.isReclamation__c = true;
        return c;
    }

    public static Case newCaseEchange() {
        Id rtId       = Utils.getCaseRecordTypeIdFromName(System.Label.NAME_ECHANGE_PROLONGATION);
        Case c        = newCase(rtId);
        c.RCMotif__c  = 'Suivi de prolongation';
        c.RCRaison__c = 'Autres';
        return c;
    }

    public static Case newCaseEnregistrement() {
        Id rtId       = Utils.getCaseRecordTypeIdFromName(System.Label.ENREGISTREMENT_ACTIVATION);
        Case c        = newCase(rtId);
        c.RCMotif__c  = 'Réclamation';
        c.RCRaison__c = 'Autres';
        return c;
    }

    public static Case newCaseVente() {
        Id rtId       = Utils.getCaseRecordTypeIdFromName(System.Label.VENTE);
        return newCase(rtId);
    }

    public static EmailMessage newReceivedMessage(Id caseId) {
        return new EmailMessage(Status='0', ParentId=caseId, ToAddress='contact'+String.valueOf(datetime.now().getTime())+'@wonderbox.fr', FromName='abdelaziz leibek', FromAddress='abdelaziz.leibek@wonderbox.fr', 
                          subject='my subject', TextBody='ghljref:_00Dg06SdfM._500g0CmWH1:ref');
    }

    public static EmailMessage newSendMessage(Id caseId) {
        return new EmailMessage(Status='3', ParentId=caseId, ToAddress='contact'+String.valueOf(datetime.now().getTime())+'@wonderbox.fr', FromName='abdelaziz leibek', FromAddress='abdelaziz.leibek@wonderbox.fr', 
                          subject='my subject', TextBody='ghljref:_00Dg06SdfM._500g0CmWH1:ref');
    }

    public static DCS__c newDCS() {
        return new DCS__c(Name='7548321222', CurrencyIsoCode='EUR');
    }

    public static Case newRemboursementNonRecu() {
        Id rtId       = Utils.getCaseRecordTypeIdFromName(System.Label.NAME_RETRACTATION);
        return new Case(RecordTypeId=rtId, RCMotif__c=System.Label.REFUND_UNSUCCESSFUL, Status=System.Label.PENDING, RCRaison__c='Autres', Origin='Téléphone', Priority='Moyen');
    }

    public static Case newCaseRetractation() {
        Id rtId       = Utils.getCaseRecordTypeIdFromName(System.Label.NAME_RETRACTATION);
        return new Case(RecordTypeId=rtId, RCMotif__c=System.Label.INFORMATION_RETRACTATION, Status=System.Label.PENDING, RCRaison__c='Autres', Origin='Téléphone', Priority='Moyen');
    }

    public static Case newDemandeRetractation() {
        Id rtId       = Utils.getCaseRecordTypeIdFromName(System.Label.NAME_RETRACTATION);
        return new Case(RecordTypeId=rtId, RCMotif__c=System.Label.DEMANDE_RETRACTATION_REMBOURSEMENT, Status=System.Label.NEW, RefundMean__c=System.Label.TRANSFER, 
                        RCRaison__c='Autres', Origin='Téléphone', Priority='Moyen');
    }

    public static Case newRetourLogicticien() {
        Case c                = newCaseSAV();
        c.RCMotif__c          = System.Label.RETURN_LOGISTICIAN;
        c.Status              = System.Label.CLOSED_NOT_RESOLVED;
        c.RCRaison_Cloture__c = System.Label.UNTREATED_BY_RC;
        c.RCRaison__c         = System.Label.TO_QUALIFY;
        return c;
    }

    public Static Attachment newAttachment() {
        return new Attachment(Name = 'file' + String.valueOf(datetime.now().getTime()), Body = Blob.valueOf('Unit Test Attachment Body'));
    }
    
    public static Commande__c newCommande() {
        return new Commande__c(Name='commande' + String.valueOf(datetime.now().getTime()), CurrencyIsoCode='EUR');
    }

    public static Product2 newProduct() {
        return new Product2(name='Product'+String.valueOf(datetime.now().getTime()), ProductCode='PR001', Univers__c='Multi', Business_Unit__c='FR', CurrencyIsoCode='EUR', isActive = true);
    }

    public static Location__c newZone() {
        return new Location__c(Name='Location'+String.valueOf(datetime.now().getTime()), Country__c='France', ISO_Country__c='FR', Valid__c=true);
    }

    public static Target__c newTarget(Product2 p, Location__c l) {
        return new Target__c(Name='Target'+String.valueOf(datetime.now().getTime()), Area__c=l.Id, Box__c=p.Id);
    }

    public static PricebookEntry newPriceBook(Product2 p) {
        //List<Pricebook2> stdPb = [Select Id from Pricebook2 where isStandard = true Limit 1];
        Id pricebookId = Test.getStandardPricebookId();
        return new PricebookEntry(pricebook2id = pricebookId, product2id = p.id, unitprice=1.0, isActive=true);
    }

    public static Opportunity newOpportunity(Account a) {
        return new Opportunity(Name = 'Opportunity' + String.valueOf(datetime.now().getTime()), AccountId = a.Id, LeadSource = 'Prospection brute', SellingCountry__c = 'France', CloseDate = Date.today().addDays(5), StageName = 'Validé Marketing');
    }
    
   
}