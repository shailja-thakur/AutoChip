module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    reg fan;
    reg heater;
    reg aircon;

    // Control the fan based on inputs
    always @(*) begin
        if (fan_on == 1 || too_cold == 1 || too_hot == 1)
            fan = 1;
        else
            fan = 0;
    end

    // Control the heater based on inputs
    always @(*) begin
        if (mode == 1 && too_cold == 1)
            heater = 1;
        else
            heater = 0;
    end

    // Control the air conditioner based on inputs
    always @(*) begin
        if (mode == 0 && too_hot == 1)
            aircon = 1;
        else
            aircon = 0;
    end

    // Assign outputs
    assign fan = fan;
    assign heater = heater;
    assign aircon = aircon;

endmodule
