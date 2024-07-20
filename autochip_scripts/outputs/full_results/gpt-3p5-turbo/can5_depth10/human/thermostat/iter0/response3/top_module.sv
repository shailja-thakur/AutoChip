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
reg fan_ctrl;

// Assign fan control signal based on conditions
always @(*) begin
    if (fan_on) begin
        fan_ctrl = 1;
    end
    else if (too_cold && mode) begin  // if in heating mode and too cold
        fan_ctrl = 1;                  // fan is on
    end
    else if (too_hot && ~mode) begin  // if in cooling mode and too hot
        fan_ctrl = 1;                  // fan is on
    end
    else begin
        fan_ctrl = 0;                  // fan is off
    end
end

// Assign output signals based on conditions
assign heater = (too_cold && mode) ? 1 : 0;  // Heater is on if in heating mode and too cold
assign aircon = (too_hot && ~mode) ? 1 : 0;  // Air conditioner is on if in cooling mode and too hot
assign fan = fan_ctrl;                        // Assign fan output signal

endmodule
