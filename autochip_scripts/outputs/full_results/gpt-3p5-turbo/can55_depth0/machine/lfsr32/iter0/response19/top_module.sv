module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// wire declaration
	wire [31:0] q_next;

	// register assignment
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= q_next;
		end
	end

	// q_next assignment
	assign q_next = {q[30:0], q[31] ^ q[1] ^ q[0]};

endmodule
