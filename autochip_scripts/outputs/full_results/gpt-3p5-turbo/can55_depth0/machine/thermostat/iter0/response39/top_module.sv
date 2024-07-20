module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Variables to store intermediate logic values
reg fan, heater, aircon;

// Logic to control the fan
always @(*) begin
    if (fan_on || too_cold || too_hot) begin
        fan = 1;
    end else begin
        fan = 0;
    end
end

// Logic to control the heater
always @(*) begin
    if (mode && too_cold) begin
        heater = 1;
    end else begin
        heater = 0;
    end
end

// Logic to control the air conditioner
always @(*) begin
    if (!mode && too_hot) begin
        aircon = 1;
    end else begin
        aircon = 0;
    end
end

// Assign outputs
assign fan = fan_out;
assign heater = heater_out;
assign aircon = aircon_out;

endmodule
