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
    // Control fan logic
    if (too_cold || too_hot || fan_on) begin
        fan = 1;
    end else begin
        fan = 0;
    end

    // Control heater logic
    if (mode && too_cold) begin
        heater = 1;
        aircon = 0;
    end else if (!mode && too_hot) begin
        aircon = 1;
        heater = 0;
    end else begin
        heater = 0;
        aircon = 0;
    end
end

endmodule
