module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declare internal signal
reg fan_state;

// Control logic
always @(*) begin
    if (mode == 1 && too_cold == 1) begin
        heater = 1;
        aircon = 0;
        fan = 1;
        fan_state = 1;
    end else if (mode == 0 && too_hot == 1) begin
        heater = 0;
        aircon = 1;
        fan = 1;
        fan_state = 1;
    end else if (fan_on == 1) begin
        heater = 0;
        aircon = 0;
        fan = 1;
        fan_state = 1;
    end else begin
        heater = 0;
        aircon = 0;
        fan = 0;
        fan_state = 0;
    end
end

endmodule
