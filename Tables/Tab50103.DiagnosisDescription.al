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
        field(4; Charges; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Test)) "G/L Account"
            else if (Type = const(Treatment)) "G/L Account"
            else if (Type = const(Drug)) Item;

        }

    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Type, Description)
        {

        }
    }

}
