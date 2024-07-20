module top_module(
    input mode,       // 1 = heating, 0 = cooling
    input too_cold, 
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @(*) begin
    if (mode == 1) begin  // Heating mode
        heater = too_cold;
        aircon = 0;
    end else begin        // Cooling mode
        heater = 0;
        aircon = too_hot;
    end
    
    fan = fan_on | heater | aircon;
end

endmodule
