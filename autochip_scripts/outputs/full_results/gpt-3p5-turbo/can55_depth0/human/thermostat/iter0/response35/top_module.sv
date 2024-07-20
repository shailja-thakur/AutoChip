module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    wire fan_on_new;

    // Combining fan_on and fan_on_new to determine the final value of the fan output
    assign fan = fan_on | fan_on_new;

    // Control signals for heater, aircon, and fan
    wire heater_control;
    wire aircon_control;
    wire fan_control;

    // Logic for heater, aircon, and fan control
    assign heater_control = (mode == 1) & too_cold;
    assign aircon_control = (mode == 0) & too_hot;
    assign fan_control = fan_on | heater_control | aircon_control;

    // Output connections
    assign heater = heater_control;
    assign aircon = aircon_control;
    assign fan_on_new = fan_control;
    
endmodule
