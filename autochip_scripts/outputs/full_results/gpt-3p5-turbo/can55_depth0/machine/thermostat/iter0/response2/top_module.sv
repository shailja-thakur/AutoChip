module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @(mode, too_cold, too_hot, fan_on)
begin
    fan = (fan_on || too_cold || too_hot);   // Fan is turned on if fan_on is high or if temperature is too cold or too hot
    heater = (mode && too_cold);   // Heater is turned on if mode is high and temperature is too cold
    aircon = (!mode && too_hot);   // Air conditioner is turned on if mode is low and temperature is too hot
end

endmodule
