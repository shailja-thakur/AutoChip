module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Declare internal signal
reg fan_on_internal;

// Fan control logic
assign fan = (fan_on | heater | aircon) ? 1'b1 : 1'b0;

// Heater control logic
always @(*)
    if (mode & too_cold)
        heater = 1'b1;
    else
        heater = 1'b0;

// Air conditioner control logic
always @(*)
    if (~mode & too_hot)
        aircon = 1'b1;
    else
        aircon = 1'b0;

// Assign fan_on_internal based on mode and fan_on inputs
always @(*)
    fan_on_internal = (mode | fan_on);

endmodule
