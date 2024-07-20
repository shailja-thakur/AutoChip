module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q_temp;
reg state_temp;

always @(posedge clk) begin
    if (a == 1'b1 && b == 1'b0)
        q_temp <= 1'b0;
    else if (a == 1'b0 && b == 1'b0)
        q_temp <= q_temp;
    else if (a == 1'b0 && b == 1'b1)
        q_temp <= 1'b1;
    else
        q_temp <= q_temp;
end

always @(posedge clk) begin
    if (state_temp == 1'b0)
        state_temp <= a & b;
    else
        state_temp <= state_temp;
end

assign q = q_temp;
assign state = state_temp;

endmodule
