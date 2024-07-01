table 50114 "Diagnosis Description Line"
{
    Caption = 'Diagnosis Description Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Enum "Diagnosis Type")
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Test No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Diagnosis Description".Code where(Type = field(Type));

            trigger OnValidate()

            begin
                if DiagnosisDescriptionRec.Get("Test No.") then
                    "Account No." := DiagnosisDescriptionRec."No.";
                Description := DiagnosisDescriptionRec.Description;
                Charge := DiagnosisDescriptionRec.Charges;
            end;
        }
        field(5; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Charge; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Test)) "G/L Account"
            else if (Type = const(Treatment)) "G/L Account"
            else if (Type = const(Drug)) Item;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var
        DiagnosisDescriptionRec: Record "Diagnosis Description";
}
