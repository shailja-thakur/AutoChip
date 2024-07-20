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
    if (mode && too_cold) begin
        heater = 1;
        aircon = 0;
        fan = 1;
    end
    // In cooling mode, turn on the air conditioner when it's too hot
    else if (~mode && too_hot) begin
        heater = 0;
        aircon = 1;
        fan = 1;
    end
    // If fan is requested, turn it on
    else if (fan_on) begin
        heater = 0;
        aircon = 0;
        fan = 1;
    end
    // Otherwise, turn everything off
    else begin
        heater = 0;
        aircon = 0;
        fan = 0;
    end
end

endmodule
