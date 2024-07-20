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
    // Set the heater
    if (mode && too_cold) begin
        heater = 1'b1;
    end else begin
        heater = 1'b0;
    end

    // Set the air conditioner
    if (!mode && too_hot) begin
        aircon = 1'b1;
    end else begin
        aircon = 1'b0;
    end

    // Set the fan
    if (heater || aircon || fan_on) begin
        fan = 1'b1;
    end else begin
        fan = 1'b0;
    end
end

endmodule
