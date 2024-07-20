module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Assign default values to outputs
assign heater = 0;
assign aircon = 0;
assign fan = 0;

// Fan control
always @(*)
    if (fan_on == 1)
        fan = 1;
    else
        fan = 0;

// Heating mode
always @(*)
    if (mode == 1 && too_cold == 1)
    begin
        heater = 1;
        aircon = 0;
    end
    else
        heater = 0;

// Cooling mode
always @(*)
    if (mode == 0 && too_hot == 1)
    begin
        aircon = 1;
        heater = 0;
    end
    else
        aircon = 0;
  
endmodule
