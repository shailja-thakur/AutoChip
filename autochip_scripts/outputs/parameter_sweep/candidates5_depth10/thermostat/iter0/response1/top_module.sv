module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg fan_on_reg;
always @(fan_on) begin
    fan_on_reg <= fan_on;
end

reg heater_reg;
always @(mode, too_cold) begin
    if (mode == 1 && too_cold) begin
        heater_reg <= 1;
    end else begin
        heater_reg <= 0;
    end
end

reg aircon_reg;
always @(mode, too_hot) begin
    if (mode == 0 && too_hot) begin
        aircon_reg <= 1;
    end else begin
        aircon_reg <= 0;
    end
end

always @(fan_on_reg, heater_reg, aircon_reg) begin
    if (fan_on_reg || heater_reg || aircon_reg) begin
        fan <= 1;
    end else begin
        fan <= 0;
    end
end

assign heater = heater_reg;
assign aircon = aircon_reg;

endmodule
