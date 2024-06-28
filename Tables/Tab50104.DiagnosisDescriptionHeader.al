table 50113 "Diagnosis Description Header"
{
    Caption = 'Diagnosis Description Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Patient No."; Code[20])
        {
            Caption = 'Patient No.';
            TableRelation = Patient;

            trigger OnValidate()
            begin
                PatientRec.Get("Patient No.");
                "First Name" := PatientRec."First Name";
                "Last Name" := PatientRec."Last Name";
                "Blood Group" := PatientRec."Blood Group";
                Genotype := PatientRec.Genotype;
            end;
        }
        field(3; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No Series';
            TableRelation = "No. Series";
        }

        field(4; "First Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'First Name';
        }

        field(5; "Last Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Name';
        }

        field(6; "Blood Group"; Enum "Blood Group")
        {
            DataClassification = ToBeClassified;
            Caption = 'Blood Group';
        }

        field(7; "Genotype"; Enum "Genotype")
        {
            DataClassification = ToBeClassified;
            Caption = 'Genotype';
        }
        field(8; "Ward No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Ward;

            /*             trigger OnValidate()
                        begin
                            if "Ward No." <> '' then begin
                                //WardRec.DeleteAll();
                                WardRec.Reset();
                                WardRec.SetRange("Ward No.", "Ward No.");
                                if WardRec.Get("Ward No.") then
                                    Error('The Ward with No. %1 is currently in use', "Ward No.");
                            end;
                        end; */
        }
        field(9; "Doctor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Staff."Staff No." where (Type = filter("Staff Type"::Doctor))); //for version 10 or higher
            TableRelation = Staff."Staff No." where(Type = CONST(Doctor));

            trigger OnValidate()

            begin
                StaffRec.Get("Doctor No.");
                "Doctor Name" := StaffRec."First Name" + ' ' + StaffRec."Last Name";
            end;
        }
        field(10; "Doctor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12; Status; Enum "Diagnosis Status")
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Total Charges"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Diagnosis Description Line".Charge where("Document No." = field(Code)));
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    var
        PatientRec: Record Patient;
        StaffRec: Record Staff;
        DiagnosisDescriptionLineRec: Record "Diagnosis Description Line";
        NoSeries: Codeunit NoSeriesManagement;

        WardRec: Record Ward;

    trigger OnInsert()

    begin
        if Code = '' then
            NoSeries.InitSeries('DD', xRec."No. Series", 0D, Code, "No. Series");
    end;

}
