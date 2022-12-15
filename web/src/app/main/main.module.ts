import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MainRoutingModule } from './main-routing.module';
import { MainComponent } from './main.component';
import { SidebarComponent } from './sidebar/sidebar.component';
import { StatisticsComponent } from './statistics/statistics.component';
import { HomeComponent } from './home/home.component';
import { TransactionInputComponent } from './transaction-input/transaction-input.component';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    MainComponent,
    SidebarComponent,
    StatisticsComponent,
    HomeComponent,
    TransactionInputComponent
  ],
  imports: [
    CommonModule,
    MainRoutingModule, 
    FormsModule
  ]
})
export class MainModule { }
