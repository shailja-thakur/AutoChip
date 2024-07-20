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
    // Control the fan
    fan = (fan_on || too_cold || too_hot);
    
    // Control the heater
    if (mode && too_cold) begin
        heater = 1'b1;
    end else begin
        heater = 1'b0;
    end
    
    // Control the aircon
    if (!mode && too_hot) begin
        aircon = 1'b1;
    end else begin
        aircon = 1'b0;
    end
end

endmodule
