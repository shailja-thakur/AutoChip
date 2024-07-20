module top_module (
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @(*) begin
    // Heater control: Turn on if mode is heating and the room is too cold
    if (mode && too_cold) begin
        heater = 1;
    end else begin
        heater = 0;
    end

    // Air conditioner control: Turn on if mode is cooling and the room is too hot
    if (!mode && too_hot) begin
        aircon = 1;
    end else begin
        aircon = 0;
    end

    // Fan control: Turn on if fan_on is high or the room is either too cold or too hot
    if (fan_on || too_cold || too_hot) begin
        fan = 1;
    end else begin
        fan = 0;
    end
end

endmodule
