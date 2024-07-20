module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_reg;
	
	// assign initial value to q_reg
	initial begin
		if (reset) begin
			q_reg <= 32'h1;
		end else begin
			q_reg <= 32'h0;
		end
	end
	
	always @(posedge clk) begin
		if (reset) begin
			q_reg <= 32'h1;
		end else begin
			q_reg <= {q_reg[30:0], q_reg[22]^q_reg[2]^q_reg[1]^q_reg[0]};
		end
	end
	
	// assign value to output q
	assign q = q_reg;
	
endmodule
