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

    always @ (mode or too_cold or too_hot or fan_on)
    begin
        if (mode)
        begin
            heater = too_cold;
            aircon = 0;
            fan = heater | fan_on;
        end
        else
        begin
            heater = 0;
            aircon = too_hot;
            fan = aircon | fan_on;
        end
    end
endmodule
