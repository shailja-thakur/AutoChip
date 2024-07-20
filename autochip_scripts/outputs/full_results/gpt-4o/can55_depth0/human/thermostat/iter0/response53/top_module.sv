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
            heater = too_cold; // Turn on heater if it's too cold
            aircon = 0;        // Do not use air conditioner in heating mode
        end else begin // Cooling mode
            heater = 0;        // Do not use heater in cooling mode
            aircon = too_hot;  // Turn on air conditioner if it's too hot
        end

        // Turn on fan if heater or air conditioner is on, or if fan_on is requested by the user.
        fan = (heater || aircon || fan_on); 
    end
endmodule
