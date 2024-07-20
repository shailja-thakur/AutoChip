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
    
    always @(*) begin
        if (mode == 1) begin
            if (too_cold)
                heater = 1;
            else
                heater = 0;
            aircon = 0;
        end else begin
            if (too_hot)
                aircon = 1;
            else
                aircon = 0;
            heater = 0;
        end
        
        fan = fan_on | heater | aircon;
    end
    
    assign heater = heater;
    assign aircon = aircon;
    assign fan = fan;
    
endmodule
