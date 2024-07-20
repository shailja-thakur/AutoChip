module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    reg heater;
    reg aircon;
    reg fan;
    
    always @(mode or too_cold or too_hot or fan_on) begin
        if (mode == 1) begin
            if (too_cold) begin
                heater = 1;
                aircon = 0;
                fan = 1;
            end else begin
                heater = 0;
                aircon = 0;
                if (fan_on)
                    fan = 1;
                else
                    fan = 0;
            end
        end else begin
            if (too_hot) begin
                heater = 0;
                aircon = 1;
                fan = 1;
            end else begin
                heater = 0;
                aircon = 0;
                if (fan_on)
                    fan = 1;
                else
                    fan = 0;
            end
        end
    end

endmodule
