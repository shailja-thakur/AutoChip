module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg fan_on_reg; //register to store the state of the fan

always @(*) begin
    if (fan_on || (mode && too_cold)) begin
        heater = 1;
        fan_on_reg = 1;
    end else begin
        heater = 0;
    end
    
    if (fan_on || (!mode && too_hot)) begin
        aircon = 1;
        fan_on_reg = 1;
    end else begin
        aircon = 0;
    end
    
    if (fan_on_reg || fan_on) begin
        fan = 1;
    end else begin
        fan = 0;
    end
end

endmodule
