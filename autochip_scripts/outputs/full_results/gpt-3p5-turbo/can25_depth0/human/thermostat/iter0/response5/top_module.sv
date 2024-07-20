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
        heater = 0;
        aircon = 0;
        fan = 0;

        if (mode == 1) begin
            if (too_cold)
                heater = 1;

            if (fan_on)
                fan = 1;
        end
        else if (mode == 0) begin
            if (too_hot)
                aircon = 1;

            if (fan_on)
                fan = 1;
        end
    end
endmodule
