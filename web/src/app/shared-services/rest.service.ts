import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import { Method } from '../shared-enums/method';

@Injectable({
  providedIn: 'root'
})
export class RestService {

  private API_URL: string = 'http://localhost:8000/api';
    private defaultHeaders: HttpHeaders = new HttpHeaders({
        'content-type': 'application/json; charset=utf-8'
    });

  constructor(private http: HttpClient) { }

  public getHeaders(): HttpHeaders {
    return this.defaultHeaders;
  }

  public getAuthHeader(): HttpHeaders {
    const token = sessionStorage.getItem('authToken');
    return this.defaultHeaders.set('authorization', 'Bearer ' + token);
  }

  private makeHttpRequest(method: Method, path: string, headers: HttpHeaders, body: any = null): Promise<any> {
    if (method === Method.GET) {
        return this.http.get(`${this.API_URL}${path}`, {headers}).toPromise();
    } else if (method === Method.POST) {
        return this.http.post(`${this.API_URL}${path}`, body, {headers}).toPromise();
    } else if (method === Method.DELETE) {
        return this.http.delete(`${this.API_URL}${path}`, {headers}).toPromise();
    } else if (method === Method.PATCH) {
        return this.http.patch(`${this.API_URL}${path}`, body, {headers}).toPromise();
    } else if (method === Method.PUT) {
        return this.http.put(`${this.API_URL}${path}`, body, {headers}).toPromise();
    }
    return Promise.resolve();
  }

  login(username: string, password: string) {
    return this.makeHttpRequest(Method.POST, '/authenticate', this.getHeaders(), {email: username, password});
  }

  // TODO: add all endpoints here
}
