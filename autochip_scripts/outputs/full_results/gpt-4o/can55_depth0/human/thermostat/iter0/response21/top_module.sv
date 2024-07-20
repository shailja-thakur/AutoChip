module top_module(
    input mode,        // 1 for heating, 0 for cooling
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Internal signals
    wire heater_on;
    wire aircon_on;

    // Heater control in heating mode
    assign heater_on = mode & too_cold;

    // Air conditioner control in cooling mode
    assign aircon_on = ~mode & too_hot;

    // Heater output
    assign heater = heater_on; 

    // Air conditioner output
    assign aircon = aircon_on;

    // Fan control: turn on when either heater or aircon is on or user requests fan on
    assign fan = heater_on | aircon_on | fan_on;

endmodule
