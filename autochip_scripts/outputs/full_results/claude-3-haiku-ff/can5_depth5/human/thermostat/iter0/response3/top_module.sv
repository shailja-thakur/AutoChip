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
    // Default state: turn off heater, air conditioner, and fan
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

    // Heating mode
    if (mode) begin
        if (too_cold) begin
            heater = 1'b1;
            fan = 1'b1;
        end
    end
    // Cooling mode
    else begin
        if (too_hot) begin
            aircon = 1'b1;
            fan = 1'b1;
        end
    end

    // Turn on fan if requested by the user
    if (fan_on) begin
        fan = 1'b1;
    end
end

endmodule
