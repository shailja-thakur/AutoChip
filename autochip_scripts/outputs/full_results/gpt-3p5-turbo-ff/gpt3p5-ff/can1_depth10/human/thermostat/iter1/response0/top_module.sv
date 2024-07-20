module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output wire heater,
    output wire aircon,
    output wire fan
);

assign fan = (heater || aircon || fan_on);

always @(*) begin
    if (mode == 1) begin
        heater = too_cold;
        aircon = 0;
    end else begin
        heater = 0;
        aircon = too_hot;
    end
end

endmodule
