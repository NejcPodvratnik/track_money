import { Component, OnInit } from '@angular/core';
import {Router} from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html'
})
export class LoginComponent implements OnInit {

  constructor(private router: Router,) { }

  ngOnInit(): void {
  }

  login() {
    console.log("Uporabnik se je prijavil"); 

    // TODO: check if valid credentials

    // const res = await this.restService.login(this.name, this.password);
    // this.auth.setToken(res.authToken);
    this.router.navigate(['main']);

  }

}
