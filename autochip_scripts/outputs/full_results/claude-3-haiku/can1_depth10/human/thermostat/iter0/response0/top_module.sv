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
        fan = heater; // Turn on fan when heater is on
    end
    else begin // Cooling mode
        heater = 0;
        aircon = too_hot;
        fan = aircon; // Turn on fan when AC is on
    end

    // Turn on fan if user requests it, even if heater and AC are off
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
