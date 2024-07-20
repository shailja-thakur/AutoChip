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
    if (mode == 1'b1) begin // Heating mode
        heater = too_cold;
        aircon = 1'b0;
    end else begin // Cooling mode
        heater = 1'b0;
        aircon = too_hot;
    end
    
    fan = fan_on | heater | aircon;
end

endmodule
