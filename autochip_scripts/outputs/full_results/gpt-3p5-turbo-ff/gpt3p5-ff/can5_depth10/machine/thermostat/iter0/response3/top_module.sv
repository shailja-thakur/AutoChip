module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    reg fan, heater, aircon;

    // Control the fan
    always @*
    begin
        if (fan_on == 1'b1 || too_cold == 1'b1 || too_hot == 1'b1)
            fan = 1'b1;
        else
            fan = 1'b0;
    end

    // Control the heater
    always @*
    begin
        if (mode == 1'b1 && too_cold == 1'b1)
            heater = 1'b1;
        else
            heater = 1'b0;
    end

    // Control the air conditioner
    always @*
    begin
        if (mode == 1'b0 && too_hot == 1'b1)
            aircon = 1'b1;
        else
            aircon = 1'b0;
    end

endmodule
