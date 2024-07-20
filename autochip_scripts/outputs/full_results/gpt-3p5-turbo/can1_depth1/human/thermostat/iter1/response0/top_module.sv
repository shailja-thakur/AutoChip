module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

// Logic for turning on and off the heater, air conditioner, and fan
always @(*)
begin
    if (mode && too_cold && !fan_on)
        heater = 1'b1;
    else
        heater = 1'b0;
    
    if (!mode && too_hot && !fan_on)
        aircon = 1'b1;
    else
        aircon = 1'b0;
    
    if (heater || aircon || fan_on)
        fan = 1'b1;
    else
        fan = 1'b0;
end

endmodule
