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
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

    if (mode == 1'b1) begin // Heating mode
        if (too_cold) begin
            heater = 1'b1;
            fan = 1'b1;
        end
    end
    else begin // Cooling mode
        if (too_hot) begin
            aircon = 1'b1;
            fan = 1'b1;
        end
    end

    // Turn on the fan if requested
    if (fan_on) begin
        fan = 1'b1;
    end
end

endmodule
