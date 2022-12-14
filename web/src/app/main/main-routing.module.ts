import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { MainComponent } from './main.component';
import { StatisticsComponent } from './statistics/statistics.component';
import { TransactionInputComponent } from './transaction-input/transaction-input.component';

const routes: Routes = [
  {
    path: '', component: MainComponent, children: [
      {path: '', redirectTo: 'home'},
      {path: 'home', component: HomeComponent}, 
      {path: 'transaction-input', component: TransactionInputComponent}, 
      {path: 'statistics', component: StatisticsComponent}, 
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MainRoutingModule { }
