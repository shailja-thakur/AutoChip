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
    // Set the heater output
    heater = (mode && too_cold);
    
    // Set the aircon output
    aircon = (~mode && too_hot);
    
    // Set the fan output
    if (fan_on) begin
        fan = 1'b1;
    end
    else begin
        fan = (too_cold || too_hot);
    end
end

endmodule
