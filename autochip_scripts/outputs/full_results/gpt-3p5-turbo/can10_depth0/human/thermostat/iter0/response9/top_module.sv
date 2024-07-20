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
reg heater_internal;
reg aircon_internal;

always @(mode, too_cold, too_hot, fan_on) begin
    fan_on_internal = fan_on;
    if (mode == 1) begin
        heater_internal = too_cold;
        aircon_internal = 0;
    end else if (mode == 0) begin
        heater_internal = 0;
        aircon_internal = too_hot;
    end
end

assign heater = heater_internal | fan_on_internal;
assign aircon = aircon_internal | fan_on_internal;
assign fan = heater_internal | aircon_internal | fan_on_internal;

endmodule
