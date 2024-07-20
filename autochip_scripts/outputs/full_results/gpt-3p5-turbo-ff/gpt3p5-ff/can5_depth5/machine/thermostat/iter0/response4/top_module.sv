module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declare internal signal for fan control
reg fan_ctrl;

always @(*) begin
    // Determine fan control based on inputs
    fan_ctrl = fan_on || too_cold || too_hot;
    
    // Control fan output based on fan control signal
    if (fan_ctrl)
        fan = 1'b1;
    else
        fan = 1'b0;
    
    // Control heater output based on mode and too_cold input
    if (mode && too_cold)
        heater = 1'b1;
    else
        heater = 1'b0;
    
    // Control aircon output based on mode and too_hot input
    if (!mode && too_hot)
        aircon = 1'b1;
    else
        aircon = 1'b0;
end

endmodule
