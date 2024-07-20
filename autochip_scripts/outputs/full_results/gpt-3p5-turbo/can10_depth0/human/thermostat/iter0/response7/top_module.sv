module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    wire heater_out;
    wire aircon_out;
    wire fan_out;
    
    // Logic for heater
    assign heater_out = (mode && too_cold) || fan_on;
    assign heater = heater_out;
    
    // Logic for air conditioner
    assign aircon_out = (!mode && too_hot) || fan_on;
    assign aircon = aircon_out;
    
    // Logic for fan
    assign fan_out = (heater_out || aircon_out || fan_on);
    assign fan = fan_out;

endmodule
