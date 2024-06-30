table 50112 "Diagnosis Description"
{
    Caption = 'Diagnosis Description';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Type"; Enum "Diagnosis Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }

        field(3; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
