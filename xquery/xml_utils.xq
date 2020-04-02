(:
  Copyright (c) 2014 Informatica Corporation
  This code is free software: you can redistribute it and/or modify it

  Unless required by applicable law or agreed to in writing, software
  is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
  ANY KIND, either express or implied.
:)
xquery version "3.0";
module namespace xmu = "http://informatica.com/modules/icrt/xml_utils/1.0/xquery";

(: Function removes unused namespaces from the xml node :)
declare function xmu:strip-ns($node as node()) as node() {
  if($node instance of element()) then (
    element { node-name($node) } {
      $node/@*,
      $node/node()/xmu:strip-ns(.)
    }
  ) else if($node instance of document-node()) then (
    document { xmu:strip-ns($node/node()) }
  ) else (
    $node
  )
};

(:~
 Function adds namespace when the root node does not have namespace declared
 while preserving Qnames of descendant elements
 This is necessary to save untyped xml in process server catalog
 Function also removes all unused namespace declarions
 Use with process objects xml
~:)
declare function xmu:addNamespaceIfSimplifiedXML ($node as node()?) as node()? {
    
    if (empty($node)) then ()
    else 
        let $xmlNSUri := namespace-uri-from-QName( node-name($node))
        (:strip unused namespaces such as aetgt,nsx,types:)       
        let $xmlRemovedNS := xmu:strip-ns($node) 
        (: add namespace just to root element of the document when namespace is not defined :)
        let $qname :=  if (string($xmlNSUri)="") then QName("urn:simple:xml", local-name($node)) 
                        else node-name($node)
         
        let $typedXML :=
          element {$qname} {
            $xmlRemovedNS/*
          }
    return
    $typedXML
};


(:~
 : Removes all attributes from the XML node recursively 
 :
 : @author  Jaroslav Brazda, Informatica 
 : @version 1.0 
 : @param   $node the XMLnode 
 :) 
declare function xmu:remove-attributes-deep ($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case comment() return $node
        case element() return 
            element{ node-name($node)} {for $child in $node/node() return xmu:remove-attributes-deep($child)}
        case attribute() return ()
        default return for $child in $node/node() return xmu:remove-attributes-deep($child)
};  

