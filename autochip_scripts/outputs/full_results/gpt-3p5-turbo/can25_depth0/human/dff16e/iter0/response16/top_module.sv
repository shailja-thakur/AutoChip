module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [15:0] q_reg; // register to hold the state of q

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			q_reg <= 16'b0; // reset q_reg to all zeros
		end else begin
			if (byteena[1]) begin
				q_reg[15:8] <= d[15:8]; // update upper byte of q_reg
			end
			if (byteena[0]) begin
				q_reg[7:0] <= d[7:0]; // update lower byte of q_reg
			end
		end
	end

	assign q = q_reg; // assign q_reg to q output

endmodule
