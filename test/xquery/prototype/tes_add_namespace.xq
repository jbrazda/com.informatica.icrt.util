(:
  Copyright (c) 2014 Informatica Corporation
  This code is free software: you can redistribute it and/or modify it

  Unless required by applicable law or agreed to in writing, software
  is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
  ANY KIND, either express or implied.
:)
xquery version "3.0";

import module namespace xmu = "http://informatica.com/modules/icrt/xml_utils/1.0/xquery" at "../../../xquery/xml_utils.xq";

declare option saxon:output "indent=yes";
declare option saxon:output "saxon:indent-spaces=4";
declare option saxon:output "omit-xml-declaration=yes";


let $xml := <RetryConfiguration xmlns:types="http://schemas.active-endpoints.com/wsdl/guideRuntime/2013/04/guideInterpreter.xsd"
                              xmlns:git="http://schemas.active-endpoints.com/wsdl/guideRuntime/2013/04/guideInterpreter.xsd"
                              xmlns:aetgt="http://schemas.active-endpoints.com/appmodules/screenflow/2010/10/avosScreenflow.xsd"
                              xmlns:ns2="http://schemas.active-endpoints.com/appmodules/screenflow/2010/10/avosScreenflow.xsd">
             <retryInterval>10</retryInterval>
             <retryCount>10</retryCount>
          </RetryConfiguration>
return
xmu:addNamespaceIfSimplifiedXML($xml)
    