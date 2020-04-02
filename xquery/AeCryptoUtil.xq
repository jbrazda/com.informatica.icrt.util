(:
  Copyright (c) 2014 Informatica Corporation
  This code is free software: you can redistribute it and/or modify it

  Unless required by applicable law or agreed to in writing, software
  is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
  ANY KIND, either express or implied.
:)
xquery version "3.0";
module namespace aecu = 'http://activevos.com/modules/Aeaecu/1.0/xquery';
declare namespace crypto = 'java:org.activebpel.rt.bpel.server.AeCryptoUtil';

(:
NOTE: THESE FUNCTIONS WILL NOT WORK IN THE XQUERY RUNTIME IN DESIGNER
these functions use class available only within server runtime
The actual encription key is stored in the SharedSecret configuration entry inside
active-bpel.war/WEB-INF/classes/aeEngineConfig.xml
@see
<entry name="SharedSecret" value="encryptionKEy"/>
:)

(:~ 
    Encrypts string using shared secret stored in  aeEngineConfig.xml
    this shared secret is used to encode / decode password in pdd endpoint references or engine configurations or aeSystemConfig table
:)
declare function aecu:encryptString ($string as xs:string?) as xs:string? {
    string(crypto:encryptString($string))
};



(:~ Decrypts string using shared secret stored in  aeEngineConfig.xml
    this shared secret is used to encode / decode password in pdd endpoint references or engine configurations or aeSystemConfig table
:)
declare function aecu:decryptString ($string as xs:string?) as xs:string? {
    string(crypto:decryptString($string))
};
