module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
 
reg fan_state;
reg heater_state;
reg aircon_state;
 
always @(mode or too_cold or too_hot or fan_on) begin
    if (mode) begin
        heater_state = too_cold;
        aircon_state = 0;
    end
    else begin
        heater_state = 0;
        aircon_state = too_hot;
    end
    
    fan_state = fan_on || heater_state || aircon_state;
end
 
assign heater = heater_state;
assign aircon = aircon_state;
assign fan = fan_state;
 
endmodule
