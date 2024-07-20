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
    // Heating mode
    if (mode) begin
        heater = too_cold;
        aircon = 0;
        fan = heater; // Turn on fan if heater is on
    end
    // Cooling mode
    else begin
        heater = 0;
        aircon = too_hot;
        fan = aircon; // Turn on fan if AC is on
    end

    // Turn on fan if user requests it, even if heater/AC are off
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
