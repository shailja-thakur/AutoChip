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
    // In heating mode, turn on the heater when it's too cold
    if (mode == 1 && too_cold == 1) begin
        heater = 1;
        aircon = 0;
    end
    // In cooling mode, turn on the air conditioner when it's too hot
    else if (mode == 0 && too_hot == 1) begin
        heater = 0;
        aircon = 1;
    end
    // If neither heating nor cooling is needed, turn off the heater and air conditioner
    else begin
        heater = 0;
        aircon = 0;
    end

    // Turn on the fan if either the heater or air conditioner is on, or if the user requests it
    if (heater == 1 || aircon == 1 || fan_on == 1) begin
        fan = 1;
    end
    else begin
        fan = 0;
    end
end

endmodule
