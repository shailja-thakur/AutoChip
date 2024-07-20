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
    // Default state: fan off, heater off, air conditioner off
    heater = 0;
    aircon = 0;
    fan = 0;

    // If heating mode and too cold, turn on heater and fan
    if (mode && too_cold) begin
        heater = 1;
        fan = 1;
    end
    // If cooling mode and too hot, turn on air conditioner and fan
    else if (~mode && too_hot) begin
        aircon = 1;
        fan = 1;
    end
    // If fan is requested, turn on fan
    else if (fan_on) begin
        fan = 1;
    end
end

endmodule
