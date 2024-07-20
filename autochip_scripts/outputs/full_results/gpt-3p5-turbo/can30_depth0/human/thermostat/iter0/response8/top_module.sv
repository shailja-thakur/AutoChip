module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
    reg heater;      // Heater control signal
    reg aircon;      // Air conditioner control signal
    reg fan;         // Fan control signal
    
    always @(mode or too_cold or too_hot or fan_on) begin
        if (mode == 1) begin                  // Heating mode
            heater = too_cold;                // Turn on heater when it is too cold
            aircon = 0;                       // Do not use air conditioner in heating mode
            fan = (heater || fan_on);         // Turn on fan if heater is on or fan_on signal is set
        end else begin                        // Cooling mode
            heater = 0;                       // Do not use heater in cooling mode
            aircon = too_hot;                 // Turn on air conditioner when it is too hot
            fan = (aircon || fan_on);         // Turn on fan if air conditioner is on or fan_on signal is set
        end
    end

endmodule
