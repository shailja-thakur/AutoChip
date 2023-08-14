module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 

    heater <= mode & too_cold;
    aircon <= mode & too_hot;
    fan <= heater | aircon | fan_on;

endmodule