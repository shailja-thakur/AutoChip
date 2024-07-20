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
    wire fan;

    assign fan = fan_on | (heater & mode) | (aircon & ~mode);

    always @(mode or too_cold or too_hot or fan_on) begin
        if (mode) begin
        // heating mode
            heater = too_cold;
            aircon = 0;
        end else begin
        // cooling mode
            heater = 0;
            aircon = too_hot;
        end
    end
endmodule
