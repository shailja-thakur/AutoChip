module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    reg heater;
    reg aircon;
    reg fan;

    always @(mode or too_cold or too_hot or fan_on) begin
        // default values
        heater = 0;
        aircon = 0;
        fan = fan_on;

        // check mode and temperature conditions
        if (mode == 1) begin // heating mode
            if (too_cold == 1) begin
                heater = 1;
                fan = 1;
            end
        end else begin // cooling mode
            if (too_hot == 1) begin
                aircon = 1;
                fan = 1;
            end
        end
    end

    assign heater = heater;
    assign aircon = aircon;
    assign fan = fan;

endmodule
