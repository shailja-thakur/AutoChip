module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declare internal wires for intermediate calculations
wire fan_temp;
wire fan_ctrl;
wire heater_ctrl;
wire aircon_ctrl;

// Assign outputs to internal wires
assign fan = fan_ctrl;
assign heater = heater_ctrl;
assign aircon = aircon_ctrl;

// Determine if the fan should be turned on
assign fan_temp = (too_cold || too_hot || fan_on);
assign fan_ctrl = (fan_temp) ? 1'b1 : 1'b0;

// Determine if the heater should be turned on
assign heater_ctrl = (mode && too_cold) ? 1'b1 : 1'b0;

// Determine if the air conditioner should be turned on
assign aircon_ctrl = (!mode && too_hot) ? 1'b1 : 1'b0;

endmodule
