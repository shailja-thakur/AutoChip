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
        if (mode) begin
            // Heating mode
            heater = too_cold;
            aircon = 0;
        end else begin
            // Cooling mode
            heater = 0;
            aircon = too_hot;
        end
        
        // The fan should be on if either the user manually turns it on, or if either the heater or air conditioner is on.
        fan = fan_on || heater || aircon;
    end
endmodule
