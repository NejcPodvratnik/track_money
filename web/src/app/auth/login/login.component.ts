import { Component, OnInit } from '@angular/core';
import {Router} from '@angular/router';
import { AuthService } from 'src/app/shared-services/auth.service';
import { RestService } from 'src/app/shared-services/rest.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html'
})
export class LoginComponent implements OnInit {

  name: string = ''; 
  password: string = '';

  constructor(
    private router: Router, 
    private restService: RestService, 
    private auth: AuthService
    ) { }

  ngOnInit(): void {
  }

  async login(): Promise<void> {
    console.log("Uporabnik se je prijavil"); 

    if (!this.name || !this.password) {
      console.log('Input not OK');
      return;
    }

    try {
      const res = await this.restService.login(this.name, this.password); 
      this.auth.setToken(res.token);
      console.log(res);
    } catch (e: any) {
      console.log('Something went wrong, try again later', e.message);
    }

    console.log("Navigate")
    this.router.navigate(['main']);
  }
}
