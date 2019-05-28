import { LightningElement, wire, api, track } from 'lwc';
import getFields from '@salesforce/apex/compareRecordController.getFieldsMethod';
import getRecords from '@salesforce/apex/compareRecordController.getRecordMethod';

export default class CompareRecordWizard extends LightningElement {
    @api titleObject;
    @api numOfRecords;
    @api objType;
    @api iconName;
    @api nameField;
    @api fieldSet;
    @track fieldNames;
    @track records;
    @track error;
    @wire(getFields,{objType: '$objType',fieldSet: '$fieldSet'})
    fieldNameExtract ({ error, data }) {
        if (data) {
            this.fieldNames = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.fieldNames = undefined;
        }
    }
    @wire(getRecords,{objType: '$objType', nameField: '$nameField'}) 
    recordExtract ({ error, data }) {
        if (data) {
            this.records = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.records = undefined;
        }
    }

}

