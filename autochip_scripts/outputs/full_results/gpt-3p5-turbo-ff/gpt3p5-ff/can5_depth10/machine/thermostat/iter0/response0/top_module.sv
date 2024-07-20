module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);
    
    always @(*)
    begin
        fan = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;
        
        if(mode)
            heater = too_cold ? 1'b1 : 1'b0;
        else
            heater = 1'b0;
            
        if(!mode)
            aircon = too_hot ? 1'b1 : 1'b0;
        else
            aircon = 1'b0;
    end
    
endmodule
