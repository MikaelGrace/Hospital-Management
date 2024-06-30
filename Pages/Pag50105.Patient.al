page 50118 Patient
{
    Caption = 'Patient';
    PageType = Card;
    SourceTable = Patient;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Birth field.', Comment = '%';
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blood Group field.', Comment = '%';
                }
                field(Genotype; Rec.Genotype)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Genotype field.', Comment = '%';
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Address field.', Comment = '%';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    //FieldPropertyName = FieldPropertyValue;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    /*                     trigger OnDrillDown()
                                        begin
                                            OpenCustomerLedgerEntries(false);
                                        end; */

                }
                group("Next of Kin")
                {
                    field("Next of Kin Name"; Rec."Next of Kin Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Next of Kin Name field.', Comment = '%';
                    }
                    field("Next of Kin Contact No"; Rec."Next of Kin Contact No")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Next of Kin Contact No field.', Comment = '%';
                    }
                }
                group(Invoicing)
                {
                    field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                    {
                        ApplicationArea = All;
                        //FieldPropertyName = FieldPropertyValue;
                    }
                    field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                    {
                        ApplicationArea = All;
                        //FieldPropertyName = FieldPropertyValue;
                    }
                    field("Customer Posting Group"; Rec."Customer Posting Group")
                    {
                        ApplicationArea = All;
                        //FieldPropertyName = FieldPropertyValue;
                    }
                }
                group(Payment)
                {
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        ApplicationArea = All;
                        //FieldPropertyName = FieldPropertyValue;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Customer")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to create as a customer', false) then begin
                        CustomerRec.Init();
                        CustomerRec."No." := Rec."Patient No.";
                        CustomerRec.Name := Rec."First Name" + ' ' + Rec."Last Name";
                        CustomerRec."E-Mail" := Rec."Email Address";
                        CustomerRec."Phone No." := Rec."Phone Number";
                        CustomerRec."Gen. Bus. Posting Group" := Rec."Gen. Bus. Posting Group";
                        CustomerRec."VAT Bus. Posting Group" := Rec."VAT Bus. Posting Group";
                        CustomerRec."Customer Posting Group" := Rec."Customer Posting Group";
                        CustomerRec."Payment Terms Code" := Rec."Payment Terms Code";
                        CustomerRec.Insert();
                        Rec."Customer No." := Rec."Patient No.";
                        Message('Patient %1 created as customer with no. %2', Rec."Patient No.", Rec."Patient No.");

                    end;
                    Page.Run(Page::"Customer List");
                end;
            }
        }
    }

    var
        CustomerRec: Record Customer;
        CustomerListPage: Page "Customer List";
}
