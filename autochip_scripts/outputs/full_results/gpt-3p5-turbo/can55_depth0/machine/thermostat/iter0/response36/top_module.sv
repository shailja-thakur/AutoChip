module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Assign default values to outputs
assign heater = 0;
assign aircon = 0;
assign fan = 0;

// Control fan
always @* begin
    if (fan_on || too_cold || too_hot) begin
        fan = 1;
    end else begin
        fan = 0;
    end
end

// Control heater
always @* begin
    if (mode && too_cold) begin
        heater = 1;
    end else begin
        heater = 0;
    end
end

// Control aircon
always @* begin
    if (!mode && too_hot) begin
        aircon = 1;
    end else begin
        aircon = 0;
    end
end

endmodule
