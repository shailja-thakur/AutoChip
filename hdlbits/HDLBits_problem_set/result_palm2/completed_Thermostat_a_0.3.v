module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 

    heater <= (too_cold & mode);
    aircon <= (too_hot & ~mode);
    fan <= (heater | aircon | fan_on);

endmodule