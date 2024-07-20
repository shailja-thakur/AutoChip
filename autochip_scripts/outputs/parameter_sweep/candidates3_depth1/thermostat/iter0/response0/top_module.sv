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
        case (mode)
            0: begin
                heater = 0;
                aircon = too_hot;
                fan = (fan_on | too_hot);
            end
            
            1: begin
                heater = too_cold;
                aircon = 0;
                fan = (fan_on | too_cold);
            end
            
            default: begin
                heater = 0;
                aircon = 0;
                fan = fan_on;
            end
        endcase
    end
endmodule
