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
    }
    keys
    {
        key(PK; "Patient No.")
        {
            Clustered = true;
        }
    }
}
