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
        if (mode) begin
            if (too_cold) begin
                heater = 1;
            end else begin
                heater = 0;
            end
            aircon = 0;
        end else begin
            if (too_hot) begin
                aircon = 1;
            end else begin
                aircon = 0;
            end
            heater = 0;
        end

        if (too_hot || too_cold || fan_on) begin
            fan = 1;
        end else begin
            fan = 0;
        end
    end

    assign fan = fan;
    assign heater = heater;
    assign aircon = aircon;

endmodule
