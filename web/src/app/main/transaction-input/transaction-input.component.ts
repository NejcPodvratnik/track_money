import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { Category } from 'src/app/shared-enums/category';
import { PaymentType } from 'src/app/shared-enums/payment_type';
import { TransactionType } from 'src/app/shared-enums/transaction-type';

@Component({
  selector: 'app-transaction-input',
  templateUrl: './transaction-input.component.html',
  styleUrls: ['./transaction-input.component.scss']
})
export class TransactionInputComponent implements OnInit {

  transactionValue: number | null = null; 
  description: string | null = null;
  selectedTrasactionType: TransactionType = TransactionType.OUTFLOW; 

  TransactionType = TransactionType;  
  PaymentsType = PaymentType; 
  selectedPaymentType: PaymentType = PaymentType.CARD; 

  Category = Category; 
  selectedCategory: Category = Category.GROCERY; 


  @ViewChild('paymentTypeDropdown') paymentTypeDropdown!: ElementRef;
  @ViewChild('categoryDropdown') categoryDropdown!: ElementRef;
  
  constructor() { }

  ngOnInit(): void {
  }

  onInFowClick() {
    this.selectedTrasactionType = TransactionType.INFLOW; 
  }

  onOutFowClick() {
    this.selectedTrasactionType = TransactionType.OUTFLOW;
  }

  onSelectedPaymentType(): void {
    this.selectedPaymentType = this.paymentTypeDropdown.nativeElement.value;
  }

  onSelectedCategory(): void {
    this.selectedCategory = this.categoryDropdown.nativeElement.value; 
  }
}
