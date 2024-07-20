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

    always @(*) begin
        if (too_cold || too_hot || fan_on) begin
            fan = 1;
            heater = 0;
            aircon = 0;
        end else if (mode && too_cold) begin
            fan = 0;
            heater = 1;
            aircon = 0;
        end else if (!mode && too_hot) begin
            fan = 0;
            heater = 0;
            aircon = 1;
        end else begin
            fan = 0;
            heater = 0;
            aircon = 0;
        end
    end

    assign fan = fan;
    assign heater = heater;
    assign aircon = aircon;
endmodule
