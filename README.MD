InQlik QVD Explorer.
-------------

Simple tool to explore data in QVD files. 

##Installation

- Clone project or just download [repository archive](https://github.com/inqlik/QvdExplorer/archive/master.zip) and copy extract directory `QvdExplorer-master` from that archive anywhere in your system (you may rename that directory to `QvdExplorer` for example). Probably path to `QvdExplorer` directory should not contain non-ascii symbols and spaces. 
- Run `setup.bat` (you can do it just double clicking that batch file in the file explorer). That operation will install new target `QvdExplorer` to `Send to` context menu in file explorer.

##Usage

Select one or several QVD files in Windows Explorer then select "Send to" item in Windows context menu. 
![Image 1](http://inqlik.github.io/images/send-to-qvdexplorer.png)

"Sent to" operation will trigger several events

- New qvw application with long unique name that included path to selected QVD files will be created in `Data` subdirectory under your QvdExplorer directory
- New QlikView load script for loading all selected QVD files into that application will be created alongside with that qvw application
- Qvw application will reload data
- Qvw application will be opened in QlikView Desktop

Newly opened qvd application may look like this:

![Image 1](http://inqlik.github.io/images/qvdexplorer-newly-opened.png)
In Dynamic filter area, you can choose a field from the list of fields available in the application and then select values to filter in the adjacent list.


Straight table with data to explore originally is hidden. To show it you should select one or more dimensions in Dimension selection area. Optionally you can add up to 5 measures to table by choosing a field from the list of available fields and aggregation function from the correspondig list.

Example of QvdExplorer application for sample dataset with some `EmployeeId`'s filtered, with selected dimensions `SupplierId` and `ProductName` and measures added to show sum of `Quantity` and number of transactions by selected dimensions

![Image 1](http://inqlik.github.io/images/qvdexplorer.png)


You can freely edit application. For example you can add additional non-dynamic charts to other sheets and save the application. Later on if you send the same set of QVD files to QvdExplorer from Windows context menu that saved application with your amendments will be opened and reloaded. 

##Changelog

####Version 1.1.0

- Checking for various locations of SendTo folder
- Explicit sort, variable prefix, additional functions
- Guard dynamic field names with bracket in formulas
