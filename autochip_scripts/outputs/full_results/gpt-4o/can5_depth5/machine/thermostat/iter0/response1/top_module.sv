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
    // Control the fan output
    fan = (too_cold | too_hot | fan_on);

    // Control the heater output
    if(mode) begin
        heater = too_cold;
    end else begin
        heater = 0;
    end

    // Control the air conditioner output
    if(~mode) begin
        aircon = too_hot;
    end else begin
        aircon = 0;
    end
end

endmodule
