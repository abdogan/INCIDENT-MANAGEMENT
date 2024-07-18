using ProcessorService as service from '../../srv/processor-service';
using from '../../db/schema';
annotate service.Incidents with @(
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    ID : 'i18nGeneralInformation',
                    Label : '{i18n>GeneralInformation}',
                    Target : '@UI.FieldGroup#i18nGeneralInformation',
                },],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Conversation}',
            ID : 'i18nConversation',
            Target : 'conversation/@UI.LineItem#i18nConversation1',
        },
    ],

    Capabilities.SearchRestrictions: {
        Searchable: false,
    },

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Customerid}',
            Value : customer_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Urgencycode1}',
            Value : urgency_code,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Statuscode1}',
            Value : status_code,
            Criticality : status.criticality,
        },
    ],
);

annotate service.Incidents with {
    customer @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Customers',
        Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
    }
};

annotate service.Incidents with @(
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ]
);
annotate service.Incidents with {
    status @Common.Label : '{i18n>Statuscode}'
};
annotate service.Incidents with {
    urgency @Common.Label : '{i18n>Urgencycode}'
};
annotate service.Incidents with {
    urgency @Common.ValueListWithFixedValues : true
};
annotate service.Urgency with {
    code @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextLast,
    }
};
annotate service.Incidents with {
    status @Common.ValueListWithFixedValues : true
};
annotate service.Status with {
    code @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextLast,
    }
};
annotate service.Incidents with {
    status @Common.Text : {
            $value : status.descr,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Incidents with @(
    UI.HeaderInfo : {
        TypeName : 'Incident',
        TypeNamePlural : 'Incidents',
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : customer.name,
        },
        TypeImageUrl : 'sap-icon://alert',
    }
);
annotate service.Incidents with @(
    UI.FieldGroup #i18nDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [],
    },
    UI.FieldGroup #i18nGeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
                Label : '{i18n>Title}',
            },
            {
                $Type : 'UI.DataField',
                Value : customer_ID,
                Label : 'Customer',
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
            },],
    },
);
annotate service.Incidents with {
    urgency @Common.Text : {
            $value : urgency.descr,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Incidents with {
    customer @Common.Text : {
            $value : customer.name,
            ![@UI.TextArrangement] : #TextFirst,
        }
};
annotate service.Incidents with {
    customer @Common.ValueListWithFixedValues : true
};
annotate service.Incidents.conversation with @(
    UI.LineItem #i18nConversation : [
        {
            $Type : 'UI.DataField',
            Value : author,
        },{
            $Type : 'UI.DataField',
            Value : message,
            Label : 'message',
        },{
            $Type : 'UI.DataField',
            Value : timestamp,
        },]
);
annotate service.Incidents.conversation with @(
    UI.LineItem #i18nConversation1 : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : '{i18n>Author}',
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : '{i18n>Message}',
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
        },]
);
annotate service.Incidents with @(
    UI.FieldGroup #test : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    }
);
annotate service.Incidents with {
    title @Common.FieldControl : #Mandatory
};
annotate service.Incidents with {
    customer @Common.FieldControl : #Mandatory
};
annotate service.Incidents with @(
    UI.SelectionPresentationVariant #table : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    }
);
annotate service.Incidents with @(
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ProcessorService.setTitle',
            Label : '{i18n>Settitle}',
        },
    ]
);

