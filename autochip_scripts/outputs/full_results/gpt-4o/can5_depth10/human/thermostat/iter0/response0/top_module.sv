module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Internal signals
    wire heater_on;
    wire aircon_on;
    
    // Heater control based on mode and too_cold signal
    assign heater_on = (mode == 1 && too_cold);
    
    // Air conditioner control based on mode and too_hot signal
    assign aircon_on = (mode == 0 && too_hot);
    
    // Assign outputs
    assign heater = heater_on;
    assign aircon = aircon_on;
    assign fan = fan_on || heater_on || aircon_on;

endmodule
