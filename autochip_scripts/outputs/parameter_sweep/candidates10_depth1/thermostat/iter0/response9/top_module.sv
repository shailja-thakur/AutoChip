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

always @* begin
    heater = 0;
    aircon = 0;
    fan = fan_on;

    if(mode == 1) begin
        if(too_cold == 1)
            heater = 1;
    end
    else begin
        if(too_hot == 1)
            aircon = 1;
    end

    if(heater == 1 || aircon == 1)
        fan = 1;
end

endmodule
