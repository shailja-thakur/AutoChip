module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    reg fan_on_req;

    always @(*) begin
        fan_on_req = (fan_on == 1) ? 1 : (mode == 1 && too_cold == 1) ? 1 : (mode == 0 && too_hot == 1) ? 1 : 0;
    end

    assign heater = (mode == 1 && too_cold == 1) ? 1 : 0;
    assign aircon = (mode == 0 && too_hot == 1) ? 1 : 0;
    assign fan = fan_on_req;

endmodule
