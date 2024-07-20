module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output reg heater,
	output reg aircon,
	output reg fan
);

    always @(*) begin
        // Heater control logic
        heater = mode && too_cold;
        
        // Air conditioner control logic
        aircon = ~mode && too_hot;
        
        // Fan control logic
        fan = too_cold || too_hot || fan_on;
    end

endmodule
