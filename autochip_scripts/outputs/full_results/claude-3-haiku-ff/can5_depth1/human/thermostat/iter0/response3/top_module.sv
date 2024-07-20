module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @(*) begin
    if (mode) begin // Heating mode
        heater = too_cold;
        aircon = 0; // Do not use air conditioner in heating mode
        fan = heater; // Turn on fan when heater is on
    end
    else begin // Cooling mode
        heater = 0; // Do not use heater in cooling mode
        aircon = too_hot;
        fan = aircon; // Turn on fan when air conditioner is on
    end
    
    // Turn on fan if user requests it, even if heater and air conditioner are off
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
