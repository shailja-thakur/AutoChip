module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	// Declaration of D flip-flops
	reg d1, d2, d3, d4;
	
	// Output register
	reg out_reg;
	
	// Assigning output
	assign out = out_reg;
	
	// Synchronous reset
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			begin
				d1 <= 1'b0;
				d2 <= 1'b0;
				d3 <= 1'b0;
				d4 <= 1'b0;
			end
		else
			begin
				d1 <= in;
				d2 <= d1;
				d3 <= d2;
				d4 <= d3;
			end
	end
	
	// Output register assignment
	always @(posedge clk) begin
		out_reg <= d4;
	end

endmodule
