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
    // Initialize all outputs to zero
    heater = 0;
    aircon = 0;
    fan = 0;

    if (mode == 1) begin // Heating mode
        if (too_cold) begin
            heater = 1;
            fan = 1; // Turn on the fan when heater is on
        end
    end else begin // Cooling mode
        if (too_hot) begin
            aircon = 1;
            fan = 1; // Turn on the fan when air conditioner is on
        end
    end

    // Turn on the fan if fan_on is requested, regardless of heater/aircon state
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
