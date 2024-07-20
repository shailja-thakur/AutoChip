module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Define internal signals
reg fan_on_internal;

// Assign internal signals based on input conditions
always @* begin
    if (mode && too_cold) begin
        heater = 1;
        aircon = 0;
        fan_on_internal = 1;
    end
    else if (!mode && too_hot) begin
        heater = 0;
        aircon = 1;
        fan_on_internal = 1;
    end
    else if (fan_on) begin
        heater = 0;
        aircon = 0;
        fan_on_internal = 1;
    end
    else begin
        heater = 0;
        aircon = 0;
        fan_on_internal = 0;
    end
end

// Assign fan output
assign fan = fan_on_internal;

endmodule
