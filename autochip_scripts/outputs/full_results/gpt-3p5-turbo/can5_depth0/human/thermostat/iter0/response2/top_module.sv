module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    // Define internal signals
    wire fan_ctrl;

    // Fan control logic
    assign fan_ctrl = (fan_on || heater || aircon) ? 1'b1 : 1'b0;
  
    // Heater control logic
    assign heater = (mode == 1 && too_cold) ? 1'b1 : 1'b0;

    // Air conditioner control logic
    assign aircon = (mode == 0 && too_hot) ? 1'b1 : 1'b0;

    // Output assignments
    assign fan = fan_ctrl;
  
endmodule
