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
    // Set the fan based on the inputs
    fan = (too_cold || too_hot) || fan_on;
    
    // Set the heater based on the inputs
    heater = (mode && too_cold);
    
    // Set the air conditioner based on the inputs
    aircon = (!mode && too_hot);
end

endmodule
