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
            aircon = 1'b0; // Air conditioner off in heating mode
        end else begin // Cooling mode
            heater = 1'b0; // Heater off in cooling mode
            aircon = too_hot;
        end

        // Fan is on if heater or air conditioner is on, or if fan_on is requested
        fan = (heater || aircon || fan_on);
    end

endmodule
