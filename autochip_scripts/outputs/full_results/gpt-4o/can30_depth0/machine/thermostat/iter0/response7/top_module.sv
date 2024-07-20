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
        // Heater control: Turns on if mode is heating (mode == 1) and it's too cold
        if (mode && too_cold)
            heater = 1;
        else
            heater = 0;
        
        // Aircon control: Turns on if mode is cooling (mode == 0) and it's too hot
        if (!mode && too_hot)
            aircon = 1;
        else
            aircon = 0;
        
        // Fan control: Turns on if fan_on is high or either too_cold or too_hot is high
        if (fan_on || too_cold || too_hot)
            fan = 1;
        else
            fan = 0;
    end

endmodule
