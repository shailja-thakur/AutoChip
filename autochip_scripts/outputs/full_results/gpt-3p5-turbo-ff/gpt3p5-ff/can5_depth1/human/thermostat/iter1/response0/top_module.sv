module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declare internal signals
reg fan_internal;
reg fan_only_internal;

// Assign fan_internal based on mode, too_cold, and fan_on inputs
always @(mode, too_cold, fan_on) begin
    if (mode == 1'b1 && too_cold == 1'b1) begin
        fan_internal <= 1'b1;
    end else if (mode == 1'b0 && too_hot == 1'b1) begin
        fan_internal <= 1'b1;
    end else if (fan_on == 1'b1) begin
        fan_internal <= 1'b1;
    end else begin
        fan_internal <= 1'b0;
    end
end

// Assign fan_only_internal based on fan_on input
always @(fan_on) begin
    if (fan_on == 1'b1) begin
        fan_only_internal <= 1'b1;
    end else begin
        fan_only_internal <= 1'b0;
    end
end

// Assign outputs based on internal signals
assign fan = fan_internal | fan_only_internal;
assign heater = (mode == 1'b1 && too_cold == 1'b1 && fan_internal == 1'b1) ? 1'b1 : 1'b0;
assign aircon = (mode == 1'b0 && too_hot == 1'b1 && fan_internal == 1'b1) ? 1'b1 : 1'b0;

endmodule
