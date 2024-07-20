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
    // Default values
    heater = 0;
    aircon = 0;
    fan = 0;

    // Heating mode
    if (mode == 1) begin
        heater = too_cold;
        fan = heater;
    end
    // Cooling mode
    else if (mode == 0) begin
        aircon = too_hot;
        fan = aircon;
    end

    // Explicit fan request
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
