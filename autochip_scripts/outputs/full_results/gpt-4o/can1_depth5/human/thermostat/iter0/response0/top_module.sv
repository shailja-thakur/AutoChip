module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Internal signals for heater and air conditioner
    reg heater_internal, aircon_internal, fan_internal;

    // Determine heater and air conditioner states based on mode and temperature
    always @(*) begin
        if (mode) begin // Heating mode
            heater_internal = too_cold;
            aircon_internal = 0;
        end else begin // Cooling mode
            heater_internal = 0;
            aircon_internal = too_hot;
        end
    end

    // Determine the fan state
    always @(*) begin
        fan_internal = heater_internal | aircon_internal | fan_on;
    end

    // Assign the outputs
    assign heater = heater_internal;
    assign aircon = aircon_internal;
    assign fan = fan_internal;

endmodule
