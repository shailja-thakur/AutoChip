module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    
    // Control signals for heater, aircon and fan
    wire control_heater;
    wire control_aircon;
    wire control_fan;
    
    // Logic for controlling heater
    assign control_heater = (mode == 1) && (too_cold || fan_on);
    assign heater = control_heater;
    
    // Logic for controlling aircon
    assign control_aircon = (mode == 0) && (too_hot || fan_on);
    assign aircon = control_aircon;
    
    // Logic for controlling fan
    assign control_fan = too_cold || too_hot || fan_on;
    assign fan = control_fan;
    
endmodule
