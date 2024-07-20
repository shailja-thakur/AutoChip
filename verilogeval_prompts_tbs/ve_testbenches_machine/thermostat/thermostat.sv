//  This Verilog module is used to control the temperature of a room. It has two inputs, mode and fan_on, and three outputs, heater, aircon and fan. The inputs mode and fan_on are used to determine the state of the system, while the outputs heater, aircon and fan are used to control the temperature of the room.  The mode input is used to determine the mode of operation. If mode is high, the system is in heating mode and if mode is low, the system is in cooling mode.  The fan_on input is used to control the fan. If fan_on is high, the fan will be turned on regardless of the mode.  The too_cold and too_hot inputs are used to determine the temperature of the room. If too_cold is high, the room is too cold and if too_hot is high, the room is too hot.  The fan output is used to control the fan. If fan is high, the fan will be turned on. The fan will be turned on if either too_cold or too_hot is high, or if fan_on is high.  The heater output is used to control the heater. If heater is high, the heater will be turned on. The heater will be turned on if mode is high and too_cold is high.  The aircon output is used to control the air conditioner. If aircon is high, the air conditioner will be turned on. The air conditioner will be turned on if mode is low and too_hot is high.

module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
