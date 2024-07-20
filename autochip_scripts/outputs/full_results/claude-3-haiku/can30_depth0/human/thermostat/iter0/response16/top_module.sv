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
    // In heating mode, turn on the heater when it is too cold
    if (mode == 1 && too_cold == 1) begin
        heater = 1;
        aircon = 0;
        fan = 1;
    end
    // In cooling mode, turn on the air conditioner when it is too hot
    else if (mode == 0 && too_hot == 1) begin
        heater = 0;
        aircon = 1;
        fan = 1;
    end
    // If the user requests the fan to be on, turn on the fan
    else if (fan_on == 1) begin
        heater = 0;
        aircon = 0;
        fan = 1;
    end
    // If none of the above conditions are met, turn everything off
    else begin
        heater = 0;
        aircon = 0;
        fan = 0;
    end
end

endmodule
