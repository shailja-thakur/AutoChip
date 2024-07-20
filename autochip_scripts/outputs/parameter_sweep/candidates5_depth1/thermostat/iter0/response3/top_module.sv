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

    always @* begin
        fan_on_internal = (fan_on || heater || aircon);
    end

    assign fan = fan_on_internal;

    always @(mode or too_cold or too_hot) begin
        if (mode) begin
            heater = too_cold;
            aircon = 0;
        end else begin
            heater = 0;
            aircon = too_hot;
        end
    end

endmodule
