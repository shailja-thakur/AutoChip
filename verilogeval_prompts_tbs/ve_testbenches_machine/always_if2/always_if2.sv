//  This top Verilog module is used to control the behavior of a computer and a car. The module has four inputs and two outputs. The first input is a signal called "cpu_overheated" which is used to indicate whether the computer is overheating. The second input is a signal called "arrived" which is used to indicate whether the car has arrived at its destination. The third input is a signal called "gas_tank_empty" which is used to indicate whether the car's gas tank is empty. The fourth input is a signal called "shut_off_computer" which is used to shut off the computer. The two outputs are signals called "keep_driving" and "shut_off_computer".   The module contains two always blocks. The first always block is used to control the "shut_off_computer" output. If the "cpu_overheated" input is high, the "shut_off_computer" output will be set to 1, otherwise it will be set to 0. The second always block is used to control the "keep_driving" output. If the "arrived" input is low, the "keep_driving" output will be set to the inverse of the "gas_tank_empty" input, otherwise it will be set to 0.

module top_module (
	input cpu_overheated,
	output reg shut_off_computer,
	input arrived,
	input gas_tank_empty,
	output reg keep_driving
);
