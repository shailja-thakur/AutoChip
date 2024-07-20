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
        fan = heater;
    end
    else begin // Cooling mode
        heater = 0;
        aircon = too_hot;
        fan = aircon;
    end
    
    // Regardless of mode, turn on the fan if requested by the user
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
