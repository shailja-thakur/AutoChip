module top_module(
    input clk,
    input d,
    output reg q);
	
	reg q_reg;
	reg q_temp;

	always @(posedge clk) begin
		q_temp <= d;
	end

	always @(negedge clk) begin
		q_reg <= q_temp;
	end

	always @(posedge clk) begin
		q <= q_reg;
	end

endmodule
