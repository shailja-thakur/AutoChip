module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Declare internal signals
reg fan_on_int;

// Logic to determine if fan should be on
always @(*) begin
    if (mode == 1 || too_cold == 1 || too_hot == 1 || fan_on == 1)
        fan_on_int = 1;
    else
        fan_on_int = 0;
end

// Logic to control heater and air conditioner
always @(mode, too_cold, too_hot) begin
    if (mode == 1 && too_cold == 1)
        heater = 1;
    else
        heater = 0;

    if (mode == 0 && too_hot == 1)
        aircon = 1;
    else
        aircon = 0;
end

// Assign fan output
assign fan = fan_on_int;

endmodule
