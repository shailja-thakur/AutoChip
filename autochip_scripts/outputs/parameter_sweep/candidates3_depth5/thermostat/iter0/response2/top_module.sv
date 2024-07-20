module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg fan_on_internal;
reg fan_on_heater;
reg fan_on_aircon;

assign fan = fan_on | fan_on_internal;

always @(*) begin
    if (mode == 1) begin
        heater = too_cold;
        aircon = 0;
        fan_on_internal = fan_on;
        fan_on_heater = fan_on_internal;
        fan_on_aircon = 0;
    end else begin
        heater = 0;
        aircon = too_hot;
        fan_on_internal = fan_on;
        fan_on_heater = 0;
        fan_on_aircon = fan_on_internal;
    end
end

always @(fan_on_internal or fan_on_heater or fan_on_aircon) begin
    fan_on = fan_on_internal | fan_on_heater | fan_on_aircon;
end

endmodule
