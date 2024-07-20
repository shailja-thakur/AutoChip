module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_reg;
reg q_reg;
reg a_reg;

always @(posedge clock) begin
	a_reg <= a;
	if (a_reg == 1'b1) begin
		p_reg <= p_reg ^ 1'b1;
		q_reg <= p_reg ^ 1'b1;
	end else begin
		p_reg <= 1'b0;
		q_reg <= 1'b0;
	end
end

assign p = p_reg;
assign q = q_reg;

endmodule
