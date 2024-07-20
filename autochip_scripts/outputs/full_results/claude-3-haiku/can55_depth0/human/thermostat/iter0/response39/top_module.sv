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
        aircon = 1'b0; // No air conditioning in heating mode
        fan = heater | fan_on; // Turn on fan if heater is on or if user requests
    end
    else begin // Cooling mode
        heater = 1'b0; // No heating in cooling mode
        aircon = too_hot;
        fan = aircon | fan_on; // Turn on fan if air conditioning is on or if user requests
    end
end

endmodule
