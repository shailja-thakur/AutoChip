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
    // Default state: Fan is off if neither heater nor AC is on
    fan = 0;

    // Heating mode
    if (mode == 1'b1) begin
        heater = too_cold;
        aircon = 0;
        if (heater || fan_on) begin
            fan = 1;
        end
    end
    // Cooling mode
    else begin
        heater = 0;
        aircon = too_hot;
        if (aircon || fan_on) begin
            fan = 1;
        end
    end
end

endmodule
