module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    reg fan;
    reg heater;
    reg aircon;

    always @(mode, too_cold, too_hot, fan_on) begin
        fan = (too_cold || too_hot || fan_on);
        
        if (mode) begin
            heater = too_cold;
            aircon = 0;
        end else begin
            heater = 0;
            aircon = too_hot;
        end
    end

    assign fan = fan;
    assign heater = heater;
    assign aircon = aircon;

endmodule
