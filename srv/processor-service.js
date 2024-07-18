const cds = require('@sap/cds');
const { Incidents } = cds.entities("sap.capire.incidents");

class ProcessorService extends cds.ApplicationService {
 
    /** Registering custom event handlers */
    init() {
        this.before('UPDATE', 'Incidents', (req) => this.onUpdate(req));
        this.before('CREATE', 'Incidents', (req) => this.changeUrgencyDueToSubject(req.data));
        this.on( 'setTitle', (req) => this.actionSetTitle(req));

        return super.init();
    }

    changeUrgencyDueToSubject(data) {
        if (data) {
            const incidetns = Array.isArray(data) ? data : [data];
            incidetns.forEach((incident) => {
                if(incident.title?.toLowerCase().includes("urgent")) {
                    incident.urgency = { code: "H", descr: "High"};
                }       
            });
        }
    }

    /** Custom Validation */
    async onUpdate (req) {
        const {status_code} = await SELECT.one(req.subject, i => i.status_code).where({ ID: req.data.ID})
        if (status_code === 'C')
            return req.reject("Can't modify a closed incident")
    }

    async actionSetTitle(req) {
        let sTitle = req.data.title;
        let ID = req.params[0].ID; 
        let oSucceeded = await UPDATE (Incidents) .set({title: sTitle}) .where({ID: ID} );
    }

}

module.exports = {ProcessorService}