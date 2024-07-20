module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// In this module we are going to define 3 signals that we can use to control the heater, aircon and fan.
// By default, they will be off.

reg heater_signal;
wire heater = heater_signal;

reg aircon_signal;
wire aircon = aircon_signal;

reg fan_signal;
wire fan = fan_signal;

// Now we are going to implement the logic of the module based on the specifications.

always @(*) begin
	if (mode == 1) begin
		heater_signal = too_cold;
		aircon_signal = 0;
		fan_signal = heater_signal || aircon_signal || fan_on;
	end else begin
		heater_signal = 0;
		aircon_signal = too_hot;
		fan_signal = heater_signal || aircon_signal || fan_on;
	end
end

endmodule
