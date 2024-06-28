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
    fieldgroups
    {
        fieldgroup(DropDown; "Staff No.", "First Name", "Last Name", Type)
        {
        }
    }
    var
        NoSeries: Codeunit NoSeriesManagement;

    trigger OnInsert()

    begin
        if "Staff No." = '' then
            NoSeries.InitSeries('STAFF', xRec."No. Series", 0D, "Staff No.", "No. Series");
        //Code := NoSeries.GetNextNo('SPT', 0D, false)
    end;
}
