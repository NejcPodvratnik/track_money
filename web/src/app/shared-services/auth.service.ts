import { Injectable } from '@angular/core';
import { RestService } from './rest.service';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  isLoggedIn = false;
  private token: string | null = '';
  userProfile: any;

  constructor(private restService: RestService) {
    this.token = sessionStorage.getItem('authToken') || '';
  }

  async isValid(): Promise<boolean> {
    if (this.token) {
      return true;
    }

    if (!this.token) {
        return false;
    }

    // TODO: check if token valid!

    return false;
  }

  getToken(): string {
    if(!this.token){
      return ''; 
    }
    return this.token;
  }

  setToken(token: string): void {

    console.log("Setting token")
    this.token = token;
    sessionStorage.setItem('authToken', this.token);
  }

  logout(): void {
    this.token = null; 
  }
}
