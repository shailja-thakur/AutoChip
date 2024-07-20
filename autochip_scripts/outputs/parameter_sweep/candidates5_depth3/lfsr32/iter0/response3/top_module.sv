module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// internal wires and registers
	reg [31:0] q_reg;
	reg feedback;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_reg <= 32'h1;
		end else begin
			q_reg <= {q_reg[30:0], feedback};
		end
	end
	
	// XOR feedback calculation
	assign feedback = q_reg[31] ^ q_reg[21] ^ q_reg[1] ^ q_reg[0];
	
	// output assignment
	always @(posedge clk) begin
		q <= q_reg;
	end
	
endmodule
