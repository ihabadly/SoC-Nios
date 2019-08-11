# SoC-Nios&reg;
Building an example System on Chip (SoC) using NIOS&reg; II processor.

## Install

These examples use [ModelSim&reg; and Quartus&reg; Prime from Intel FPGA](http://fpgasoftware.intel.com/?edition=lite), [GIT](https://git-scm.com/download/win), [Visual Studio Code](https://code.visualstudio.com/download), make sure they are installed locally on your computer before proceeding.

## Usage

1. Grab a copy of this repository to your computer's local folder (i.e. C:\projects):

    ```sh
    $ cd projects
    $ git clone https://github.com/ihabadly/soc-nios.git
    ```
2. Use Visual Studio Code (VSC) to edit and view the design files:

    ```sh
    $ cd soc-nios
    $ code .
    ```
    Click on the soc_nios.vhd file in the left pane to view its contents.
    
3. The example System on Chip design consists of:
    - Nios&reg; II processor
    - On-Chip memory
    - JTAG UART module
    - Timer core
    - Parallel I/O module
    - System ID core

4.  Run the Quartus&reg; Prime Tool to build the Nios&reg; II processor system, then:
    - From Menu, choose Tools -> Platform Designer
    - Click: Close
    - From the IP Catalog, double click on: "Nios II Processor" under the "Processor and Peripherals" category and the "Embedded Processors" sub-category
    - Click: Finish
    - From the IP Catalog, double click on: "On-Chip Memory (RAM or ROM)" under the "Basic Functions" category and the "On Chip Memory" sub-category
    - Click: Finish
    - From the IP Catalog, double click on: "JTAG UART" under the "Interface Protocols" category and the "Serial" sub-category
    - Click: Finish
    - From the IP Catalog, double click on: "Interval Timer" under the "Processor and Peripherals" category and the "Peripherals" sub-category 
    - Click: Finish
    - From the IP Catalog, double click on: "PIO (Parallel I/O)" under the "Processor and Peripherals" category and the "Peripherals" sub-category 
    - Click: Finish
    - From the IP Catalog, double click on: "System ID Peripheral" under the "Basic Functions" category, the "Simulation; Debug and Verification" sub-category and the "Debug and Performance" sub-category 
    - Click: Finish
    - From Menu, choose System -> Create Global Reset Netwok
    - In the System Contents view, connect the "clk" port of the "clk_0" clock source to the "clk" port of all other modules (by clicking on the bubble at the wire intersections)
    - In the System Contents view, connect the "data_master" and "instruction_master" ports of the "nios2_gen2_0" to the "s1" port of the "onchip_memory2_0" module
    - In the System Contents view, connect the "data_master" port of the "nios2_gen2_0" to the "s1" port to each of the remaining modules
    - In the System Contents view, connect the "irq" port of the "nios2_gen2_0" to the "irq" port of the "timer_0" then to the "irq" port of the "jtag_uart_0"
    - In the System Contents view, double click in the "Export" field at the row "external_connection" under the "pio_0" module and hit the return key
    - In the System Contents view, double click on the "nios2_gen2_0" core, under the "Vectors" tab, choose "onchip_memory2_0.s1" as the "Reset vector memory" and the "Exception vector memory"  
    - From Menu, choose System -> Assign Base Addresses
    - Click: Finish
    - In the save dialog box, browse to the "soc-nios" folder then click Open, and name the design as "nios_system.qsys" and click Save
    - Click: Close
    - When prompted to Generate now?, click Yes, then click Generate
    - Click: Finish

5.  Use the Quartus&reg; Prime Tool to synthesis the processor design:
    - From the Menu, choose File -> New Project Wizard
    - Click: Next
    - For the working directory, fill with: "path to your projects folder"/soc-nios/
    - For the project name, fill with: soc_nios
    - Click: Next
    - Click: Next
    - In the File name field, fill with: soc_nios.vhd
    - Click: Add
    - In the File name field, fill with: soc_nios.sdc
    - Click: Add
    - In the File name field, fill with: nios_system/synthesis/nios_system.qip
    - Click: Add
    - Click: Next
    - From the Device family, choose: Cyclone IV E
    - From Available devices, choose: EP4CE22F17C6
    - Click: Next
    - From Simulation, choose Tool Name: ModelSim-Intel and Format: VHDL
    - Click: Next
    - Click: Finish
    - From the Menu, choose Processing -> Start -> Start Analysis & Elaboration
    - Wait until the anaylsis completes
    - From the Menu, choose Assignments -> Pin Planner
    - Assign Location "R8" for the "clk" port
    - Assign Location "J15" for the "rst" port
    - Assign Location "L3" for the "leds[7]" port
    - Assign Location "B1" for the "leds[6]" port
    - Assign Location "F3" for the "leds[5]" port
    - Assign Location "D1" for the "leds[4]" port
    - Assign Location "A11" for the "leds[3]" port
    - Assign Location "B13" for the "leds[2]" port
    - Assign Location "A13" for the "leds[1]" port
    - Assign Location "A15" for the "leds[0]" port
    - Close the Pin Planner window
    - From the Menu, choose Processing -> Start Compilation
    - Wait until the design compilation completes
    - Connect the FPGA Development Board (DE0-NANO) to the any USB port on your computer
    - From the Taskbar, click the Device Programmer icon
    - Click on "Hardware Setup..." and double click "USB Blaster" then click Close 
    - Click "Add File...", browse to the folder "output_files" in the "soc-nios" folder, select the "soc_nios.sof" file and click Open
    - Click Start to start programming the FPGA device connected to your computer

6. Writing a program to run on the Nios&reg; II:

    - From the Quartus&reg; Prime Menu, choose Tools -> Nios II Software Build Tools for Eclipse
    - When prompted for the Workspace, browse to "your projects folder"/soc-nios/software
    - Click OK
    - From the Nios II - Eclipse Menu, choose File -> New -> Nios II Application and BSP from Template
    - For SOPC Information File name, browse to "your projects folder>/nios-system and open the SOPC Information File: nios_system.sopcinfo
    - In the Project name field, type: hello_world
    - In the Project template, select the "Hello World" template and click Finish
    - In the Project Explorer view, expand "hello_world". Double-click "hello_world.c" to view the source code
    - To build the project, select "hello_world", from the Menu, choose Project -> Build Project
    - To run the C program, select "hello_world", from the Menu, choose Run -> Run As -> Nios II Hardware
    - The Nios II SBT for Eclipse downloads the program to the FPGA on the target board and executes the code
    - The message “Hello from Nios II!” displays in the Nios II Console view

