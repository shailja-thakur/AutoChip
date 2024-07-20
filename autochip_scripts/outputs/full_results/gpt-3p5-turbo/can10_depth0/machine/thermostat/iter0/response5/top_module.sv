module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Internal Signals
wire fan;
wire heater;
wire aircon;

// Logic for fan control
assign fan = (fan_on || too_cold || too_hot);

// Logic for heater control
assign heater = (mode && too_cold);

// Logic for aircon control
assign aircon = (!mode && too_hot);

endmodule
