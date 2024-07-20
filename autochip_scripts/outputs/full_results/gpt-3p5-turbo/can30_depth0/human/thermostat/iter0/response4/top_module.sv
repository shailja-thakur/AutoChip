module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    
    wire heater_ctrl;
    wire aircon_ctrl;
    
    assign heater = (mode == 1) && too_cold;
    assign aircon = (mode == 0) && too_hot;
    assign fan = fan_on || heater || aircon;
    
    assign heater_ctrl = (mode == 1) && too_cold;
    assign aircon_ctrl = (mode == 0) && too_hot;
    
    always @(*) begin
        if (fan_on == 1)
            fan = 1;
        else if (heater_ctrl == 1)
            fan = 1;
        else if (aircon_ctrl == 1)
            fan = 1;
        else
            fan = 0;
    end
    
endmodule
