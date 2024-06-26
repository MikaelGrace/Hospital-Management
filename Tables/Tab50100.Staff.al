table 50109 Staff
{
    Caption = 'Staff';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
        }
        field(2; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "First Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Last Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Type; Enum "Staff Type")
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Staff No.")
        {
            Clustered = true;
        }
    }
}
