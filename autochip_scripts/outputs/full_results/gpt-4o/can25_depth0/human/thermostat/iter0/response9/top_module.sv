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
    if (mode == 1) begin // Heating mode
        heater = too_cold;
        aircon = 0;
    end else begin // Cooling mode
        heater = 0;
        aircon = too_hot;
    end

    // Turn on fan if heater or aircon are on, or if fan_on is requested
    fan = heater || aircon || fan_on;
end

endmodule
