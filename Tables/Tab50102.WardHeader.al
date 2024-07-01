table 50111 "Ward Header"
{
    Caption = 'Ward';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Ward No."; Code[20])
        {
            Caption = 'Ward No.';
        }
        field(2; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No Series';
            TableRelation = "No. Series";
        }

        field(3; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }

        field(4; "Category"; Enum "Ward Category")
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
        }
        field(5; "Bed Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. Of Beds"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Ward No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, Category)
        {
        }
    }

    var
        NoSeries: Codeunit NoSeriesManagement;

    trigger OnInsert()

    begin
        if "Ward No." = '' then
            NoSeries.InitSeries('WD', xRec."No Series", 0D, "Ward No.", "No Series");
        //Code := NoSeries.GetNextNo('SPT', 0D, false)
    end;

}
