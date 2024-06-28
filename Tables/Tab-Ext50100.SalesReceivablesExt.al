tableextension 50100 "Sales & Receivables Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Service Account"; Code[20])
        {
            Caption = 'Service Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
}
