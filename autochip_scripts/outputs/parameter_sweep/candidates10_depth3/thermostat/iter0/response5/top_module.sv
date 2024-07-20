module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    
    // Wire to control heater, air conditioner, and fan
    wire heater_on;
    wire aircon_on;
    wire fan_on_internal;
    
    // Heater control logic
    assign heater_on = (mode == 1) && too_cold;
    assign heater = heater_on;
    
    // Air conditioner control logic
    assign aircon_on = (mode == 0) && too_hot;
    assign aircon = aircon_on;
    
    // Fan control logic
    assign fan_on_internal = heater_on || aircon_on || fan_on;
    assign fan = fan_on_internal;
    
endmodule
