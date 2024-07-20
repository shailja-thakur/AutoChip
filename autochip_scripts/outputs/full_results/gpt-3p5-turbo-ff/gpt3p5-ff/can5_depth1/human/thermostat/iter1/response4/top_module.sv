module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

// Declare internal signal
reg fan_internal;

// Assign fan_internal based on mode, too_cold, and fan_on inputs
always @(mode, too_cold, too_hot, fan_on) begin
    if (mode && too_cold) begin
        fan_internal <= 1'b1;
    end else if (!mode && too_hot) begin
        fan_internal <= 1'b1;
    end else if (fan_on) begin
        fan_internal <= 1'b1;
    end else begin
        fan_internal <= 1'b0;
    end
end

// Assign outputs based on internal signals
always @(fan_internal) begin
    if (fan_internal) begin
        heater <= (mode && too_cold) ? 1'b1 : 1'b0;
        aircon <= (!mode && too_hot) ? 1'b1 : 1'b0;
    end else begin
        heater <= 1'b0;
        aircon <= 1'b0;
    end
end

assign fan = fan_internal;

endmodule
