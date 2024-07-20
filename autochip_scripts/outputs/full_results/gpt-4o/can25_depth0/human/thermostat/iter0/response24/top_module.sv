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
        if (mode == 1) begin // heating mode
            heater = too_cold;
            aircon = 0;
        end else begin // cooling mode
            heater = 0;
            aircon = too_hot;
        end
        
        // fan is on when either the heater or aircon is on, or requested by user
        fan = heater || aircon || fan_on;
    end

endmodule
