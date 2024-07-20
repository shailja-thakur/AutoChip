module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    // Declare internal wires
    wire fan_on_internal;
    wire heater_internal;
    wire aircon_internal;
    
    // Assign internal wires
    assign fan_on_internal = (fan_on || heater_internal || aircon_internal);
    assign heater = heater_internal;
    assign aircon = aircon_internal;
    assign fan = fan_on_internal;
    
    // Control logic
    always @*
    begin
        if (mode == 1 && too_cold == 1)
        begin
            heater_internal = 1;
            aircon_internal = 0;
        end
        else if (mode == 0 && too_hot == 1)
        begin
            aircon_internal = 1;
            heater_internal = 0;
        end
        else
        begin
            aircon_internal = 0;
            heater_internal = 0;
        end
    end
    
endmodule
