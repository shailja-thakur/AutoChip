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

// Logic for heater, air conditioner, and fan control
always @* begin
    if (mode && too_cold) begin
        heater = 1;
        fan = 1;
    end else if (!mode && too_hot) begin
        aircon = 1;
        fan = 1;
    end else if (fan_on) begin
        fan = 1;
    end else begin
        heater = 0;
        aircon = 0;
        fan = 0;
    end
end

endmodule
