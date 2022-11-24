export interface GeoLocation {
  lat: number;
  lng: number;
}

export interface Address {
  street: string;
  houseNumber: string;
  postalCode: string;
  city: string;
  geoLocation: GeoLocation;
}

export interface Atm {
  address: Address;
  distance: number;
  type: string;
}
