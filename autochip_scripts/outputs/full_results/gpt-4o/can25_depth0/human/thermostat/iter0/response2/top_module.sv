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
    if (mode) begin // Heating mode
        heater = too_cold;
        aircon = 0;
    end else begin // Cooling mode
        aircon = too_hot;
        heater = 0;
    end
    
    fan = (heater | aircon) | fan_on; // Fan is on if either heater or aircon is on, or if fan_on is requested
end

endmodule
