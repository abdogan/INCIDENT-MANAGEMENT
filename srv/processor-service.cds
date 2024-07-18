using { sap.capire.incidents as my } from '../db/schema';

type tyTitle : String;

service ProcessorService {

    entity Incidents as projection on my.Incidents actions{
        @( cds.odata.bindingparameter.name : '_it',
        Common.SideEffects : {TargetProperties : ['_it/title']} ) 
        action setTitle(title: tyTitle @mandatory @title : 'New Title' );
    };

    @readonly
    entity Customers as projection on my.Customers;

}

extend projection ProcessorService.Customers with {
    firstName || ' ' || lastName as name: String
};

annotate ProcessorService.Incidents with @odata.draft.enabled;

annotate ProcessorService with @(requires: ['support']);