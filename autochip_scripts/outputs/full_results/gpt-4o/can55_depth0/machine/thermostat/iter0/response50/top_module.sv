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
        // Determine the state of the fan
        fan = fan_on || too_cold || too_hot;
        
        // Determine the state of the heater
        if (mode && too_cold) begin
            heater = 1;
        end else begin
            heater = 0;
        end
        
        // Determine the state of the air conditioner
        if (!mode && too_hot) begin
            aircon = 1;
        end else begin
            aircon = 0;
        end
    end

endmodule
