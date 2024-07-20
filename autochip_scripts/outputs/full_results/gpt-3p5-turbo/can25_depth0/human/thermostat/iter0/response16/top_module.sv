module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Create internal signals
reg fan_req;

// Logic to determine if the fan should be on
assign fan = (fan_on || heater || aircon) ? 1'b1 : 1'b0;

// Logic to control the heater and air conditioner
always @* begin
    if (mode == 1'b1) begin
        heater = too_cold;
        aircon = 1'b0;
    end else begin
        heater = 1'b0;
        aircon = too_hot;
    end
end

endmodule
