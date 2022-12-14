import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from './shared-services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class LoginGuard implements CanActivate {

  constructor(private auth: AuthService, private router: Router) {
  }

  async canActivate (
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Promise<boolean> {
    
    const isAuth = await this.auth.isValid(); 

    if(!isAuth) {
      console.log("User not authenitcated"); 
      this.router.navigate(['auth']); 
    }

    return isAuth;
  }
  
}
