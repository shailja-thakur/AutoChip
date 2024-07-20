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
    if (too_cold || too_hot || fan_on) begin
        fan = 1'b1;
    end else begin
        fan = 1'b0;
    end

    // Set the heater output
    if (mode && too_cold) begin
        heater = 1'b1;
    end else begin
        heater = 1'b0;
    end

    // Set the aircon output
    if (!mode && too_hot) begin
        aircon = 1'b1;
    end else begin
        aircon = 1'b0;
    end
end

endmodule
