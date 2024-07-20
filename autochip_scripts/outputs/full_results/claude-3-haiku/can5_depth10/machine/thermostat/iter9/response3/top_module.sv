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
    if (too_cold || too_hot) begin
        fan = 1'b1;
    end
    else if (fan_on) begin
        fan = 1'b1;
    end
    else begin
        fan = 1'b0;
    end
    
    // Set the heater output
    heater = (mode && too_cold);
    
    // Set the aircon output
    aircon = (~mode && too_hot);
end

endmodule
