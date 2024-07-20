module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    reg fan_output;
    
    assign fan = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;
    assign heater = (mode && too_cold) ? 1'b1 : 1'b0;
    assign aircon = (mode && !too_cold && too_hot) ? 1'b1 : 1'b0;
    
    always @(posedge mode or posedge too_cold or posedge too_hot or posedge fan_on) begin
        fan_output <= (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;
    end
    
    assign fan = fan_output;
endmodule
