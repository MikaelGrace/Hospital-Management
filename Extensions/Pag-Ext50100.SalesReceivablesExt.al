pageextension 50100 "Sales & Receivables Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("VAT Bus. Posting Gr. (Price)")
        {
            field("Service Account"; Rec."Service Account")
            {
                ApplicationArea = All;
                //FieldPropertyName = FieldPropertyValue;
            }
        }
    }
}
