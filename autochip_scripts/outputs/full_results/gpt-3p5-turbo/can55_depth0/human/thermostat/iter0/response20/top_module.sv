module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// assign fan output to fan_on input when the fan_on is requested
assign fan = fan_on;

// control signals for the heater and aircon
wire heater_on;
wire aircon_on;

// logic for controlling the heater and aircon based on mode, too_cold, and too_hot
assign heater = (mode == 1) && too_cold;
assign aircon = (mode == 0) && too_hot;

// turn on the fan when the heater or aircon are on, or the fan_on is requested
assign fan = heater_on || aircon_on || fan_on; 

endmodule
