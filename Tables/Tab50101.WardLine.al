table 50115 "Ward Line"
{
    Caption = 'Ward Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Patient No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Patient;

            trigger OnValidate()
            begin
                "Patient Name" := PatientRec."First Name" + ' ' + PatientRec."Last Name";
            end;
        }
        field(4; "Patient Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                DaysDiff: Integer;
            begin
                DaysDiff := "End Date" - "Start Date";
                if DaysDiff >= 0 then
                    "No. of Days" := DaysDiff + 1
                else
                    Error('End date must be after start date');
            end;
        }
        field(7; "Diagnosis No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Enum "Ward Status")
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Unit Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Total Bed Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Description; Text[100])
        {
            DataClassification = ToBeClassified;
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
        PatientRec: Record Patient;

    trigger OnInsert()
    begin
        if "Start Date" = 0D then
            "Start Date" := Today;
    end;
}
