table 50110 Patient
{
    Caption = 'Patient';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Patient No."; Code[20])
        {
            Caption = 'Patient No.';
        }
        field(2; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No Series';
            TableRelation = "No. Series";
        }

        field(3; "First Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'First Name';
        }

        field(4; "Last Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Name';
        }

        field(5; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of Birth';
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

        field(8; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Address';
        }

        field(9; "Phone Number"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Phone Number';
        }

        field(10; "Next of Kin Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Next of Kin Name';
        }

        field(11; "Next of Kin Contact No"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Next of Kin Contact No';
        }
        field(12; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(13; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(14; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            /*             trigger OnValidate()
                        begin
                            UpdateTaxAreaId;
                        end; */
        }
        field(15; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";

            /* trigger OnValidate()
            begin
                UpdatePaymentTermsId;
            end; */
        }
        field(16; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = field("Patient No.")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(PK; "Patient No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Patient No.", "First Name", "Last Name", "Blood Group")
        {
        }
    }
    var
        NoSeries: Codeunit NoSeriesManagement;
        GenBusPostingGrp: Record "Gen. Business Posting Group";

    trigger OnInsert()

    begin
        if "Patient No." = '' then
            NoSeries.InitSeries('PAT', xRec."No Series", 0D, "Patient No.", "No Series");
    end;
}
