module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Fan control
    wire fan;
    assign fan = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;
    
    // Heater control
    wire heater;
    assign heater = (mode && too_cold) ? 1'b1 : 1'b0;

    // Aircon control
    wire aircon;
    assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;

    // Output assignments
    assign fan = fan;
    assign heater = heater;
    assign aircon = aircon; 
endmodule
