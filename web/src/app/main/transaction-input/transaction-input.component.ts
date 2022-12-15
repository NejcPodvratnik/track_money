import { Component, OnInit } from '@angular/core';
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

  constructor() { }

  ngOnInit(): void {
  }

  onInFowClick() {
    this.selectedTrasactionType = TransactionType.INFLOW; 
  }

  onOutFowClick() {
    this.selectedTrasactionType = TransactionType.OUTFLOW;
  }

}
