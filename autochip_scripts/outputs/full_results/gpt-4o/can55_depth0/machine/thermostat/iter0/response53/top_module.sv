module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

// control the fan
always @(*) begin
    fan = fan_on | too_cold | too_hot;
end

// control the heater
always @(*) begin
    if (mode && too_cold) begin
        heater = 1;
    end else begin
        heater = 0;
    end
end

// control the air conditioner
always @(*) begin
    if (~mode && too_hot) begin
        aircon = 1;
    end else begin
        aircon = 0;
    end
end

endmodule
