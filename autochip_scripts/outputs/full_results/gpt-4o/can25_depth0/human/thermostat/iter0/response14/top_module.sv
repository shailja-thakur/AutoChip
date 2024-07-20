module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output fan
);

    // Heater and aircon control
    always @(*) begin
        if (mode) begin
            // Heating mode
            heater = too_cold;
            aircon = 0;
        end else begin
            // Cooling mode
            heater = 0;
            aircon = too_hot;
        end
    end

    // Fan control
    assign fan = fan_on | heater | aircon;

endmodule
