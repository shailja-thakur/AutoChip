module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    wire heater_on;
    wire aircon_on;
    wire fan_on_internal;
    
    assign fan_on_internal = (fan_on) ? 1 : (mode && too_cold) || (!mode && too_hot);
    assign heater_on = mode && too_cold && !fan_on_internal;
    assign aircon_on = !mode && too_hot && !fan_on_internal;
    
    assign heater = heater_on;
    assign aircon = aircon_on;
    assign fan = fan_on_internal;
    
endmodule
