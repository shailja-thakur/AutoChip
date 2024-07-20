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
    
    assign fan = (fan_on || fan_on_internal);
    
    always @(*) begin
        if (mode == 1) begin
            heater = too_cold;
            aircon = 0;
        end else begin
            heater = 0;
            aircon = too_hot;
        end
        
        if (heater || aircon) begin
            fan_on_internal = 1;
        end else begin
            fan_on_internal = fan_on;
        end
    end
endmodule
