module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declarations
reg heater;
reg aircon;
reg fan;

// Logic for heater
always @(mode, too_cold) begin
    if (mode && too_cold)
        heater = 1;
    else
        heater = 0;
end

// Logic for aircon
always @(mode, too_hot) begin
    if (!mode && too_hot)
        aircon = 1;
    else
        aircon = 0;
end

// Logic for fan
always @(fan_on) begin
    if (fan_on || heater || aircon)
        fan = 1;
    else
        fan = 0;
end

endmodule
