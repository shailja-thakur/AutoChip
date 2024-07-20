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
    // Set the fan output
    if (fan_on) begin
        fan = 1'b1;
    end else if (heater || aircon) begin
        fan = 1'b1;
    end else begin
        fan = 1'b0;
    end
    
    // Set the heater and air conditioner outputs
    if (mode) begin // Heating mode
        if (too_cold) begin
            heater = 1'b1;
            aircon = 1'b0;
        end else begin
            heater = 1'b0;
            aircon = 1'b0;
        end
    end else begin // Cooling mode
        if (too_hot) begin
            heater = 1'b0;
            aircon = 1'b1;
        end else begin
            heater = 1'b0;
            aircon = 1'b0;
        end
    end
end

endmodule
