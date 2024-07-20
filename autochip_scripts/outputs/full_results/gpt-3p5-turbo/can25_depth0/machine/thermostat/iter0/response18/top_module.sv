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
    reg heater;
    reg aircon;

    // Control fan
    always @(*) begin
        if (fan_on || too_cold || too_hot) begin
            fan = 1;
        end else begin
            fan = 0;
        end
    end

    // Control heater
    always @(posedge too_cold or negedge mode) begin
        if (mode && too_cold) begin
            heater = 1;
        end else begin
            heater = 0;
        end
    end

    // Control aircon
    always @(posedge too_hot or negedge mode) begin
        if (!mode && too_hot) begin
            aircon = 1;
        end else begin
            aircon = 0;
        end
    end
endmodule
