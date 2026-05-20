___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "OpenAI Parameter Generator",
  "description": "Generates OpenAI parameters from dataLayer or custom array objects.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "supported_parameters",
    "displayName": "Supported Parameters",
    "radioItems": [
      {
        "value": "contents",
        "displayValue": "contents [ {} ]"
      },
      {
        "value": "currency",
        "displayValue": "currency",
        "help": "Only Returns the GA4 \u0027ecommerce.currency\u0027 value."
      },
      {
        "value": "amount",
        "displayValue": "amount",
        "help": "Only Returns the GA4 \u0027ecommerce.value\u0027 event amount."
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "object_properties",
    "displayName": "Contents Configuration",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "array_of_objects",
        "displayName": "Array of Objects",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "ga4_datalayer",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ],
        "help": "Provide the array of item objects for custom mapping."
      },
      {
        "type": "CHECKBOX",
        "name": "ga4_datalayer",
        "checkboxText": "Use GA4 Ecommerce DataLayer",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "content_type",
        "displayName": "Content Type",
        "simpleValueType": true,
        "defaultValue": "product",
        "enablingConditions": []
      },
      {
        "type": "TEXT",
        "name": "item_id",
        "displayName": "Item ID Key",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "ga4_datalayer",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "item_name",
        "displayName": "Item Name Key",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "ga4_datalayer",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "quantity",
        "displayName": "Quantity Key",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "ga4_datalayer",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "price",
        "displayName": "Price Key",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "ga4_datalayer",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "supported_parameters",
        "paramValue": "contents",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromDataLayer = require('copyFromDataLayer');

const useGA4 = data.ga4_datalayer === true;

const ecommerce = copyFromDataLayer('ecommerce') || {};

const items = useGA4 ?
	(ecommerce.items || []) :
	(data.array_of_objects || []);

const currency = ecommerce.currency || '';
const value = ecommerce.value || 0;

const contents = items.map(function(item) {

	return {

		id: useGA4 ?
			(item.item_id !== undefined ?
				item.item_id + '' :
				undefined) :
			(data.item_id && item[data.item_id] !== undefined ?
				item[data.item_id] + '' :
				undefined),

		name: useGA4 ?
			(item.item_name !== undefined ?
				item.item_name + '' :
				undefined) :
			(data.item_name && item[data.item_name] !== undefined ?
				item[data.item_name] + '' :
				undefined),

		content_type: data.content_type || 'product',

		quantity: useGA4 ?
			(item.quantity !== undefined ?
				item.quantity * 1 :
				undefined) :
			(data.quantity && item[data.quantity] !== undefined ?
				item[data.quantity] * 1 :
				undefined),

		amount: useGA4 ?
			(item.price !== undefined ?
				item.price * 1 :
				undefined) :
			(data.price && item[data.price] !== undefined ?
				item[data.price] * 1 :
				undefined),

		currency: currency || undefined
	};

});

switch (data.supported_parameters) {

	case 'contents':
		return contents;

	case 'currency':
		return currency;

	case 'amount':
		return value * 1;

	default:
		return undefined;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ecommerce"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 5/20/2026, 6:05:43 PM


