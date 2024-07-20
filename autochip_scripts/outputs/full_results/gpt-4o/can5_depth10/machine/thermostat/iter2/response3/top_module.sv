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
        heater = mode & too_cold;

        // Air conditioner control logic
        aircon = ~mode & too_hot;

        // Fan control logic
        // Correcting the fan logic to handle mutually exclusive temperature conditions
        fan = (too_cold & mode) | (too_hot & ~mode) | fan_on;
    end

endmodule
