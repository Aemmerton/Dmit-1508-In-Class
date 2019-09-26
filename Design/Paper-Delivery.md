# Paper Distribution ERD

## Customer Profile

> ![VIEW_NAME CustomerProfile](./CustomerProfile.PNG)

### 0NF

**CustomerProfile** <span class="md"><b class='pk'>CustomerID</b>, FirstName, LastName, Address, City, PostalCode, PrePaidTip, RouteID, RouteName <b class='rg'>PaperID, PaperDescription, DeliveryTypeID, DeliveryTypeDescription, DeliveryTypeCharge</b>

### 1NF

**Customer** <span class="md"><b class='pk'>CustomerId</b>, FirstName, LastName, Address, City, Province, PostalCode, PrePaidTip, RouteID, RouteName</span>

**PaperOrder** <span class='md'><b class='pk'><i class='fk'>CustomerID</i>, PaperID</b>, PaperDescription, DeliveryTpeID, DeliveryTpeDescription, DeliveryTypeCharge</span>

### 2NF

**PaperOrder** <span class='md'><b class='pk'><i class='fk'>CustomerID</i>, <i class='fk'>PaperID</i></b>, PaperDescription</span>

**DeliveryDetails** <span class='md'><b class='pk'><i class='fk'>CustomerID</i>, DeliveryTypeID</b>, DeliveryTypeDescription, DeliveryTypeCharge</span>

### 3NF
>No Changes

### Paper Distribution ERD

![VIEW_NAME ERD](./ERD1.png)

----

## Distributor Routes Summary

![VIEW_NAME ERD](./Profile2.png)

### 0NF

**PurchaseOrder** <span class="md"><b class='pk'>ZoneID</b>, ZoneName, ZoneManagerName, CellNumber, <b class='rg'> RegionID, RegionName, RegionSupervisorName, RouteID, RouteName, CarrierID, DropSiteID</b> </span>

### 1NF

**Zone** <span class="md"><b class='pk'>ZoneID</b>, ZoneNAme, ZoneManagerName, CellNumber</span>

**Region** <span class='md'><b class='pk'><i class='fk'>ZoneID</i>, RegionID</b>, RegionName, RegionSupervisorName, RouteID, RouteName, CarrierID, DropSiteID</span>

### 2NF

**Region** <span class='md'><b class='pk'><i class='fk'>ZoneID, RegionID</i></b>, RegionName, RegionSupervisorName,  CarrierID, DropSiteID</span>

**Region** <span class='md'><b class='pk'><i class='fk'>ZoneID</i>, RouteID</b>, RouteName</span>


### 3NF

>No Changes


### Distributor Routes ERD

![VIEW_NAME ERD](./ERD2.png)

----

## Drop Site Delivery Orders

![VIEW_NAME ERD](./Profile3.png)

### 0NF

**DropSiteDeliveryOrders** <span class="md"><b class='pk'>DropSiteID</b>, DropSiteName, DropSiteAddress, <b class='rg'> RouteID, RouteName, CarrierID, CarrierName, CarrierPhone</b> </span>

### 1NF

**DropSite** <span class="md"><b class='pk'>DropSiteID</b>, DropSiteName, DropSiteAddress</span>

**Route** <span class='md'><b class='pk'><i class='fk'>DropSiteID</i>, RouteID</b>, RouteName, CarrierID, CarrierName, CarrierPhone</span>

### 2NF

>No Changes

### 3NF

>No Changes

### Drop Site Delivery Orders ERD

![VIEW_NAME ERD](./ERD3.png)

----

### Combined Paper Delivery ERD

![VIEW_NAME ERD](./CombinedERD.png)

----

This legend is a guide to reading and interpreting the table listings under 0NF through 3NF.

- **TableName:**
  - Table names will be bolded and end with a colon. (e.g.: `**TableName:**`)
- (Column, Names)
  - Column names for a table will be enclosed in (rounded parenthesis) (e.g.: `<span class="md">All, Attributes</span>`).
- <b class="pk">PrimaryKeyFields</b>
  - Primary key fields will be bold and inside a box. (e.g.: `<b class="pk">PrimaryKeyFields</b>`)
