module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    reg fan;
    
    always @(*) begin
        if (fan_on == 1 || too_cold == 1 || too_hot == 1)
            fan = 1;
        else
            fan = 0;
    end
    
    always @(*) begin
        if (mode == 1 && too_cold == 1)
            heater = 1;
        else
            heater = 0;
    end
    
    always @(*) begin
        if (mode == 0 && too_hot == 1)
            aircon = 1;
        else
            aircon = 0;
    end

endmodule
