module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declare internal signals
wire fan_on_req;
wire fan_on_ctrl;

// Fan control logic
assign fan_on_req = fan_on | (mode & (too_cold | too_hot));
assign fan_on_ctrl = fan_on & ~fan_on_req;
assign fan = fan_on_req | fan_on_ctrl;

// Heater control logic
assign heater = mode & too_cold & ~fan_on_req;

// Air conditioner control logic
assign aircon = ~mode & too_hot & ~fan_on_req;

// End of module
endmodule