- <u class="fk">ForeignKeyFields</u>
  - Foreign key fields will be a wavy underline in italic and green. (e.g.: `<u class="fk">ForeignKeyFields</u>`)
- <b class="rg">Repeating Groups</b>
  - Groups of repeating fields will be identified in 0NF stage, and will be enclosed in orange curly braces. (e.g.: `<b class="rg">Repeating, Group, Fields</b>`)

----

## Styling

Most of the styling is done by the default conversion from Markdown (.md) to Markup (.html). Additional styling for primary keys, foreign keys, and notes are made through the following stylesheet. <span class="note">Note:</span> Mardown text can include regular HTML elements, but not all elements are rendered on GitHub.com by default (such as the `<style>` and `<script>` elements).

```html
<style type="text/css">
.md {
    display: inline-block;
    vertical-align: top;
    white-space:normal;
}
.md::before {
    content: '(';
    font-size: 1.25em;
    font-weight: bold;
}
.md::after {
    content: ')';
    font-size: 1.25em;
    font-weight: bold;
}
.pk {
    font-weight: 700;
    display: inline-block;
    border: thin solid #00f;
    padding: 0 2px;
    position: relative;
}
.pk::before {
    content: 'P';
    font-size:.55em;
    font-weight: bold;
    color: white;
    background-color: #72c4f7;
    position: absolute;
    left: -5px;
    top: -15px;
    border-radius: 50%;
    border: solid thin blue;
    width: 1.4em;
    height: 1.4em;
    padding:3px;
    text-align:center;
}
.fk {
    color: green;
    font-style: italic;
    text-decoration: wavy underline green;
    padding: 0 2px;
    position: relative;
}
.fk::before {
    content: 'F';
    font-size:.65em;
    position: absolute;
    left: -1px;
    bottom: -17px;
    color:darkgreen;
    background-color: #a7dea7;
    border-radius: 50%;
    border: dashed thin green;
    width: 1.4em;
    height: 1.4em;
    padding:3px;
    text-align:center;
}
.rg::before {
    content: '\007B';
    color: darkorange;
    font-size: 1.2em;
    font-weight: bold;
}
.rg::after {
    content: '\007D';
    color: darkorange;
    font-size: 1.2em;
    font-weight: bold;
}
.rg {
    display: inline-block;
    color: inherit;
    font-size: 1em;
    font-weight: normal;
}
.note {
    font-weight: bold;
    color: brown;
    font-size: 1.1em;
}
</style>
```

<style type="text/css">
.md {
    display: inline-block;
    vertical-align: top;
    white-space:normal;
}
.md::before {
    content: '(';
    font-size: 1.25em;
    font-weight: bold;
}
.md::after {
    content: ')';
    font-size: 1.25em;
    font-weight: bold;
}
.pk {
    font-weight: 700;
    display: inline-block;
    border: thin solid #00f;
    padding: 0 2px;
    position: relative;
}
.pk::before {
    content: 'P';
    font-size:.55em;
    font-weight: bold;
    color: white;
    background-color: #72c4f7;
    position: absolute;
    left: -5px;
    top: -15px;
    border-radius: 50%;
    border: solid thin blue;
    width: 1.4em;
    height: 1.4em;
    padding:3px;
    text-align:center;
}
.fk {
    color: green;
    font-style: italic;
    text-decoration: wavy underline green;
    padding: 0 2px;
    position: relative;
}
.fk::before {
    content: 'F';
    font-size:.65em;
    position: absolute;
    left: -1px;
    bottom: -17px;
    color:darkgreen;
    background-color: #a7dea7;
    border-radius: 50%;
    border: dashed thin green;
    width: 1.4em;
    height: 1.4em;
    padding:3px;
    text-align:center;
}
.rg::before {
    content: '\007B';
    color: darkorange;
    font-size: 1.2em;
    font-weight: bold;
}
.rg::after {
    content: '\007D';
    color: darkorange;
    font-size: 1.2em;
    font-weight: bold;
}
.rg {
    display: inline-block;
    color: inherit;
    font-size: 1em;
    font-weight: normal;
}
.note {
    font-weight: bold;
    color: brown;
    font-size: 1.1em;
}
</style>

