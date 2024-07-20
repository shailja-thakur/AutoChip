module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg q_reg;
always @(posedge clk) begin
	if (a & ~b)
		state <= 1'b1;
	else
		state <= 1'b0;
        
    q_reg <= state;
end

always @(posedge clk)
    q <= q_reg;

endmodule
