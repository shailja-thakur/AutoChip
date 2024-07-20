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
reg heater_reg;
reg aircon_reg;
wire fan_on_signal;
wire heater_signal;
wire aircon_signal;

//Assigning outputs
assign heater = heater_signal;
assign aircon = aircon_signal;
assign fan = fan_on_signal;

//Flip-flops for fan_on, heater and aircon inputs
always @(posedge mode or posedge too_cold or posedge too_hot or posedge fan_on)
begin
    fan_on_reg <= fan_on;
    heater_reg <= (mode && too_cold && !too_hot) || fan_on;
    aircon_reg <= (!mode && too_hot && !too_cold) || fan_on;
end

//Assigning the flip-flops outputs to output signals
assign fan_on_signal = fan_on_reg;
assign heater_signal = heater_reg;
assign aircon_signal = aircon_reg;

endmodule
