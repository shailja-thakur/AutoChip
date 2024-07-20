module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Internal signal declaration
reg fan_on_internal;

// Logic to turn on and off the heater, air conditioning, and fan
always @ (mode or too_cold or too_hot or fan_on) begin
    if (mode == 1) begin
        // Heating mode
        heater = too_cold;
        aircon = 0;
    end else begin
        // Cooling mode
        heater = 0;
        aircon = too_hot;
    end
    
    // Fan control logic
    if (fan_on == 1 || heater == 1 || aircon == 1) begin
        fan_on_internal = 1;
    end else begin
        fan_on_internal = 0;
    end
end

// Assign internal signal to output
assign fan = fan_on_internal;

endmodule
